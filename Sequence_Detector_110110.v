`timescale 1ns/1ps

module seq_detec(clk,x,z,rst);
  input clk,x,rst;
  output reg z;
  reg [3:0] ps ,ns;
  parameter S0=3'b000 , S1=3'b001, S2=3'b010, S3=3'b011, S4=3'b100;
  
  always @(posedge clk, posedge rst) begin
    if (rst) begin
      z<=0;
      ps<=S0;
    end
    else
      ps<=ns;
  end
  always @(ps,x) begin
    case(ps)
      S0: begin
        z= x?0:0;
        ns=x?S1:S0;
      end
       S1: begin
        z= x?0:0;
        ns=x?S1:S2;
      end
       S2: begin
        z= x?0:0;
        ns=x?S3:S0;
      end
       S3: begin
        z= x?0:0;
        ns=x?S4:S0;
      end
      S4: begin
        z= x?0:1;
        ns=x?S2:S1;
      end
    endcase
  end
endmodule
    
    //Testbench

`timescale 1ns/1ps
module seq_detec_tb;
  reg clk,rst,x;
  wire z;
  seq_detec sq1 (.clk(clk),.x(x),.rst(rst),.z(z));
initial
  begin
    clk=0;
    rst=1;
    $dumpfile("seq_detec.vcd");
    $dumpvars;
  end
  
  always clk = #5 ~clk;
  initial
    begin
      $monitor("Input=%b Output=%b",x,z);
      
      #2 rst=0; x=0;
      #10 x=1;
      #10 x=0;
      #10 x=0;
      #10 x=1;
      #10 x=1;
      #10 x=0;
      #10 x=1;
      #10 x=1;
      #10 x=0;
      #10 x=1;
      #10 $finish;
    end
endmodule
