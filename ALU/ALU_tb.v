//~ `New testbench
`timescale  1ns / 1ps  
`include "ALU.v"
module tb_ALU;

// ALU Parameters      
parameter PERIOD  = 10;


// ALU Inputs
reg   [31:0]  a                            = 0 ;
reg   [31:0]  b                            = 0 ;
reg   [3:0]  op                            = 0 ;

// ALU Outputs
wire  [31:0]  out                          ;
wire  ZF                                   ;
wire  CF                                   ;
wire  OF                                   ;
wire  SF                                   ;


ALU  u_ALU (
    .a                       ( a    [31:0] ),
    .b                       ( b    [31:0] ),
    .op                      ( op   [3:0]  ),

    .out                     ( out  [31:0] ),
    .ZF                      ( ZF          ),
    .CF                      ( CF          ),
    .OF                      ( OF          ),
    .SF                      ( SF          )
);

initial
begin
    $dumpfile("ALU.vcd");
    $dumpvars(0, tb_ALU);

    #100;
    a=32'hF0000001;
    b=32'hF0000000;
    op=4'b0000;

    #100;
    a=32'hFFFFFFFF;
    b=32'h00000001;
    op=4'b0001;

    #100;
    a=32'hF0000001;
    b=32'h00000010;
    op=4'b0010;
    
    #100;
    a=32'h00000001;
    b=32'h00000010;
    op=4'b0011;

    #100;
    a=32'h00000001;
    b=32'h00000011;
    op=4'b0100;

    #100;
    a=32'h00000001;
    b=32'h00000001;
    op=4'b0101;

    #100;
    a=32'h00000001;
    b=32'h00000011;
    op=4'b0110;

    #100;
    a=32'h00000001;
    b=32'h00000011;
    op=4'b0111;

    #100;
    a=32'h00000001;
    b=32'h00000011;
    op=4'b1000;

    #100;
    a=32'h00000001;
    b=32'h00000001;
    op=4'b1101;

    #100;
    a=32'h00000001;
    b=32'h00000000;
    op=4'b1010;

    #100;
    a=32'h00000001;
    b=32'h00000000;
    op=4'b1011;

    #100;
    $finish;
end

endmodule