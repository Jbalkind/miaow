module reg_64page_1024x32b_3r_2w (
  rd0_addr,
  rd0_data,

  rd1_addr,
  rd1_data,

  rd2_addr,
  rd2_data,

  wr0_en,
  wr0_addr,
  wr0_data,

  wr1_en,
  wr1_en_xoutof4,
  wr1_addr,
  wr1_data,

  clk
);

  output [8191:0] rd0_data;
  output [2047:0] rd1_data;
  output [2047:0] rd2_data;

  input [9:0] rd0_addr;
  input [9:0] rd1_addr;
  input [9:0] rd2_addr;

  input [9:0] wr0_addr;
  input [9:0] wr1_addr;

  input [63:0] wr0_en;
  input [63:0] wr1_en;
  input [3:0] wr1_en_xoutof4;

  input [2047:0] wr0_data;
  input [8191:0] wr1_data;

  input clk;

  wire [255:0] effective_wr1_en;

  reg_1024x32b_3r_2w page[63:0] (
    .rd0_addr(rd0_addr),
    .rd0_data(rd0_data),
    .rd1_addr(rd1_addr),
    .rd1_data(rd1_data),
    .rd2_addr(rd2_addr),
    .rd2_data(rd2_data),
    .wr0_en(wr0_en),
    .wr0_addr(wr0_addr),
    .wr0_data(wr0_data),
    .wr1_en(effective_wr1_en),
    .wr1_addr(wr1_addr),
    .wr1_data(wr1_data),
    .clk(clk)
  );

