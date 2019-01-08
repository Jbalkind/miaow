module decoder_6_to_40 (out,in);
  output [39:0] out;
  input [5:0] in;
// %%start_veriperl
// my $i;
// for($i=0; $i<40; $i=$i+1)
// {
//   print "  assign out[$i] = (in == 6'd$i) ? 1'b1 : 1'b0;\n";
// }
// %%stop_veriperl
  assign out[0] = (in == 6'd0) ? 1'b1 : 1'b0;
  assign out[1] = (in == 6'd1) ? 1'b1 : 1'b0;
  assign out[2] = (in == 6'd2) ? 1'b1 : 1'b0;
  assign out[3] = (in == 6'd3) ? 1'b1 : 1'b0;
  assign out[4] = (in == 6'd4) ? 1'b1 : 1'b0;
  assign out[5] = (in == 6'd5) ? 1'b1 : 1'b0;
  assign out[6] = (in == 6'd6) ? 1'b1 : 1'b0;
  assign out[7] = (in == 6'd7) ? 1'b1 : 1'b0;
  assign out[8] = (in == 6'd8) ? 1'b1 : 1'b0;
  assign out[9] = (in == 6'd9) ? 1'b1 : 1'b0;
  assign out[10] = (in == 6'd10) ? 1'b1 : 1'b0;
  assign out[11] = (in == 6'd11) ? 1'b1 : 1'b0;
  assign out[12] = (in == 6'd12) ? 1'b1 : 1'b0;
  assign out[13] = (in == 6'd13) ? 1'b1 : 1'b0;
  assign out[14] = (in == 6'd14) ? 1'b1 : 1'b0;
  assign out[15] = (in == 6'd15) ? 1'b1 : 1'b0;
  assign out[16] = (in == 6'd16) ? 1'b1 : 1'b0;
  assign out[17] = (in == 6'd17) ? 1'b1 : 1'b0;
  assign out[18] = (in == 6'd18) ? 1'b1 : 1'b0;
  assign out[19] = (in == 6'd19) ? 1'b1 : 1'b0;
  assign out[20] = (in == 6'd20) ? 1'b1 : 1'b0;
  assign out[21] = (in == 6'd21) ? 1'b1 : 1'b0;
  assign out[22] = (in == 6'd22) ? 1'b1 : 1'b0;
  assign out[23] = (in == 6'd23) ? 1'b1 : 1'b0;
  assign out[24] = (in == 6'd24) ? 1'b1 : 1'b0;
  assign out[25] = (in == 6'd25) ? 1'b1 : 1'b0;
  assign out[26] = (in == 6'd26) ? 1'b1 : 1'b0;
  assign out[27] = (in == 6'd27) ? 1'b1 : 1'b0;
  assign out[28] = (in == 6'd28) ? 1'b1 : 1'b0;
  assign out[29] = (in == 6'd29) ? 1'b1 : 1'b0;
  assign out[30] = (in == 6'd30) ? 1'b1 : 1'b0;
  assign out[31] = (in == 6'd31) ? 1'b1 : 1'b0;
  assign out[32] = (in == 6'd32) ? 1'b1 : 1'b0;
  assign out[33] = (in == 6'd33) ? 1'b1 : 1'b0;
  assign out[34] = (in == 6'd34) ? 1'b1 : 1'b0;
  assign out[35] = (in == 6'd35) ? 1'b1 : 1'b0;
  assign out[36] = (in == 6'd36) ? 1'b1 : 1'b0;
  assign out[37] = (in == 6'd37) ? 1'b1 : 1'b0;
  assign out[38] = (in == 6'd38) ? 1'b1 : 1'b0;
  assign out[39] = (in == 6'd39) ? 1'b1 : 1'b0;
endmodule
