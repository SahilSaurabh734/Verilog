`timescale 1ns/1ps

module clk_gen(clk);
  input clk;
endmodule

//Testbench

`timescale 1ns/1ps
module clk_gen_tb;
  reg clk;
  initial begin
    clk=0;
  $dumpfile("clk_gen_tb.vcd");
  $dumpvars;
  end
  
  always clk = #100 ~clk;
  
  initial
    #1000 $finish;
endmodule
