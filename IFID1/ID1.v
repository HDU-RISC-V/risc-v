`include "./ImmU.v"  // 包含 ImmU 模块的代码文件

module ID1 (
    input [31:0] inst,         // 输入端口 inst，为 32 位宽
    output reg [4:0] rs1,      // 输出寄存器 rs1，为 5 位宽
    output reg [4:0] rs2,      // 输出寄存器 rs2，为 5 位宽
    output reg [4:0] rd,       // 输出寄存器 rd，为 5 位宽
    output reg [6:0] opcode,   // 输出操作码 opcode，为 7 位宽
    output reg [2:0] funct3,   // 输出功能码 funct3，为 3 位宽
    output reg [6:0] funct7,   // 输出功能码 funct7，为 7 位宽
    output [31:0] imm32        // 输出立即数 imm32，为 32 位宽
);
    ImmU immu1(.inst(inst), .imm32(imm32));  // 实例化 ImmU 模块，连接输入 inst 和输出 imm32

    always @(*) begin
        {funct7, rs2, rs1, funct3, rd, opcode} <= inst;  // 从输入 inst 中提取不同字段并赋值给相应的输出端口
    end
endmodule
