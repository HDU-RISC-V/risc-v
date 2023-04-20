`include "../RegArray/RegArray.v"


module RAM (
    input Men_Write,
    input [5:0] DM_Addr,
    input [31:0] M_W_Data,
    input clk_dm,
    output reg [31:0] M_R_Data
);
    wire [31:0] R_A;
    wire [31:0] R_B;
    wire [31:0] Abort_Data;
    
    RegArray arr_00 (
        .clk_Regs(clk_dm*(~DM_Addr[4])),
        .Reg_Write(Men_Write),
        .R_Addr_A(DM_Addr[4:0]),
        .R_Addr_B(5'b00000),
        .W_Addr(DM_Addr[4:0]),
        .W_Data(M_W_Data),
        .R_Data_A(R_A),
        .R_Data_B(Abort_Data)
    );

    RegArray arr_01 (
        .clk_Regs(clk_dm*(DM_Addr[4])),
        .Reg_Write(Men_Write),
        .R_Addr_A(DM_Addr[4:0]),
        .R_Addr_B(5'b00000),
        .W_Addr(DM_Addr[4:0]),
        .W_Data(M_W_Data),
        .R_Data_A(R_B),
        .R_Data_B(Abort_Data)
    );

    always @(posedge clk_dm) begin
        if (DM_Addr[4]) begin
            M_R_Data <= R_B;
        end
        else begin
            M_R_Data <= R_A;
        end
    end

endmodule