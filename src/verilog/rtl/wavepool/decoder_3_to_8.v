module decoder_3_to_8 (out,in);
  output [7:0] out;
  input [2:0] in;
// %%start_veriperl
// my $i;
// for($i=0; $i<8; $i=$i+1)
// {
//   print "  assign out[$i] = (in == 3'd$i) ? 1'b1 : 1'b0;\n";
// }
// %%stop_veriperl
  assign out[0] = (in == 3'd0) ? 1'b1 : 1'b0;
  assign out[1] = (in == 3'd1) ? 1'b1 : 1'b0;
  assign out[2] = (in == 3'd2) ? 1'b1 : 1'b0;
  assign out[3] = (in == 3'd3) ? 1'b1 : 1'b0;
  assign out[4] = (in == 3'd4) ? 1'b1 : 1'b0;
  assign out[5] = (in == 3'd5) ? 1'b1 : 1'b0;
  assign out[6] = (in == 3'd6) ? 1'b1 : 1'b0;
  assign out[7] = (in == 3'd7) ? 1'b1 : 1'b0;
endmodule
