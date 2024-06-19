`timescale 1ns/1ps
module d_latch (q,d,en,rst);
  input en,rst,d;
  output reg q;
  
  always @ (en,rst) begin
    if (rst)
      q<=0;
    if(en) q<=d;
    else q<=q;
  end
endmodule

//Testbench

`timescale 1ns/1ps
module dlatch_tb();
  reg en,d,rst;
  wire q;
  
  d_latch dl1 (.en(en), .d(d), .rst(rst), .q(q));
  
  initial begin
    en = 0;
    rst =1;
    d =0;
    $dumpfile("dlatch_tb.vcd");
    $dumpvars();
    
  end
  
  
  always en =#5 ~en;
  
  initial begin
    #2 rst =0;
    repeat(5) #10 d=~d;
    #200 $finish;
  end
  
endmodule
  
  
