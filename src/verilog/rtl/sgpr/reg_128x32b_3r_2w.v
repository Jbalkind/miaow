module reg_128x32b_3r_2w
(/*AUTOARG*/
   // Outputs
   rd0_data, rd1_data, rd2_data,
   // Inputs
   clk, rd0_addr, rd1_addr, rd2_addr, wr0_addr, wr1_addr, wr0_en,
   wr1_en, wr0_data, wr1_data
   );
input clk;

output [31:0] rd0_data;
output [31:0] rd1_data;
output [31:0] rd2_data;

input [6:0] rd0_addr;
input [6:0] rd1_addr;
input [6:0] rd2_addr;

input [6:0] wr0_addr;
input [6:0] wr1_addr;

input wr0_en;
input wr1_en;

input [31:0] wr0_data;
input [31:0] wr1_data;

wire [31:0] rd0_data_i;
wire [31:0] rd1_data_i;
wire [31:0] rd2_data_i;
   
wire [4095:0] word_out;
wire [4095:0] word_in;
wire [127:0] wr_en_word;

wire [127:0] wr0_word_select;
wire [127:0] wr1_word_select;
wire [127:0] wr0_word_enable;
wire [127:0] wr1_word_enable;

//Register file
flop_32b word[127:0](.out(word_out), .in(word_in), .wr_en(wr_en_word), .clk(clk));

//Muxes for read ports
mux_128x32b_to_1x32b mux_rd_port_0 
  (.out(rd0_data_i), .in(word_out), .select(rd0_addr));
mux_128x32b_to_1x32b mux_rd_port_1 
  (.out(rd1_data_i), .in(word_out), .select(rd1_addr));
mux_128x32b_to_1x32b mux_rd_port_2 
  (.out(rd2_data_i), .in(word_out), .select(rd2_addr));

//Write port logic
decoder_param #(7,128) decoder_wr_port_0 (.out(wr0_word_select), .in(wr0_addr));
decoder_param #(7,128) decoder_wr_port_1 (.out(wr1_word_select), .in(wr1_addr));
assign wr0_word_enable = {128{wr0_en}} & wr0_word_select;
assign wr1_word_enable = {128{wr1_en}} & wr1_word_select;
assign wr_en_word = wr0_word_enable | wr1_word_enable;

