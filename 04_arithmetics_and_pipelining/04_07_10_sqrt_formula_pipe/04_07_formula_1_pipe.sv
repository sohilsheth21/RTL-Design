//----------------------------------------------------------------------------
// Task
//----------------------------------------------------------------------------

module formula_1_pipe
(
    input         clk,
    input         rst,

    input         arg_vld,
    input  [31:0] a,
    input  [31:0] b,
    input  [31:0] c,

    output        res_vld,
    output [31:0] res
);

    // Task:
    //
    // Implement a pipelined module formula_1_pipe that computes the result
    // of the formula defined in the file formula_1_fn.svh.
    //
    // The requirements:
    //
    // 1. The module formula_1_pipe has to be pipelined.
    //
    // It should be able to accept a new set of arguments a, b and c
    // arriving at every clock cycle.
    //
    // It also should be able to produce a new result every clock cycle
    // with a fixed latency after accepting the arguments.
    //
    // 2. Your solution should instantiate exactly 3 instances
    // of a pipelined isqrt module, which computes the integer square root.
    //
    // 3. Your solution should save dynamic power by properly connecting
    // the valid bits.
    //
    // You can read the discussion of this problem
    // in the article by Yuri Panchul published in
    // FPGA-Systems Magazine :: FSM :: Issue ALFA (state_0)
    // You can download this issue from https://fpga-systems.ru/fsm#state_0
    
    logic a_sqrt_vld, b_sqrt_vld, c_sqrt_vld;
    logic [31:0] sqrta, sqrtb, sqrtc;
    
     isqrt q1(.clk(clk),.rst(rst),.x_vld(arg_vld),.x(a),.y_vld(a_sqrt_vld),.y(sqrta));
    isqrt q2(.clk(clk),.rst(rst),.x_vld(arg_vld),.x(b),.y_vld(b_sqrt_vld),.y(sqrtb));
    isqrt q3(.clk(clk),.rst(rst),.x_vld(arg_vld),.x(c),.y_vld(c_sqrt_vld),.y(sqrtc));
	logic result_vld;
	logic[31:0] result;

    always_ff @(posedge clk)
    if(rst) begin
    result_vld<=0;
    result<=31'b0;
    end
    else begin
    result_vld<=a_sqrt_vld&b_sqrt_vld&c_sqrt_vld;
    result<=a_sqrt_vld&b_sqrt_vld&c_sqrt_vld?sqrta+sqrtb+sqrtc:31'b0;
    end
    
    
	assign res_vld = result_vld;
	assign res = result;

	
endmodule
