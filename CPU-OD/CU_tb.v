//~ `New testbench
`timescale  1ns / 1ps
`include "CU.v"

module tb_CU;

// CU Parameters
parameter PERIOD = 10     ;

// CU Inputs
reg   [6:0]  opcode                        = 0 ;
reg   [2:0]  funct3                        = 0 ;
reg   [6:0]  funct7                        = 0 ;
reg   rst_n                                = 0 ;
reg   clk                                  = 0 ;

// CU Outputs
wire  [3:0]  ALU_OP                        ;
wire  rs2_imm_s                            ;
wire  w_data_s                             ;
wire  Reg_Write                            ;
wire  IR_Write                             ;
wire  PC_Write                             ;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD*2) rst_n  =  1;
end

CU u_CU (
    .opcode                  ( opcode     [6:0] ),
    .funct3                  ( funct3     [2:0] ),
    .funct7                  ( funct7     [6:0] ),
    .rst_n                   ( rst_n            ),
    .clk                     ( clk              ),

    .ALU_OP                  ( ALU_OP     [3:0] ),
    .rs2_imm_s               ( rs2_imm_s        ),
    .w_data_s                ( w_data_s         ),
    .Reg_Write               ( Reg_Write        ),
    .IR_Write                ( IR_Write         ),
    .PC_Write                ( PC_Write         )
);

initial
begin
    $dumpfile("CU.vcd");
    $dumpvars(0, u_CU);
    opcode=7'b0110011;
    funct3=3'b000;
    funct7=7'b0000000;

    #(PERIOD*10);


    $finish;
end

endmodule
