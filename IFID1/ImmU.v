module ImmU (
    input [31:0] inst,           // 输入指令码 inst，32 位宽
    output reg [31:0] imm32      // 输出立即数 imm32，32 位宽
);
    reg [6:0] opcode;            // 内部寄存器 opcode，用于存储指令的操作码
    reg [2:0] funct3;            // 内部寄存器 funct3，用于存储指令的 funct3 字段
    
    always @(*) begin
        opcode <= inst[6:0];     // 从指令码中提取操作码 opcode
        
        // R 类型指令
        if (opcode == 7'b0110011) begin
            imm32 <= 32'b0;      // 立即数 imm32 置零
        end
        // S 类型指令
        else if (opcode == 7'b0100011) begin
            imm32 <= {{20{inst[31]}}, inst[31:25], inst[11:7]};  // 从指令码中提取立即数
        end
        // B 类型指令
        else if (opcode == 7'b1100011) begin
            imm32 <= {{20{inst[31]}}, inst[7], inst[30:25], inst[11:8]};  // 从指令码中提取立即数
        end
        // J 类型指令
        else if (opcode == 7'b1101111) begin
            imm32 <= {{12{inst[31]}}, inst[19:12], inst[20], inst[30:21], 1'b0};  // 从指令码中提取立即数
        end
        // U 类型指令
        else if (opcode == 7'b0110111 || opcode == 7'b0010111) begin
            imm32 <= {inst[31:12], 12'b0};  // 从指令码中提取立即数
        end
        // I 类型指令
        else if (opcode == 7'b0010011 || opcode == 7'b0000011 || opcode == 7'b1100111 || opcode == 7'b1110011) begin
            imm32 <= {{20{inst[31]}}, inst[31:20]};  // 从指令码中提取立即数
            funct3 <= inst[14:12];  // 从指令码中提取 funct3 字段
            
            // 部分指令需要对立即数进行特殊处理
            if (opcode == 7'b0010011 && (funct3 == 3'b001 || funct3 == 3'b101)) begin
                imm32[31:5] <= 27'b0;  // 将 imm32 的高位清零
            end
        end
    end
endmodule
