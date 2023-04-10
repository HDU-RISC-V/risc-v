//~ `New testbench
`timescale  1ns / 1ps  

module tb_Top;

// Top Parameters      
parameter PERIOD  = 10;


// Top Inputs
reg   clk                                  = 0 ;
reg   clk_F                                = 0 ;
reg   clk_A                                = 0 ;
reg   clk_B                                = 0 ;
reg   rst_n                                = 0 ;
reg   [31:0]  SW                           = 0 ;

// Top Outputs
wire  [3:0]  F                             ;
wire  [3:0]  AN                            ;
wire  [7:0]  seg                           ;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD*2) rst_n  =  1;
end

Top  u_Top (
    .clk                     ( clk           ),
    .clk_F                   ( clk_F         ),
    .clk_A                   ( clk_A         ),
    .clk_B                   ( clk_B         ),
    .rst_n                   ( rst_n         ),
    .SW                      ( SW     [31:0] ),

    .F                       ( F      [3:0]  ),
    .AN                      ( AN     [3:0]  ),
    .seg                     ( seg    [7:0]  )
);

initial
begin

    $finish;
end

endmodule