//----------------------------------------------------------------------------
// Task
//----------------------------------------------------------------------------

module halve_tokens
(
    input  clk,
    input  rst,
    input  a,
    output b
);
    // Task:
    // Implement a serial module that reduces amount of incoming '1' tokens by half.
    //
    //
    // Example:
    // a -> 110_011_101_000_1111
    // b -> 010_001_001_000_0101
    logic cnt;
    logic bout;
    assign b = bout;
    always_ff @(posedge clk)
    if(rst) begin
    bout<=0;
    cnt<=0;
    end
    else begin
    bout<=0;
    if(a) begin
    if(cnt == 1) begin //second 1
    bout<=1;
    cnt<=0;
    end
    else
    cnt<=1; //first 1
    end
    else
    bout<=0;
    
    end
    


endmodule
