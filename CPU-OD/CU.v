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

reg [3:0] ST; // 当前状态

// 有限状态
parameter Idle = 4'b0000; // 空闲
parameter S1 = 4'b0001;
parameter S2 = 4'b0010;
parameter S3 = 4'b0011;
parameter S4 = 4'b0100;
parameter S5 = 4'b0101;
parameter S6 = 4'b0110;

reg [3:0] Next_ST; //次态

initial begin
    ST <= Idle;
end


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
    Next_ST <= Idle;
    case (ST) 
        S1: begin
            case (opcode)
                7'b0010011: begin
                    Next_ST <= S2;
                end
                7'b0110011: begin
                    Next_ST <= S2;
                end
                7'b0110111: begin
                    Next_ST <= S6;
                end
                default:
                    Next_ST <= Idle;
            endcase
        end
        S2: begin
            case (opcode)
                7'b0110011: begin
                    Next_ST <= S3;
                end
                7'b0010011: begin
                    Next_ST <= S5;
                end
                default:
                    Next_ST <= Idle;
            endcase
        end
        S3: begin
            Next_ST <= S4;
        end
        S4: begin
            Next_ST <=S1;
        end
        S5: begin
            Next_ST <=S4;
        end
        S6: begin
            Next_ST <=S1;
        end
        default begin
            Next_ST <= S1;
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
                PC_Write <= 1'b1;
                IR_Write <= 1'b1;
                Reg_Write <= 1'b0;
            end
            S2:begin
                PC_Write <= 1'b0;
                IR_Write <= 1'b0;
                Reg_Write <= 1'b0;
            end
            S3:begin
                PC_Write <= 1'b0;
                IR_Write <= 1'b0;
                Reg_Write <= 1'b0;
                rs2_imm_s <= 1'b0;
                ALU_OP <= {funct7[5], funct3};
            end
            S4:begin
                PC_Write <= 1'b0;
                IR_Write <= 1'b0;
                Reg_Write <= 1'b1;
                w_data_s <= 1'b0;
            end
            S5:begin
                PC_Write <= 1'b0;
                IR_Write <= 1'b0;
                Reg_Write <= 1'b0;
                rs2_imm_s <= 1'b1;
                if (funct3==3'b101) begin
                    ALU_OP <= {funct7[5],funct3};                    
                end
                else begin
                  ALU_OP<={1'b0,funct3};
                end
            end
            S6:begin
                PC_Write <= 1'b0;
                IR_Write <= 1'b0;
                Reg_Write <= 1'b1;
                w_data_s <= 1'b1;
            end
        endcase
    end
end
endmodule