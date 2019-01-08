module mux_40x64b_to_1x64b (out, in, select);

  output [63:0] out;
  input [2559:0] in;
  input [5:0] select;

  reg [63:0] out;

  always @ (in or select) begin
    casex(select)
// %%start_veriperl
// my $i;
// my $low_index;
// my $high_index;
// for($i=0; $i<40; $i=$i+1)
// {
//   $low_index = 64*$i;
//   $high_index = 64*$i+63;
//   print "      6'd$i : out <= in [$high_index:$low_index];\n";
// }
// %%stop_veriperl
      6'd0 : out <= in [63:0];
      6'd1 : out <= in [127:64];
      6'd2 : out <= in [191:128];
      6'd3 : out <= in [255:192];
      6'd4 : out <= in [319:256];
      6'd5 : out <= in [383:320];
      6'd6 : out <= in [447:384];
      6'd7 : out <= in [511:448];
      6'd8 : out <= in [575:512];
      6'd9 : out <= in [639:576];
      6'd10 : out <= in [703:640];
      6'd11 : out <= in [767:704];
      6'd12 : out <= in [831:768];
      6'd13 : out <= in [895:832];
      6'd14 : out <= in [959:896];
      6'd15 : out <= in [1023:960];
      6'd16 : out <= in [1087:1024];
      6'd17 : out <= in [1151:1088];
      6'd18 : out <= in [1215:1152];
      6'd19 : out <= in [1279:1216];
      6'd20 : out <= in [1343:1280];
      6'd21 : out <= in [1407:1344];
      6'd22 : out <= in [1471:1408];
      6'd23 : out <= in [1535:1472];
      6'd24 : out <= in [1599:1536];
      6'd25 : out <= in [1663:1600];
      6'd26 : out <= in [1727:1664];
      6'd27 : out <= in [1791:1728];
      6'd28 : out <= in [1855:1792];
      6'd29 : out <= in [1919:1856];
      6'd30 : out <= in [1983:1920];
      6'd31 : out <= in [2047:1984];
      6'd32 : out <= in [2111:2048];
      6'd33 : out <= in [2175:2112];
      6'd34 : out <= in [2239:2176];
      6'd35 : out <= in [2303:2240];
      6'd36 : out <= in [2367:2304];
      6'd37 : out <= in [2431:2368];
      6'd38 : out <= in [2495:2432];
      6'd39 : out <= in [2559:2496];
      default: out <= {64{1'bx}};
    endcase
  end
endmodule
