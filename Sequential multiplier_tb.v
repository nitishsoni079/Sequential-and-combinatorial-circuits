// Code your testbench here
// or browse Examples
module sequential_multiplier_tb();
  reg C;
  reg [3:0] M;
  reg [3:0] Q;
  wire [8:0] Z;
  
  sequential_multiplier SM_uut(
    .C(C),
    .M(M),
    .Q(Q),
    .Z(Z)
  );
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0);
    C = 0;
    M = 0;
    Q = 0;
     
    #30
    
    C = 0;
    M = 4'b1101;
    Q = 4'b1101;
    
    #50
    
    $finish();
  end
endmodule
    
    