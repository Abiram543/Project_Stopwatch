`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.06.2026 14:30:04
// Design Name: 
// Module Name: clk_1kHz
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
module clk_div_1kHz(
    input wire clk_10MHz, rst, 
    output reg clk_1kHz
    );
    reg [12:0]div_count;
    
    always@(posedge clk_10MHz or posedge rst)
    begin
        if(rst) begin
            div_count <= 0;
            clk_1kHz <= 0;
         end
         else begin
            if(div_count==13'd4999)
            begin
                div_count <= 0;
                clk_1kHz <= ~clk_1kHz;
            end
            else begin
                div_count <= div_count + 1;
               end
          end
    end
endmodule


