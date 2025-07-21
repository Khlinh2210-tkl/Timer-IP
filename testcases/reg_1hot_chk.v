task run_test;
begin
	write_data (TCR, 32'h0000_0802);
	write_data (TDR0, 32'hffff_ff00);
	write_data (TDR1, 32'hffff_fffe);
	write_data (TCMP0, 32'h0000_0000);
	write_data (TCMP1, 32'h0000_0001);
	write_data (TIER, 32'h00ff_ff00);
	write_data (TISR, 32'hff00_00ff);
	write_data (THCSR, 32'h0f0f_0f0f);

	chk_ro_32b(TCR, 32'h0000_0802, 32'hffff_ffff);
        chk_ro_32b(TDR0, 32'hffff_ff00, 32'hffff_ffff);
        chk_ro_32b(TDR1, 32'hffff_fffe, 32'hffff_ffff);
        chk_ro_32b(TCMP0, 32'h0000_0000, 32'hffff_ffff);
        chk_ro_32b(TCMP1, 32'h0000_0001, 32'hffff_ffff);
	chk_ro_32b(TIER, 32'h0000_0000, 32'hffff_ffff);
	chk_ro_32b(TISR, 32'h0000_0000, 32'hffff_ffff);
	chk_ro_32b(THCSR, 32'h0000_0001, 32'hffff_ffff);

	chk_rw_32b(TCR, 32'h0000_0000,32'h0000_0000, 32'hffff_ffff);
        chk_ro_32b(TDR0, 32'hffff_ff00,32'hffff_ffff);
        chk_rw_32b(TDR0, 32'h0000_0000,32'h0000_0000, 32'hffff_ffff);

	if(test_bench.err != 0) begin
		$display("Test_result FAILED");
	end else begin
		$display("Test_result PASSED");
end  
end
	
endtask



