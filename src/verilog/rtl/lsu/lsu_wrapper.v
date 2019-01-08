module lsu_wrapper (
    input wire clk,
    input wire rst,

    // Packet filter interface
    // requests
    output wire        lsu_filter_val,
    output wire [63:0] lsu_filter_data,
    input wire         filter_lsu_rdy,

    // responses
    input wire        filter_lsu_val,
    input wire [63:0] filter_lsu_data,
    output wire       lsu_filter_rdy,

    // Neko LSU
    input issue_lsu_select,
    input mem_ack,
    input [5:0] issue_wfid,
    input [6:0] mem_tag_resp,
    input [11:0] issue_source_reg1,
    input [11:0] issue_source_reg2,
    input [11:0] issue_source_reg3,
    input [11:0] issue_dest_reg,
    input [11:0] issue_mem_sgpr,
    input [15:0] issue_imm_value0,
    input [15:0] issue_lds_base,
    input [31:0] issue_imm_value1,
    input [31:0] issue_opcode,
    input [31:0] sgpr_source2_data,
    input [31:0] exec_rd_m0_value,
    input [31:0] issue_instr_pc,
    input [63:0] exec_exec_value,
    input [127:0] sgpr_source1_data,
    input [2047:0] vgpr_source1_data,
    input [2047:0] vgpr_source2_data,
    input [MEMORY_BUS_WIDTH-1:0] mem_rd_data,
    input lsu_stall,
    
    output issue_ready,
    output vgpr_source1_rd_en,
    output vgpr_source2_rd_en,
    output sgpr_source1_rd_en,
    output sgpr_source2_rd_en,
    output mem_gm_or_lds,
    output tracemon_gm_or_lds,
    output vgpr_dest_wr_en,
    output mem_rd_en,
    output mem_wr_en,
    output [3:0] sgpr_dest_wr_en,
    output [5:0] exec_rd_wfid,
    output [6:0] mem_tag_req,
    output [8:0] sgpr_source1_addr,
    output [8:0] sgpr_source2_addr,
    output [8:0] sgpr_dest_addr,
    output [9:0] vgpr_source1_addr,
    output [9:0] vgpr_source2_addr,
    output [9:0] vgpr_dest_addr,
    output [63:0] vgpr_dest_wr_mask,
    output [63:0] mem_wr_mask,
    output [127:0] sgpr_dest_data,
    output [31:0] mem_addr,
    output [2047:0] vgpr_dest_data,
    output [MEMORY_BUS_WIDTH-1:0] mem_wr_data,
    
    output rfa_dest_wr_req,
    
    output lsu_done,
    output sgpr_instr_done,
    output vgpr_instr_done,
    
    output [5:0] lsu_done_wfid,
    output [5:0] sgpr_instr_done_wfid,
    output [5:0] vgpr_instr_done_wfid,
    
    output [31:0]  tracemon_retire_pc,
    output [2047:0] tracemon_mem_addr,
    output tracemon_idle,

);

// internal wires are set based on wrapper LSU logic
wire issue2lsu_lsu_select, mem_ack;
wire [5:0] issue2lsu_wfid;
wire [6:0] mem2lsu_tag_resp;
wire [11:0] issue2lsu_source_reg1, issue2lsu_source_reg2, issue2lsu_source_reg3,
    issue2lsu_dest_reg, issue2lsu_mem_sgpr;
wire [15:0] issue2lsu_imm_value0, issue2lsu_lds_base;
wire [31:0] issue2lsu_imm_value1, issue2lsu_opcode, sgpr2lsu_source2_data, exec2lsu_rd_m0_value,
    issue2lsu_instr_pc;
wire [63:0] exec2lsu_exec_value;
wire [127:0] sgpr2lsu_source1_data;
wire [2047:0] vgpr2lsu_source1_data;
wire [2047:0] vgpr2lsu_source2_data;
wire [MEMORY_BUS_WIDTH-1:0] mem2lsu_rd_data;
wire lsu2lsu_stall;

wire lsu2issue_ready, lsu2vgpr_source1_rd_en, lsu2vgpr_source2_rd_en,
      lsu2sgpr_source1_rd_en, lsu2sgpr_source2_rd_en, lsu2mem_gm_or_lds,
      lsu2tracemon_gm_or_lds;
wire lsu2vgpr_dest_wr_en, lsu2mem_rd_en, lsu2mem_wr_en;
wire [3:0] lsu2sgpr_dest_wr_en;
wire [5:0]   lsu2exec_rd_wfid;
wire [6:0]   lsu2mem_tag_req;
wire [8:0]   lsu2sgpr_source1_addr, lsu2sgpr_source2_addr, lsu2sgpr_dest_addr;
wire [9:0]   lsu2vgpr_source1_addr, lsu2vgpr_source2_addr, lsu2vgpr_dest_addr;
wire [63:0]  lsu2vgpr_dest_wr_mask, lsu2mem_wr_mask;
wire [127:0] lsu2sgpr_dest_data;
wire [31:0] lsu2mem_addr;
wire [2047:0] lsu2vgpr_dest_data;
wire [MEMORY_BUS_WIDTH-1:0] lsu2mem_wr_data;

