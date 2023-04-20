module RegArray (
    input clk_Regs, // 时钟信号输入
    input Reg_Write, // 寄存器写使能信号
    input [4:0] R_Addr_A, // 读寄存器地址A输入
    input [4:0] R_Addr_B, // 读寄存器地址B输入
    input [4:0] W_Addr, // 写寄存器地址输入
    input [31:0] W_Data, // 写入数据输入
    output [31:0] R_Data_A, // 读取数据A输出
    output [31:0] R_Data_B // 读取数据B输出
);
    reg [31:0] REG_Files[0:31]; // 定义32个寄存器

    // 将读取地址A对应的寄存器数据赋值给R_Data_A
    assign R_Data_A = REG_Files[R_Addr_A];
    // 将读取地址B对应的寄存器数据赋值给R_Data_B
    assign R_Data_B = REG_Files[R_Addr_B];

    integer i; // 定义循环变量

    // 初始化寄存器数组
    initial begin
        for (i = 0; i < 32; i = i + 1) begin
            REG_Files[i] = 32'h00000000;
            // 显示初始化寄存器值
            $display("REG_Files[%d] = %h", i, REG_Files[i]);
        end
    end

    // 时钟上升沿触发
    always@(posedge clk_Regs) begin
        // 如果写使能信号为1，则将W_Data写入W_Addr指定的寄存器
        if (Reg_Write) begin
            REG_Files[W_Addr] <= W_Data;
        end
    end

endmoduleß