`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.06.2026 14:30:04
// Design Name: 
// Module Name: dis_7seg
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
module dis_7seg(
    input wire [3:0] digit,
    output reg [6:0] segpins
    );
	
  always@(*) begin
    case(digit)
    4'd0: segpins = 7'b1000000;
    4'd1: segpins = 7'b1111001;
    4'd2: segpins = 7'b0100100;
    4'd3: segpins = 7'b0110000;
	4'd4: segpins = 7'b0011001;
	4'd5: segpins = 7'b0010010;
	4'd6: segpins = 7'b0000010;
	4'd7: segpins = 7'b1111000;
	4'd8: segpins = 7'b0000000;
	4'd9: segpins = 7'b0010000;
    default: segpins = 7'b1111111;
    endcase
  end
endmodule
