`include "define.tmp.h"

module fpga_memory_2 # (
    parameter LSU_MEM_DATA_WIDTH = 32,
    parameter VGPR_BUS_WIDTH = 2048,
    parameter VGPR_BUS_WIDTH_LOG = 11,
    parameter MAX_PKT_LEN = 35,
    parameter MSG_MSHRID_HI = 13,
    parameter MSG_MSHRID_LO = 6
)
(
    input wire clk,
    input wire rst,

    // output to noc2 (send requests to noc2 through packet filter)
    output reg                          noc2_filter_val,
    output wire [`NOC_DATA_WIDTH - 1:0] noc2_filter_data,
    input wire                          filter_noc2_rdy,

    // input from noc3 (receive responses from noc3 through packet filter)
    input wire                         filter_noc3_val,
    input wire [`NOC_DATA_WIDTH - 1:0] filter_noc3_data,
    output reg                         noc3_filter_rdy,

    // LSU inputs/outputs
    input wire                            lsu_wr_en,
    input wire                            lsu_rd_en,
    input wire [LSU_MEM_DATA_WIDTH - 1:0] lsu_addr,
    input wire [LSU_MEM_DATA_WIDTH - 1:0] lsu_wr_data,
    input wire [6:0]                      lsu_tag_req,

    output reg  [6:0]                      lsu_tag_resp,
    output wire [LSU_MEM_DATA_WIDTH - 1:0] lsu_rd_data,
    output reg                             lsu_ack
);

// STATES
localparam STATE_IDLE = 4'd0; // waiting for a mem request from LSU
localparam STATE_WR_SAVE_DATA = 4'd1; // get 32 bits from LSU
localparam STATE_WR_WAIT_DATA = 4'd2; // wait a cycle to get data from LSU
localparam STATE_WR_SLIDE_DATA = 4'd3; // shift data over in buffer
localparam STATE_WR_SEND_FLIT_ONE = 4'd4; // send first write header flit
localparam STATE_WR_SEND_FLIT_TWO = 4'd5; // send second write header flit
localparam STATE_WR_SEND_FLIT_THREE = 4'd6; // send third write header flit
localparam STATE_WR_SEND_FLIT_DATA = 4'd7; // send data to write
localparam STATE_WR_ACK_WAIT = 4'd8; // wait for ack from memory
localparam STATE_RD_SEND_FLIT_ONE = 4'd9; // send first read header flit
localparam STATE_RD_SEND_FLIT_TWO = 4'd10; // send second read header flit
localparam STATE_RD_SEND_FLIT_THREE = 4'd11; // send third read header flit
localparam STATE_RD_RESP_HEAD = 4'd12; // response header from memory
localparam STATE_RD_RESP_DATA = 4'd13; // response data from memory
localparam STATE_RD_SEND_DATA = 4'd14; // send data to LSU
localparam STATE_RD_WAIT_TO_SEND = 4'd15; // wait to send data to LSU

reg [4:0] state;
reg [4:0] state_next;

// amount of data seen so far (in either read rsp or write req)
reg [VGPR_BUS_WIDTH_LOG - 1:0] bits_seen;
reg [VGPR_BUS_WIDTH_LOG - 1:0] bits_seen_next;

reg [5:0] flit_count;
reg [5:0] flit_count_next;

reg [5:0] total_flits_to_send;
reg [5:0] total_flits_to_send_next;

reg [5:0] total_flits_to_see;
reg [5:0] total_flits_to_see_next;

reg [VGPR_BUS_WIDTH - 1:0] data_buffer;
reg [VGPR_BUS_WIDTH - 1:0] data_buffer_next;

reg [6:0] lsu_tag_resp_next;

reg [6:0] lsu_tag_req_reg;
reg [6:0] lsu_tag_req_reg_next;

reg [LSU_MEM_DATA_WIDTH - 1:0] lsu_addr_reg;
reg [LSU_MEM_DATA_WIDTH - 1:0] lsu_addr_reg_next;

reg [`NOC_DATA_WIDTH - 1:0] flit_to_send;

assign lsu_rd_data = data_buffer[LSU_MEM_DATA_WIDTH - 1:0];
assign noc2_filter_data = flit_to_send;

reg is_new_flit;
reg is_new_flit_next;

