module register
( 
	input wire sys_clk,
	input wire sys_rst_n,
	input wire [63:0] cnt,
	input wire rd_en,
	input wire wr_en,

	input wire [11:0] tim_paddr,
	input wire [31:0] tim_wdata,
	output reg [31:0] tim_rdata,
	input wire halt_ack,
	output reg int_st,
	output reg int_en,

	output reg timer_en,
	output reg [3:0] div_val,
	output reg div_en,
	output reg halt_req,
	output wire tdr0_wr_sel,
	output wire tdr1_wr_sel
);

parameter TCR  = 12'h00;
parameter TDR0 = 12'h04;
parameter TDR1 = 12'h08;
parameter TCMP0 = 12'h0C;
parameter TCMP1 = 12'h10;
parameter TIER = 12'h14;
parameter TISR = 12'h18;
parameter THCSR = 12'h1C;

wire tcr_wr_sel;
wire timer_en_pre;
wire div_en_pre;
wire [3:0] div_val_pre;

always @(posedge sys_clk or negedge sys_rst_n) begin
	if( !sys_rst_n) begin
		timer_en <= 1'b0;
		div_en <= 1'b0;
		div_val <= 4'b0001;
	end else begin
		timer_en <= timer_en_pre;
		div_en <= div_en_pre;
		div_val <= div_val_pre;
	end
end

// select
assign tcr_wr_sel = wr_en & (tim_paddr == TCR);
assign tdr0_wr_sel = wr_en & (tim_paddr == TDR0);
assign tdr1_wr_sel = wr_en & (tim_paddr ==TDR1);
assign timer_en_pre = tcr_wr_sel ? tim_wdata[0] : timer_en;
assign div_en_pre = tcr_wr_sel ? tim_wdata[1] : div_en;
assign div_val_pre = (tcr_wr_sel && (tim_wdata[11:8] < 4'd9)) ? tim_wdata[11:8] : div_val;

wire tcmp0_wr_sel;
wire [31:0] tcmp0_pre;
reg [31:0] tcmp0;

always @(posedge sys_clk or negedge sys_rst_n) begin
	if(!sys_rst_n) begin
		tcmp0 <= 32'hffffffff;
	end else begin
		tcmp0 <= tcmp0_pre;
	end
end

assign tcmp0_wr_sel = wr_en & (tim_paddr == TCMP0);
assign tcmp0_pre = tcmp0_wr_sel ? tim_wdata : tcmp0;


wire tcmp1_wr_sel;
wire [31:0] tcmp1_pre;
reg [31:0] tcmp1;

always @(posedge sys_clk or negedge sys_rst_n) begin
	if(! sys_rst_n) begin
		tcmp1 <= 32'hffffffff;
	end else begin
		tcmp1 <= tcmp1_pre;
	end
end

assign tcmp1_wr_sel = wr_en & ( tim_paddr == TCMP1);
assign tcmp1_pre = tcmp1_wr_sel ? tim_wdata : tcmp1;

wire tier_wr_sel;
wire int_en_pre;

always @(posedge sys_clk or negedge sys_rst_n) begin
	if(!sys_rst_n) begin
		int_en <= 1'b0;
	end else begin
		int_en <= int_en_pre;
	end
end

assign tier_wr_sel = wr_en & (tim_paddr == TIER);
assign int_en_pre = tier_wr_sel ? tim_wdata[0] : int_en;


wire tisr_wr_sel;
wire int_st_pre;
wire value_match;

always @(posedge sys_clk or negedge sys_rst_n) begin
	if(!sys_rst_n) begin
		int_st <= 1'b0;
	end else begin
		int_st <= int_st_pre;
	end
end

assign value_match = cnt == {tcmp1, tcmp0};
assign tisr_wr_sel = wr_en & (tim_paddr == TISR);
assign int_st_pre = (tisr_wr_sel && tim_wdata[0] && int_st) ?1'b0 : ( value_match) ? 1'b1 : int_st;


wire thcsr_wr_sel;
wire halt_req_pre;

always @(posedge sys_clk or negedge sys_rst_n) begin
	if(!sys_rst_n) begin
		halt_req <= 1'b0;
	end else begin
		halt_req <= halt_req_pre;
	end
end

assign thcsr_wr_sel = wr_en & (tim_paddr == THCSR);
assign halt_req_pre = thcsr_wr_sel ? tim_wdata[0] : halt_req;


always @* begin
	if(rd_en) begin
		case(tim_paddr)
			TCR: tim_rdata = {20'b0, div_val, 6'b0, div_en, timer_en};
			TDR0: tim_rdata = cnt[31:0];
			TDR1: tim_rdata = cnt[63:32];
			TCMP0: tim_rdata = tcmp0;
			TCMP1: tim_rdata = tcmp1;
			TIER: tim_rdata = {31'b0, int_en};
			TISR: tim_rdata = {31'b0, int_st};
			THCSR: tim_rdata = {30'b0, halt_ack, halt_req};
			default: tim_rdata = 32'b0;
		endcase
	end else begin
		tim_rdata = 32'b0;
	end
end

endmodule
