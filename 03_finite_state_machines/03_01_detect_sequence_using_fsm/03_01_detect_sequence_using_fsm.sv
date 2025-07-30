//----------------------------------------------------------------------------
// Example
//----------------------------------------------------------------------------

module detect_4_bit_sequence_using_fsm
(
  input  clk,
  input  rst,
  input  a,
  output detected
);

  // Detection of the "1010" sequence

  // States (F — First, S — Second)
  enum logic[2:0]
  {
     IDLE = 3'b000,
     F1   = 3'b001,
     F0   = 3'b010,
     S1   = 3'b011,
     S0   = 3'b100
  }
  state, new_state;

  // State transition logic
  always_comb
  begin
    new_state = state;

    // This lint warning is bogus because we assign the default value above
    // verilator lint_off CASEINCOMPLETE

    case (state)
      IDLE: if (  a) new_state = F1;
      F1:   if (~ a) new_state = F0;
      F0:   if (  a) new_state = S1;
            else     new_state = IDLE;
      S1:   if (~ a) new_state = S0;
            else     new_state = F1;
      S0:   if (  a) new_state = S1;
            else     new_state = IDLE;
    endcase

    // verilator lint_on CASEINCOMPLETE

  end

  // Output logic (depends only on the current state)
  assign detected = (state == S0);

  // State update
  always_ff @ (posedge clk)
    if (rst)
      state <= IDLE;
    else
      state <= new_state;

endmodule

//----------------------------------------------------------------------------
// Task
//----------------------------------------------------------------------------

module detect_6_bit_sequence_using_fsm
(
  input  clk,
  input  rst,
  input  a,
  output detected
);

  // Task:
  // Implement a module that detects the "110011" input sequence
  //
  // Hint: See Lecture 3 for details
  parameter F0 = 3'b000;
  parameter F1 = 3'b001;
  parameter S0 = 3'b010;
  parameter S1 = 3'b011;
  parameter S2 = 3'b100;
  parameter S3 = 3'b101;
  parameter S4 = 3'b110;

  logic [2:0] state, new_state;
  always_comb
  begin
 new_state = state; //to avoid latch inference

  case (state)
      F0:   new_state = a?F1:F0;
      F1:   new_state = a?S0:F0;
      S0:   new_state = (a==0)?S1:S0;
      S1:   new_state = (a==0)?S2:F0;
      S2:   new_state = a?S3:F0;
      S3: 	 new_state = a?S4:F0;
	S4:   new_state = a?S0:S1;
    endcase
  end

  assign detected = (state == S4);

  // State update
  always_ff @ (posedge clk)
    if (rst)
      state <= F0;
    else
      state <= new_state;


  


endmodule