// update variables
always @( * ) begin
    noc2_filter_val = 1'b0;
    noc3_filter_rdy = 1'b0;
    lsu_ack = 1'b0;
    flit_to_send = 64'b0;

    lsu_tag_resp_next = lsu_tag_resp;
    bits_seen_next = bits_seen;
    flit_count_next = flit_count;
    total_flits_to_send_next = total_flits_to_send;
    total_flits_to_see_next = total_flits_to_see;
    data_buffer_next = data_buffer;
    lsu_addr_reg_next = lsu_addr_reg;
    lsu_tag_req_reg_next = lsu_tag_req;
    is_new_flit_next = is_new_flit;

    case (state)
        STATE_IDLE: begin
            bits_seen_next = 11'd0;
            flit_count_next = 6'd0;
            total_flits_to_send_next = 6'd0;
            total_flits_to_see_next = 6'd0;
            data_buffer_next = 2048'd0;

            if (lsu_wr_en) begin
                is_new_flit_next = 1'b1;
                total_flits_to_send_next = 4'd3;
            end
            else if (lsu_rd_en) begin
                total_flits_to_see_next = MAX_PKT_LEN - 2; // 2 fewer header packets
            end
        end
        STATE_WR_SAVE_DATA: begin
            lsu_ack = 1'b1;
            if (bits_seen == 0) begin
                lsu_tag_req_reg_next = lsu_tag_req;
                lsu_addr_reg_next = lsu_addr;
            end

            data_buffer_next[VGPR_BUS_WIDTH - LSU_MEM_DATA_WIDTH - 1: 0] = data_buffer[VGPR_BUS_WIDTH - 1:LSU_MEM_DATA_WIDTH];
            data_buffer_next[VGPR_BUS_WIDTH - 1:VGPR_BUS_WIDTH - LSU_MEM_DATA_WIDTH] = lsu_wr_data;

            bits_seen_next = bits_seen + 6'd32;
        end
        STATE_WR_WAIT_DATA: begin
            if (is_new_flit) begin
                total_flits_to_send_next = total_flits_to_send + 1;
            end

            is_new_flit_next = ~is_new_flit;
        end
        STATE_WR_SLIDE_DATA: begin
            data_buffer_next[VGPR_BUS_WIDTH - LSU_MEM_DATA_WIDTH - 1: 0] = data_buffer[VGPR_BUS_WIDTH - 1:LSU_MEM_DATA_WIDTH];
            
            bits_seen_next = bits_seen + 6'd32;
        end
        STATE_WR_SEND_FLIT_ONE: begin
            if (filter_noc2_rdy) begin
                noc2_filter_val = 1'b1;
                flit_count_next = flit_count + 1'b1;
                flit_to_send[`MSG_LENGTH] = total_flits_to_send - 1;
                flit_to_send[MSG_MSHRID_HI - 2:MSG_MSHRID_LO] = lsu_tag_req_reg;
            end
        end
        STATE_WR_SEND_FLIT_TWO: begin
            if (filter_noc2_rdy) begin
                noc2_filter_val = 1'b1;
                flit_count_next = flit_count + 1'b1;
                flit_to_send[`MSG_ADDR_] = {16'b0, lsu_addr_reg};
            end
        end
        STATE_WR_SEND_FLIT_THREE: begin
            if (filter_noc2_rdy) begin
                noc2_filter_val = 1'b1;
                flit_count_next = flit_count + 1'b1;
             end
        end
        STATE_WR_SEND_FLIT_DATA: begin
            if (filter_noc2_rdy) begin
                noc2_filter_val = 1'b1;
                flit_count_next = flit_count + 1'b1;
                flit_to_send = data_buffer[`NOC_DATA_WIDTH:0];
                data_buffer_next[VGPR_BUS_WIDTH - 1 - `NOC_DATA_WIDTH:0] = data_buffer[VGPR_BUS_WIDTH - 1:`NOC_DATA_WIDTH];
            end

            if (flit_count >= total_flits_to_send - 1 && filter_noc2_rdy) begin
                flit_count_next = 6'd0;
            end
        end
        STATE_WR_ACK_WAIT: begin
            noc3_filter_rdy = 1'b1;
            if (filter_noc3_val) begin
                lsu_tag_resp_next = filter_noc3_data[MSG_MSHRID_HI - 2:MSG_MSHRID_LO];
            end
        end
        STATE_RD_SEND_FLIT_ONE: begin
            if (filter_noc2_rdy) begin
                noc2_filter_val = 1'b1;
                flit_count_next = flit_count + 1'b1;
                flit_to_send[`MSG_LENGTH] = 8'd3;
                flit_to_send[MSG_MSHRID_HI - 2:MSG_MSHRID_LO] = lsu_tag_req;
                lsu_addr_reg_next = lsu_addr;
            end
        end
        STATE_RD_SEND_FLIT_TWO: begin
            if (filter_noc2_rdy) begin
                noc2_filter_val = 1'b1;
                flit_count_next=  flit_count + 1'b1;
                flit_to_send[`MSG_ADDR_] = {16'b0, lsu_addr_reg};
            end
        end
        STATE_RD_SEND_FLIT_THREE: begin
            if (filter_noc2_rdy) begin
                noc2_filter_val = 1'b1;
                flit_count_next = 6'd0;
            end
        end
        STATE_RD_RESP_HEAD: begin
            noc3_filter_rdy = 1'b1;
            if (filter_noc3_val) begin
                lsu_tag_resp_next = filter_noc3_data[MSG_MSHRID_HI - 2:MSG_MSHRID_LO];
                flit_count_next = flit_count + 1'b1;
            end
        end
        STATE_RD_RESP_DATA: begin
            noc3_filter_rdy = 1'b1;
            if (filter_noc3_val) begin
                data_buffer_next[VGPR_BUS_WIDTH - 1 - `NOC_DATA_WIDTH:0] = data_buffer[VGPR_BUS_WIDTH - 1:`NOC_DATA_WIDTH];
                data_buffer_next[VGPR_BUS_WIDTH - 1:VGPR_BUS_WIDTH - `NOC_DATA_WIDTH] = filter_noc3_data;
                flit_count_next = flit_count + 1'b1;
            end
        end
        STATE_RD_SEND_DATA: begin
            lsu_ack = 1'b1;
        end
        STATE_RD_WAIT_TO_SEND: begin
            data_buffer_next[VGPR_BUS_WIDTH - 1 - LSU_MEM_DATA_WIDTH:0] = data_buffer[VGPR_BUS_WIDTH - 1:LSU_MEM_DATA_WIDTH];
        end
        default: begin
        end
    endcase
end

// next state logic
always @( * ) begin
    state_next = state;

    case (state)
        STATE_IDLE: begin
            if (lsu_wr_en) begin
                state_next = STATE_WR_SAVE_DATA;
            end
            else if (lsu_rd_en) begin
                state_next = STATE_RD_SEND_FLIT_ONE;
            end
        end
        STATE_WR_SAVE_DATA: begin
            state_next = STATE_WR_WAIT_DATA;
        end
        STATE_WR_WAIT_DATA: begin
            if (lsu_wr_en) begin
                state_next = STATE_WR_SAVE_DATA;
            end
            else begin
                state_next = STATE_WR_SLIDE_DATA;
            end
        end
        STATE_WR_SLIDE_DATA: begin
            if (bits_seen >= VGPR_BUS_WIDTH - LSU_MEM_DATA_WIDTH) begin
                state_next = STATE_WR_SEND_FLIT_ONE;
            end
        end
        STATE_WR_SEND_FLIT_ONE: begin
            if (filter_noc2_rdy) begin
                state_next = STATE_WR_SEND_FLIT_TWO;
            end
        end
        STATE_WR_SEND_FLIT_TWO: begin
            if (filter_noc2_rdy) begin
                state_next = STATE_WR_SEND_FLIT_THREE;
            end
        end
        STATE_WR_SEND_FLIT_THREE: begin
            if (filter_noc2_rdy) begin
                state_next = STATE_WR_SEND_FLIT_DATA;
            end
        end
        STATE_WR_SEND_FLIT_DATA: begin
            if (flit_count >= total_flits_to_send - 1 && filter_noc2_rdy) begin
                state_next = STATE_WR_ACK_WAIT;
            end
        end
        STATE_WR_ACK_WAIT: begin
            if (filter_noc3_val) begin
                state_next = STATE_IDLE;
            end
        end
        STATE_RD_SEND_FLIT_ONE: begin
            if (filter_noc2_rdy) begin
                state_next = STATE_RD_SEND_FLIT_TWO;
            end
        end
        STATE_RD_SEND_FLIT_TWO: begin
            if (filter_noc2_rdy) begin
                state_next = STATE_RD_SEND_FLIT_THREE;
            end
        end
        STATE_RD_SEND_FLIT_THREE: begin
            if (filter_noc2_rdy) begin
                state_next = STATE_RD_RESP_HEAD;
            end
        end
        STATE_RD_RESP_HEAD: begin
            if (filter_noc3_val) begin
                state_next = STATE_RD_RESP_DATA;
            end
        end
        STATE_RD_RESP_DATA: begin
            if (filter_noc3_val && flit_count >= total_flits_to_see - 1) begin
                state_next = STATE_RD_SEND_DATA;
            end
        end
        STATE_RD_SEND_DATA: begin
            state_next = STATE_RD_WAIT_TO_SEND;
        end
        STATE_RD_WAIT_TO_SEND: begin
            if (lsu_rd_en) begin
                state_next = STATE_RD_SEND_DATA;
            end
            else begin
                state_next = STATE_IDLE;
            end
        end
        default: begin
            state_next = state;
        end
    endcase
end

// update registers
always @(posedge clk) begin
    if (rst) begin
        state <= STATE_IDLE;
        bits_seen <= 11'd0;
        total_flits_to_send <= 6'd0;
        total_flits_to_see <= 6'd0;
        flit_count <= 6'd0;
        data_buffer <= 2048'd0;
        lsu_tag_resp <= 6'd0;
        lsu_addr_reg <= 32'd0;
        lsu_tag_req_reg <= 6'd0;
        is_new_flit <= 1'b0;
    end
    else begin
        state <= state_next;
        bits_seen <= bits_seen_next;
        total_flits_to_send <= total_flits_to_send_next;
        total_flits_to_see <= total_flits_to_see_next;
        flit_count <= flit_count_next;
        data_buffer <= data_buffer_next;
        lsu_tag_resp <= lsu_tag_resp_next;
        lsu_addr_reg <= lsu_addr_reg_next;
        lsu_tag_req_reg <= lsu_tag_req_reg_next;
        is_new_flit <= is_new_flit_next;
    end
end

endmodule
