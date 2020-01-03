// Code your testbench here
// or browse Examples
module pipeline_memory_store_tb();
  wire [15:0] Zout;
  reg [3:0] s1, s2, r_addr, opr;
  reg [7:0] addr;
  reg clk_1, clk_2;
  integer i;
  
  pipeline_memory_store instant(
    .Zout(Zout),
    .s1(s1),
    .s2(s2),
    .r_addr(r_addr),
    .opr(opr),
    .addr(addr),
    .clk_1(clk_1),
    .clk_2(clk_2)
  );
  
  initial begin
    clk_1 = 0; clk_2 = 0;
    repeat(30)
      begin
      #5 clk_1 = 1'b1;
      #5 clk_1 = 1'b0;
      #5 clk_2 = 1'b1;
      #5 clk_2 = 1'b0;
      end
  end
  
  initial begin
    for(i=0; i<16; i= i+1)
      instant.register_bank[i] = i;
  end
  
  initial begin
    #5  s1 = 3;  s2 = 5;  r_addr = 10; opr = 0;  addr = 125;
    #20 s1 = 3;  s2 = 8;  r_addr = 12; opr = 2;  addr = 126;
    #20 s1 = 10; s2 = 5;  r_addr = 14; opr = 1;  addr = 127;
    #20 s1 = 7;  s2 = 3;  r_addr = 13; opr = 11; addr = 128;
    #20 s1 = 10; s2 = 5;  r_addr = 15; opr = 1;  addr = 129;
    #20 s1 = 12; s2 = 13; r_addr = 16; opr = 0;  addr = 130;
    
    #60 for(i=125; i<131; i=i+1)
      begin
        $display ("Memory[%3d]= %3d", i, instant.memory[i]);
      end
    
    
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1, pipeline_memory_store_tb);
    $monitor ("Time: %3d, F = %3d", $time, Zout);
    #300
    $finish();
  end
endmodule
    
    
    