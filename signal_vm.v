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
	input wire b,
	input wire clk,
	output reg Ago,
	output reg Astop,
	output reg Bgo,
	output reg Bstop
);
reg reset;
reg crossing;
wire timer;
reg [3:0] current_state = 4'b0;
reg [3:0] next_state = 4'b0;
reg [3:0] previous = 4'b0;
reg [NBITS-1:0] cnt_ini;
reg [NBITS-1:0] cnt_rst;

//Sequential logic
always@(posedge clk) begin
	current_state = next_state;
	//$display("This is working");
	//$display(current_state);
end

//Combinatorial logic
//assign cnt_ini = 32'h0000;
//assign cnt_rst = 32'h1C9C380; // 3 secs

//FSM
localparam INIT = 4'b0000;
localparam Astart = 4'b0001;
localparam Await = 4'b0010;
localparam Ainit = 4'b0011;
localparam Bstart = 4'b0100;
localparam Bwait = 4'b0101;
localparam Binit = 4'b0110;
localparam Cstart = 4'b0111;
localparam Cwait = 4'b1000;
localparam Cinit = 4'b1001;

always @(posedge clk) begin
	//cnt_rst = (crossing) ? 32'h2FAF080 : 32'h1C9C380;
//$display(current_state);
	case(current_state)
		INIT: begin
			cnt_ini = 32'h0000;
			cnt_rst = 32'h1C9C380;
			crossing = 0;
			Ago = 1'b0;
			Bgo = 1'b0;
			Astop = 1'b0;
			Bstop = 1'b0;
			reset = 1'b1;
			next_state = Ainit;
		end
		Ainit: begin
			cnt_rst = 32'h1C9C380;
			if(crossing == 0 & b == 1)
				crossing = 1;
			Ago = 1'b1;
			Bgo = 1'b0;
			Astop = 1'b0;
			Bstop = 1'b1;
			reset = 1'b1;
			next_state = Astart;
		end
		Astart: begin
			if(crossing == 0 & b == 1)
				crossing = 1;
			Ago = 1'b1;
			Bgo = 1'b0;
			Astop = 1'b0;
			Bstop = 1'b1;
			reset = 1'b0;
			next_state = Await;
		end
		Await: begin
			if(crossing == 0 & b == 1)
				crossing = 1;
			Ago = 1'b1;
			Bgo = 1'b0;
			Astop = 1'b0;
			Bstop = 1'b1;
			reset = 1'b0;
			//$display("Timer is ");
			//$display(timer);
			previous = current_state;
			if(timer == 0)
				next_state = Await;
			else begin
				if(crossing == 1)
					next_state = Cinit;
				else
					next_state = Binit;
			end
		end
		Binit: begin
			cnt_rst = 32'h1C9C380;
			if(crossing == 0 & b == 1)
				crossing = 1;
			Ago = 1'b0;
			Bgo = 1'b1;
			Astop = 1'b1;
			Bstop = 1'b0;
			reset = 1'b1;
			next_state = Bstart;
		end
		Bstart: begin
			if(crossing == 0 & b == 1)
				crossing = 1;
			Ago = 1'b0;
			Bgo = 1'b1;
			Astop = 1'b1;
			Bstop = 1'b0;
			reset = 1'b0;
			next_state = Bwait;
		end
		Bwait: begin
			if(crossing == 0 & b == 1)
				crossing = 1;
			Ago = 1'b0;
			Bgo = 1'b1;
			Astop = 1'b1;
			Bstop = 1'b0;
			reset = 1'b0;
			previous = current_state;
			if(timer == 0)
				next_state = Bwait;
			else begin
				if(crossing == 1)
					next_state = Cinit;
				else
					next_state = Ainit;
			end
		end
		Cinit: begin
			$display("now allowing corssing...");
			crossing = 0;
			cnt_rst = 32'h2FAF080;
			Ago = 1'b0;
			Bgo = 1'b0;
			Astop = 1'b1;
			Bstop = 1'b1;
			reset = 1'b1;
			next_state = Cstart;
		end
		Cstart: begin
			Ago = 1'b0;
			Bgo = 1'b0;
			Astop = 1'b1;
			Bstop = 1'b1;
			reset = 1'b0;
			next_state = Cwait;
		end
		Cwait: begin
			Ago = 1'b0;
			Bgo = 1'b0;
			Astop = 1'b1;
			Bstop = 1'b1;
			reset = 1'b0;
			if(timer == 0) begin
				next_state = Cwait;
			end else begin
				if(previous == 4'b0010)
					next_state = Binit;
				else
					next_state = Ainit;
			end
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
