module reg_64page_1024x32b_3r_1w 
  (/*AUTOARG*/
   // Outputs
   rd0_data, rd1_data, rd2_data,
   // Inputs
   rd0_addr, rd1_addr, rd2_addr, wr0_addr, wr0_en, wr0_en_xoutof4,
   wr0_data, clk
   );

   output [2047:0] rd0_data;
   output [2047:0] rd1_data;
   output [2047:0] rd2_data;

   input [9:0] 	   rd0_addr;
   input [9:0] 	   rd1_addr;
   input [9:0] 	   rd2_addr;

   input [9:0] 	   wr0_addr;

   input [63:0]    wr0_en;
   input [3:0] 	   wr0_en_xoutof4;


   input [2047:0]  wr0_data;

   input 	   clk;

   wire [255:0]    effective_wr0_en;

   reg_1024x32b_3r_1w page[63:0] 
     (
      .rd0_addr(rd0_addr),
      .rd0_data(rd0_data),
      .rd1_addr(rd1_addr),
      .rd1_data(rd1_data),
      .rd2_addr(rd2_addr),
      .rd2_data(rd2_data),
      .wr0_en(effective_wr0_en),
      .wr0_addr(wr0_addr),
      .wr0_data(wr0_data),
      .clk(clk)
      );

// %%start_veriperl
//    my $i;
//    my $low_index;
//    my $high_index;
//    for($i=0; $i<64; $i=$i+1)
//      {
//       $low_index = 4*$i;
//       $high_index = 4*$i+3;
//       print "assign effective_wr0_en[$high_index:$low_index] = {4{wr0_en[$i]}} & wr0_en_xoutof4;\n";
//       }
// %%stop_veriperl
assign effective_wr0_en[3:0] = {4{wr0_en[0]}} & wr0_en_xoutof4;
assign effective_wr0_en[7:4] = {4{wr0_en[1]}} & wr0_en_xoutof4;
assign effective_wr0_en[11:8] = {4{wr0_en[2]}} & wr0_en_xoutof4;
assign effective_wr0_en[15:12] = {4{wr0_en[3]}} & wr0_en_xoutof4;
assign effective_wr0_en[19:16] = {4{wr0_en[4]}} & wr0_en_xoutof4;
assign effective_wr0_en[23:20] = {4{wr0_en[5]}} & wr0_en_xoutof4;
assign effective_wr0_en[27:24] = {4{wr0_en[6]}} & wr0_en_xoutof4;
assign effective_wr0_en[31:28] = {4{wr0_en[7]}} & wr0_en_xoutof4;
assign effective_wr0_en[35:32] = {4{wr0_en[8]}} & wr0_en_xoutof4;
assign effective_wr0_en[39:36] = {4{wr0_en[9]}} & wr0_en_xoutof4;
assign effective_wr0_en[43:40] = {4{wr0_en[10]}} & wr0_en_xoutof4;
assign effective_wr0_en[47:44] = {4{wr0_en[11]}} & wr0_en_xoutof4;
assign effective_wr0_en[51:48] = {4{wr0_en[12]}} & wr0_en_xoutof4;
assign effective_wr0_en[55:52] = {4{wr0_en[13]}} & wr0_en_xoutof4;
assign effective_wr0_en[59:56] = {4{wr0_en[14]}} & wr0_en_xoutof4;
assign effective_wr0_en[63:60] = {4{wr0_en[15]}} & wr0_en_xoutof4;
assign effective_wr0_en[67:64] = {4{wr0_en[16]}} & wr0_en_xoutof4;
assign effective_wr0_en[71:68] = {4{wr0_en[17]}} & wr0_en_xoutof4;
assign effective_wr0_en[75:72] = {4{wr0_en[18]}} & wr0_en_xoutof4;
assign effective_wr0_en[79:76] = {4{wr0_en[19]}} & wr0_en_xoutof4;
assign effective_wr0_en[83:80] = {4{wr0_en[20]}} & wr0_en_xoutof4;
assign effective_wr0_en[87:84] = {4{wr0_en[21]}} & wr0_en_xoutof4;
assign effective_wr0_en[91:88] = {4{wr0_en[22]}} & wr0_en_xoutof4;
assign effective_wr0_en[95:92] = {4{wr0_en[23]}} & wr0_en_xoutof4;
assign effective_wr0_en[99:96] = {4{wr0_en[24]}} & wr0_en_xoutof4;
assign effective_wr0_en[103:100] = {4{wr0_en[25]}} & wr0_en_xoutof4;
assign effective_wr0_en[107:104] = {4{wr0_en[26]}} & wr0_en_xoutof4;
assign effective_wr0_en[111:108] = {4{wr0_en[27]}} & wr0_en_xoutof4;
assign effective_wr0_en[115:112] = {4{wr0_en[28]}} & wr0_en_xoutof4;
assign effective_wr0_en[119:116] = {4{wr0_en[29]}} & wr0_en_xoutof4;
assign effective_wr0_en[123:120] = {4{wr0_en[30]}} & wr0_en_xoutof4;
assign effective_wr0_en[127:124] = {4{wr0_en[31]}} & wr0_en_xoutof4;
assign effective_wr0_en[131:128] = {4{wr0_en[32]}} & wr0_en_xoutof4;
assign effective_wr0_en[135:132] = {4{wr0_en[33]}} & wr0_en_xoutof4;
assign effective_wr0_en[139:136] = {4{wr0_en[34]}} & wr0_en_xoutof4;
assign effective_wr0_en[143:140] = {4{wr0_en[35]}} & wr0_en_xoutof4;
assign effective_wr0_en[147:144] = {4{wr0_en[36]}} & wr0_en_xoutof4;
assign effective_wr0_en[151:148] = {4{wr0_en[37]}} & wr0_en_xoutof4;
assign effective_wr0_en[155:152] = {4{wr0_en[38]}} & wr0_en_xoutof4;
assign effective_wr0_en[159:156] = {4{wr0_en[39]}} & wr0_en_xoutof4;
assign effective_wr0_en[163:160] = {4{wr0_en[40]}} & wr0_en_xoutof4;
assign effective_wr0_en[167:164] = {4{wr0_en[41]}} & wr0_en_xoutof4;
assign effective_wr0_en[171:168] = {4{wr0_en[42]}} & wr0_en_xoutof4;
assign effective_wr0_en[175:172] = {4{wr0_en[43]}} & wr0_en_xoutof4;
assign effective_wr0_en[179:176] = {4{wr0_en[44]}} & wr0_en_xoutof4;
assign effective_wr0_en[183:180] = {4{wr0_en[45]}} & wr0_en_xoutof4;
assign effective_wr0_en[187:184] = {4{wr0_en[46]}} & wr0_en_xoutof4;
assign effective_wr0_en[191:188] = {4{wr0_en[47]}} & wr0_en_xoutof4;
assign effective_wr0_en[195:192] = {4{wr0_en[48]}} & wr0_en_xoutof4;
assign effective_wr0_en[199:196] = {4{wr0_en[49]}} & wr0_en_xoutof4;
assign effective_wr0_en[203:200] = {4{wr0_en[50]}} & wr0_en_xoutof4;
assign effective_wr0_en[207:204] = {4{wr0_en[51]}} & wr0_en_xoutof4;
assign effective_wr0_en[211:208] = {4{wr0_en[52]}} & wr0_en_xoutof4;
assign effective_wr0_en[215:212] = {4{wr0_en[53]}} & wr0_en_xoutof4;
assign effective_wr0_en[219:216] = {4{wr0_en[54]}} & wr0_en_xoutof4;
assign effective_wr0_en[223:220] = {4{wr0_en[55]}} & wr0_en_xoutof4;
assign effective_wr0_en[227:224] = {4{wr0_en[56]}} & wr0_en_xoutof4;
assign effective_wr0_en[231:228] = {4{wr0_en[57]}} & wr0_en_xoutof4;
assign effective_wr0_en[235:232] = {4{wr0_en[58]}} & wr0_en_xoutof4;
assign effective_wr0_en[239:236] = {4{wr0_en[59]}} & wr0_en_xoutof4;
assign effective_wr0_en[243:240] = {4{wr0_en[60]}} & wr0_en_xoutof4;
assign effective_wr0_en[247:244] = {4{wr0_en[61]}} & wr0_en_xoutof4;
assign effective_wr0_en[251:248] = {4{wr0_en[62]}} & wr0_en_xoutof4;
assign effective_wr0_en[255:252] = {4{wr0_en[63]}} & wr0_en_xoutof4;
	 
	 endmodule
