`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.06.2026 15:37:52
// Design Name: 
// Module Name: debouncer
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
module edge_detector (
  input   wire  clk,
  input   wire  rst,
  input   wire  button_in,
  output  wire   button_sync
);

reg R1;
reg	R2;

//2FF synchronizer
always @ (posedge clk or posedge rst) begin
	if(rst) begin
		R1 <= 0;
		R2 <= 0;
	end
	else begin
		R1 <= button_in;
		R2 <= R1;
	end
end

assign button_sync = R1 & ~R2;

endmodule 
