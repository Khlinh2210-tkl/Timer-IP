task run_test;
	begin
		#100;
		$display("=============== DEFAULT MODE ==============");
		chk_cnt_ctrl(32'h201);
		$display("==== CONTROL MODE ======");
		$display("=========================");
		$display("===== DIV_VAL = 0 =======");
		chk_cnt_ctrl(32'h03);
		$display("===== DIV_VAL =1 ====");
		chk_cnt_ctrl (32'h103);
		$display("===== DIV_VAL = 2 ====");
                chk_cnt_ctrl (32'h203);
		$display("===== DIV_VAL = 3 ====");
                chk_cnt_ctrl (32'h303);
		$display("===== DIV_VAL = 4 ====");
                chk_cnt_ctrl (32'h403);
		$display("===== DIV_VAL = 5 ====");
                chk_cnt_ctrl (32'h503);
		$display("===== DIV_VAL = 6 ====");
                chk_cnt_ctrl (32'h603);
		$display("===== DIV_VAL = 7 ====");
                chk_cnt_ctrl (32'h703);
		$display("===== DIV_VAL = 8 ====");
                chk_cnt_ctrl (32'h803);

		if(test_bench.err != 0) begin
			$display("Test_result FAILED");
		end else begin
			$display("Test_result PASSED");
	end   
end
endtask
