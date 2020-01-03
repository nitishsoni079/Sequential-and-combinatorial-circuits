// Code your testbench here
`timescale 1ns/10ps

// or browse Examples
module RingCounter_tb;
  reg clk = 1'b0;
  reg clr;
  wire [2:0] Q;
  
  RingCounter instant(
    .clk(clk),
    .clr(clr),
    .Q(Q)
  );
  
  always #5 clk = !clk;
    
    
    initial begin
      
      $dumpfile("dump.vcd");
      $dumpvars(0);
      
      clk = 0;
      clr = 1;
      
      #10    
      clr = 0;
      #50
      
      $finish();
    
    end
endmodule