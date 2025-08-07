// APB Master

// TB should drive a cmd_i input decoded as:
//  - 2'b00 - No-op
//  - 2'b01 - Read from address 0xDEAD_CAFE
//  - 2'b10 - Increment the previously read data and store it to 0xDEAD_CAFE

module day16 (
  input       wire        clk,
  input       wire        reset,

  input       wire[1:0]   cmd_i,

  output      wire        psel_o,
  output      wire        penable_o,
  output      wire[31:0]  paddr_o,
  output      wire        pwrite_o,
  output      wire[31:0]  pwdata_o,
  input       wire        pready_i,
  input       wire[31:0]  prdata_i
);

  // Write your logic here...
  parameter IDLE = 2'b00, SETUP = 2'b01, ACCESS =2'b10;
  logic [1:0] state, next_state;
  logic [31:0] rd_data;
  logic [1:0] latched_cmd;
  
  always_comb
    begin
      next_state = state;
      case(state)
        IDLE: next_state = (|cmd_i)?SETUP:IDLE;
        SETUP: next_state = ACCESS;
        ACCESS: next_state = (pready_i==0)?ACCESS:(|cmd_i)?SETUP:IDLE; //if pready 0 => wait; if 1 & transfer =>setup else idle
        default: next_state = IDLE;
      endcase
    end
  
  always_ff @(posedge clk or posedge reset)
    if(reset)
      state<=IDLE;
  else
    state<=next_state;
  
  always_ff @(posedge clk or posedge reset)
    if(reset)
      latched_cmd<=2'b00;
  else if (state == IDLE && |cmd_i)
    latched_cmd<=cmd_i;  //to keep value stable when in setup
  
  assign psel_o = state==SETUP || state == ACCESS;
  assign penable_o = state == ACCESS;
  assign paddr_o = 32'hDEAD_CAFE;
  assign pwrite_o = latched_cmd[1];
  assign pwdata_o = rd_data + 32'h1;
  
  always_ff @(posedge clk or posedge reset)
    if(reset)
      rd_data<=32'h0;
  else if(penable_o && pready_i && latched_cmd[0])
    rd_data<=prdata_i;
  

endmodule
