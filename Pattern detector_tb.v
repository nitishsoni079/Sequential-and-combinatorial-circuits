// Code your testbench here
// or browse Examples
module Pattern_Detector_tb();
  reg X;
  reg reset;
  reg clk;
  wire Y;
  
  Pattern_Detector instant(
    .X(X),
    .reset(reset),
    .clk(clk),
    .Y(Y)
  );
  
  always#10 clk = !clk;
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0);
    clk = 1'b0;
    reset = 1'b0;
    X = 1'b0;
    repeat(2) @(posedge clk)
    
    
    @(posedge clk)
     X <= 1'b1;
    @(posedge clk)
     X <= 1'b0;
    @(posedge clk)
     X <= 1'b1;
    @(posedge clk)
     X <= 1'b1;
    @(posedge clk)
     X <= 1'b1;
    @(posedge clk)
     X <= 1'b0;
    @(posedge clk)
     X <= 1'b1;
    @(posedge clk)
     X <= 1'b1;
    @(posedge clk)
     X <= 1'b0;
    @(posedge clk)
     X <= 1'b1;
    @(posedge clk)
     X <= 1'b1;
    #20
    $finish();
  end
endmodule
    
    
    
    