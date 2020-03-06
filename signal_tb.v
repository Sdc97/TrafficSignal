`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:23:52 03/05/2020
// Design Name:   signal_vm
// Module Name:   D:/CS120A Labs/TrafficSignal/signal_tb.v
// Project Name:  TrafficSignal
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: signal_vm
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module signal_tb;

	// Inputs
	reg clk;
	
	// Outputs
	wire Ago;
	wire Astop;
	wire Bgo;
	wire Bstop;

	// Instantiate the Unit Under Test (UUT)
	signal_vm uut (
		.clk(clk), 
		.Ago(Ago), 
		.Astop(Astop), 
		.Bgo(Bgo), 
		.Bstop(Bstop)
	);

	initial begin
		// Initialize Inputs
		clk = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
			
	end
   
	always begin 
		#50 clk = !clk;
	end
endmodule

