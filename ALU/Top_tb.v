//~ `New testbench
`timescale  1ns / 1ps  
`include "Top.v"

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


Top  u_Top (
    .clk                     ( clk           ),
    .clk_F                   ( clk_F         ),
    .clk_A                   ( clk_A         ),
    .clk_B                   ( clk_B         ),
    .SW                      ( SW     [31:0] ),

    .F                       ( F      [3:0]  ),
    .AN                      ( AN     [3:0]  ),
    .seg                     ( seg    [7:0]  )
);

initial
begin
    $dumpfile("Top.vcd");
    $dumpvars(0, tb_Top);


// add overflow
    #100 SW = 32'hFFFFFFFF;
    #100 clk_A = 1;
    #100 clk_A = 0;

    #100 SW = 32'hFFFFFFFF;
    #100 clk_B = 1;
    #100 clk_B = 0;

    #100 SW = 32'h00000000;
    #100 clk_F = 1;
    #100 clk_F = 0;

    #1000;
// add

    #100 SW = 32'h00000001;
    #100 clk_A = 1;
    #100 clk_A = 0;

    #100 SW = 32'h00000001;
    #100 clk_B = 1;
    #100 clk_B = 0;

    #100 SW = 32'h00000000;
    #100 clk_F = 1;
    #100 clk_F = 0;

    #1000;
// move left
    #100 SW = 32'h00000001;
    #100 clk_A = 1;
    #100 clk_A = 0;

    #100 SW = 32'h00000002;
    #100 clk_B = 1;
    #100 clk_B = 0;

    #100 SW = 32'h00000001;
    #100 clk_F = 1;
    #100 clk_F = 0;

    #1000;

// compare < with signal
    #100 SW = 32'hA0000001; // neg
    #100 clk_A = 1;
    #100 clk_A = 0;

    #100 SW = 32'h00000001; // pos
    #100 clk_B = 1;
    #100 clk_B = 0;

    #100 SW = 32'h00000002;
    #100 clk_F = 1;
    #100 clk_F = 0;

    #1000;

// compare < with signal
    #100 SW = 32'h00000002; // big
    #100 clk_A = 1;
    #100 clk_A = 0;

    #100 SW = 32'h00000001; // small
    #100 clk_B = 1;
    #100 clk_B = 0;

    #100 SW = 32'h00000002;
    #100 clk_F = 1;
    #100 clk_F = 0;

    #1000;


    

    $finish;
end

endmodule