`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:31:36 03/04/2020 
// Design Name: 
// Module Name:    signal_vm 
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
module signal_vm#(
parameter NBITS = 32
)
(
	input wire clk,
	output reg Ago,
	output reg Astop,
	output reg Bgo,
	output reg Bstop
);
reg reset;
wire timer;
reg [2:0] current_state = 3'b0;
reg [2:0] next_state = 3'b0;
wire [NBITS-1:0] cnt_ini;
wire [NBITS-1:0] cnt_rst;

//Sequential logic
always@(posedge clk) begin
	current_state = next_state;
	//$display("This is working");
	//$display(current_state);
end

//Combinatorial logic
assign cnt_ini = 32'h0000;
assign cnt_rst = 32'h1C9C380; // 3 secs

//FSM
localparam INIT = 3'b000;
localparam Astart = 3'b001;
localparam Await = 3'b010;
localparam Ainit = 3'b011;
localparam Bstart = 3'b100;
localparam Bwait = 3'b101;
localparam Binit = 3'b110;

always @(posedge clk) begin
//$display(current_state);
	case(current_state)
		INIT: begin
			Ago = 1'b0;
			Bgo = 1'b0;
			Astop = 1'b0;
			Bstop = 1'b0;
			reset = 1'b1;
			next_state = Ainit;
		end
		Ainit: begin
			Ago = 1'b1;
			Bgo = 1'b0;
			Astop = 1'b0;
			Bstop = 1'b1;
			reset = 1'b1;
			next_state = Astart;
		end
		Astart: begin
			Ago = 1'b1;
			Bgo = 1'b0;
			Astop = 1'b0;
			Bstop = 1'b1;
			reset = 1'b0;
			next_state = Await;
		end
		Await: begin
			Ago = 1'b1;
			Bgo = 1'b0;
			Astop = 1'b0;
			Bstop = 1'b1;
			reset = 1'b0;
			//$display("Timer is ");
			//$display(timer);
			if(timer == 0)
				next_state = Await;
			else
				next_state = Binit;
		end
		Binit: begin
			Ago = 1'b0;
			Bgo = 1'b1;
			Astop = 1'b1;
			Bstop = 1'b0;
			reset = 1'b1;
			next_state = Bstart;
		end
		Bstart: begin
			Ago = 1'b0;
			Bgo = 1'b1;
			Astop = 1'b1;
			Bstop = 1'b0;
			reset = 1'b0;
			next_state = Bwait;
		end
		Bwait: begin
			Ago = 1'b0;
			Bgo = 1'b1;
			Astop = 1'b1;
			Bstop = 1'b0;
			reset = 1'b0;
			if(timer == 0)
				next_state = Bwait;
			else
				next_state = Ainit;
		end
		default: begin
			reset = 1'b0;
			next_state = INIT;
		end
	endcase
end

traffictimer_bh #( .NBITS(NBITS) ) timerst (
.timer(timer),
.clk(clk),
.reset(reset) ,
.cnt_ini(cnt_ini) ,
.cnt_rst(cnt_rst)
);

endmodule
