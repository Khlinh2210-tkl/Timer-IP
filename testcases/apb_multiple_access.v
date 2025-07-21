task run_test;
	begin
		#100;
		write_data(TDR0, 32'hffff_ff00);
		write_data(TDR1, 32'hffff_ffff);
		chk_ro_32b(TDR0, 32'hffff_ff00, 32'hffff_ffff);
		chk_ro_32b(TDR1, 32'hffff_ffff, 32'hffff_ffff);
		chk_rw_32b(TDR0, 32'hffff_ffff, 32'hffff_ffff, 32'hffff_ffff);
		chk_rw_32b(TDR1, 32'hffff_fffe, 32'hffff_fffe, 32'hffff_ffff);
		
		if(test_bench.err != 0 ) begin
			$display("Test_result FAILED");
		end else begin
			$display("Test_result PASSED");
		end
	
	end
endtask
