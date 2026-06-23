`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.06.2026 15:37:52
// Design Name: 
// Module Name: top
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

module top(
	input wire sys_clk, sys_rst,
	input wire start,
	input wire stop,
	input wire increment,
	output wire [6:0] seg_out1, seg_out2,
	output wire [3:0] an1, an2
);
wire [3:0] ms0;
wire [3:0] ms1;
wire [3:0] ss0;
wire [2:0] ss1;
wire [3:0] MM0;
wire [2:0] MM1;
wire [3:0] HH0;
wire HH1;

wire clk_10MHz, clk_1kHz;
wire start_sync, stop_sync, increment_sync;

// Debouncer for input buttons
edge_detector inst1(.clk(clk_1kHz), .rst(sys_rst), .button_in(start), .button_sync(start_sync));
edge_detector inst2(.clk(clk_1kHz), .rst(sys_rst), .button_in(stop), .button_sync(stop_sync));
edge_detector inst3(.clk(clk_1kHz), .rst(sys_rst), .button_in(increment), .button_sync(increment_sync));

//Clock div 100MHz to 10MHz
clk_wiz_0 inst4
   (
    // Clock out ports
    .clk_out1(clk_10MHz),     // output clk_out1
    // Status and control signals
    .reset(sys_rst), // input reset
   // Clock in ports
    .clk_in1(sys_clk)      // input clk_in1
);

// Clock div 10MHz to 1kHz
clk_div_1kHz inst6(.clk_10MHz(clk_10MHz), .clk_1kHz(clk_1kHz), .rst(sys_rst));

// Core FSM- Stopwatch
stopwatch inst7(.clk_1kHz(clk_1kHz), .sys_rst(sys_rst), .start(start_sync), .stop(stop_sync), .increment(increment_sync), .ms0(ms0), .ms1(ms1), .ss0(ss0), .ss1(ss1), .MM0(MM0), .MM1(MM1), .HH0(HH0), .HH1(HH1));

// 7-segment display manager
display_manager inst8(.clk_1kHz(clk_1kHz), .sys_rst(sys_rst), .digit0(ms0), .digit1(ms1), .digit2(ss0), .digit3({1'b0, ss1}), .digit4(MM0), .digit5({1'b0, MM1}), .digit6(HH0), .digit7({3'b000, HH1}), .seg_out1(seg_out1), .seg_out2(seg_out2), .an1(an1), .an2(an2));


endmodule
