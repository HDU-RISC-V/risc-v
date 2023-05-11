module ImmU (
    input[31:0] inst,
    output reg[31:0] imm32 
);
    reg[6:0] opcode;
    reg[2:0] funct3;
    always @(*) begin
        opcode<=inst[6:0];
        // R
        if(opcode == 7'b0110011) begin
            imm32<=32'b0;
        end
        // S
        else if(opcode==7'b0100011) begin
            imm32<={{20{inst[31]}},inst[31:25],inst[11:7]};
        end
        // B
        else if(opcode==7'b1100011) begin
            imm32<={{20{inst[31]}},inst[7],inst[30:25],inst[11:8]};
        end
        // J
        else if(opcode==7'b1101111) begin
            imm32<={{12{inst[31]}},inst[19:12],inst[20],inst[30:21],1'b0};
        end
        // U
        else if(opcode==7'b0110111 || opcode==7'b0010111)begin
            imm32<={inst[31:12],12'b0};
        end
        // I
        else if (opcode==7'b0010011||opcode==7'b0000011||opcode==7'b1100111||opcode==7'b1110011) begin
            imm32<={27'b0,inst[24:20]};
            funct3<=inst[14:12];
            if (funct3==3'h1||funct3==3'h5) begin
                imm32[11:5]<=inst[31:25];
            end
        end
    end
    
endmodule