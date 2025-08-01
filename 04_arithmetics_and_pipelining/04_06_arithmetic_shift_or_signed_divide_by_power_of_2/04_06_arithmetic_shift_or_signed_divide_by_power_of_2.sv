//----------------------------------------------------------------------------
// Example
//----------------------------------------------------------------------------

module arithmetic_right_shift_of_N_by_S_using_arithmetic_right_shift_operation
# (parameter N = 8, S = 3)
(input  [N - 1:0] a, output [N - 1:0] res);

  wire signed [N - 1:0] as = a;
  assign res = as >>> S;

endmodule

//----------------------------------------------------------------------------
// Task
//----------------------------------------------------------------------------

module arithmetic_right_shift_of_N_by_S_using_concatenation
# (parameter N = 8, S = 3)
(input  [N - 1:0] a, output [N - 1:0] res);

  // Task:
  //
  // Implement a module with the logic for the arithmetic right shift,
  // but without using ">>>" operation. You are allowed to use only
  // concatenations ({a, b}), bit repetitions ({ a { b }}), bit slices
  // and constant expressions.
  
  assign res = a[N-1]? {{S{1'b1}},a[N-1:S]}: {{S{1'b0}},a[N-1:S]} ;


endmodule

module arithmetic_right_shift_of_N_by_S_using_for_inside_always
# (parameter N = 8, S = 3)
(input  [N - 1:0] a, output logic [N - 1:0] res);

  // Task:
  //
  // Implement a module with the logic for the arithmetic right shift,
  // but without using ">>>" operation, concatenations or bit slices.
  // You are allowed to use only "always_comb" with a "for" loop
  // that iterates through the individual bits of the input.
  
    always_comb
  for(int i=0;i<N;i++)
  res [i] = i < N-S ? a[i+S] : (a[N-1]?1'b1:1'b0);



endmodule

module arithmetic_right_shift_of_N_by_S_using_for_inside_generate
# (parameter N = 8, S = 3)
(input  [N - 1:0] a, output [N - 1:0] res);

  // Task:
  // Implement a module that arithmetically shifts input exactly
  // by `S` bits to the right using "generate" and "for"
  
      genvar i;

  generate
    for (i = 0; i < N; i ++)
      if (i < N-S) begin : shifted_bit_gen
        
        assign res [i] = a [i+S];
      end
      else begin : zero_bit
        assign res [i] = a[N-1]?1'b1:1'b0;
      end
  endgenerate



endmodule
