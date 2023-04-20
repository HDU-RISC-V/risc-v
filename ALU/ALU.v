module ALU (
    input [31:0] a,        // 输入操作数a
    input [31:0] b,        // 输入操作数b
    input [3:0] op,        // 4位操作码，用于选择ALU执行的操作
    output reg [31:0] out, // 输出结果
    output reg ZF,         // 零标志位，结果为零时置1
    output reg CF,         // 进位标志位，加法或减法操作时发生进位/借位时置1
    output reg OF,         // 溢出标志位，加法或减法操作时发生溢出时置1
    output reg SF          // 符号标志位，结果的符号位（最高位），用于表示结果为正或负
);

    always @(*) begin
        
        if (op == 4'b0000) begin
            // 加法操作，计算a+b，并更新CF
            {CF, out} <= a + b;
        end

        else if (op == 4'b0001) begin
            // 左移操作，将a左移b位
            out <= a << b;
        else if (op ==4'b0001) begin
            {CF,out} <= a << b;
        end

        else if (op == 4'b0010) begin
            // 有符号数比较操作，比较a和b的大小，考虑符号位
            if (a[31] == b[31]) begin
                out <= a < b;
            end
            else begin
                out <= a[31];
            end
        end

        else if (op == 4'b0011) begin
            // 无符号数比较操作，比较a和b的大小
            out <= a < b;
        end

        else if (op == 4'b0100) begin
            // 异或操作，计算a异或b
            out <= a ^ b;
        end

        else if (op == 4'b0101) begin
            // 无符号右移操作，将a右移b位
            out <= a >> b;
        end

        else if (op == 4'b0110) begin
            // 或操作，计算a或b
            out <= a | b;
        end

        else if (op == 4'b0111) begin
            // 与操作，计算a与b
            out <= a & b;
        end

        else if (op == 4'b1000) begin
            // 减法操作，计算a-b，并更新CF
            {CF, out} <= a - b;
        end

        else if (op == 4'b1101) begin
            // 有符号右移操作，将a右移b位，考虑符号位
            if (a[31] == 1) begin
                out <= a >> b;
                out <= out | (32'hFFFFFFFF << (32 - b));
            end
            else
                out <= a >> b;
        end

        // INC
        else if (op ==4'b1010) begin
            {CF,out} <= a+1;
        end

        // DEC
        else if (op ==4'b1011) begin
            {CF,out} <= a-1;
        end

        ZF<=(out==0)?1:0;
        // OF<=CF^out[31]^a[31]^b[31];
        OF<=CF^out[31];
        SF<=out[31];
    end

endmodule
