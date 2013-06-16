`include "timescale_inc.v"

////////////////////////////////////////////////////////////////////////////////
// Company: OSURC
// Engineer: Reese Russell
//
// Create Date: 03:23:52 06/16/2013
// Design Name: i2c_clk_ctrl_mod
// Module Name: C:/Users/Reese/Zynq_7020_ADV7511_int/i2c_clk_ctrl_tb.v
// Project Name: Zynq_7020_ADV7511_int
// Target Device: ISim   
// Tool versions: 14.5
// Description: Simple test bench
//
// Verilog Test Fixture created by ISE for module: i2c_clk_ctrl_mod
//
// Dependencies: None
// 
// Revision: 0.0.1
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module i2c_clk_ctrl_tb;

	// Inputs
	reg [0:0] clk_i;
	reg [0:0] rst_i;
	reg [7:0] cnt_tb_int;

	// Outputs
	wire [0:0] clk_o;
	// Instantiate the Unit Under Test (UUT)
	i2c_clk_ctrl_mod uut (
		.clk_i(clk_i), 
		.rst_i(rst_i), 
		.clk_o(clk_o)
	);

	initial begin
		// Initialize Inputs
		clk_i = 0;
		rst_i = 0;
		// Wait 100 ns for global reset to finish
		#100;
		rst_i = 1'b1;
		#100;
		rst_i = 1'b0;
	end
	
	always
		begin
			#5 clk_i = !clk_i;
		end

	always @ (posedge clk_i)
		begin
			if (clk_o)
				begin
					cnt_tb_int <= 1'b0;
				end
			else
				begin
					cnt_tb_int <= cnt_tb_int + 1'b1;
				end
		end
		      
endmodule