// %%start_veriperl
// my $i;
// my $low_index;
// my $high_index;
// for($i=0; $i<64; $i=$i+1)
// {
//   $low_index = 4*$i;
//   $high_index = 4*$i+3;
//   print "assign effective_wr1_en[$high_index:$low_index] = {4{wr1_en[$i]}} & wr1_en_xoutof4;\n";
// }
// %%stop_veriperl
assign effective_wr1_en[3:0] = {4{wr1_en[0]}} & wr1_en_xoutof4;
assign effective_wr1_en[7:4] = {4{wr1_en[1]}} & wr1_en_xoutof4;
assign effective_wr1_en[11:8] = {4{wr1_en[2]}} & wr1_en_xoutof4;
assign effective_wr1_en[15:12] = {4{wr1_en[3]}} & wr1_en_xoutof4;
assign effective_wr1_en[19:16] = {4{wr1_en[4]}} & wr1_en_xoutof4;
assign effective_wr1_en[23:20] = {4{wr1_en[5]}} & wr1_en_xoutof4;
assign effective_wr1_en[27:24] = {4{wr1_en[6]}} & wr1_en_xoutof4;
assign effective_wr1_en[31:28] = {4{wr1_en[7]}} & wr1_en_xoutof4;
assign effective_wr1_en[35:32] = {4{wr1_en[8]}} & wr1_en_xoutof4;
assign effective_wr1_en[39:36] = {4{wr1_en[9]}} & wr1_en_xoutof4;
assign effective_wr1_en[43:40] = {4{wr1_en[10]}} & wr1_en_xoutof4;
assign effective_wr1_en[47:44] = {4{wr1_en[11]}} & wr1_en_xoutof4;
assign effective_wr1_en[51:48] = {4{wr1_en[12]}} & wr1_en_xoutof4;
assign effective_wr1_en[55:52] = {4{wr1_en[13]}} & wr1_en_xoutof4;
assign effective_wr1_en[59:56] = {4{wr1_en[14]}} & wr1_en_xoutof4;
assign effective_wr1_en[63:60] = {4{wr1_en[15]}} & wr1_en_xoutof4;
assign effective_wr1_en[67:64] = {4{wr1_en[16]}} & wr1_en_xoutof4;
assign effective_wr1_en[71:68] = {4{wr1_en[17]}} & wr1_en_xoutof4;
assign effective_wr1_en[75:72] = {4{wr1_en[18]}} & wr1_en_xoutof4;
assign effective_wr1_en[79:76] = {4{wr1_en[19]}} & wr1_en_xoutof4;
assign effective_wr1_en[83:80] = {4{wr1_en[20]}} & wr1_en_xoutof4;
assign effective_wr1_en[87:84] = {4{wr1_en[21]}} & wr1_en_xoutof4;
assign effective_wr1_en[91:88] = {4{wr1_en[22]}} & wr1_en_xoutof4;
assign effective_wr1_en[95:92] = {4{wr1_en[23]}} & wr1_en_xoutof4;
assign effective_wr1_en[99:96] = {4{wr1_en[24]}} & wr1_en_xoutof4;
assign effective_wr1_en[103:100] = {4{wr1_en[25]}} & wr1_en_xoutof4;
assign effective_wr1_en[107:104] = {4{wr1_en[26]}} & wr1_en_xoutof4;
assign effective_wr1_en[111:108] = {4{wr1_en[27]}} & wr1_en_xoutof4;
assign effective_wr1_en[115:112] = {4{wr1_en[28]}} & wr1_en_xoutof4;
assign effective_wr1_en[119:116] = {4{wr1_en[29]}} & wr1_en_xoutof4;
assign effective_wr1_en[123:120] = {4{wr1_en[30]}} & wr1_en_xoutof4;
assign effective_wr1_en[127:124] = {4{wr1_en[31]}} & wr1_en_xoutof4;
assign effective_wr1_en[131:128] = {4{wr1_en[32]}} & wr1_en_xoutof4;
assign effective_wr1_en[135:132] = {4{wr1_en[33]}} & wr1_en_xoutof4;
assign effective_wr1_en[139:136] = {4{wr1_en[34]}} & wr1_en_xoutof4;
assign effective_wr1_en[143:140] = {4{wr1_en[35]}} & wr1_en_xoutof4;
assign effective_wr1_en[147:144] = {4{wr1_en[36]}} & wr1_en_xoutof4;
assign effective_wr1_en[151:148] = {4{wr1_en[37]}} & wr1_en_xoutof4;
assign effective_wr1_en[155:152] = {4{wr1_en[38]}} & wr1_en_xoutof4;
assign effective_wr1_en[159:156] = {4{wr1_en[39]}} & wr1_en_xoutof4;
assign effective_wr1_en[163:160] = {4{wr1_en[40]}} & wr1_en_xoutof4;
assign effective_wr1_en[167:164] = {4{wr1_en[41]}} & wr1_en_xoutof4;
assign effective_wr1_en[171:168] = {4{wr1_en[42]}} & wr1_en_xoutof4;
assign effective_wr1_en[175:172] = {4{wr1_en[43]}} & wr1_en_xoutof4;
assign effective_wr1_en[179:176] = {4{wr1_en[44]}} & wr1_en_xoutof4;
assign effective_wr1_en[183:180] = {4{wr1_en[45]}} & wr1_en_xoutof4;
assign effective_wr1_en[187:184] = {4{wr1_en[46]}} & wr1_en_xoutof4;
assign effective_wr1_en[191:188] = {4{wr1_en[47]}} & wr1_en_xoutof4;
assign effective_wr1_en[195:192] = {4{wr1_en[48]}} & wr1_en_xoutof4;
assign effective_wr1_en[199:196] = {4{wr1_en[49]}} & wr1_en_xoutof4;
assign effective_wr1_en[203:200] = {4{wr1_en[50]}} & wr1_en_xoutof4;
assign effective_wr1_en[207:204] = {4{wr1_en[51]}} & wr1_en_xoutof4;
assign effective_wr1_en[211:208] = {4{wr1_en[52]}} & wr1_en_xoutof4;
assign effective_wr1_en[215:212] = {4{wr1_en[53]}} & wr1_en_xoutof4;
assign effective_wr1_en[219:216] = {4{wr1_en[54]}} & wr1_en_xoutof4;
assign effective_wr1_en[223:220] = {4{wr1_en[55]}} & wr1_en_xoutof4;
assign effective_wr1_en[227:224] = {4{wr1_en[56]}} & wr1_en_xoutof4;
assign effective_wr1_en[231:228] = {4{wr1_en[57]}} & wr1_en_xoutof4;
assign effective_wr1_en[235:232] = {4{wr1_en[58]}} & wr1_en_xoutof4;
assign effective_wr1_en[239:236] = {4{wr1_en[59]}} & wr1_en_xoutof4;
assign effective_wr1_en[243:240] = {4{wr1_en[60]}} & wr1_en_xoutof4;
assign effective_wr1_en[247:244] = {4{wr1_en[61]}} & wr1_en_xoutof4;
assign effective_wr1_en[251:248] = {4{wr1_en[62]}} & wr1_en_xoutof4;
assign effective_wr1_en[255:252] = {4{wr1_en[63]}} & wr1_en_xoutof4;

endmodule
