//----------------------------------------------------------------------------
// Example
//----------------------------------------------------------------------------

module add
(
  input  [3:0] a, b,
  output [3:0] sum
);

  assign sum = a + b;

endmodule

//----------------------------------------------------------------------------
// Task
//----------------------------------------------------------------------------

module signed_add_with_saturation
(
  input  [3:0] a, b,
  output [3:0] sum
);

  // Task:
  //
  // Implement a module that adds two signed numbers with saturation.
  //
  // "Adding with saturation" means:
  //
  // When the result does not fit into 4 bits,
  // and the arguments are positive,
  // the sum should be set to the maximum positive number.
  //
  // When the result does not fit into 4 bits,
  // and the arguments are negative,
  // the sum should be set to the minimum negative number.
  logic [3:0]s;
  assign s = a+b;
  assign sum = s[3]&(~a[3])&(~b[3])?4'b0111:(~s[3]&a[3]&b[3]?4'b1000:s); //if s[3] is 1 for 2 positive nos then overflow 1 with max sum 7, s[3] is 0 for 2 negative then min is -8, else a+b 


endmodule
