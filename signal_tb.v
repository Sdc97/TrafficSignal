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
	reg b;
	
	// Outputs
	wire Ago;
	wire Astop;
	wire Bgo;
	wire Bstop;

	// Instantiate the Unit Under Test (UUT)
	signal_vm uut (
		.b(b),
		.clk(clk), 
		.Ago(Ago), 
		.Astop(Astop), 
		.Bgo(Bgo), 
		.Bstop(Bstop)
	);
	
	initial begin
		// Initialize Inputs
		b = 0;
		clk = 0;
		
		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		#250
		b = 1;
		#200
		b = 0;
	end
   
	always begin 
		#50 clk = !clk;
	end
endmodule

