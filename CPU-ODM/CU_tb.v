//~ `New testbench
`timescale  1ns / 1ps
`include "CU.v"

module tb_CU;

// CU Parameters
parameter PERIOD = 10     ;
parameter Idle  = 4'b0000;
parameter S1    = 4'b0001;
parameter S2    = 4'b0010;
parameter S3    = 4'b0011;
parameter S4    = 4'b0100;
parameter S5    = 4'b0101;
parameter S6    = 4'b0110;
parameter S7    = 4'b0111;
parameter S8    = 4'b1000;
parameter S9    = 4'b1001;
parameter S10   = 4'b1010;

// CU Inputs
reg   [6:0]  opcode                        = 0 ;
reg   [2:0]  funct3                        = 0 ;
reg   [6:0]  funct7                        = 0 ;
reg   rst_n                                = 0 ;
reg   clk                                  = 0 ;

// CU Outputs
wire  [3:0]  ALU_OP                        ;
wire  rs2_imm_s                            ;
wire  [1:0]  w_data_s                      ;
wire  Reg_Write                            ;
wire  IR_Write                             ;
wire  PC_Write                             ;
wire  Mem_Write                            ;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD*2) rst_n  =  1;
end

CU #(
    .Idle ( Idle ),
    .S1   ( S1   ),
    .S2   ( S2   ),
    .S3   ( S3   ),
    .S4   ( S4   ),
    .S5   ( S5   ),
    .S6   ( S6   ),
    .S7   ( S7   ),
    .S8   ( S8   ),
    .S9   ( S9   ),
    .S10  ( S10  ))
 u_CU (
    .opcode                  ( opcode     [6:0] ),
    .funct3                  ( funct3     [2:0] ),
    .funct7                  ( funct7     [6:0] ),
    .rst_n                   ( rst_n            ),
    .clk                     ( clk              ),

    .ALU_OP                  ( ALU_OP     [3:0] ),
    .rs2_imm_s               ( rs2_imm_s        ),
    .w_data_s                ( w_data_s   [1:0] ),
    .Reg_Write               ( Reg_Write        ),
    .IR_Write                ( IR_Write         ),
    .PC_Write                ( PC_Write         ),
    .Mem_Write               ( Mem_Write        )
);

initial
begin
    $dumpfile("CU.vcd");
    $dumpvars(0, u_CU);
    #(PERIOD*2);
    opcode<=7'b0000011;
    funct3<=3'b010;
    #(PERIOD*4);
    opcode<=7'b0100011;
    funct3<=3'b010;
    #(PERIOD*8);
    $finish;
end

endmodule
