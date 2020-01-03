// Code your design here
module sequential_multiplier(
  input C,
  input [3:0] M,
  input [3:0] Q,
  output reg [8:0] Z
);
  integer i;
  
  reg [3:0] A = 0;
  always@(M,Q,C)
    begin
      Z[8:0] = {C, A, Q};
      for(i=0; i<4; i=i+1)
        begin
          if(Z[0] == 1)
            begin
                Z[8:4] = Z[8:4] + M;
                Z = Z>>1;
            end
          else
            Z = Z>>1;
        end
    end
endmodule
        
      
  
  