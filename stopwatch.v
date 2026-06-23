`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.06.2026 14:30:04
// Design Name: 
// Module Name: stopwatch
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`default_nettype none
module stopwatch(
input wire clk_1kHz,
input wire sys_rst,
input wire start,
input wire stop,
input wire increment,
output reg [3:0] ms0, 
output reg [3:0] ms1,
output reg [3:0] ss0, 
output reg [2:0] ss1,
output reg [3:0] MM0, 
output reg [2:0] MM1,
output reg [3:0] HH0, 
output reg 		 HH1
);

// State Parameterization
localparam IDLE = 2'd0,
		   S1 = 2'd1,
		   S2 = 2'd2,
		   S3 = 2'd3;
		   
// Counter registers
reg       count_HH1;
reg [3:0] count_HH0;
reg [3:0] count_MM0;
reg [2:0] count_MM1;
reg [3:0] count_ss0;
reg [2:0] count_ss1;
reg [3:0] count_ms0;
reg [3:0] count_ms1;
reg [3:0] count;

// state registers
reg [1:0] PS, NS;


// Temp count values
wire count_temp;
wire count_ms0_temp;
wire count_ms1_temp;
wire count_ss0_temp;
wire count_ss1_temp;
wire count_MM0_temp;
wire count_MM1_temp;
wire count_HH0_temp;
wire count_HH1_temp;

// Present state logic
always @ (posedge clk_1kHz or posedge sys_rst) begin
	if(sys_rst)
		PS <= IDLE;
	else 
		PS <= NS;
end

// Next state logic
always @ * begin
	case (PS)
		IDLE: begin
			if(start)
				NS = S1;
			else if(stop)
				NS = S2;
			else
				NS = IDLE;
		end
		S1: begin
			if(stop)
				NS = S2;
			else 
				NS = S1;
		end
		S2: begin
			if(start)
				NS = S1;
			else if(increment)
				NS = S3;
			else
				NS = S2;
		end
		S3: begin
				NS = S2;
		end
		default: NS = IDLE;
		endcase
end

// Counter logic
always @ (posedge clk_1kHz or posedge sys_rst) begin
	if(sys_rst) begin
		count_HH1 <= 0;
		count_HH0 <= 0;
		count_MM0 <= 0;
		count_MM1 <= 0;
        count_ss0 <= 0;
        count_ss1 <= 0;
		count_ms0 <= 0;
        count_ms1 <= 0;
		count <= 0;
	end
	else begin
	case(PS)
	IDLE: begin
		count_HH1 <= 0;
        count_HH0 <= 0;
        count_MM0 <= 0;
        count_MM1 <= 0;
        count_ss0 <= 0;
        count_ss1 <= 0;
        count_ms0 <= 0;
        count_ms1 <= 0;
		count <= 0;
	end
	S1: begin
	if(count_temp) begin
		count <= 0;
		if(count_ms0_temp) begin
			count_ms0 <= 0;
			if(count_ms1_temp) begin
				count_ms1 <= 0;
				if(count_ss0_temp) begin
					count_ss0 <= 0;
					if(count_ss1_temp) begin
						count_ss1 <= 0;
						if(count_MM0_temp) begin
							count_MM0 <= 0;
							if(count_MM1_temp) begin
								count_MM1 <= 0;
								if(count_HH0_temp) begin
									count_HH1 <= count_HH1 + 1;
									count_HH0 <= 0;
								end
								else begin
									count_HH0 <= count_HH0 + 1;
								end
							end
							else begin
								count_MM1 <= count_MM1 + 1;
							end
						end
						else begin
							count_MM0 <= count_MM0 + 1;
						end
					end
					else begin
						count_ss1 <= count_ss1 + 1;
					end
				end
				else begin
					count_ss0 <= count_ss0 + 1;
				end
			end
			else begin
				count_ms1 <= count_ms1 + 1;
			end
		end
		else begin
			count_ms0 <= count_ms0 + 1;
		end
	end
	else begin
		count <= count + 1;
	end
	end
	S2: begin
		count_HH1 <= count_HH1;
		count_HH0 <= count_HH0;
		count_MM0 <= count_MM0;
		count_MM1 <= count_MM1;
		count_ss0 <= count_ss0;
		count_ss1 <= count_ss1;
        count_ms0 <= count_ms0;
        count_ms1 <= count_ms1;
	end
	S3: begin
		if(count_ms0_temp) begin
		    count_ms0 <= 0;
			if(count_ms1_temp) begin
				count_ms1 <= 0;
				if(count_ss0_temp) begin
					count_ss0 <= 0;
					if(count_ss1_temp) begin
						count_ss1 <= 0;
						if(count_MM0_temp) begin
							count_MM0 <= 0;
							if(count_MM1_temp) begin
								count_MM1 <= 0;
								if(count_HH0_temp) begin
									count_HH1 <= count_HH1 + 1;
									count_HH0 <= 0;
								end
								else begin
									count_HH0 <= count_HH0 + 1;
								end
							end
							else begin
								count_MM1 <= count_MM1 + 1;
							end
						end
						else begin
							count_MM0 <= count_MM0 + 1;
						end
					end
					else begin
						count_ss1 <= count_ss1 + 1;
					end
				end
				else begin
					count_ss0 <= count_ss0 + 1;
				end
			end
			else begin
				count_ms1 <= count_ms1 + 1;
			end
		end
		else begin
			count_ms0 <= count_ms0 + 1;
		end
	end
	default: begin
		count_HH1 <= 0;
		count_HH0 <= 0;	
        count_MM0 <= 0;
        count_MM1 <= 0;
        count_ss0 <= 0;
        count_ss1 <= 0;
        count_ms0 <= 0;
        count_ms1 <= 0;
        count <= 0;
	end
	endcase
	end
end

// Output logic
always @ * begin
	ms0 = count_ms0;
    ms1 = count_ms1;
    ss0 = count_ss0;
    ss1 = count_ss1;
    MM0 = count_MM0;
    MM1 = count_MM1;
    HH0 = count_HH0;
    HH1 = count_HH1;
end

// Temp combo ckt for counter value
assign count_temp = (count == 4'd9) ? 1'b1 : 1'b0;
assign count_ms0_temp = (count_ms0 == 4'd9) ? 1'b1 : 1'b0;
assign count_ms1_temp = (count_ms1 == 4'd9) ? 1'b1 : 1'b0;
assign count_ss0_temp = (count_ss0 == 4'd9) ? 1'b1 : 1'b0;
assign count_ss1_temp = (count_ss1 == 3'd5) ? 1'b1 : 1'b0;
assign count_MM0_temp = (count_MM0 == 4'd9) ? 1'b1 : 1'b0;
assign count_MM1_temp = (count_MM1 == 3'd5) ? 1'b1 : 1'b0;
assign count_HH0_temp = (count_HH0 == 4'd9) ? 1'b1 : 1'b0;
     
endmodule


