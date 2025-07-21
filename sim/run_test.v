task run_test;
	begin
		#100;
		$display("==========================================================");
		$display("======== Case 2: Check RW access value ==========");
		$display("=====================================================");

		$display("=============== TCR value ================");
		chk_rw_32b(TCR, 32'h0000_0000, 32'h0000_0000, 32'hffff_ffff);
		chk_rw_32b(TCR, 32'hffff_ffff, 32'h0000_0003, 32'hffff_ffff);
		chk_rw_32b(TCR, 32'h5555_5555, 32'h0000_0501, 32'hffff_ffff);
		chk_rw_32b(TCR, 32'haaaa_aaaa, 32'h0000_0502, 32'hffff_ffff);
		chk_rw_32b(TCR, 32'h5aa5_a55a, 32'h0000_0502, 32'hffff_ffff);

		#25 sys_rst_n = 1'b0;
		#25 sys_rst_n = 1'b1;

		$display("=============== TDR0 value ================");
                chk_rw_32b(TDR0, 32'h0000_0000, 32'h0000_0000, 32'hffff_ffff);
                chk_rw_32b(TDR0, 32'hffff_ffff, 32'hffff_ffff, 32'hffff_ffff);
                chk_rw_32b(TDR0, 32'h5555_5555, 32'h5555_5555, 32'hffff_ffff);
                chk_rw_32b(TDR0, 32'haaaa_aaaa, 32'haaaa_aaaa, 32'hffff_ffff);
                chk_rw_32b(TDR0, 32'h5aa5_a55a, 32'h5aa5_a55a, 32'hffff_ffff);

		$display("=============== TDR1 value ================");
                chk_rw_32b(TDR1, 32'h0000_0000, 32'h0000_0000, 32'hffff_ffff);
                chk_rw_32b(TDR1, 32'hffff_ffff, 32'hffff_ffff, 32'hffff_ffff);
                chk_rw_32b(TDR1, 32'h5555_5555, 32'h5555_5555, 32'hffff_ffff);
                chk_rw_32b(TDR1, 32'haaaa_aaaa, 32'haaaa_aaaa, 32'hffff_ffff);
                chk_rw_32b(TDR1, 32'h5aa5_a55a, 32'h5aa5_a55a, 32'hffff_ffff);

		$display("=============== TCMP0 value ================");
                 chk_rw_32b(TCMP0, 32'h0000_0000, 32'h0000_0000, 32'hffff_ffff);
                 chk_rw_32b(TCMP0, 32'hffff_ffff, 32'hffff_ffff, 32'hffff_ffff);
                 chk_rw_32b(TCMP0, 32'h5555_5555, 32'h5555_5555, 32'hffff_ffff);
                 chk_rw_32b(TCMP0, 32'haaaa_aaaa, 32'haaaa_aaaa, 32'hffff_ffff);
                 chk_rw_32b(TCMP0, 32'h5aa5_a55a, 32'h5aa5_a55a, 32'hffff_ffff);

		$display("=============== TCMP1 value ================");
                  chk_rw_32b(TCMP1, 32'h0000_0000, 32'h0000_0000, 32'hffff_ffff);
                  chk_rw_32b(TCMP1, 32'hffff_ffff, 32'hffff_ffff, 32'hffff_ffff);
                  chk_rw_32b(TCMP1, 32'h5555_5555, 32'h5555_5555, 32'hffff_ffff);
                  chk_rw_32b(TCMP1, 32'haaaa_aaaa, 32'haaaa_aaaa, 32'hffff_ffff);
                  chk_rw_32b(TCMP1, 32'h5aa5_a55a, 32'h5aa5_a55a, 32'hffff_ffff);

		$display("=============== TIER value ================");
                  chk_rw_32b(TIER, 32'h0000_0000, 32'h0000_0000, 32'hffff_ffff);
                  chk_rw_32b(TIER, 32'hffff_ffff, 32'h0000_00001, 32'hffff_ffff);
                  chk_rw_32b(TIER, 32'h5555_5555, 32'h0000_0001, 32'hffff_ffff);
                  chk_rw_32b(TIER, 32'haaaa_aaaa, 32'h0000_0000, 32'hffff_ffff);
                  chk_rw_32b(TIER, 32'h5aa5_a55a, 32'h0000_0000, 32'hffff_ffff);

		#25 sys_rst_n = 1'b0;
		#25 sys_rst_n = 1'b1;

		$display("========== TISR value ===========");
		u_timer_top.u_register.int_st = 1;
		#1;
		$display("tisr = %b", u_timer_top.u_register.int_st);
                  chk_rw_32b(TISR, 32'h0000_0001, 32'h0000_0000, 32'hffff_ffff);
                  chk_rw_32b(TISR, 32'h0000_0000, 32'h0000_0000, 32'hffff_ffff);
                  chk_rw_32b(TISR, 32'hffff_ffff, 32'h0000_0000, 32'hffff_ffff);
                  chk_rw_32b(TISR, 32'h5555_5555, 32'h0000_0000, 32'hffff_ffff);
                  chk_rw_32b(TISR, 32'haaaa_aaaa, 32'h0000_0000, 32'hffff_ffff);
		  chk_rw_32b(TISR, 32'h5aa5_a55a, 32'h0000_0000, 32'hffff_ffff);

		$display("=============== THCSR value ================");
                  chk_rw_32b(THCSR, 32'h0000_0000, 32'h0000_0000, 32'hffff_ffff);
                  chk_rw_32b(THCSR, 32'hffff_ffff, 32'h0000_00001, 32'hffff_ffff);
                  chk_rw_32b(THCSR, 32'h5555_5555, 32'h0000_0001, 32'hffff_ffff);
                  chk_rw_32b(THCSR, 32'haaaa_aaaa, 32'h0000_0000, 32'hffff_ffff);
                  chk_rw_32b(THCSR, 32'h5aa5_a55a, 32'h0000_0000, 32'hffff_ffff);

		$display("=============== Reserved value ================");
                  chk_rw_32b( 32'h4000_1ffc, 32'hffff_ffff,32'h0000_0000, 32'hffff_ffff);
                  chk_rw_32b( 32'h4000_0020, 32'hffff_ffff,32'h0000_0000, 32'hffff_ffff);
                  chk_rw_32b(12'h03, 32'hffff_ffff, 32'h0000_0000, 32'hffff_ffff);
                
		  chk_rw_32b(TCR, 32'h0000_0103, 32'h0000_0103, 32'hffff_ffff);
		  #100 sys_rst_n = 1'b0;
		  chk_ro_32b(TCR, 32'h0000_0100, 32'hffff_ffff);
		  chk_ro_32b(TDR0, 32'h0000_0000, 32'hffff_ffff);
		  chk_ro_32b(TDR1, 32'h0000_0000, 32'hffff_ffff);
		  chk_ro_32b(TCMP0, 32'hffff_ffff, 32'hffff_ffff);
		  chk_ro_32b(TCMP1, 32'hffff_ffff, 32'hffff_ffff);

		  //
		  if (test_bench.err != 0) begin
			  $display("Test_result FAILED");
		  end else begin
			  $display("Test_result PASSED ");
	  end  
  end
  endtask

