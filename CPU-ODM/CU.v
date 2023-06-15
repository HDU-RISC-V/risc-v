module CU(
    input [6:0] opcode,
    input [2:0] funct3,
    input [6:0] funct7,
    input rst_n,
    input clk,
    output reg [3:0] ALU_OP,
    output reg rs2_imm_s,
    output reg [1:0] w_data_s,
    output reg Reg_Write,
    output reg IR_Write,
    output reg PC_Write,
    output reg Mem_Write
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
// 实验9
parameter S7 = 4'b0111;
parameter S8 = 4'b1000;
parameter S9 = 4'b1001;
parameter S10 = 4'b1010;

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
                7'b0000011: begin
                    if (funct3==3'b010) begin  // lw
                        Next_ST <= S2;
                    end else begin  // other
                        Next_ST <= Idle;
                    end
                end
                7'b0100011: begin
                    if (funct3==3'b010) begin  // sw
                        Next_ST <= S2;
                    end else begin  // other
                        Next_ST <= Idle;
                    end
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
                7'b0000011: begin
                    if (funct3==3'b010) begin  // lw
                        Next_ST <= S7;
                    end else begin  // other
                        Next_ST <= Idle;
                    end
                end
                7'b0100011: begin
                    if (funct3==3'b010) begin  // sw
                        Next_ST <= S7;
                    end else begin  // other
                        Next_ST <= Idle;
                    end
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
        S7: begin
            if (funct3==3'b010 && opcode==7'b0000011) begin  // lw
                Next_ST <= S8;
            end else if ( funct3==3'b010 && opcode==7'b0100011 ) begin  // sw
                Next_ST <= S10;
            end else begin
                Next_ST <= Idle;
            end
        end
        S8: begin
            Next_ST <= S9;
        end
        S9: begin
            Next_ST <= S1;
        end
        S10: begin
            Next_ST <= S1;
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
        w_data_s <= 2'b00;
        rs2_imm_s <= 1'b0;
        ALU_OP <= 4'b0;
        Mem_Write <= 1'b0;
    end else begin
        case (Next_ST)
            S1:begin
                PC_Write <= 1'b1;
                IR_Write <= 1'b1;
                Reg_Write <= 1'b0;
                Mem_Write <= 1'b0;
            end
            S2:begin
                PC_Write <= 1'b0;
                IR_Write <= 1'b0;
                Reg_Write <= 1'b0;
                Mem_Write <= 1'b0;
            end
            S3:begin
                PC_Write <= 1'b0;
                IR_Write <= 1'b0;
                Reg_Write <= 1'b0;
                rs2_imm_s <= 1'b0;
                ALU_OP <= {funct7[5], funct3};
                Mem_Write <= 1'b0;
            end
            S4:begin
                PC_Write <= 1'b0;
                IR_Write <= 1'b0;
                Reg_Write <= 1'b1;
                w_data_s <= 2'b00;
                Mem_Write <= 1'b0;
            end
            S5:begin
                PC_Write <= 1'b0;
                IR_Write <= 1'b0;
                Reg_Write <= 1'b0;
                rs2_imm_s <= 1'b1;
                Mem_Write <= 1'b0;
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
                w_data_s <= 2'b01;
                Mem_Write <= 1'b0;
            end
            S7:begin
                PC_Write <= 1'b0;
                IR_Write <= 1'b0;
                Reg_Write <= 1'b0;
                ALU_OP <= 4'b0000;
                Mem_Write <= 1'b0;
            end
            S8:begin
                PC_Write <= 1'b0;
                IR_Write <= 1'b0;
                Reg_Write <= 1'b0;
                Mem_Write <= 1'b0;
            end
            S9:begin
                PC_Write <= 1'b0;
                IR_Write <= 1'b0;
                Reg_Write <= 1'b1;
                Mem_Write <= 1'b0;
                w_data_s <= 2'b10;
            end
            S10:begin
                PC_Write <= 1'b0;
                IR_Write <= 1'b0;
                Reg_Write <= 1'b0;
                Mem_Write <= 1'b1;
            end
        endcase
    end
end
endmodule