module mux_40xX_to_1xX (out, in, select);

  parameter WIDTH = 1;
  output [WIDTH-1:0] out;
  input [(40*WIDTH)-1:0] in;
  input [5:0] select;

  reg [WIDTH-1:0] out;

  always @ (in or select) begin
    casex(select)
// %%start_veriperl
// my $i;
// my $i_plus_one;
// for($i=0; $i<40; $i=$i+1)
// {
//   $i_plus_one = $i + 1;
//   print "      6'd$i : out <= in [(WIDTH*$i_plus_one)-1:WIDTH*$i];\n";
// }
// %%stop_veriperl
      6'd0 : out <= in [(WIDTH*1)-1:WIDTH*0];
      6'd1 : out <= in [(WIDTH*2)-1:WIDTH*1];
      6'd2 : out <= in [(WIDTH*3)-1:WIDTH*2];
      6'd3 : out <= in [(WIDTH*4)-1:WIDTH*3];
      6'd4 : out <= in [(WIDTH*5)-1:WIDTH*4];
      6'd5 : out <= in [(WIDTH*6)-1:WIDTH*5];
      6'd6 : out <= in [(WIDTH*7)-1:WIDTH*6];
      6'd7 : out <= in [(WIDTH*8)-1:WIDTH*7];
      6'd8 : out <= in [(WIDTH*9)-1:WIDTH*8];
      6'd9 : out <= in [(WIDTH*10)-1:WIDTH*9];
      6'd10 : out <= in [(WIDTH*11)-1:WIDTH*10];
      6'd11 : out <= in [(WIDTH*12)-1:WIDTH*11];
      6'd12 : out <= in [(WIDTH*13)-1:WIDTH*12];
      6'd13 : out <= in [(WIDTH*14)-1:WIDTH*13];
      6'd14 : out <= in [(WIDTH*15)-1:WIDTH*14];
      6'd15 : out <= in [(WIDTH*16)-1:WIDTH*15];
      6'd16 : out <= in [(WIDTH*17)-1:WIDTH*16];
      6'd17 : out <= in [(WIDTH*18)-1:WIDTH*17];
      6'd18 : out <= in [(WIDTH*19)-1:WIDTH*18];
      6'd19 : out <= in [(WIDTH*20)-1:WIDTH*19];
      6'd20 : out <= in [(WIDTH*21)-1:WIDTH*20];
      6'd21 : out <= in [(WIDTH*22)-1:WIDTH*21];
      6'd22 : out <= in [(WIDTH*23)-1:WIDTH*22];
      6'd23 : out <= in [(WIDTH*24)-1:WIDTH*23];
      6'd24 : out <= in [(WIDTH*25)-1:WIDTH*24];
      6'd25 : out <= in [(WIDTH*26)-1:WIDTH*25];
      6'd26 : out <= in [(WIDTH*27)-1:WIDTH*26];
      6'd27 : out <= in [(WIDTH*28)-1:WIDTH*27];
      6'd28 : out <= in [(WIDTH*29)-1:WIDTH*28];
      6'd29 : out <= in [(WIDTH*30)-1:WIDTH*29];
      6'd30 : out <= in [(WIDTH*31)-1:WIDTH*30];
      6'd31 : out <= in [(WIDTH*32)-1:WIDTH*31];
      6'd32 : out <= in [(WIDTH*33)-1:WIDTH*32];
      6'd33 : out <= in [(WIDTH*34)-1:WIDTH*33];
      6'd34 : out <= in [(WIDTH*35)-1:WIDTH*34];
      6'd35 : out <= in [(WIDTH*36)-1:WIDTH*35];
      6'd36 : out <= in [(WIDTH*37)-1:WIDTH*36];
      6'd37 : out <= in [(WIDTH*38)-1:WIDTH*37];
      6'd38 : out <= in [(WIDTH*39)-1:WIDTH*38];
      6'd39 : out <= in [(WIDTH*40)-1:WIDTH*39];
      default: out <= {WIDTH{1'bx}};
    endcase
  end
endmodule
