// Code your design here
module Pattern_Detector(
  input X,
  input reset,
  input clk,
  output Y
);
  parameter IDLE                       = 4'b0000;
  parameter STATE_10                   = 4'b0001;
  parameter STATE_101                  = 4'b0010;
  parameter STATE_1011                 = 4'b0100;
  parameter STATE_start_checking_again = 4'b1000;
  
  reg [3:0] current_state, next_state;
  assign Y = current_state == STATE_start_checking_again? 1 : 0;
  
  always@(posedge clk)
    begin
      if(reset)
        current_state <= IDLE;
      else
        current_state <= next_state;
    end
  
  always@(current_state or X)
    begin
      case(current_state)
        
          IDLE:begin
            if(X)
              next_state <= STATE_10;
            else
              next_state <= IDLE;
          end
          
          STATE_10: begin
            if(X)
              next_state <= IDLE;
            else
              next_state <= STATE_101;
          end
          
          STATE_101: begin
            if(X) 
              next_state <= STATE_1011;
            else
              next_state <= STATE_10;
          end
          
          STATE_1011: begin
            if(X) 
              next_state <= STATE_start_checking_again;
            else
              next_state <= STATE_10;
            end
           STATE_start_checking_again: begin
             if(X)
               next_state <= STATE_10;
             else
               next_state <= STATE_101;
           end
             
          default: next_state <= IDLE;
         endcase
      
      end
 endmodule
          
                
  
  