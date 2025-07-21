module test_bench;
parameter TCR  = 12'h00;
parameter TDR0 = 12'h04;
parameter TDR1 = 12'h08;
parameter TCMP0 = 12'h0C;
parameter TCMP1 = 12'h10;
parameter TIER = 12'h14;
parameter TISR = 12'h18;
parameter THCSR = 12'h1C;

integer err = 0;

reg sys_clk;
reg sys_rst_n;
reg tim_pwrite;
reg tim_psel;
reg tim_penable;
reg [11:0] tim_paddr;
reg [31:0] tim_wdata;
reg debug_mode;
wire [31:0] tim_rdata;
wire tim_int;
wire tim_pready;
wire tim_pslverr;

`include "../sim/run_test.v"

timer_top u_timer_top (
	.sys_clk (sys_clk),
	.sys_rst_n (sys_rst_n),
	.dbg_mode (debug_mode),
	.tim_psel (tim_psel),
	.tim_penable (tim_penable),
	.tim_pwrite (tim_pwrite),
	.tim_paddr (tim_paddr),
	.tim_pwdata (tim_wdata),
	.tim_prdata (tim_rdata),
	.tim_pready (tim_pready),
	.tim_pslverr (tim_pslverr),
	.tim_int (tim_int)
);

initial begin 
	sys_clk = 0;
	forever #25 sys_clk= ~sys_clk;
end

initial begin
	sys_rst_n = 1'b0;
	#25 sys_rst_n= 1'b1;
//end

//initial begin
	tim_psel = 0;
	tim_penable = 0;
	tim_pwrite = 0;
	//tim_paddr = 0;;
	//tim_pstrb = 0;
	debug_mode = 0;
	run_test();
	#100 $finish;

	// In ra ket qua 
	//if (err != 0) begin
	//	$display(" Test_result FALIED ");
	//end else begin
	//	$display(" Test_result PASSED");
	//end

end

task chk_ro_32b;
	input [31:0] in_addr;
	input [31:0] exp_data;
	input [31:0] mask;
	begin
		$display("[INFO] RO check task");
		@(posedge sys_clk);
		tim_psel = 1;
		tim_pwrite = 0;
		tim_paddr = in_addr;
		@(posedge sys_clk);
		tim_penable = 1;
		#1;
		if((tim_rdata & mask)  !== (exp_data & mask)) begin
			$display("------------------------------------------------");
			$display("t= %10d FAIL: rdata at addr 12'h%2h is not correct", $time, tim_paddr);
			$display("Exp: 32'h%x Actual: 32'h%x", exp_data & mask, tim_rdata & mask);
			$display("------------------------------------------------");
			err = err + 1;
			#100;
		end else begin
			$display("-----------------------------------------------");
			$display("t=%10d PASS: rdata = 32'h%x at addr 12'h%2h is correct", $time, tim_rdata, tim_paddr);
			$display("----------------------------------------------");
		end
		@(posedge sys_clk);
		tim_psel = 0;
		tim_pwrite = 0;
		tim_penable = 0;
		tim_paddr = 0;
	end
endtask

task chk_rw_32b;
	input [31:0] in_addr;
	input [31:0] in_wdata;
	input [31:0] exp_data;
	input [31:0] mask;
	begin
		$display("[INFO] RW check task");
		$display("Write data = 32'h%x at addr: 12'h%2h", in_wdata, in_addr);
		@(posedge sys_clk);
		tim_psel = 1;
		tim_pwrite = 1;
		tim_paddr = in_addr;
		tim_wdata = in_wdata;
		@(posedge sys_clk);
		tim_penable = 1;
		@(posedge sys_clk);
		tim_psel = 0;
		tim_pwrite = 0;
		tim_penable = 0;
		tim_paddr = 0;
		tim_wdata = 32'h0;
		@(posedge sys_clk);
		tim_psel = 1;
		tim_pwrite = 0;
		tim_paddr = in_addr;
		@(posedge sys_clk);
		tim_penable = 1;
		#1;
		if ((tim_rdata & mask) !== (exp_data & mask) ) begin
			$display("------------------------------------------------");
			$display("t=%10d FAIL: rdata at addr 12'h%2h is not correct", $time, tim_paddr);
			$display("Exp: 32;h%x Actual: 32'h%x", exp_data & mask, tim_rdata & mask);
			$display("---------------------------------------------------");
			err = err + 1;
			#100;
		end else begin
			$display("---------------------------------------------------");
			$display("t=%10d PASS: rdata = 32'h%x at addr 12'h%2h is correct", $time, tim_rdata, tim_paddr);
			$display("-----------------------------------------------------");
		end
		@(posedge sys_clk);
		tim_psel = 0;
		tim_pwrite = 0;
		tim_penable = 0;
		tim_paddr = 0;
	end
endtask

task chk_cnt_ctrl;
	input [31:0] in_wdata;
	begin
		$display("Write data = 32'h%x", in_wdata);
		@(posedge sys_clk);
		tim_psel = 1;
		tim_pwrite = 1;
		tim_paddr = TCR;
		tim_wdata = in_wdata;
		@(posedge sys_clk);
		tim_penable = 1;
		@(posedge sys_clk);
		tim_psel = 0;
		tim_pwrite = 0;
		tim_penable =0;
		tim_paddr = 0;
		#1;
		$display("---------------------------------------------");
		$display("t= %10d Timer_en = %d, div_en = %d, div_val= %d", $stime, u_timer_top .u_register.timer_en, u_timer_top.u_register.div_en, u_timer_top .u_register.div_val);
		$display("-----------------------------------------");
	       repeat (255) @(posedge sys_clk);
       #1;
end
endtask


task write_data;
       input [31:0] in_addr;
       input [31:0] in_wdata;
	begin
		$display("Write data = 32'h%x at add : 12'h%2h", in_wdata, in_addr);
		@(posedge sys_clk);
		tim_psel = 1;
		tim_pwrite = 1;
		tim_paddr = in_addr;
		tim_wdata = in_wdata;
		@(posedge sys_clk);
		tim_penable = 1;
		@(posedge sys_clk);
		tim_psel = 0;
		tim_pwrite = 0;
		tim_penable = 0;
		tim_paddr = 0;
	end
endtask

task read_data;
	input [31:0] in_addr;
	begin
		@(posedge sys_clk);
		tim_psel = 1;
		tim_pwrite = 0;
		tim_paddr = in_addr;

		@(posedge sys_clk);
		tim_penable = 1;
		@(posedge sys_clk);
		tim_psel = 0;
		tim_pwrite = 0;
		tim_penable = 0;
		tim_paddr = 0;
		$display("----------------------------------------");
                $display("t=%10d rdata = 32'h%x at addr: 12'h%2h", $stime, tim_rdata, in_addr);
                $display("-------------------------------------------------");
         end
endtask		
		
endmodule
