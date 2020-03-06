`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:44:08 03/05/2020
// Design Name:   timer_st
// Module Name:   D:/CS120A Labs/TrafficSignal/timer_tb.v
// Project Name:  TrafficSignal
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: timer_st
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module timer_tb;

	// Inputs
	reg clk;
	reg reset;
	reg [31:0] cnt_ini;
	reg [31:0] cnt_rst;

	// Outputs
	wire timer;

	// Instantiate the Unit Under Test (UUT)
	timer_st uut (
		.timer(timer), 
		.clk(clk), 
		.reset(reset), 
		.cnt_ini(cnt_ini), 
		.cnt_rst(cnt_rst)
	);

	initial begin
		// Initialize Inputs
		clk = 1;
		reset = 1;
		cnt_ini = 32'h0000;
		cnt_rst = 32'h2FAF080;

		// Wait 100 ns for global reset to finish
		#100;
		
		// Add stimulus here
	end
	
	always begin 
		#50 clk = !clk;
	end
      
endmodule

