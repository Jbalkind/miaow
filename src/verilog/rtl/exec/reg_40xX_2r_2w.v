module reg_40xX_2r_2w (
  rd0_addr,
  rd0_data,

  rd1_addr,
  rd1_data,

  wr0_en,
  wr0_addr,
  wr0_data,

  wr1_en,
  wr1_addr,
  wr1_data,

  clk,
  rst
);

parameter WIDTH = 64;

output [WIDTH-1:0] rd0_data;
input [5:0] rd0_addr;

output [WIDTH-1:0] rd1_data;
input [5:0] rd1_addr;

input wr0_en;
input [5:0] wr0_addr;
input [WIDTH-1:0] wr0_data;

input wr1_en;
input [5:0] wr1_addr;
input [WIDTH-1:0] wr1_data;

input clk;
input rst;

wire [(40*WIDTH)-1:0] word_out;
wire [(40*WIDTH)-1:0] word_in;
wire [39:0] wr_en_word;
wire [39:0] wr0_word_select;
wire [39:0] wr1_word_select;
wire [39:0] wr0_word_enable;
wire [39:0] wr1_word_enable;

mux_40xX_to_1xX #(WIDTH) mux_rd_port_0(
  .out(rd0_data),
  .in(word_out),
  .select(rd0_addr)
);

mux_40xX_to_1xX #(WIDTH) mux_rd_port_1(
  .out(rd1_data),
  .in(word_out),
  .select(rd1_addr)
);

decoder_6_to_40 decoder_wr_port_0(
  .out(wr0_word_select),
  .in(wr0_addr)
);

decoder_6_to_40 decoder_wr_port_1(
  .out(wr1_word_select),
  .in(wr1_addr)
);

register #(WIDTH) word[39:0](
  .out(word_out),
  .in(word_in),
  .wr_en(wr_en_word),
  .clk(clk),
  .rst(rst)
);

assign wr0_word_enable = {40{wr0_en}} & wr0_word_select;
assign wr1_word_enable = {40{wr1_en}} & wr1_word_select;
assign wr_en_word = wr0_word_enable | wr1_word_enable;

