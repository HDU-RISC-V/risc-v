//~ `New testbench
`timescale  1ns / 1ps
`include "RAMTop.v"

module tb_RAMTop;

// RAMTop Parameters
parameter PERIOD  = 2;


// RAMTop Inputs
reg   clk                                  = 0 ;
reg   Mem_Write                            = 0 ;
reg   [7:2]  DM_Addr                       = 0 ;
reg   [1:0]  MW_Data_s                     = 0 ;
reg   clk_dm                               = 0 ;

// RAMTop Outputs
wire  [3:0]  AN                            ;
wire  [7:0]  seg                           ;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end


RAMTop  u_RAMTop (
    .clk                     ( clk              ),
    .Mem_Write               ( Mem_Write        ),
    .DM_Addr                 ( DM_Addr    [7:2] ),
    .MW_Data_s               ( MW_Data_s  [1:0] ),
    .clk_dm                  ( clk_dm           ),

    .AN                      ( AN         [3:0] ),
    .seg                     ( seg        [7:0] )
);

integer i, j;

initial
begin
    // $dumpfile("RAMTop_tb.vcd");
    // $dumpvars(0, tb_RAMTop);
    // for (j = 6'b000000; j<6'b000001; ++j) begin
    //     for (i = 2'b00; i<2'b11; ++i) begin
    // #100000;
    //         Mem_Write = 1;
    //         DM_Addr = j;
    //         MW_Data_s = i;
    // #100000;
    //         clk_dm = 1;
    // #100000;
    //         clk_dm = 0;
    // #100000;
    //         Mem_Write=0;
    //         // $display("DM_Addr = %b, M_R_Data = %b", DM_Addr, M_R_Data);
    //     end
    //     #100000;
    // end
    

    // #100000;
    //     #100000;
    //         #100000;
    //             #100000;
    Mem_Write = 1;
    DM_Addr = 6'b000000;
    MW_Data_s = 2'b01;
    #100000;
    clk_dm = 1;
    #100000;
    clk_dm = 0;
    #100000;
    Mem_Write=0;

    #100000;    #100000;    #100000;    #100000;




    $finish;
end

endmodule
