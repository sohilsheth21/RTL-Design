// Counter with a load
module day10 (
  input     wire          clk,
  input     wire          reset,
  input     wire          load_i,
  input     wire[3:0]     load_val_i,

  output    wire[3:0]     count_o
);

  // Write your logic here...
  logic[3:0] cnt;
  
  always_ff @(posedge clk or posedge reset)
    if(reset)
      cnt<=4'h0;
  else
    cnt<=(load_i)?load_val_i:((cnt==4'hF)?load_val_i:cnt+1);
    
  assign count_o=cnt;

endmodule
