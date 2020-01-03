// Code your testbench here
// or browse Examples
module Seq_Divider_tb();
  reg  [7:0] Q;
  reg  [7:0] M;
  wire [7:0] Quo;
  wire [7:0] Rem;
  
  Seq_Divider instant(
    .Q(Q),
    .M(M),
    .Quo(Quo),
    .Rem(Rem)
  );
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0);
    
    #50
    Q = 8'b11000000;
    M = 8'b00000011;
    #50
    
    $finish();
  end
endmodule
    
    