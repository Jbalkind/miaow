module mux_40x35b_to_1x35b (out, in, select);

  output [34:0] out;
  input [1399:0] in;
  input [5:0] select;

  reg [34:0] out;

  always @ (in or select) begin
    casex(select)
// %%start_veriperl
// my $i;
// my $low_index;
// my $high_index;
// for($i=0; $i<40; $i=$i+1)
// {
//   $low_index = 35*$i;
//   $high_index = 35*$i+34;
//   print "      6'd$i : out <= in [$high_index:$low_index];\n";
// }
// %%stop_veriperl
      6'd0 : out <= in [34:0];
      6'd1 : out <= in [69:35];
      6'd2 : out <= in [104:70];
      6'd3 : out <= in [139:105];
      6'd4 : out <= in [174:140];
      6'd5 : out <= in [209:175];
      6'd6 : out <= in [244:210];
      6'd7 : out <= in [279:245];
      6'd8 : out <= in [314:280];
      6'd9 : out <= in [349:315];
      6'd10 : out <= in [384:350];
      6'd11 : out <= in [419:385];
      6'd12 : out <= in [454:420];
      6'd13 : out <= in [489:455];
      6'd14 : out <= in [524:490];
      6'd15 : out <= in [559:525];
      6'd16 : out <= in [594:560];
      6'd17 : out <= in [629:595];
      6'd18 : out <= in [664:630];
      6'd19 : out <= in [699:665];
      6'd20 : out <= in [734:700];
      6'd21 : out <= in [769:735];
      6'd22 : out <= in [804:770];
      6'd23 : out <= in [839:805];
      6'd24 : out <= in [874:840];
      6'd25 : out <= in [909:875];
      6'd26 : out <= in [944:910];
      6'd27 : out <= in [979:945];
      6'd28 : out <= in [1014:980];
      6'd29 : out <= in [1049:1015];
      6'd30 : out <= in [1084:1050];
      6'd31 : out <= in [1119:1085];
      6'd32 : out <= in [1154:1120];
      6'd33 : out <= in [1189:1155];
      6'd34 : out <= in [1224:1190];
      6'd35 : out <= in [1259:1225];
      6'd36 : out <= in [1294:1260];
      6'd37 : out <= in [1329:1295];
      6'd38 : out <= in [1364:1330];
      6'd39 : out <= in [1399:1365];
      default: out <= 32'hxxxxxxxx;
    endcase
  end
endmodule
