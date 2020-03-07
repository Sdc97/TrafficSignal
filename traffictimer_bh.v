`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:22:36 03/06/2020 
// Design Name: 
// Module Name:    traffictimer_bh 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module traffictimer_bh#(
 parameter NBITS = 32
)
(
 output wire timer ,
 input wire clk ,
 input wire reset,
 input [NBITS-1:0] cnt_ini ,
 input [NBITS-1:0] cnt_rst
);
integer i = 0;
integer same = 0;
integer current =	0;
always @(posedge clk) begin
	if(reset == 0) begin
		current = current + 1;
		if(current == cnt_rst)
			same = 1;
		else
			same = 0;
	end else begin
		current = 0;
		same = 0;
	end
end

assign timer = (same >= 'd1) ? 'd1 : 'd0;

endmodule
