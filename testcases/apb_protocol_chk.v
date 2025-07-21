task run_test;
	begin
		#100;
		chk_rw_32b(TDR0, 32'h0000_00ff, 32'h0000_00ff, 32'hffff_ffff);
		chk_rw_32b(TDR0, 32'hffff_ff00, 32'hffff_ff00, 32'hffff_ffff);

		$display("============== tim_psel = 0, tim_penable = 1 =============");
		$display("===== WRITE TDR1 = 32'hffff_ffff ======");
		@(posedge sys_clk);
		tim_psel = 0;
		tim_pwrite = 1;
		tim_paddr = TDR1;
		tim_wdata = 32'hffff_ffff;
		@(posedge sys_clk);
		tim_penable = 1;
		@(posedge sys_clk);
		tim_psel = 0;
		tim_pwrite = 0;
		tim_penable = 0;
		tim_paddr = 0;
		$display("==== Data of TDR1 not changed =====");
		read_data(TDR1);

		$display("========== tim_psel = 1, tim_penable = 0 ==========");
		$display("Write TDR1 = 32'hffff_ffff =====");
		@(posedge sys_clk);
		tim_psel = 1;
		tim_pwrite = 1;
		tim_paddr = TDR1;
		tim_wdata = 32'hffff_ffff;
		@(posedge sys_clk);
		tim_penable = 0;
		@(posedge sys_clk);
		tim_psel = 0;
		tim_pwrite = 0;
		tim_penable = 0;
		tim_paddr = 0;
		$display("====== Data of TDR1 not changed ======");
		read_data (TDR1);

		$display("=========== Check pready, pslverr ============");
		$display("==== Write TDR1 = 32'hffff_ffff =======");
		@(posedge sys_clk);
		tim_psel = 1;
		tim_pwrite = 1;
		tim_paddr = TDR1;
		tim_wdata = 32'hffff_ffff;
		@(posedge sys_clk);
		tim_penable = 1;
		#1;
		$display("t=%10d tim_pready = %d, tim_pslverr = %d", $stime, tim_pready, tim_pslverr);
		@(posedge sys_clk);
		tim_psel = 0;
		tim_pwrite = 0;
		tim_penable = 0;
		tim_paddr = 0;
		$display("========== Data of TDR1 =========");
		read_data(TDR1);
	
		if(test_bench.err != 0) begin
			$display("Test_result FAILED");
		end else begin
			$display("Test_result PASSED");	
		end
		
	end
endtask

