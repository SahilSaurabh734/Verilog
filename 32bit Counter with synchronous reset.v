`timescale 1ns/1p
module counter (count, clock,reset);
  input clock, reset;
  output reg [31:0] count =0;
  
  
  always @(posedge clock) begin
    if (reset)
      count<=0;
    else 
      count <=count+1;
  end
endmodule


`timescale 1ns/1ps
module count_tb();
  wire [31:0] count;
  reg clock, reset;
  counter c1 (.clock(clock), .count(count), .reset(reset));
  initial begin
    clock=0;
    reset=1;
    $dumpfile("count_tb.vcd");
    $dumpvars;
  end
   always clock = #5 ~clock;
  initial begin
    #2 reset = 0;
    $monitor($time ," Count = %0d",count);
   #500 $finish;
  end
endmodule
