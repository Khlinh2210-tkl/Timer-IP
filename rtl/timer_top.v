module timer_top (
	input wire sys_clk,
	input wire sys_rst_n,
	input wire tim_pwrite,
	input wire tim_psel,
	input wire tim_penable,
	input wire [11:0] tim_paddr,
	input wire [31:0] tim_pwdata,
	input wire [3:0] tim_pstrb,
	input wire dbg_mode,
	output wire [31:0] tim_prdata,
	output wire tim_pready,
	output wire tim_pslverr,
	output wire tim_int
);

wire wr_en, rd_en;
wire timer_en, div_en, halt_req;
wire [3:0] div_val;
wire int_en, int_st;
wire tdr0_wr_sel, tdr1_wr_sel;
wire div_clk, cnt_en, cnt_clr, halt_ack;
wire [63:0] cnt;

apb_slave u_apb_slave
(
	.sys_clk  (sys_clk),
	.sys_rst_n  (sys_rst_n),
	.tim_pwrite (tim_pwrite),
	.tim_psel  (tim_psel),
	.tim_penable  (tim_penable),
	.tim_pready  (tim_pready),
	.tim_paddr  (tim_paddr),
	.tim_pslverr (tim_pslverr),
	.wr_en  (wr_en),
	.rd_en  (rd_en)
);

register u_register
(
	.sys_clk  (sys_clk),
	.sys_rst_n  (sys_rst_n),
	.cnt (cnt),
	.wr_en (wr_en),
	.rd_en (rd_en),
	.tim_paddr (tim_paddr),
	.tim_wdata (tim_pwdata),
	.halt_ack (halt_ack),
	.int_st (int_st),
	.int_en  (int_en),
	.halt_req (halt_req),
	.tim_rdata (tim_prdata),
	.timer_en (timer_en),
	.div_val (div_val),
	.div_en  (div_en),
	.tdr0_wr_sel (tdr0_wr_sel),
	.tdr1_wr_sel (tdr1_wr_sel)
);

counter_control u_counter_control
(
	.sys_clk  (sys_clk),
	.sys_rst_n  (sys_rst_n),
	.debug_mode (dbg_mode),
	.timer_en (timer_en),
	.div_en  (div_en),
	.halt_req  (halt_req),
	.div_val  (div_val),
	.cnt_en (cnt_en),
	.halt_ack (halt_ack),
	.div_clk (div_clk),
	.cnt_clr (cnt_clr)
);

counter  u_counter
(
	.sys_clk  (sys_clk),
	.sys_rst_n (sys_rst_n),
	.cnt_en  (cnt_en),
	.tim_wdata  (tim_pwdata),
	.tdr0_wr_sel (tdr0_wr_sel),
	.tdr1_wr_sel (tdr1_wr_sel),
	.cnt_clr  (cnt_clr),
	.cnt  (cnt),
	.halt_ack ( halt_ack),
	.div_clk (div_clk)
);

interrupt u_interrupt
(
	.int_en (int_en),
	.int_st (int_st),
	.tim_int (tim_int)
);

endmodule

