//----------------------------------------------------------------------------
// Example
//----------------------------------------------------------------------------

module fibonacci
(
  input               clk,
  input               rst,
  output logic [15:0] num
);

  logic [15:0] num2;

  always_ff @ (posedge clk)
    if (rst)
      { num, num2 } <= { 16'd1, 16'd1 };
    else
      { num, num2 } <= { num2, num + num2 };

endmodule

//----------------------------------------------------------------------------
// Task
//----------------------------------------------------------------------------

module fibonacci_2
(
  input               clk,
  input               rst,
  output logic [15:0] num,
  output logic [15:0] num2
);

  // Task:
  // Implement a module that generates two fibonacci numbers per cycle
   logic [15:0] num3;
   logic [15:0] num4;

  always_ff @ (posedge clk)
    if (rst) begin
      { num, num2 } <= { 16'd1, 16'd1 };
   //   { num3, num4 } <= { 16'd1, 16'd1 };
      end
    else begin
 //     { num, num2 } <= { num4, num3 + num4 };  //1,2 ; 3,5; 8,13;
   //   { num3, num4 } <= { num2, num2 + num }; // 2,3; 5,8; 13,21;  cannot do coz non blocking hence takes old values to compute
      num3 = num + num2;
      num4 = num3 + num2;
      num<=num3;
      num2<=num4;
      end
      

  


endmodule
