//~ `New testbench
`timescale  1ns / 1ps  

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
reg   rst_n                                = 0 ;
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

initial
begin
    #(PERIOD*2) rst_n  =  1;
end

RegATop  u_RegATop (
    .clk                     ( clk              ),
    .R_Addr_A                ( R_Addr_A   [4:0] ),
    .R_Addr_B                ( R_Addr_B   [4:0] ),
    .W_Addr                  ( W_Addr     [4:0] ),
    .ALU_OP                  ( ALU_OP     [3:0] ),
    .Reg_Write               ( Reg_Write        ),
    .rst_n                   ( rst_n            ),
    .clk_RR                  ( clk_RR           ),
    .clk_F                   ( clk_F            ),
    .clk_WB                  ( clk_WB           ),

    .AN                      ( AN         [3:0] ),
    .seg                     ( seg        [7:0] ),
    .FR                      ( FR         [3:0] )
);

initial
begin

    $finish;
end

endmodule