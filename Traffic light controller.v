module traffic_light(
  input  wire   clk,
  input  wire   reset,
  output reg    [2:0] light_A,
  output reg    [2:0] light_B
);
  
  parameter FIRST_STATE  = 3'b000;
  parameter SECOND_STATE = 3'b001;
  parameter THIRD_STATE  = 3'b010;
  parameter FOURTH_STATE = 3'b011;
  parameter FIFTH_STATE  = 3'b100;
  parameter SIXTH_STATE  = 3'b101;
  
  reg [2:0] state;
  reg [3:0] count = 0;
  parameter SEC5  = 4'd5;
  parameter SEC1  = 4'd1;
  
  always@(posedge clk or posedge reset)
    begin
    if(reset)
      begin
        state <= FIRST_STATE;
        count <= 0;
      end
  else
    begin
      case(state)
        begin
          FIRST_STATE:begin
            if(count < SEC5)
              begin
                count <= count+1;
                state <= FIRST_STATE;
              end
            else begin
              count <= 0;
              state <= SECOND_STATE;
            end
          end
          
           SECOND_STATE:begin
             if(count < SEC1)
              begin
                count <= count+1;
                state <= SECOND_STATE;
              end
            else begin
              count <= 0;
              state <= THIRD_STATE;
            end
          end
          
          THIRD_STATE:begin
            if(count < SEC5)
              begin
                count <= count+1;
                state <= THIRD_STATE;
              end
            else begin
              count <= 0;
              state <= FOURTH_STATE;
            end
          end
          
           FOURTH_STATE:begin
            if(count < SEC5)
              begin
                count <= count+1;
                state <= FOURTH_STATE;
              end
            else begin
              count <= 0;
              state <= FIFTH_STATE;
            end
          end
          
           FIFTH_STATE:begin
            if(count < SEC5)
              begin
                count <= count+1;
                state <= FIFTH_STATE;
              end
            else begin
              count <= 0;
              state <= SIXTH_STATE;
            end
          end
          
           SIXTH_STATE:begin
            if(count < SEC5)
              begin
                count <= count+1;
                state <= SIXTH_STATE;
              end
            else begin
              count <= 0;
              state <= FIRST_STATE;
            end
          end
          
           default state <= FIRST_STATE;
       
        endcase
        end
        end
        
        always@(*)
          begin
            case(state)
              begin
                FIRST_STATE:  begin light_A <= 3'b001; light_B <= 3'b100; end
                SECOND_STATE: begin light_A <= 3'b010; light_B <= 3'b100; end
                THIRD_STATE:  begin light_A <= 3'b100; light_B <= 3'b100; end
                FOURTH_STATE: begin light_A <= 3'b100; light_B <= 3'b001; end
                FIFTH_STATE:  begin light_A <= 3'b100; light_B <= 3'b010; end
                SIXTH_STATE:  begin light_A <= 3'b100; light_B <= 3'b100; end
                default:      begin light_A <= 3'b100; light_B <= 3'b100; end
            endcase
          end
        
        
        endmodule

  