//~ `New testbench
`timescale  1ns / 1ps  
`include "RegArray.v"
module tb_RegArray;    

// RegArray Parameters 
parameter PERIOD  = 10;


// RegArray Inputs
reg   clk_Regs                             = 0 ;
reg   Reg_Write                            = 0 ;
reg   [4:0]  R_Addr_A                      = 0 ;
reg   [4:0]  R_Addr_B                      = 0 ;
reg   [4:0]  W_Addr                        = 0 ;
reg   [31:0]  W_Data                       = 0 ;

// RegArray Outputs
wire  [31:0]  R_Data_A                     ;
wire  [31:0]  R_Data_B                     ;


initial
begin
    forever #(PERIOD/2)  clk_Regs=~clk_Regs;
end

RegArray  u_RegArray (
    .clk_Regs                ( clk_Regs          ),
    .Reg_Write               ( Reg_Write         ),
    .R_Addr_A                ( R_Addr_A   [4:0]  ),
    .R_Addr_B                ( R_Addr_B   [4:0]  ),
    .W_Addr                  ( W_Addr     [4:0]  ),
    .W_Data                  ( W_Data     [31:0] ),

    .R_Data_A                ( R_Data_A   [31:0] ),
    .R_Data_B                ( R_Data_B   [31:0] )
);

initial
begin
    $dumpfile("RegArray.vcd");
    $dumpvars(0, tb_RegArray);
    
    #33;
    Reg_Write = 1;
    W_Addr = 5'b00000; 
    W_Data = 32'h7643210;
    R_Addr_A = 5'b00001;
    R_Addr_B = 5'b00000;

    #33;
    Reg_Write = 1;
    W_Addr = 5'b00001; 
    W_Data = 32'hFEDCBA98;
    R_Addr_A = 5'b00000;
    R_Addr_B = 5'b00001;

    #33;
    Reg_Write = 0;
    W_Addr = 5'b00000; 
    W_Data = 32'h00000000;
    R_Addr_A = 5'b00000;
    R_Addr_B = 5'b00001;

    #3;
    Reg_Write = 0;
    W_Addr = 5'b00001; 
    W_Data = 32'h00000000;
    R_Addr_A = 5'b00001;
    R_Addr_B = 5'b00000;

    #33;
    $finish;
end

endmodule