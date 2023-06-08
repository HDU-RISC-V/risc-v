//~ `New testbench
`timescale  1ns / 1ps
`include "DM.v"
module tb_DM;        

// DM Parameters     
parameter PERIOD  = 10;


// DM Inputs
reg   clk_dm                               = 0 ;
reg   Mem_Write                            = 0 ;
reg   [31:0]  DM_Addr                      = 0 ;
reg   [31:0]  M_W_Data                     = 0 ;

// DM Outputs
wire  [31:0]  M_R_Data                     ;


initial
begin
    forever #(PERIOD/2)  clk_dm=~clk_dm;
end

// initial
// begin
//     #(PERIOD*2) rst_n  =  1;
// end

DM  u_DM (
    .clk_dm                  ( clk_dm            ),
    .Mem_Write               ( Mem_Write         ),
    .DM_Addr                 ( DM_Addr    [31:0] ),
    .M_W_Data                ( M_W_Data   [31:0] ),

    .M_R_Data                ( M_R_Data   [31:0] )
);

integer i;
initial
begin
    $dumpfile("DM.vcd");
    $dumpvars(0, u_DM);
    #10;
    for (i = 0; i<1024; i=i+1) begin
        #10 DM_Addr<=i;
    end
    $finish;
end

endmodule