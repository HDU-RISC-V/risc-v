`include "./ImmU.v"

module ID1 (
    input[31:0] inst,
    output reg[4:0] rs1,
    output reg[4:0] rs2,
    output reg[4:0] rd,
    output reg[6:0] opcode,
    output reg[2:0] funct3,
    output reg[6:0] funct7,
    output [31:0] imm32
);
    ImmU immu1(.inst(inst),.imm32(imm32));
    always @(*) begin
        {funct7,rs2,rs1,funct3,rd,opcode}<=inst;
    end
    
endmodule
