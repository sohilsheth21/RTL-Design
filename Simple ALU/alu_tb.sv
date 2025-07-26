// Simple ALU TB

module alu_tb ();

  logic [7:0]   a_i;
  logic [7:0]   b_i;
  logic [2:0]   op_i;

  logic [7:0]   alu_o;
  
  alu alu_tb(.*);
  
  initial begin
    a_i = 8'b01010000;
    b_i = 8'b01011000;
    op_i = 3'b011;
    
    #10;
    a_i = 8'b01011000;
    b_i = 8'b01111000;
    op_i = 3'b100;
    #10;
    a_i = 8'b01010100;
    b_i = 8'b01011000;
    op_i = 3'b111;
  end


endmodule
