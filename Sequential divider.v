// Code your design here
module Seq_Divider(
  input [7:0] Q,
  input [7:0] M,
  output [7:0] Quo,
  output [7:0] Rem
);
  
  reg [7:0] Quo = 0;
  reg [7:0] Rem = 0;
  reg [7:0] a1;
  reg [7:0] b1;
  reg [7:0] A;
  integer i;
  always@(Q or M)
  begin
    a1 = Q;
    b1 = M;
    A = 0;
  for(i = 0; i<8; i = i +1)
    begin
      A[7:0] = {A[6:0], a1[7]};
      a1[7:1] = {a1[6:0]};
      A = A - b1;
      if(A[7] == 1)
        begin
          a1[0] = 0;
          A = A + b1;
        end
      else
        a1[0] = 1;
    end
  Quo = a1;
  Rem = A;
  end
endmodule
      
      