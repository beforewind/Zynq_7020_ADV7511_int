`include "timescale_inc.v"

module includes_mod();
	initial
		begin
			`ifdef INCLUDES
				$display ("Includes have been defined");
			`else
				$display ("Inludes are successfully defined");
			`endif
		end

endmodule