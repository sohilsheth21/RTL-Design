//----------------------------------------------------------------------------
// Task
//----------------------------------------------------------------------------

module round_robin_arbiter_with_2_requests
(
  input  logic       clk,
  input  logic       rst,
  input  logic [1:0] requests,
  output logic [1:0] grants
);
    // Task:
    // Implement a "arbiter" module that accepts up to two requests
    // and grants one of them to operate in a round-robin manner.
    //
    // The module should maintain an internal register
    // to keep track of which requester is next in line for a grant.
    //
    // Note:
    // Check the waveform diagram in the README for better understanding.
    //
    // Example:
    // requests -> 01 00 10 11 11 00 11 00 11 11
    // grants   -> 01 00 10 01 10 00 01 00 10 01
  logic next_ptr;
  always_comb begin
    case (requests)
      2'b00:      grants = 2'b00;           
      2'b01:      grants = 2'b01;           
      2'b10:      grants = 2'b10;      
      2'b11:      grants = (next_ptr) ? 2'b01  : 2'b10;
      endcase
  end


  // 2) On each clock, update the pointer *if* there was a tie:
  always_ff @(posedge clk) begin
    if (rst) begin
      next_ptr <= 1'b0;  
    end else if (requests == 2'b11) begin
      next_ptr <= ~next_ptr;  // flip‑flop on every tie to alternate
    end
  end

endmodule
