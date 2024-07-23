`timescale 1ns / 1ps

module top_tb;

reg clk, reset;

Top Top_inst(.clk(clk), .reset(reset));

initial begin
    #1 clk = 0;
    #3 reset = 1;
    #1 reset = 0;
end

initial begin
    #5 clk = 0;
    forever #5 clk = ~clk;
end

endmodule
