module RAM (
    input Mem_Write,            // 写使能信号
    input [5:0] DM_Addr,       // 读写地址
    input [31:0] M_W_Data,     // 写入的数据
    input clk_dm,              // 时钟信号
    output [31:0] M_R_Data     // 读出的数据
);
    reg [31:0] M_R_Data_reg_00 [0:31]; // 存储器数据寄存器1
    reg [31:0] M_R_Data_reg_01 [0:31]; // 存储器数据寄存器2
    integer i;

    assign M_R_Data = DM_Addr[5]?M_R_Data_reg_01[DM_Addr[4:0]]:M_R_Data_reg_00[DM_Addr[4:0]]; // 将M_R_Data与M_R_Data_reg中对应的数据相连

    initial begin                        // 初始化内存数据
        for (i = 0; i<32; ++i) begin
            M_R_Data_reg_00[i] = 32'h00000000; // 初始化存储器数据寄存器1
            M_R_Data_reg_01[i] = 32'h00000000; // 初始化存储器数据寄存器2
        end
    end

    always@(posedge clk_dm) begin          // 在时钟信号上升沿时执行
        if (DM_Addr[5]==0) begin           // 判断写入哪一个存储器
            M_R_Data_reg_00[DM_Addr[4:0]] <= M_W_Data; // 写入存储器数据寄存器1
            $display("M_R_Data_reg_00[%d] <= %d", DM_Addr[4:0], M_W_Data); // 输出写入的地址和数据
        end else begin
            M_R_Data_reg_01[DM_Addr[4:0]] <= M_W_Data; // 写入存储器数据寄存器2
            $display("M_R_Data_reg_01[%d] <= %d", DM_Addr[4:0], M_W_Data); // 输出写入的地址和数据
        end
        $display("M_R_Data = %d", M_R_Data); // 输出读出的数据
    end
endmodule
