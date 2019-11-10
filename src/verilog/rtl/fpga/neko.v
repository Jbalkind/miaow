module neko #
(
	parameter integer NEKO_AXI_DATA_WIDTH	= 32,
	parameter integer NEKO_AXI_ADDR_WIDTH	= 11
)
(
    input                                   chipset_clk,
    input                                   rst_n,

    input                                   noc2_in_val,
    input       [`NOC_DATA_WIDTH-1:0]       noc2_in_data,
    output                                  noc2_in_rdy,

    output                                  noc3_out_val,
    output      [`NOC_DATA_WIDTH-1:0]       noc3_out_data,
    input                                   noc3_out_rdy

`ifdef PITON_PMESH_MIAOW
    ,
    output                                  noc2_out_val,
    output      [`NOC_DATA_WIDTH-1:0]       noc2_out_data,
    input                                   noc2_out_rdy,

    input                                   noc3_in_val,
    input       [`NOC_DATA_WIDTH-1:0]       noc3_in_data,
    output                                  noc3_in_rdy
`endif
);


	wire  neko_axi_aclk;
	wire  neko_axi_aresetn;
	wire [NEKO_AXI_ADDR_WIDTH-1 : 0] neko_axi_awaddr;
	wire [2 : 0] neko_axi_awprot;
	wire  neko_axi_awvalid;
	wire  neko_axi_awready;
	wire [NEKO_AXI_DATA_WIDTH-1 : 0] neko_axi_wdata;
	wire [(NEKO_AXI_DATA_WIDTH/8)-1 : 0] neko_axi_wstrb;
	wire  neko_axi_wvalid;
	wire  neko_axi_wready;
	wire [1 : 0] neko_axi_bresp;
	wire  neko_axi_bvalid;
	wire  neko_axi_bready;
	wire [NEKO_AXI_ADDR_WIDTH-1 : 0] neko_axi_araddr;
	wire [2 : 0] neko_axi_arprot;
	wire  neko_axi_arvalid;
	wire  neko_axi_arready;
	wire [NEKO_AXI_DATA_WIDTH-1 : 0] neko_axi_rdata;
	wire [1 : 0] neko_axi_rresp;
	wire  neko_axi_rvalid;
	wire  neko_axi_rready;

    assign neko_axi_aclk = chipset_clk;
    assign neko_axi_aresetn = rst_n;

noc_axilite_bridge noc_neko_bridge   (
    .clk                    (chipset_clk        ),
    .rst                    (~rst_n             ),      // TODO: rewrite to positive ?
           
    .splitter_bridge_val    (noc2_in_val   ),
    .splitter_bridge_data   (noc2_in_data  ),
    .bridge_splitter_rdy    (noc2_in_rdy   ),   // CRAZY NAMING !

    .bridge_splitter_val    (noc3_out_val   ),
    .bridge_splitter_data   (noc3_out_data  ),
    .splitter_bridge_rdy    (noc3_out_rdy   ),   // CRAZY NAMING !
       
    //axi lite signals             
    //write address channel
    .m_axi_awaddr        (neko_axi_awaddr),
    .m_axi_awvalid       (neko_axi_awvalid),
    .m_axi_awready       (neko_axi_awready),

    //write data channel
    .m_axi_wdata         (neko_axi_wdata),
    .m_axi_wstrb         (neko_axi_wstrb),
    .m_axi_wvalid        (neko_axi_wvalid),
    .m_axi_wready        (neko_axi_wready),

    //read address channel
    .m_axi_araddr        (neko_axi_araddr),
    .m_axi_arvalid       (neko_axi_arvalid),
    .m_axi_arready       (neko_axi_arready),

    //read data channel
    .m_axi_rdata         (neko_axi_rdata),
    .m_axi_rresp         (neko_axi_rresp),
    .m_axi_rvalid        (neko_axi_rvalid),
    .m_axi_rready        (neko_axi_rready),

    //write response channel
    .m_axi_bresp         (neko_axi_bresp),
    .m_axi_bvalid        (neko_axi_bvalid),
    .m_axi_bready        (neko_axi_bready)
);

    compute_unit_fpga # (
        .C_S_AXI_DATA_WIDTH(NEKO_AXI_DATA_WIDTH),
        .C_S_AXI_ADDR_WIDTH(NEKO_AXI_ADDR_WIDTH)
    ) compute_unit_fpga (
        .S_AXI_ACLK(neko_axi_aclk),
		.S_AXI_ARESETN(neko_axi_aresetn),
		.S_AXI_AWADDR(neko_axi_awaddr),
		.S_AXI_AWPROT(neko_axi_awprot),
		.S_AXI_AWVALID(neko_axi_awvalid),
		.S_AXI_AWREADY(neko_axi_awready),
		.S_AXI_WDATA(neko_axi_wdata),
		.S_AXI_WSTRB(neko_axi_wstrb),
		.S_AXI_WVALID(neko_axi_wvalid),
		.S_AXI_WREADY(neko_axi_wready),
		.S_AXI_BRESP(neko_axi_bresp),
		.S_AXI_BVALID(neko_axi_bvalid),
		.S_AXI_BREADY(neko_axi_bready),
		.S_AXI_ARADDR(neko_axi_araddr),
		.S_AXI_ARPROT(neko_axi_arprot),
		.S_AXI_ARVALID(neko_axi_arvalid),
		.S_AXI_ARREADY(neko_axi_arready),
		.S_AXI_RDATA(neko_axi_rdata),
		.S_AXI_RRESP(neko_axi_rresp),
		.S_AXI_RVALID(neko_axi_rvalid),
		.S_AXI_RREADY(neko_axi_rready)
`ifdef PITON_PMESH_MIAOW
,
        .noc2_filter_val(noc2_out_val),
        .noc2_filter_data(noc2_out_data),
        .filter_noc2_rdy(noc2_out_rdy),
        .filter_noc3_val(noc3_in_val),
        .filter_noc3_data(noc3_in_data),
        .noc3_filter_rdy(noc3_in_rdy)
`endif
    );
endmodule
