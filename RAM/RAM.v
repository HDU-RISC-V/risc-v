`include "../RegArray/RegArray.v"


module RAM (
    input Mem_Write,
    input [5:0] DM_Addr,
    input [31:0] M_W_Data,
    input clk_dm,
    output [31:0] M_R_Data
);
    reg [31:0] M_R_Data_reg_00 [0:31];
    reg [31:0] M_R_Data_reg_01 [0:31];
    integer i;

    assign M_R_Data = DM_Addr[5]&M_R_Data_reg_01[DM_Addr[4:0]] | ~DM_Addr[5]&M_R_Data_reg_00[DM_Addr[4:0]];

    initial begin
        for (i = 0; i<32; ++i) begin
            M_R_Data_reg_00[i] = 32'h00000000;
            M_R_Data_reg_01[i] = 32'h00000000;
        end
    end

    always@(posedge clk_dm) begin
        if (DM_Addr[5]==0) begin
            M_R_Data_reg_00[DM_Addr[4:0]] <= M_W_Data;
        end else begin
            M_R_Data_reg_01[DM_Addr[4:0]] <= M_W_Data;
        end
    end


endmodule