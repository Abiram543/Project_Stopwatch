# Project_Stopwatch
Implement Stopwatch design using Boolean board.
Objective: Design and implement a five-digit digital stopwatch using the seven-segment display of the 
Boolean board. The stopwatch must accurately count time from 00.000 to 99.999 seconds, with 1ms 
resolution. It should support Start, Stop, Increment, and Clear functionalities through dedicated 
pushbuttons.
Specifications: 
• Display Output: 
o Use the seven-segment display to show time in the format HH.MM.SS.mm 
(Seconds.Milliseconds). 
o Rolls over after 11.59.59.99 seconds back to 00.00.00.00. 
• Clocking: 
o Internally use the FPGA’s high-frequency clock and generate a 1kHz (1ms) pulse for 
stopwatch incrementing. 3. Inputs (Pushbuttons): 
o Start: Begins counting at a 1kHz rate. 
o Stop: Pauses the count without resetting the display. 
o Increment: Manually increments the current value by 1ms on each press (detect only 
edges). 
o Clear: Immediately resets the counter to 00.000. 4. Other Requirements: 
o Debounce all button inputs.
o Ensure button actions (especially increment) are edge-detected, not level-based.
Deliverables: 
• Verilog/VHDL code implementing stopwatch logic. 
• Testbench (for simulation). 
• Demonstration on the Boolean board. 
• Optional: Use LEDs to indicate which mode is active (running/paused).
