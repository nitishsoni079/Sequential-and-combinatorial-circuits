// Code your design here
module RingCounter(
  input wire clk,
  input wire clr,
  output reg [2:0] Q
);
  
  always@ (posedge clk or posedge clr)
    begin
      if (clr)
        Q <= 3'b001;
       else
         Q <= {Q[0], Q[2:1]};
     end 
         
endmodule
    