wire lsu2rfa_dest_wr_req;

wire lsu2issue_done;
wire lsu2sgpr_instr_done;
wire lsu2vgpr_instr_done;

wire [5:0] lsu2issue_done_wfid;
wire [5:0] lsu2sgpr_instr_done_wfid;
wire [5:0] lsu2vgpr_instr_done_wfid;

wire [31:0]  lsu2tracemon_retire_pc;
wire [2047:0] lsu2tracemon_mem_addr;
wire lsu2tracemon_idle;

neko_lsu neko_lsu0 (
    .clk(clk),//
    .rst(rst),//
    //  Inputs
    .issue_lsu_select(issue2lsu_lsu_select),//
    .issue_source_reg1(issue2lsu_source_reg1),//
    .issue_source_reg2(issue2lsu_source_reg2),//
    .issue_source_reg3(issue2lsu_source_reg3),//
    .issue_dest_reg(issue2lsu_dest_reg),//
    .issue_imm_value0(issue2lsu_imm_value0),//
    .issue_imm_value1(issue2lsu_imm_value1),//
    .issue_opcode(issue2lsu_opcode),//
    .issue_mem_sgpr(issue2lsu_mem_sgpr),//
    .issue_wfid(issue2lsu_wfid),//
    .issue_lds_base(issue2lsu_lds_base),//
    .vgpr_source1_data(vgpr2lsu_source1_data),//
    .vgpr_source2_data(vgpr2lsu_source2_data),//
    .mem_rd_data(mem2lsu_rd_data),//
    .mem_tag_resp(mem2lsu_tag_resp),//
    .mem_ack(mem2lsu_ack),//
    .sgpr_source1_data(sgpr2lsu_source1_data),//
    .sgpr_source2_data(sgpr2lsu_source2_data),//
    .exec_exec_value(exec2lsu_exec_value),//
    .exec_rd_m0_value(exec2lsu_rd_m0_value),//
    .issue_instr_pc(issue2lsu_instr_pc),//
     .lsu_stall(lsu2lsu_stall),//**CHANGE
    //  Outputs
    .issue_ready(lsu2issue_ready),
    .lsu_done(lsu2issue_done),
    .lsu_done_wfid(lsu2issue_done_wfid),
    .vgpr_source1_addr(lsu2vgpr_source1_addr),
    .vgpr_source2_addr(lsu2vgpr_source2_addr),
    .vgpr_dest_addr(lsu2vgpr_dest_addr),
    .vgpr_dest_data(lsu2vgpr_dest_data),
    .vgpr_dest_wr_en(lsu2vgpr_dest_wr_en),
    .vgpr_dest_wr_mask(lsu2vgpr_dest_wr_mask),
    .vgpr_instr_done_wfid(lsu2vgpr_instr_done_wfid),
    .vgpr_instr_done(lsu2vgpr_instr_done),
    .vgpr_source1_rd_en(lsu2vgpr_source1_rd_en),
    .vgpr_source2_rd_en(lsu2vgpr_source2_rd_en),
    .exec_rd_wfid(lsu2exec_rd_wfid),
    .mem_rd_en(lsu2mem_rd_en),
    .mem_wr_en(lsu2mem_wr_en),
    .mem_addr(lsu2mem_addr),
    .mem_wr_data(lsu2mem_wr_data),
    .mem_tag_req(lsu2mem_tag_req),
    .mem_wr_mask(lsu2mem_wr_mask),
    .sgpr_source1_addr(lsu2sgpr_source1_addr),
    .sgpr_source2_addr(lsu2sgpr_source2_addr),
    .sgpr_dest_addr(lsu2sgpr_dest_addr),
    .sgpr_dest_data(lsu2sgpr_dest_data),
    .sgpr_dest_wr_en(lsu2sgpr_dest_wr_en),
    .sgpr_instr_done_wfid(lsu2sgpr_instr_done_wfid),
    .sgpr_instr_done(lsu2sgpr_instr_done),
    .sgpr_source1_rd_en(lsu2sgpr_source1_rd_en),
    .sgpr_source2_rd_en(lsu2sgpr_source2_rd_en),
    .mem_gm_or_lds(lsu2mem_gm_or_lds),
    .rfa_dest_wr_req(lsu2rfa_dest_wr_req),
    .tracemon_retire_pc(lsu2tracemon_retire_pc),
    .tracemon_gm_or_lds(lsu2tracemon_gm_or_lds),
    .tracemon_mem_addr(lsu2tracemon_addr),
    .tracemon_idle(lsu2tracemon_idle)
);
