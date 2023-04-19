
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
    
    assign R_Data_A=REG_Files[R_Addr_A];
    assign R_Data_B=REG_Files[R_Addr_B];

    integer i;

    initial begin
        for (i=0;i<32;i=i+1) begin
            REG_Files[i]=32'h00000000;
            $display("REG_Files[%d]=%h",i,REG_Files[i]);
        end
    end


    always@(posedge clk_Regs) begin
        if (Reg_Write) begin
            REG_Files[W_Addr] <=W_Data;
        end
    end

endmodule