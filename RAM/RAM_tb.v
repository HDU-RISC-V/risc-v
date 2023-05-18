//~ `New testbench
`timescale  1ns / 1ps
`include "RAM.v"

module tb_RAM;

// RAM Parameters
parameter PERIOD  = 10;


// RAM Inputs
reg   Mem_Write                            = 0 ;
reg   [5:0]  DM_Addr                       = 0 ;
reg   [31:0]  M_W_Data                     = 0 ;
reg   clk_dm                               = 0 ;

// RAM Outputs
wire  [31:0]  M_R_Data                     ;


RAM  u_RAM (
    .Mem_Write               ( Mem_Write         ),
    .DM_Addr                 ( DM_Addr    [5:0]  ),
    .M_W_Data                ( M_W_Data   [31:0] ),
    .clk_dm                  ( clk_dm            ),

    .M_R_Data                ( M_R_Data   [31:0] )
);
integer i;

initial
begin
    $dumpfile("RAM_tb.vcd");
    $dumpvars(0, tb_RAM);

    for (i = 5'b0000; i<5'b11111; ++i) begin
        #10;
        Mem_Write = 1;
        DM_Addr = i;
        M_W_Data = 32'h00001<<i;
        #10;
        clk_dm = 1;
        #10;
        clk_dm = 0;
        Mem_Write = 0;
        $display("DM_Addr = %b, M_R_Data = %b", DM_Addr, M_R_Data);
    end

    

    $finish;
end

endmodule
