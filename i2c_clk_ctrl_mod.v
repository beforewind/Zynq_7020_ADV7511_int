/*********************************************************************************
/  Company: OSURC
/  Engineer: Reese Russell
/  
/  Create Date:	23:39:48 06/15/2013 
/  Design Name: i2c clk control module
/  Module Name:	i2c_clk_ctrl_mod 
/  Project Name: AD5711 
/  Target Devices: 
/  Tool versions: 14.5
/  Description: 
/
/  Dependencies: 
/ 
/  Revision: 0.0.1
/  Revision 0.01 - File Created
/  Additional Comments: 
/ 
*********************************************************************************/
module i2c_clk_ctrl_mod(
	input wire  [0:0]  clk_i, 
	input wire  [0:0]  rst_i,
	
	output reg  [0:0]  clk_o
	);
	// Use floor(ln(in_clk_freq)/ln(2))+1 to obtain bit depth
	// Unless it end ur being a whole interger such as 64 to 6bits
	parameter par_in_bit_dpth     = 28;
	parameter par_in_clk_freq     = 100000000;
	parameter par_out_clk_freq    = 400000 * 2 ;

	// 
	reg   [par_in_bit_dpth - 1:0] d_int;
	wire  [par_in_bit_dpth - 1:0] d_inc_int = d_int[par_in_bit_dpth - 1] ?
		  (par_out_clk_freq):(par_out_clk_freq - par_in_clk_freq);
	wire  [par_in_bit_dpth - 1:0] d_n_int = d_int + d_inc_int;
	wire  [0:0] b_clk = ~d_int[par_in_bit_dpth - 1];

	// async rst with clk 
	always @ (posedge b_clk or posedge rst_i)
		begin
			if (rst_i)
				begin	
					clk_o <= 1'b0;
				end
			else
				begin
					clk_o <= !clk_o;
				end
		end 
			
	always @ (posedge clk_i or posedge rst_i)
		begin
			if (rst_i)
				begin
					d_int <= 1'b0;
					$display("Reset @: %t", $realtime);
				end
			else 
				begin
					d_int <= d_n_int;
					$display("d_int val: %d", d_int);
				end
		end
	
endmodule
