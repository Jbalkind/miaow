module mux_8x64b_to_1x64b (out, in, select);

  output [63:0] out;
  input [511:0] in;
  input [2:0] select;

  reg [63:0] out;

  always @ (in or select) begin
    casex(select)
// %%start_veriperl
// my $i;
// my $low_index;
// my $high_index;
// for($i=0; $i<8; $i=$i+1)
// {
//   $low_index = 64*$i;
//   $high_index = 64*$i+63;
//   print "      3'd$i : out <= in [$high_index:$low_index];\n";
// }
// %%stop_veriperl
      3'd0 : out <= in [63:0];
      3'd1 : out <= in [127:64];
      3'd2 : out <= in [191:128];
      3'd3 : out <= in [255:192];
      3'd4 : out <= in [319:256];
      3'd5 : out <= in [383:320];
      3'd6 : out <= in [447:384];
      3'd7 : out <= in [511:448];
      default: out <= {64{1'bx}};
    endcase
  end
endmodule
