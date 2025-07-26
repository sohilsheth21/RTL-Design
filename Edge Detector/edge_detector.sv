 // An edge detector

module edge (
  input     wire    clk,
  input     wire    reset,

  input     wire    a_i,

  output    wire    rising_edge_o,
  output    wire    falling_edge_o
);

  logic a_i_del;
  
  always_ff @(posedge clk or posedge reset)
  
      if(reset)
        a_i_del<=0;
        else
          a_i_del <=a_i;  //storing current state in a_i_del
  
  

  assign rising_edge_o = (~a_i_del & a_i); //a_i_del is prev state and a_i is current: 0->1 is rising edge
  assign falling_edge_o = (a_i_del  & ~a_i);          
  

endmodule
