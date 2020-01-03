// Code your design here
module pipeline_memory_store(Zout, s1, s2, r_addr, opr, addr, clk_1, clk_2);
  input  [3:0] s1, s2, r_addr, opr;
  input  [7:0] addr;
  output [15:0] Zout;
  input clk_1, clk_2;
  
  reg [15:0] register_bank [0:15];
  reg [15:0] memory [0:255];
  
  reg [15:0] Latch12_A, Latch12_B, Latch23_Zout, Latch34_Zout;
  reg [7:0]  Latch12_addr, Latch23_addr, Latch34_addr;
  reg [3:0]  Latch12_opr, Latch12_r_addr, Latch23_r_addr;
  
  assign Zout = Latch34_Zout;
  
  always@(posedge clk_1)          //STAGE 1
    begin
      Latch12_A      <= #2 register_bank[s1];
      Latch12_B      <= #2 register_bank[s2];
      Latch12_r_addr <= #2 r_addr;
      Latch12_addr   <= #2 addr;
      Latch12_opr    <= #2 opr;
    end
  
  always@(negedge clk_2)           //STATE 2
    begin 
      case(opr)
        4'b0000: Latch23_Zout <= #2 Latch12_A + Latch12_B;
        4'b0001: Latch23_Zout <= #2 Latch12_A - Latch12_B;
        4'b0010: Latch23_Zout <= #2 Latch12_A * Latch12_B;
        4'b0011: Latch23_Zout <= #2 Latch12_A;
        4'b0100: Latch23_Zout <= #2 Latch12_B;
        4'b0101: Latch23_Zout <= #2 Latch12_A & Latch12_B;
        4'b0110: Latch23_Zout <= #2 Latch12_A | Latch12_B;
        4'b0111: Latch23_Zout <= #2 Latch12_A ^ Latch12_B;
        4'b1000: Latch23_Zout <= #2 - Latch12_A;
        4'b1001: Latch23_Zout <= #2 - Latch12_B;
        4'b1010: Latch23_Zout <= #2 Latch12_A >> 1;
        4'b1011: Latch23_Zout <= #2 Latch12_A << 1;
        default: Latch23_Zout <= #2 16'hxxxx;
      endcase
      Latch23_r_addr <= #2 Latch12_r_addr;
      Latch23_addr   <= #2 Latch12_addr;
    end
  
  always@(posedge clk_1)          //STATE 3
    begin
      register_bank[Latch23_r_addr] <= #2 Latch23_Zout;
      Latch34_addr          <= #2 Latch23_addr;
      Latch34_Zout          <= #2 Latch23_Zout;
    end
  
  always@(negedge clk_2)          // STATE 4
    begin
      memory[Latch34_addr] <= #2 Latch34_Zout;
    end
endmodule
      
      
      
          