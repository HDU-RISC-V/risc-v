`include "ADD.v"   // 包含 ADD 模块的代码文件
`include "PC.v"    // 包含 PC 模块的代码文件
`include "IR.v"    // 包含 IR 模块的代码文件
`include "IM.v"    // 包含 IM 模块的代码文件

module IF (
    input IR_Write,         // 输入信号 IR_Write
    input PC_Write,         // 输入信号 PC_Write
    input clk_im,           // 输入时钟信号 clk_im
    input rst_n,            // 输入复位信号 rst_n
    output [31:0] inst,     // 输出指令 inst，为 32 位宽
    output [31:0] pc_out    // 输出程序计数器 pc_out，为 32 位宽
);

wire [31:0] _pc_out;        // 内部信号 _pc_out，为 32 位宽
wire [31:0] add_out;        // 内部信号 add_out，为 32 位宽
wire [31:0] im_out;         // 内部信号 im_out，为 32 位宽

ADD add_0 (
    .a(pc_out),             // 输入端口 a 连接 pc_out
    .b(4),                  // 输入端口 b 设置为常数 4
    .out(add_out)           // 输出端口 out 连接 add_out
);

PC pc_0 (
    .PC_In(add_out),        // 输入端口 PC_In 连接 add_out
    .PC_Write(PC_Write),    // 输入端口 PC_Write
    .clk(~clk_im),          // 输入端口 clk 连接 clk_im 的反相信号
    .rst_n(rst_n),          // 输入端口 rst_n
    .PC_Out(_pc_out)        // 输出端口 PC_Out 连接 _pc_out
);

IM im_0 (
    .IM_Addr(_pc_out[7:2]), // 输入端口 IM_Addr 连接 _pc_out 的位切片 [7:2]
    .clk_im(clk_im),        // 输入端口 clk_im
    .Inst_Code(im_out)      // 输出端口 Inst_Code 连接 im_out
);

IR ir_0 (
    .IR_In(im_out),         // 输入端口 IR_In 连接 im_out
    .IR_Write(IR_Write),    // 输入端口 IR_Write
    .clk(~clk_im),          // 输入端口 clk 连接 clk_im 的反相信号
    .IR_Out(inst)           // 输出端口 IR_Out 连接 inst
);

assign pc_out = _pc_out;    // 将 _pc_out 赋值给 pc_out

endmodule