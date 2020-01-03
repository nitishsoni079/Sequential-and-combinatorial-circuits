
module FIFO(
  input clk,
  input reset,
  input [31:0] data_in,
  input EN,
  input RD,
  input WR,
  output EMPTY,
  output FULL,
  output reg [31:0] data_out
);

reg [2:0]count = 0;
reg [2:0]read_counter = 0;
reg [2:0]write_counter = 0;
reg [31:0]FIFO [0:7];
assign FULL = (count == 8)? 1'b1: 1'b0;
assign EMPTY = (count == 0)?1'b1:1'b0;

always@(posedge clk)
  begin
    if(EN == 0);
    else
      begin
        if(reset == 1)
          begin
            read_counter = 0;
            write_counter = 0;
          end
      else if(RD == 1'b1 && count!= 0)
      begin
        data_out = FIFO[read_counter];
        read_counter = read_counter + 1;
      end
    else if(WR == 1'b1 && count< 8 )
      begin
        FIFO[write_counter] = data_in;
        write_counter = write_counter + 1;
      end
        else;
      end
    if(read_counter == 8)
      begin
        read_counter = 0;
      end
    else if(write_counter == 8)
      begin
        write_counter = 0;
      end
    else if(read_counter > write_counter)
      begin
        count = read_counter - write_counter;
      end
    else if(write_counter > read_counter)
      begin
        count = write_counter - read_counter;
      end
    else;
  end
endmodule
        
      
    