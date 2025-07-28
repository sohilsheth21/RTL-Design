//----------------------------------------------------------------------------
// Task
//----------------------------------------------------------------------------

module serial_to_parallel
# (
    parameter width = 8
)
(
    input                      clk,
    input                      rst,

    input                      serial_valid,
    input                      serial_data,

    output logic               parallel_valid,
    output logic [width - 1:0] parallel_data
);
    // Task:
    // Implement a module that converts serial data to the parallel multibit value.
    //
    // The module should accept one-bit values with valid interface in a serial manner.
    // After accumulating 'width' bits, the module should assert the parallel_valid
    // output and set the data.
    //
    // Note:
    // Check the waveform diagram in the README for better understanding.
    localparam count = $clog2(width);
    logic [count-1:0] cnt;
  	always_ff @(posedge clk)
    if(rst)
    begin
    cnt<=0;
    parallel_valid<=0;
    parallel_data<=0;
    end
    else 
    begin
    parallel_valid<=0;
    if(serial_valid) begin
    if(cnt==0)
    parallel_data <= {serial_data, {(width-1){1'b0}} }; //left shift-LSB first
    else
    parallel_data <= {serial_data, parallel_data[width-1:1]};
    cnt<=cnt+1;
    if(cnt==width-1)
    begin
    parallel_valid<=1;
    cnt<=0;
    end
    end
    end
 
    
    
    


endmodule
