//----------------------------------------------------------------------------
// Example
//----------------------------------------------------------------------------

module posedge_detector (input clk, rst, a, output detected);

  logic a_r;

  // Note:
  // The a_r flip-flop input value d propogates to the output q
  // only on the next clock cycle.

  always_ff @ (posedge clk)
    if (rst)
      a_r <= '0;
    else
      a_r <= a;

  assign detected = ~ a_r & a;

endmodule

//----------------------------------------------------------------------------
// Task
//----------------------------------------------------------------------------

module one_cycle_pulse_detector (input clk, rst, a, output detected);

  // Task:
  // Create an one cycle pulse (010) detector.
  logic a_1, a_2;
  
  always_ff @(posedge clk)
  if(rst) begin
  a_1<=1'b0;
  a_2<=1'b0;
  end
  else begin
  a_1<=a;
  a_2<=a_1;
  end
  
  assign detected = ~a && a_1 && ~a_2;
  
  //
  // Note:
  // See the testbench for the output format ($display task).


endmodule
