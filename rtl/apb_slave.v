module apb_slave
(
	input wire sys_clk,
	input wire sys_rst_n,
	input wire tim_pwrite,
	input wire tim_psel,
	input wire tim_penable,
	input wire [11:0] tim_paddr,

	output wire tim_pready,
	output wire tim_pslverr,
	output wire wr_en,
	output wire rd_en
);

parameter TCR = 12'h00;
parameter TDR0 = 12'h04;
parameter TDR1 = 12'h08;
parameter TCMP0 = 12'h0C;
parameter TCMP1 = 12'h10;
parameter TIER = 12'h14;
parameter TISR = 12'h18;
parameter THCSR = 12'h1C;

reg AddrValid;
always @* begin
	case (tim_paddr)
		TCR: AddrValid = 1'b1;
		TDR0: AddrValid = 1'b1;
		TDR1: AddrValid = 1'b1;
		TCMP0: AddrValid = 1'b1;
		TCMP1: AddrValid = 1'b1;
		TIER: AddrValid = 1'b1;
		TISR: AddrValid = 1'b1;
		THCSR: AddrValid = 1'b1;
		default: AddrValid = 1'b0;
	endcase
end

assign tim_pready = 1'b1;
assign tim_pslverr = tim_pready & ~AddrValid;

assign wr_en = tim_psel & tim_penable & tim_pwrite & AddrValid ;
assign rd_en = tim_psel & tim_penable & ~tim_pwrite & AddrValid ;

endmodule
