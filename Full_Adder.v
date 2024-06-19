`timescale 1ns/1ps
module full_adder(sum,cout,a,b,c);
  input a,b,c;
  output sum,cout;
  
  assign sum = a ^b^c;
  assign cout = ((a&b) |(c&(a^b)));
  
endmodule


//Testbench
`timescale 1ns/1ps
module full_adder_tb();
  reg a,b,c;
  wire sum,cout;
  full_adder fa1(.a(a),.b(b),.c(c),.sum(sum),.cout(cout));
  
  initial begin
    $monitor($time," a=%b b=%b c=%b sum=%b carry=%b",a,b,c,sum,cout);
     a=0; b=0; c=0;
    #10 c=1;
    #10 b=1; c=0;
    #10 c=1;
    #10 a=1; b=0; c=0;
    #10 c=1;
    #10 b=1; c=0;
    #10 c=1;
    #10 $finish;
    $dumpfile("fa_tb.vcd");
    $dumpvars;
   
  end
endmodule
