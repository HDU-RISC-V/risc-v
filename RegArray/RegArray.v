`include "decoder_5_32.v"

module RegArray (
    input clk_Regs,
    input Reg_Write,
    input [4:0] R_Addr_A,
    input [4:0] R_Addr_B,
    input [4:0] W_Addr, 
    input [31:0] W_Data,
    output [31:0] R_Data_A,
    output [31:0] R_Data_B
);
    reg [31:0] REG_Files[0:31];
    wire [31:0] W_Addr_32,R_Addr_A_32,R_Addr_B_32;
    
    assign R_Data_A=REG_Files[R_Addr_A_32];
    assign R_Data_B=REG_Files[R_Addr_B_32];

    Decoder_5_32 uW(
        .in(W_Addr),
        .out(W_Addr_32)
    );
    Decoder_5_32 uA(
        .in(R_Addr_A),
        .out(R_Addr_A_32)
    );
    Decoder_5_32 uB(
        .in(R_Addr_B),
        .out(R_Addr_B_32)
    );

    always@(posedge clk_Regs) begin
        if (Reg_Write) begin
            REG_Files[W_Addr_32] <=W_Data;
        end
    end

endmodule