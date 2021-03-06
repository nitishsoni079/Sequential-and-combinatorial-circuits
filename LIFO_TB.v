`timescale 1ns / 1ps

module LIFObuffer_tb;
  
 reg [3:0] dataIn;
 reg RW;
 reg EN;
 reg Rst;
 reg Clk;
 wire [3:0] dataOut;
 wire EMPTY;
 wire FULL;

  LIFObuffer uut (
    .dataIn(dataIn), 
    .dataOut(dataOut),
    .RW(RW),
    .EN(EN),  
    .Rst(Rst), 
    .EMPTY(EMPTY), 
    .FULL(FULL), 
    .Clk(Clk)
    );

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0);
    
  dataIn  = 4'h0;
  RW  = 1'b0;
  EN  = 1'b0;
  Rst  = 1'b1;
  Clk  = 1'b0;
  #100;      
    
  EN   = 1'b1;
  Rst  = 1'b1;
  #40;
  EN      <= 1'b1;
  Rst     <= 1'b0;
  RW      <= 1'b0;
  dataIn  <= 4'h0;

  #20;

  dataIn = 4'h2;

  #20;

  dataIn = 4'h4;

  #20;

  dataIn = 4'h6;

  #20;

  RW  = 1'b1;
  #100
   $finish();

 end 

 always #10 Clk = ~Clk;

endmodule

