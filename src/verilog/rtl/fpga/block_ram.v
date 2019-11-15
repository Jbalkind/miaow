// DO NOT USE THIS, THIS IS A PLACEHOLDER FOR A XILINX IP CORE BLOCK RAM

module block_ram
(
  clka,
  wea,
  addra,
  dina,
  douta,
  clkb,
  web,
  addrb,
  dinb,
  doutb
);

input clka, clkb;
input wea, web;
input [9:0] addra, addrb;
input [31:0] dina, dinb;
output [31:0] douta, doutb;

endmodule
