module counter
(
	input wire div_clk,
	input wire sys_clk,
	input wire sys_rst_n,
	input wire cnt_en,
	input wire cnt_clr,
	input wire halt_ack,
	input wire [31:0] tim_wdata,
	input wire tdr0_wr_sel,
	input wire tdr1_wr_sel,
	output wire [63:0] cnt
);
	wire [63:0] cnt_plus1;
	wire [31:0] tdr0_pre;
	wire [31:0] tdr1_pre;
	reg [31:0] tdr0;
	reg [31:0] tdr1;

	assign cnt_plus1 = cnt +1'b1;
	assign tdr0_pre[31:0] = tdr0_wr_sel ? tim_wdata[31:0] : cnt_en ? cnt_plus1[31:0] : tdr0;
	assign tdr1_pre[31:0] = tdr1_wr_sel ? tim_wdata[31:0] : cnt_en ? cnt_plus1[63:32] : tdr1;

always @(posedge sys_clk or negedge sys_rst_n) begin
	if( !sys_rst_n) begin
		tdr0 <= 32'h0;
		tdr1 <= 32'h0;
	end else begin
		tdr0 <= tdr0_pre;
		tdr1 <= tdr1_pre;
	end
end

assign cnt[63:0] = {tdr1, tdr0};

endmodule
