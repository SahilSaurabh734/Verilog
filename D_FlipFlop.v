`timescale 1ns/1ps
module d_ff (q,d,clk,rst);
  input clk,rst,d;
  output reg q;
  
  always @ (posedge clk, posedge rst) begin
    if (rst)
      q<=0;
    else q<=d;
  end
endmodule


`timescale 1ns/1ps
module dff_tb();
  reg clk,d,rst;
  wire q;
  
  d_ff dff1 (.clk(clk), .d(d), .rst(rst), .q(q));
  
  initial begin
    clk = 0;
    rst =1;
    d =0;
    $dumpfile("dff_tb.vcd");
    $dumpvars;
    
  end
  
  
  always clk =#5 ~clk;
  
  initial begin
    #2 rst =0;
    repeat(10) #10 d=~d;
    #200 $finish;
  end
  
endmodule
  
  
