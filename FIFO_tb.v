`timescale 1ns/10ps

module FIFO_tb();
  reg clk;
  reg reset;
  reg [31:0] data_in;
  reg EN;
  reg RD;
  reg WR;
  wire EMPTY;
  wire FULL;
  wire [31:0] data_out;
  
  FIFO FIFO_instant(
    .clk(clk),
    .reset(reset),
    .data_in(data_in),
    .EN(EN),
    .RD(RD),
    .WR(WR),
    .EMPTY(EMPTY),
    .FULL(FULL),
    .data_out(data_out)
  );
  
  always # 10 clk = !clk;
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0);
    
    clk = 1'b0;
    reset = 1'b1;
    EN = 0;
    RD = 1'b0;
    WR = 1'b0;
    data_in = 32'h0;
    #100
    EN = 1'b1;
    reset = 1'b1;
    #20
    WR = 1'b1;
    reset = 1'b0;
    data_in = 32'h1;
    #20
    data_in = 32'h2;
    #20
    data_in = 32'h3;
    #20
    data_in = 32'h4;
    #20
    WR = 1'b0;
    RD = 1'b1;
    #20
    
    $finish();
  end
endmodule

  
  
  