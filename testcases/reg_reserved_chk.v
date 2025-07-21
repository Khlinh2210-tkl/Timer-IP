task run_test;
	begin
		#100;
		write_data(TCR, 32'h0000_0203);
		#100;
		debug_mode = 1;
		write_data(THCSR, 32'h0000_0001);
		#100;
		write_data(THCSR, 32'h0000_0000);
		#500;
		debug_mode = 0;
		#200;
		sys_rst_n = 1'b0;
		#25 sys_rst_n= 1'b1;
		#100;
		debug_mode = 1;
		write_data(THCSR, 32'h0000_0001);
		#200;
		debug_mode = 0;
		#200;
		if(test_bench.err != 0) begin
			$display("Test_result FAILED");
		end else begin
			$display("Test_result PASSED");
	end  
end
endtask
