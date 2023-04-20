//~ `New testbench
`timescale  1ns / 1ps  
`include "RegATop.v"


module tb_RegATop;     

// RegATop Parameters  
parameter PERIOD  = 10;


// RegATop Inputs
reg   clk                                  = 0 ;
reg   [4:0]  R_Addr_A                      = 0 ;
reg   [4:0]  R_Addr_B                      = 0 ;
reg   [4:0]  W_Addr                        = 0 ;
reg   [3:0]  ALU_OP                        = 0 ;
reg   Reg_Write                            = 0 ;
reg   clk_RR                               = 0 ;
reg   clk_F                                = 0 ;
reg   clk_WB                               = 0 ;

// RegATop Outputs
wire  [3:0]  AN                            ;
wire  [7:0]  seg                           ;
wire  [3:0]  FR                            ;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end


RegATop  u_RegATop (
    .clk                     ( clk              ),
    .R_Addr_A                ( R_Addr_A   [4:0] ),
    .R_Addr_B                ( R_Addr_B   [4:0] ),
    .W_Addr                  ( W_Addr     [4:0] ),
    .ALU_OP                  ( ALU_OP     [3:0] ),
    .Reg_Write               ( Reg_Write        ),
    .clk_RR                  ( clk_RR           ),
    .clk_F                   ( clk_F            ),
    .clk_WB                  ( clk_WB           ),

    .AN                      ( AN         [3:0] ),
    .seg                     ( seg        [7:0] ),
    .FR                      ( FR         [3:0] )
);

integer i;

initial
begin
    $dumpfile("RegATop.vcd");
    $dumpvars(0, tb_RegATop);

    #100;
    R_Addr_A = 0;
    R_Addr_B = 0;
    W_Addr = 0;
    ALU_OP = 3;
    Reg_Write = 0;
    clk_RR = 0;

    // init
    // 全部置0
    for (i = 0; i < 32; i = i + 1) begin
        #100;
        Reg_Write = 0;
        R_Addr_A = i;
        R_Addr_B = i;
        W_Addr = i;
        ALU_OP = 3;
        #10;
        clk_RR = 1;
        #10;
        clk_RR = 0;

        #10;
        clk_F = 1;
        #10;
        clk_F = 0;

        Reg_Write = 1;
        #10;
        clk_WB = 1;
        #10;
        Reg_Write = 0;
        clk_WB = 0;
    end


    // 第i位置i
    for (i = 1; i < 32; i = i + 1) begin
        #100;
        Reg_Write = i;
        R_Addr_A = i-1;
        R_Addr_B = i-1;
        W_Addr = i;
        ALU_OP = 10;
        #10;
        clk_RR = 1;
        #10;
        clk_RR = 0;

        // 输出
        #10;
        clk_F = 1;
        #10;
        clk_F = 0;

        // 写回
        Reg_Write = 1;
        #10;
        clk_WB = 1;
        #10;
        Reg_Write = 0;
        clk_WB = 0;
    end

    // 遍历
    for (i = 0; i < 32; i = i + 1) begin
        #100;
        Reg_Write = i;
        R_Addr_A = 0;
        R_Addr_B = i;
        W_Addr = 0;
        ALU_OP = 0;
        #10;
        clk_RR = 1;
        #10;
        clk_RR = 0;

        // 输出
        #10;
        clk_F = 1;
        #10;
        clk_F = 0;
    end

    // 输出第i位左移i位
    for (i = 1; i < 32; i = i + 1) begin
        #100;
        Reg_Write = 0;
        R_Addr_A = 1;
        R_Addr_B = i;
        W_Addr = i;
        ALU_OP = 1;
        #10;
        clk_RR = 1;
        #10;
        clk_RR = 0;

        // 输出
        #10;
        clk_F = 1;
        #10;
        clk_F = 0;

    end


    $finish;
end

endmodule