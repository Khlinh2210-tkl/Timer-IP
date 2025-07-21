task run_test;
	begin
		#100;
		$display("===================================");
		$display("=== Case 1 : check reset value === ");
		$display("===================================");

		$display("========== TCR value ===========");
		chk_ro_32b(TCR, 32'h0000_0100, 32'hffff_ffff);

		$display("========== TDR0 value ============");
		chk_ro_32b(TDR0, 32'h0000_0000, 32'hffff_ffff);

		$display("=========== TDR1 value ============");
	       chk_ro_32b(TDR1, 32'h0000_0000, 32'hffff_ffff);

		$display("=========== TCMP0 value ============");
		chk_ro_32b(TCMP0, 32'hffff_ffff, 32'hffff_ffff);

		$display("=========== TCMP1 value ============");
		 chk_ro_32b(TCMP1, 32'hffff_ffff, 32'hffff_ffff);

		 $display("=========== TIER value ============");
                 chk_ro_32b(TIER, 32'h0000_0000, 32'hffff_ffff);

		 $display("=========== TISR value ============");
                 chk_ro_32b(TISR, 32'h0000_0000, 32'hffff_ffff);

		 $display("=========== THCSR value ============");
                 chk_ro_32b(THCSR, 32'h0000_0000, 32'hffff_ffff);

		 if(test_bench.err != 0) begin
			 $display("Test_result FAILED ");
		 end else begin
			 $display("Test_result PASSED");
	 end  
 end
 endtask