// %%start_veriperl
// my $i;
// my $i_plus_one;
// for($i=0; $i<40; $i=$i+1)
// {
//   $i_plus_one = $i + 1;
//   print "  assign word_in[(WIDTH*$i_plus_one)-1:WIDTH*$i] = ({wr1_word_enable[$i],wr0_word_enable[$i]} == 2'b01) ? wr0_data : (({wr1_word_enable[$i],wr0_word_enable[$i]} == 2'b10) ? wr1_data : {WIDTH{1'bx}});\n";
// }
// %%stop_veriperl
  assign word_in[(WIDTH*1)-1:WIDTH*0] = ({wr1_word_enable[0],wr0_word_enable[0]} == 2'b01) ? wr0_data : (({wr1_word_enable[0],wr0_word_enable[0]} == 2'b10) ? wr1_data : {WIDTH{1'bx}});
  assign word_in[(WIDTH*2)-1:WIDTH*1] = ({wr1_word_enable[1],wr0_word_enable[1]} == 2'b01) ? wr0_data : (({wr1_word_enable[1],wr0_word_enable[1]} == 2'b10) ? wr1_data : {WIDTH{1'bx}});
  assign word_in[(WIDTH*3)-1:WIDTH*2] = ({wr1_word_enable[2],wr0_word_enable[2]} == 2'b01) ? wr0_data : (({wr1_word_enable[2],wr0_word_enable[2]} == 2'b10) ? wr1_data : {WIDTH{1'bx}});
  assign word_in[(WIDTH*4)-1:WIDTH*3] = ({wr1_word_enable[3],wr0_word_enable[3]} == 2'b01) ? wr0_data : (({wr1_word_enable[3],wr0_word_enable[3]} == 2'b10) ? wr1_data : {WIDTH{1'bx}});
  assign word_in[(WIDTH*5)-1:WIDTH*4] = ({wr1_word_enable[4],wr0_word_enable[4]} == 2'b01) ? wr0_data : (({wr1_word_enable[4],wr0_word_enable[4]} == 2'b10) ? wr1_data : {WIDTH{1'bx}});
  assign word_in[(WIDTH*6)-1:WIDTH*5] = ({wr1_word_enable[5],wr0_word_enable[5]} == 2'b01) ? wr0_data : (({wr1_word_enable[5],wr0_word_enable[5]} == 2'b10) ? wr1_data : {WIDTH{1'bx}});
  assign word_in[(WIDTH*7)-1:WIDTH*6] = ({wr1_word_enable[6],wr0_word_enable[6]} == 2'b01) ? wr0_data : (({wr1_word_enable[6],wr0_word_enable[6]} == 2'b10) ? wr1_data : {WIDTH{1'bx}});
  assign word_in[(WIDTH*8)-1:WIDTH*7] = ({wr1_word_enable[7],wr0_word_enable[7]} == 2'b01) ? wr0_data : (({wr1_word_enable[7],wr0_word_enable[7]} == 2'b10) ? wr1_data : {WIDTH{1'bx}});
  assign word_in[(WIDTH*9)-1:WIDTH*8] = ({wr1_word_enable[8],wr0_word_enable[8]} == 2'b01) ? wr0_data : (({wr1_word_enable[8],wr0_word_enable[8]} == 2'b10) ? wr1_data : {WIDTH{1'bx}});
  assign word_in[(WIDTH*10)-1:WIDTH*9] = ({wr1_word_enable[9],wr0_word_enable[9]} == 2'b01) ? wr0_data : (({wr1_word_enable[9],wr0_word_enable[9]} == 2'b10) ? wr1_data : {WIDTH{1'bx}});
  assign word_in[(WIDTH*11)-1:WIDTH*10] = ({wr1_word_enable[10],wr0_word_enable[10]} == 2'b01) ? wr0_data : (({wr1_word_enable[10],wr0_word_enable[10]} == 2'b10) ? wr1_data : {WIDTH{1'bx}});
  assign word_in[(WIDTH*12)-1:WIDTH*11] = ({wr1_word_enable[11],wr0_word_enable[11]} == 2'b01) ? wr0_data : (({wr1_word_enable[11],wr0_word_enable[11]} == 2'b10) ? wr1_data : {WIDTH{1'bx}});
  assign word_in[(WIDTH*13)-1:WIDTH*12] = ({wr1_word_enable[12],wr0_word_enable[12]} == 2'b01) ? wr0_data : (({wr1_word_enable[12],wr0_word_enable[12]} == 2'b10) ? wr1_data : {WIDTH{1'bx}});
  assign word_in[(WIDTH*14)-1:WIDTH*13] = ({wr1_word_enable[13],wr0_word_enable[13]} == 2'b01) ? wr0_data : (({wr1_word_enable[13],wr0_word_enable[13]} == 2'b10) ? wr1_data : {WIDTH{1'bx}});
  assign word_in[(WIDTH*15)-1:WIDTH*14] = ({wr1_word_enable[14],wr0_word_enable[14]} == 2'b01) ? wr0_data : (({wr1_word_enable[14],wr0_word_enable[14]} == 2'b10) ? wr1_data : {WIDTH{1'bx}});
  assign word_in[(WIDTH*16)-1:WIDTH*15] = ({wr1_word_enable[15],wr0_word_enable[15]} == 2'b01) ? wr0_data : (({wr1_word_enable[15],wr0_word_enable[15]} == 2'b10) ? wr1_data : {WIDTH{1'bx}});
  assign word_in[(WIDTH*17)-1:WIDTH*16] = ({wr1_word_enable[16],wr0_word_enable[16]} == 2'b01) ? wr0_data : (({wr1_word_enable[16],wr0_word_enable[16]} == 2'b10) ? wr1_data : {WIDTH{1'bx}});
  assign word_in[(WIDTH*18)-1:WIDTH*17] = ({wr1_word_enable[17],wr0_word_enable[17]} == 2'b01) ? wr0_data : (({wr1_word_enable[17],wr0_word_enable[17]} == 2'b10) ? wr1_data : {WIDTH{1'bx}});
  assign word_in[(WIDTH*19)-1:WIDTH*18] = ({wr1_word_enable[18],wr0_word_enable[18]} == 2'b01) ? wr0_data : (({wr1_word_enable[18],wr0_word_enable[18]} == 2'b10) ? wr1_data : {WIDTH{1'bx}});
  assign word_in[(WIDTH*20)-1:WIDTH*19] = ({wr1_word_enable[19],wr0_word_enable[19]} == 2'b01) ? wr0_data : (({wr1_word_enable[19],wr0_word_enable[19]} == 2'b10) ? wr1_data : {WIDTH{1'bx}});
  assign word_in[(WIDTH*21)-1:WIDTH*20] = ({wr1_word_enable[20],wr0_word_enable[20]} == 2'b01) ? wr0_data : (({wr1_word_enable[20],wr0_word_enable[20]} == 2'b10) ? wr1_data : {WIDTH{1'bx}});
  assign word_in[(WIDTH*22)-1:WIDTH*21] = ({wr1_word_enable[21],wr0_word_enable[21]} == 2'b01) ? wr0_data : (({wr1_word_enable[21],wr0_word_enable[21]} == 2'b10) ? wr1_data : {WIDTH{1'bx}});
  assign word_in[(WIDTH*23)-1:WIDTH*22] = ({wr1_word_enable[22],wr0_word_enable[22]} == 2'b01) ? wr0_data : (({wr1_word_enable[22],wr0_word_enable[22]} == 2'b10) ? wr1_data : {WIDTH{1'bx}});
  assign word_in[(WIDTH*24)-1:WIDTH*23] = ({wr1_word_enable[23],wr0_word_enable[23]} == 2'b01) ? wr0_data : (({wr1_word_enable[23],wr0_word_enable[23]} == 2'b10) ? wr1_data : {WIDTH{1'bx}});
  assign word_in[(WIDTH*25)-1:WIDTH*24] = ({wr1_word_enable[24],wr0_word_enable[24]} == 2'b01) ? wr0_data : (({wr1_word_enable[24],wr0_word_enable[24]} == 2'b10) ? wr1_data : {WIDTH{1'bx}});
  assign word_in[(WIDTH*26)-1:WIDTH*25] = ({wr1_word_enable[25],wr0_word_enable[25]} == 2'b01) ? wr0_data : (({wr1_word_enable[25],wr0_word_enable[25]} == 2'b10) ? wr1_data : {WIDTH{1'bx}});
  assign word_in[(WIDTH*27)-1:WIDTH*26] = ({wr1_word_enable[26],wr0_word_enable[26]} == 2'b01) ? wr0_data : (({wr1_word_enable[26],wr0_word_enable[26]} == 2'b10) ? wr1_data : {WIDTH{1'bx}});
  assign word_in[(WIDTH*28)-1:WIDTH*27] = ({wr1_word_enable[27],wr0_word_enable[27]} == 2'b01) ? wr0_data : (({wr1_word_enable[27],wr0_word_enable[27]} == 2'b10) ? wr1_data : {WIDTH{1'bx}});
  assign word_in[(WIDTH*29)-1:WIDTH*28] = ({wr1_word_enable[28],wr0_word_enable[28]} == 2'b01) ? wr0_data : (({wr1_word_enable[28],wr0_word_enable[28]} == 2'b10) ? wr1_data : {WIDTH{1'bx}});
  assign word_in[(WIDTH*30)-1:WIDTH*29] = ({wr1_word_enable[29],wr0_word_enable[29]} == 2'b01) ? wr0_data : (({wr1_word_enable[29],wr0_word_enable[29]} == 2'b10) ? wr1_data : {WIDTH{1'bx}});
  assign word_in[(WIDTH*31)-1:WIDTH*30] = ({wr1_word_enable[30],wr0_word_enable[30]} == 2'b01) ? wr0_data : (({wr1_word_enable[30],wr0_word_enable[30]} == 2'b10) ? wr1_data : {WIDTH{1'bx}});
  assign word_in[(WIDTH*32)-1:WIDTH*31] = ({wr1_word_enable[31],wr0_word_enable[31]} == 2'b01) ? wr0_data : (({wr1_word_enable[31],wr0_word_enable[31]} == 2'b10) ? wr1_data : {WIDTH{1'bx}});
  assign word_in[(WIDTH*33)-1:WIDTH*32] = ({wr1_word_enable[32],wr0_word_enable[32]} == 2'b01) ? wr0_data : (({wr1_word_enable[32],wr0_word_enable[32]} == 2'b10) ? wr1_data : {WIDTH{1'bx}});
  assign word_in[(WIDTH*34)-1:WIDTH*33] = ({wr1_word_enable[33],wr0_word_enable[33]} == 2'b01) ? wr0_data : (({wr1_word_enable[33],wr0_word_enable[33]} == 2'b10) ? wr1_data : {WIDTH{1'bx}});
  assign word_in[(WIDTH*35)-1:WIDTH*34] = ({wr1_word_enable[34],wr0_word_enable[34]} == 2'b01) ? wr0_data : (({wr1_word_enable[34],wr0_word_enable[34]} == 2'b10) ? wr1_data : {WIDTH{1'bx}});
  assign word_in[(WIDTH*36)-1:WIDTH*35] = ({wr1_word_enable[35],wr0_word_enable[35]} == 2'b01) ? wr0_data : (({wr1_word_enable[35],wr0_word_enable[35]} == 2'b10) ? wr1_data : {WIDTH{1'bx}});
  assign word_in[(WIDTH*37)-1:WIDTH*36] = ({wr1_word_enable[36],wr0_word_enable[36]} == 2'b01) ? wr0_data : (({wr1_word_enable[36],wr0_word_enable[36]} == 2'b10) ? wr1_data : {WIDTH{1'bx}});
  assign word_in[(WIDTH*38)-1:WIDTH*37] = ({wr1_word_enable[37],wr0_word_enable[37]} == 2'b01) ? wr0_data : (({wr1_word_enable[37],wr0_word_enable[37]} == 2'b10) ? wr1_data : {WIDTH{1'bx}});
  assign word_in[(WIDTH*39)-1:WIDTH*38] = ({wr1_word_enable[38],wr0_word_enable[38]} == 2'b01) ? wr0_data : (({wr1_word_enable[38],wr0_word_enable[38]} == 2'b10) ? wr1_data : {WIDTH{1'bx}});
  assign word_in[(WIDTH*40)-1:WIDTH*39] = ({wr1_word_enable[39],wr0_word_enable[39]} == 2'b01) ? wr0_data : (({wr1_word_enable[39],wr0_word_enable[39]} == 2'b10) ? wr1_data : {WIDTH{1'bx}});

endmodule

