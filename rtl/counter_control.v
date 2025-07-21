module counter_control
(
	input wire sys_clk,
	input wire sys_rst_n,
	input wire timer_en,
	input wire div_en,
	input wire halt_req,
	input wire [3:0] div_val,
	output wire div_clk,
	output wire cnt_en,
	input wire debug_mode,
	output wire halt_ack,
	output reg cnt_clr
);
reg [7:0] int_cnt;
reg [7:0] int_cnt_max;
wire [7:0] int_cnt_nxt;
wire cnt_rst;

always @* begin
	case (div_val)
		4'd0 : int_cnt_max = 8'd0;
		4'd1 : int_cnt_max = 8'd1;
		4'd2 : int_cnt_max = 8'd3;
		4'd3 : int_cnt_max = 8'd7;
		4'd4 : int_cnt_max = 8'd15;
		4'd5 : int_cnt_max = 8'd31;
		4'd6 : int_cnt_max = 8'd63;
		4'd7 : int_cnt_max = 8'd127;
		4'd8 : int_cnt_max = 8'd255;
		default: int_cnt_max = 8'hxx;
	endcase
end

always @(posedge sys_clk or negedge sys_rst_n) begin
	if(!sys_rst_n) begin
		int_cnt <= 8'h00 ;
	end else if (cnt_en) begin 
		int_cnt <= 8'h00;
	end else if (timer_en) begin
		int_cnt <= int_cnt_nxt + 1'b1;
	end else begin
		int_cnt <= int_cnt_nxt;
	end
end
	
	assign halt_ack = debug_mode & halt_req;
	assign cnt_rst = (int_cnt == int_cnt_max) | (!timer_en) | (!div_en);
	assign int_cnt_nxt = cnt_rst ? 8'h00 : int_cnt;
	
	assign cnt_en = (!timer_en) ? 1'b0: (div_en == 0) ? 1'b1 : (div_val == 0) ? 1'b1 : (int_cnt == int_cnt_max);
	assign div_clk = (div_en == 0) ? sys_clk : (div_val == 0) ? sys_clk : ( int_cnt == int_cnt_max);

endmodule