// %%start_veriperl
// my $i;
// my $low_index;
// my $high_index;
// for($i=0; $i<128; $i=$i+1)
// {
//   $low_index = 32*$i;
//   $high_index = 32*$i+31;
//   print "assign word_in[$high_index:$low_index] = ({wr1_word_enable[$i],wr0_word_enable[$i]} == 2'b01) ? wr0_data : (({wr1_word_enable[$i],wr0_word_enable[$i]} == 2'b10) ? wr1_data : {32{1'bx}});\n";
// }
// %%stop_veriperl
assign word_in[31:0] = ({wr1_word_enable[0],wr0_word_enable[0]} == 2'b01) ? wr0_data : (({wr1_word_enable[0],wr0_word_enable[0]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[63:32] = ({wr1_word_enable[1],wr0_word_enable[1]} == 2'b01) ? wr0_data : (({wr1_word_enable[1],wr0_word_enable[1]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[95:64] = ({wr1_word_enable[2],wr0_word_enable[2]} == 2'b01) ? wr0_data : (({wr1_word_enable[2],wr0_word_enable[2]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[127:96] = ({wr1_word_enable[3],wr0_word_enable[3]} == 2'b01) ? wr0_data : (({wr1_word_enable[3],wr0_word_enable[3]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[159:128] = ({wr1_word_enable[4],wr0_word_enable[4]} == 2'b01) ? wr0_data : (({wr1_word_enable[4],wr0_word_enable[4]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[191:160] = ({wr1_word_enable[5],wr0_word_enable[5]} == 2'b01) ? wr0_data : (({wr1_word_enable[5],wr0_word_enable[5]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[223:192] = ({wr1_word_enable[6],wr0_word_enable[6]} == 2'b01) ? wr0_data : (({wr1_word_enable[6],wr0_word_enable[6]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[255:224] = ({wr1_word_enable[7],wr0_word_enable[7]} == 2'b01) ? wr0_data : (({wr1_word_enable[7],wr0_word_enable[7]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[287:256] = ({wr1_word_enable[8],wr0_word_enable[8]} == 2'b01) ? wr0_data : (({wr1_word_enable[8],wr0_word_enable[8]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[319:288] = ({wr1_word_enable[9],wr0_word_enable[9]} == 2'b01) ? wr0_data : (({wr1_word_enable[9],wr0_word_enable[9]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[351:320] = ({wr1_word_enable[10],wr0_word_enable[10]} == 2'b01) ? wr0_data : (({wr1_word_enable[10],wr0_word_enable[10]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[383:352] = ({wr1_word_enable[11],wr0_word_enable[11]} == 2'b01) ? wr0_data : (({wr1_word_enable[11],wr0_word_enable[11]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[415:384] = ({wr1_word_enable[12],wr0_word_enable[12]} == 2'b01) ? wr0_data : (({wr1_word_enable[12],wr0_word_enable[12]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[447:416] = ({wr1_word_enable[13],wr0_word_enable[13]} == 2'b01) ? wr0_data : (({wr1_word_enable[13],wr0_word_enable[13]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[479:448] = ({wr1_word_enable[14],wr0_word_enable[14]} == 2'b01) ? wr0_data : (({wr1_word_enable[14],wr0_word_enable[14]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[511:480] = ({wr1_word_enable[15],wr0_word_enable[15]} == 2'b01) ? wr0_data : (({wr1_word_enable[15],wr0_word_enable[15]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[543:512] = ({wr1_word_enable[16],wr0_word_enable[16]} == 2'b01) ? wr0_data : (({wr1_word_enable[16],wr0_word_enable[16]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[575:544] = ({wr1_word_enable[17],wr0_word_enable[17]} == 2'b01) ? wr0_data : (({wr1_word_enable[17],wr0_word_enable[17]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[607:576] = ({wr1_word_enable[18],wr0_word_enable[18]} == 2'b01) ? wr0_data : (({wr1_word_enable[18],wr0_word_enable[18]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[639:608] = ({wr1_word_enable[19],wr0_word_enable[19]} == 2'b01) ? wr0_data : (({wr1_word_enable[19],wr0_word_enable[19]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[671:640] = ({wr1_word_enable[20],wr0_word_enable[20]} == 2'b01) ? wr0_data : (({wr1_word_enable[20],wr0_word_enable[20]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[703:672] = ({wr1_word_enable[21],wr0_word_enable[21]} == 2'b01) ? wr0_data : (({wr1_word_enable[21],wr0_word_enable[21]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[735:704] = ({wr1_word_enable[22],wr0_word_enable[22]} == 2'b01) ? wr0_data : (({wr1_word_enable[22],wr0_word_enable[22]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[767:736] = ({wr1_word_enable[23],wr0_word_enable[23]} == 2'b01) ? wr0_data : (({wr1_word_enable[23],wr0_word_enable[23]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[799:768] = ({wr1_word_enable[24],wr0_word_enable[24]} == 2'b01) ? wr0_data : (({wr1_word_enable[24],wr0_word_enable[24]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[831:800] = ({wr1_word_enable[25],wr0_word_enable[25]} == 2'b01) ? wr0_data : (({wr1_word_enable[25],wr0_word_enable[25]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[863:832] = ({wr1_word_enable[26],wr0_word_enable[26]} == 2'b01) ? wr0_data : (({wr1_word_enable[26],wr0_word_enable[26]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[895:864] = ({wr1_word_enable[27],wr0_word_enable[27]} == 2'b01) ? wr0_data : (({wr1_word_enable[27],wr0_word_enable[27]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[927:896] = ({wr1_word_enable[28],wr0_word_enable[28]} == 2'b01) ? wr0_data : (({wr1_word_enable[28],wr0_word_enable[28]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[959:928] = ({wr1_word_enable[29],wr0_word_enable[29]} == 2'b01) ? wr0_data : (({wr1_word_enable[29],wr0_word_enable[29]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[991:960] = ({wr1_word_enable[30],wr0_word_enable[30]} == 2'b01) ? wr0_data : (({wr1_word_enable[30],wr0_word_enable[30]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[1023:992] = ({wr1_word_enable[31],wr0_word_enable[31]} == 2'b01) ? wr0_data : (({wr1_word_enable[31],wr0_word_enable[31]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[1055:1024] = ({wr1_word_enable[32],wr0_word_enable[32]} == 2'b01) ? wr0_data : (({wr1_word_enable[32],wr0_word_enable[32]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[1087:1056] = ({wr1_word_enable[33],wr0_word_enable[33]} == 2'b01) ? wr0_data : (({wr1_word_enable[33],wr0_word_enable[33]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[1119:1088] = ({wr1_word_enable[34],wr0_word_enable[34]} == 2'b01) ? wr0_data : (({wr1_word_enable[34],wr0_word_enable[34]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[1151:1120] = ({wr1_word_enable[35],wr0_word_enable[35]} == 2'b01) ? wr0_data : (({wr1_word_enable[35],wr0_word_enable[35]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[1183:1152] = ({wr1_word_enable[36],wr0_word_enable[36]} == 2'b01) ? wr0_data : (({wr1_word_enable[36],wr0_word_enable[36]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[1215:1184] = ({wr1_word_enable[37],wr0_word_enable[37]} == 2'b01) ? wr0_data : (({wr1_word_enable[37],wr0_word_enable[37]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[1247:1216] = ({wr1_word_enable[38],wr0_word_enable[38]} == 2'b01) ? wr0_data : (({wr1_word_enable[38],wr0_word_enable[38]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[1279:1248] = ({wr1_word_enable[39],wr0_word_enable[39]} == 2'b01) ? wr0_data : (({wr1_word_enable[39],wr0_word_enable[39]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[1311:1280] = ({wr1_word_enable[40],wr0_word_enable[40]} == 2'b01) ? wr0_data : (({wr1_word_enable[40],wr0_word_enable[40]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[1343:1312] = ({wr1_word_enable[41],wr0_word_enable[41]} == 2'b01) ? wr0_data : (({wr1_word_enable[41],wr0_word_enable[41]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[1375:1344] = ({wr1_word_enable[42],wr0_word_enable[42]} == 2'b01) ? wr0_data : (({wr1_word_enable[42],wr0_word_enable[42]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[1407:1376] = ({wr1_word_enable[43],wr0_word_enable[43]} == 2'b01) ? wr0_data : (({wr1_word_enable[43],wr0_word_enable[43]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[1439:1408] = ({wr1_word_enable[44],wr0_word_enable[44]} == 2'b01) ? wr0_data : (({wr1_word_enable[44],wr0_word_enable[44]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[1471:1440] = ({wr1_word_enable[45],wr0_word_enable[45]} == 2'b01) ? wr0_data : (({wr1_word_enable[45],wr0_word_enable[45]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[1503:1472] = ({wr1_word_enable[46],wr0_word_enable[46]} == 2'b01) ? wr0_data : (({wr1_word_enable[46],wr0_word_enable[46]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[1535:1504] = ({wr1_word_enable[47],wr0_word_enable[47]} == 2'b01) ? wr0_data : (({wr1_word_enable[47],wr0_word_enable[47]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[1567:1536] = ({wr1_word_enable[48],wr0_word_enable[48]} == 2'b01) ? wr0_data : (({wr1_word_enable[48],wr0_word_enable[48]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[1599:1568] = ({wr1_word_enable[49],wr0_word_enable[49]} == 2'b01) ? wr0_data : (({wr1_word_enable[49],wr0_word_enable[49]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[1631:1600] = ({wr1_word_enable[50],wr0_word_enable[50]} == 2'b01) ? wr0_data : (({wr1_word_enable[50],wr0_word_enable[50]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[1663:1632] = ({wr1_word_enable[51],wr0_word_enable[51]} == 2'b01) ? wr0_data : (({wr1_word_enable[51],wr0_word_enable[51]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[1695:1664] = ({wr1_word_enable[52],wr0_word_enable[52]} == 2'b01) ? wr0_data : (({wr1_word_enable[52],wr0_word_enable[52]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[1727:1696] = ({wr1_word_enable[53],wr0_word_enable[53]} == 2'b01) ? wr0_data : (({wr1_word_enable[53],wr0_word_enable[53]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[1759:1728] = ({wr1_word_enable[54],wr0_word_enable[54]} == 2'b01) ? wr0_data : (({wr1_word_enable[54],wr0_word_enable[54]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[1791:1760] = ({wr1_word_enable[55],wr0_word_enable[55]} == 2'b01) ? wr0_data : (({wr1_word_enable[55],wr0_word_enable[55]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[1823:1792] = ({wr1_word_enable[56],wr0_word_enable[56]} == 2'b01) ? wr0_data : (({wr1_word_enable[56],wr0_word_enable[56]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[1855:1824] = ({wr1_word_enable[57],wr0_word_enable[57]} == 2'b01) ? wr0_data : (({wr1_word_enable[57],wr0_word_enable[57]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[1887:1856] = ({wr1_word_enable[58],wr0_word_enable[58]} == 2'b01) ? wr0_data : (({wr1_word_enable[58],wr0_word_enable[58]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[1919:1888] = ({wr1_word_enable[59],wr0_word_enable[59]} == 2'b01) ? wr0_data : (({wr1_word_enable[59],wr0_word_enable[59]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[1951:1920] = ({wr1_word_enable[60],wr0_word_enable[60]} == 2'b01) ? wr0_data : (({wr1_word_enable[60],wr0_word_enable[60]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[1983:1952] = ({wr1_word_enable[61],wr0_word_enable[61]} == 2'b01) ? wr0_data : (({wr1_word_enable[61],wr0_word_enable[61]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[2015:1984] = ({wr1_word_enable[62],wr0_word_enable[62]} == 2'b01) ? wr0_data : (({wr1_word_enable[62],wr0_word_enable[62]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[2047:2016] = ({wr1_word_enable[63],wr0_word_enable[63]} == 2'b01) ? wr0_data : (({wr1_word_enable[63],wr0_word_enable[63]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[2079:2048] = ({wr1_word_enable[64],wr0_word_enable[64]} == 2'b01) ? wr0_data : (({wr1_word_enable[64],wr0_word_enable[64]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[2111:2080] = ({wr1_word_enable[65],wr0_word_enable[65]} == 2'b01) ? wr0_data : (({wr1_word_enable[65],wr0_word_enable[65]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[2143:2112] = ({wr1_word_enable[66],wr0_word_enable[66]} == 2'b01) ? wr0_data : (({wr1_word_enable[66],wr0_word_enable[66]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[2175:2144] = ({wr1_word_enable[67],wr0_word_enable[67]} == 2'b01) ? wr0_data : (({wr1_word_enable[67],wr0_word_enable[67]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[2207:2176] = ({wr1_word_enable[68],wr0_word_enable[68]} == 2'b01) ? wr0_data : (({wr1_word_enable[68],wr0_word_enable[68]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[2239:2208] = ({wr1_word_enable[69],wr0_word_enable[69]} == 2'b01) ? wr0_data : (({wr1_word_enable[69],wr0_word_enable[69]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[2271:2240] = ({wr1_word_enable[70],wr0_word_enable[70]} == 2'b01) ? wr0_data : (({wr1_word_enable[70],wr0_word_enable[70]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[2303:2272] = ({wr1_word_enable[71],wr0_word_enable[71]} == 2'b01) ? wr0_data : (({wr1_word_enable[71],wr0_word_enable[71]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[2335:2304] = ({wr1_word_enable[72],wr0_word_enable[72]} == 2'b01) ? wr0_data : (({wr1_word_enable[72],wr0_word_enable[72]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[2367:2336] = ({wr1_word_enable[73],wr0_word_enable[73]} == 2'b01) ? wr0_data : (({wr1_word_enable[73],wr0_word_enable[73]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[2399:2368] = ({wr1_word_enable[74],wr0_word_enable[74]} == 2'b01) ? wr0_data : (({wr1_word_enable[74],wr0_word_enable[74]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[2431:2400] = ({wr1_word_enable[75],wr0_word_enable[75]} == 2'b01) ? wr0_data : (({wr1_word_enable[75],wr0_word_enable[75]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[2463:2432] = ({wr1_word_enable[76],wr0_word_enable[76]} == 2'b01) ? wr0_data : (({wr1_word_enable[76],wr0_word_enable[76]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[2495:2464] = ({wr1_word_enable[77],wr0_word_enable[77]} == 2'b01) ? wr0_data : (({wr1_word_enable[77],wr0_word_enable[77]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[2527:2496] = ({wr1_word_enable[78],wr0_word_enable[78]} == 2'b01) ? wr0_data : (({wr1_word_enable[78],wr0_word_enable[78]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[2559:2528] = ({wr1_word_enable[79],wr0_word_enable[79]} == 2'b01) ? wr0_data : (({wr1_word_enable[79],wr0_word_enable[79]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[2591:2560] = ({wr1_word_enable[80],wr0_word_enable[80]} == 2'b01) ? wr0_data : (({wr1_word_enable[80],wr0_word_enable[80]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[2623:2592] = ({wr1_word_enable[81],wr0_word_enable[81]} == 2'b01) ? wr0_data : (({wr1_word_enable[81],wr0_word_enable[81]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[2655:2624] = ({wr1_word_enable[82],wr0_word_enable[82]} == 2'b01) ? wr0_data : (({wr1_word_enable[82],wr0_word_enable[82]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[2687:2656] = ({wr1_word_enable[83],wr0_word_enable[83]} == 2'b01) ? wr0_data : (({wr1_word_enable[83],wr0_word_enable[83]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[2719:2688] = ({wr1_word_enable[84],wr0_word_enable[84]} == 2'b01) ? wr0_data : (({wr1_word_enable[84],wr0_word_enable[84]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[2751:2720] = ({wr1_word_enable[85],wr0_word_enable[85]} == 2'b01) ? wr0_data : (({wr1_word_enable[85],wr0_word_enable[85]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[2783:2752] = ({wr1_word_enable[86],wr0_word_enable[86]} == 2'b01) ? wr0_data : (({wr1_word_enable[86],wr0_word_enable[86]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[2815:2784] = ({wr1_word_enable[87],wr0_word_enable[87]} == 2'b01) ? wr0_data : (({wr1_word_enable[87],wr0_word_enable[87]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[2847:2816] = ({wr1_word_enable[88],wr0_word_enable[88]} == 2'b01) ? wr0_data : (({wr1_word_enable[88],wr0_word_enable[88]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[2879:2848] = ({wr1_word_enable[89],wr0_word_enable[89]} == 2'b01) ? wr0_data : (({wr1_word_enable[89],wr0_word_enable[89]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[2911:2880] = ({wr1_word_enable[90],wr0_word_enable[90]} == 2'b01) ? wr0_data : (({wr1_word_enable[90],wr0_word_enable[90]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[2943:2912] = ({wr1_word_enable[91],wr0_word_enable[91]} == 2'b01) ? wr0_data : (({wr1_word_enable[91],wr0_word_enable[91]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[2975:2944] = ({wr1_word_enable[92],wr0_word_enable[92]} == 2'b01) ? wr0_data : (({wr1_word_enable[92],wr0_word_enable[92]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[3007:2976] = ({wr1_word_enable[93],wr0_word_enable[93]} == 2'b01) ? wr0_data : (({wr1_word_enable[93],wr0_word_enable[93]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[3039:3008] = ({wr1_word_enable[94],wr0_word_enable[94]} == 2'b01) ? wr0_data : (({wr1_word_enable[94],wr0_word_enable[94]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[3071:3040] = ({wr1_word_enable[95],wr0_word_enable[95]} == 2'b01) ? wr0_data : (({wr1_word_enable[95],wr0_word_enable[95]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[3103:3072] = ({wr1_word_enable[96],wr0_word_enable[96]} == 2'b01) ? wr0_data : (({wr1_word_enable[96],wr0_word_enable[96]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[3135:3104] = ({wr1_word_enable[97],wr0_word_enable[97]} == 2'b01) ? wr0_data : (({wr1_word_enable[97],wr0_word_enable[97]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[3167:3136] = ({wr1_word_enable[98],wr0_word_enable[98]} == 2'b01) ? wr0_data : (({wr1_word_enable[98],wr0_word_enable[98]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[3199:3168] = ({wr1_word_enable[99],wr0_word_enable[99]} == 2'b01) ? wr0_data : (({wr1_word_enable[99],wr0_word_enable[99]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[3231:3200] = ({wr1_word_enable[100],wr0_word_enable[100]} == 2'b01) ? wr0_data : (({wr1_word_enable[100],wr0_word_enable[100]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[3263:3232] = ({wr1_word_enable[101],wr0_word_enable[101]} == 2'b01) ? wr0_data : (({wr1_word_enable[101],wr0_word_enable[101]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[3295:3264] = ({wr1_word_enable[102],wr0_word_enable[102]} == 2'b01) ? wr0_data : (({wr1_word_enable[102],wr0_word_enable[102]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[3327:3296] = ({wr1_word_enable[103],wr0_word_enable[103]} == 2'b01) ? wr0_data : (({wr1_word_enable[103],wr0_word_enable[103]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[3359:3328] = ({wr1_word_enable[104],wr0_word_enable[104]} == 2'b01) ? wr0_data : (({wr1_word_enable[104],wr0_word_enable[104]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[3391:3360] = ({wr1_word_enable[105],wr0_word_enable[105]} == 2'b01) ? wr0_data : (({wr1_word_enable[105],wr0_word_enable[105]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[3423:3392] = ({wr1_word_enable[106],wr0_word_enable[106]} == 2'b01) ? wr0_data : (({wr1_word_enable[106],wr0_word_enable[106]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[3455:3424] = ({wr1_word_enable[107],wr0_word_enable[107]} == 2'b01) ? wr0_data : (({wr1_word_enable[107],wr0_word_enable[107]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[3487:3456] = ({wr1_word_enable[108],wr0_word_enable[108]} == 2'b01) ? wr0_data : (({wr1_word_enable[108],wr0_word_enable[108]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[3519:3488] = ({wr1_word_enable[109],wr0_word_enable[109]} == 2'b01) ? wr0_data : (({wr1_word_enable[109],wr0_word_enable[109]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[3551:3520] = ({wr1_word_enable[110],wr0_word_enable[110]} == 2'b01) ? wr0_data : (({wr1_word_enable[110],wr0_word_enable[110]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[3583:3552] = ({wr1_word_enable[111],wr0_word_enable[111]} == 2'b01) ? wr0_data : (({wr1_word_enable[111],wr0_word_enable[111]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[3615:3584] = ({wr1_word_enable[112],wr0_word_enable[112]} == 2'b01) ? wr0_data : (({wr1_word_enable[112],wr0_word_enable[112]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[3647:3616] = ({wr1_word_enable[113],wr0_word_enable[113]} == 2'b01) ? wr0_data : (({wr1_word_enable[113],wr0_word_enable[113]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[3679:3648] = ({wr1_word_enable[114],wr0_word_enable[114]} == 2'b01) ? wr0_data : (({wr1_word_enable[114],wr0_word_enable[114]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[3711:3680] = ({wr1_word_enable[115],wr0_word_enable[115]} == 2'b01) ? wr0_data : (({wr1_word_enable[115],wr0_word_enable[115]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[3743:3712] = ({wr1_word_enable[116],wr0_word_enable[116]} == 2'b01) ? wr0_data : (({wr1_word_enable[116],wr0_word_enable[116]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[3775:3744] = ({wr1_word_enable[117],wr0_word_enable[117]} == 2'b01) ? wr0_data : (({wr1_word_enable[117],wr0_word_enable[117]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[3807:3776] = ({wr1_word_enable[118],wr0_word_enable[118]} == 2'b01) ? wr0_data : (({wr1_word_enable[118],wr0_word_enable[118]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[3839:3808] = ({wr1_word_enable[119],wr0_word_enable[119]} == 2'b01) ? wr0_data : (({wr1_word_enable[119],wr0_word_enable[119]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[3871:3840] = ({wr1_word_enable[120],wr0_word_enable[120]} == 2'b01) ? wr0_data : (({wr1_word_enable[120],wr0_word_enable[120]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[3903:3872] = ({wr1_word_enable[121],wr0_word_enable[121]} == 2'b01) ? wr0_data : (({wr1_word_enable[121],wr0_word_enable[121]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[3935:3904] = ({wr1_word_enable[122],wr0_word_enable[122]} == 2'b01) ? wr0_data : (({wr1_word_enable[122],wr0_word_enable[122]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[3967:3936] = ({wr1_word_enable[123],wr0_word_enable[123]} == 2'b01) ? wr0_data : (({wr1_word_enable[123],wr0_word_enable[123]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[3999:3968] = ({wr1_word_enable[124],wr0_word_enable[124]} == 2'b01) ? wr0_data : (({wr1_word_enable[124],wr0_word_enable[124]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[4031:4000] = ({wr1_word_enable[125],wr0_word_enable[125]} == 2'b01) ? wr0_data : (({wr1_word_enable[125],wr0_word_enable[125]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[4063:4032] = ({wr1_word_enable[126],wr0_word_enable[126]} == 2'b01) ? wr0_data : (({wr1_word_enable[126],wr0_word_enable[126]} == 2'b10) ? wr1_data : {32{1'bx}});
assign word_in[4095:4064] = ({wr1_word_enable[127],wr0_word_enable[127]} == 2'b01) ? wr0_data : (({wr1_word_enable[127],wr0_word_enable[127]} == 2'b10) ? wr1_data : {32{1'bx}});

  // Output flop on the read ports.
  dff_en rd_port_0_out_flop[31:0]
    (.q(rd0_data),
     .d(rd0_data_i),
     .en(1'b1),
     .clk(clk),
     .rst(1'b0));

  dff_en rd_port_1_out_flop[31:0]
    (.q(rd1_data),
     .d(rd1_data_i),
     .en(1'b1),
     .clk(clk),
     .rst(1'b0));

  dff_en rd_port_2_out_flop[31:0]
    (.q(rd2_data),
     .d(rd2_data_i),
     .en(1'b1),
     .clk(clk),
     .rst(1'b0));

/*   // For now disable this flop
   assign rd0_data = rd0_data_i;
   assign rd1_data = rd1_data_i;
   assign rd2_data = rd2_data_i;*/

endmodule
