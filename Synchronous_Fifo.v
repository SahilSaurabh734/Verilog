`timescale 1ns/1ps
module sync_fifo #(parameter FIFO_DEPTH = 16, parameter DATA_WIDTH=8) (clk,rst,wr_en,rd_en,full,empty,data_in,data_out);
  input clk,rst,wr_en,rd_en;
  input [DATA_WIDTH-1:0] data_in;
  output reg [DATA_WIDTH-1:0] data_out;
  output reg full=0;
  output reg empty=1;
  reg [DATA_WIDTH-1:0] mem [FIFO_DEPTH-1:0];
  reg [$clog2(FIFO_DEPTH)-1:0] wr_ptr,rd_ptr;
  reg [$clog2(FIFO_DEPTH)+1:0] count =0;
  
  always @(count) begin
    empty = (count==0)?1:0;
    full = (count==5'b10000)?1:0;
  end
  
  always @(posedge clk , posedge rst) begin
    if (rst)
      count<=0;
    else if (!full && wr_en)
      count<=count+1;
    else if (!empty && rd_en)
      count<=count-1;
    else count <=count;
  end
  
   always @(posedge clk , posedge rst) begin
     if (rst) begin
       rd_ptr<=0;
       data_out<=0;
     end
     else if (!empty && rd_en) begin
       rd_ptr<=rd_ptr+1;
       data_out<=mem[rd_ptr];
     end
     else begin
       rd_ptr<=rd_ptr;
       data_out<=data_out;
     end
   end
  
  
    always @(posedge clk , posedge rst) begin
     if (rst) begin
       wr_ptr<=0;
     end
      else if (!full && wr_en) begin
       wr_ptr<=wr_ptr+1;
        mem[wr_ptr]<=data_in;
     end
     else begin
       wr_ptr<=wr_ptr;
       mem[wr_ptr]<=mem[wr_ptr];
     end
   end
endmodule


//Testbench

`timescale 1ns/1ps
module sync_fifo_tb;
  reg clk,rst,wr_en, rd_en;
  reg [7:0] data_in;
  wire [7:0] data_out;
  wire empty,full;
    
  sync_fifo fifo1 (.clk(clk),.rst(rst),.wr_en(wr_en),.rd_en(rd_en),.data_in(data_in),.data_out(data_out),.full(full),.empty(empty));
  
  initial begin
    $monitor("time=%0t data_in=%0d data_out=%0d",$time,data_in,data_out);
    
    
    rst=1;
    clk=0;
    wr_en=0;
    rd_en=0;
    
    $dumpfile("fifo_tb.vcd");
    $dumpvars;
  end
  always clk =#5~clk;
  initial begin
    #2 rst =0; wr_en=1;
    repeat(16) #10 data_in = $random;
    #10 wr_en=0; rd_en=1;
    #200 rd_en=0;
    #10 $finish;
  end
  
endmodule
    
  
    
