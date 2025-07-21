task run_test;
	begin
		#100;
		$display("======================================================");
		$display("=============== int_en = 0 ==========================");
		$display("=====================================================");
		write_data (TCMP0, 32'h0000_00ff);
		write_data (TCMP1, 32'h0000_0000);
		write_data (TCR, 32'h0000_0001);
		repeat (256) @(posedge sys_clk);
		read_data (TISR);
		$display("t=%10d TIM_INT = %d", $stime, tim_int);
		$display("=====WRITE 0 to TISR.int_st =====");
		write_data(TISR, 32'h00);
		$display("===== TISR.int_st remained ===");
		read_data (TISR);
		$display("=====WRITE 1 to TISR.int_st =====");
                write_data(TISR, 32'h01);
                $display("===== TISR.int_st cleared ===");
                read_data (TISR);
		

		#25 sys_rst_n = 1'b0;
		#25 sys_rst_n = 1'b1;

		$display("=================================================");
		$display("=================== int_en = 1 ==================");
		$display("=================================================");
		write_data (TCMP0, 32'h0000_00ff);
		write_data (TCMP1, 32'h0000_0000);
		write_data (TIER, 32'h0000_0001);
                write_data (TCR, 32'h0000_0001);
                 repeat (256) @(posedge sys_clk);
                 read_data (TISR);
                 $display("t=%10d TIM_INT = %d", $stime, tim_int);
                 $display("=====WRITE 0 to TISR.int_st =====");
                 write_data(TISR, 32'h00);
                 $display("===== TISR.int_st remained ===");
                 read_data (TISR);
                 $display("=====WRITE 1 to TISR.int_st =====");
                 write_data(TISR, 32'h01);
                 $display("===== TISR.int_st cleared ===");
                 read_data (TISR);
                 $display("t=%10d TIM_INT = %d", $stime, tim_int);
	
		#25 sys_rst_n = 1'b0;
                #25 sys_rst_n = 1'b1;
 
                $display("=================================================");
                $display("=================== int_en = 1 ==================");
                $display("=================================================");
                write_data (TCMP0, 32'h0000_00ff);
                write_data (TCMP1, 32'h0000_0000);
                write_data (TIER, 32'h0000_0001);
                write_data (TCR, 32'h0000_0001);
                repeat (256) @(posedge sys_clk);
                read_data (TISR);
                $display("t=%10d TIM_INT = %d", $stime, tim_int);
                $display("=====WRITE TIER.int_en = 0  =====");
                write_data(TIER, 32'h00);
                $display("===== TISR.int_st remained ===");
                read_data(TISR);
		$display("t=%10d TIM_INT = %d", $stime, tim_int);


	 	#25 sys_rst_n = 1'b0;
                #25 sys_rst_n = 1'b1;
  
                $display("=================================================");
                $display("=================== int_en = 1 ==================");
                $display("=================================================");
                write_data (TCMP0, 32'h0000_00ff);
                write_data (TCMP1, 32'h0000_0000);
                write_data (TIER, 32'h0000_0001);
                write_data (TCR, 32'h0000_0001);
                repeat (256) @(posedge sys_clk);
                read_data (TISR);
                $display("t=%10d TIM_INT = %d", $stime, tim_int);
                $display("=====WRITE Timer_en = 0  =====");
                write_data(TCR, 32'h00);
                $display("===== TISR.int_st remained ===");
                read_data (TISR);
                $display("t=%10d TIM_INT = %d", $stime, tim_int);

		// ket qua
		if(test_bench.err != 0) begin
			$display("Test_result FAILED");
		end else begin
			$display("Test_result PASSED");
	end 
end
endtask	
