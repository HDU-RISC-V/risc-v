module CU(
    input [6:0] opcode,
    input [2:0] funct3,
    input [6:0] funct7,
    input rst_n,
    input clk,
    output reg [3:0] ALU_OP,
    output reg rs2_imm_s,
    output reg w_data_s,
    output reg Reg_Write,
    output reg IR_Write,
    output reg PC_Write
);

reg Idle; // 空闲
reg [3:0] ST; // 当前状态
reg [3:0] S0, S1, S2, S3, S4, S5, S6, S7, S8, S9; // 有限状态

reg [3:0] Next_ST; //次态


always @(negedge rst_n or posedge clk)
begin 
    if (!rst_n) begin
        ST <= Idle;
    end
    else begin
        ST <= Next_ST;
    end
end

always @(*)
begin
    Next_ST = Idle;
    case (ST) 
        S1: begin

        end
        S2: begin

        end
        S3: begin

        end
        S4: begin
            Next_ST <=S1;
        end
        S5: begin

        end
        S6: begin

        end
        default begin

        end 
    endcase
end

always @(negedge rst_n or posedge clk)
begin
    if (!rst_n) begin
        PC_Write <= 1'b0;
        IR_Write <= 1'b0;
        Reg_Write <= 1'b0;
        w_data_s <= 1'b0;
        rs2_imm_s <= 1'b0;
        ALU_OP <= 4'b0;
    end else begin
        case (Next_ST)
            S1:begin
            
            end
            S2:begin
            
            end
            S3:begin
            
            end
            S4:begin
                PC_Write <= 1'b0;
                IR_Write <= 1'b0;
                Reg_Write <= 1'b1;
                w_data_s <= 1'b0;
            end
            S5:begin
            
            end
            S6:begin
            
            end
        endcase
    end
end
endmodule