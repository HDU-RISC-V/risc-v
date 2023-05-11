`include "ADD.v"
`include "PC.v"
`include "IR.v"
`include "IM.v"


module IF(
    input IR_Write,
    input PC_Write,
    input clk_im,
    output [31:0] inst
);

wire [31:0] pc_out;
wire [31:0] add_out;
wire [31:0] im_out;

ADD add_0(
    .a(pc_out),
    .b(4),
    .out(add_out)
);

PC pc_0(
    .PC_In(add_out),
    .PC_Write(PC_Write),
    .clk(~clk_im),
    .PC_Out(pc_out)
);

IM im_0(
    .IM_Addr(pc_out[7:2]),
    .clk_im(clk_im),
    .Inst_Code(im_out)
);

IR ir_0(
    .IR_In(im_out),
    .IR_Write(IR_Write),
    .clk(~clk_im),
    .IR_Out(inst)
);


endmodule