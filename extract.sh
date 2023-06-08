#!/bin/bash

# 提供一个十六进制的输入指令
hex_instruction="$1"

# 将所有的小写字母转换为大写
hex_instruction=$(echo "$hex_instruction" | tr '[:lower:]' '[:upper:]')

# 将十六进制数转换为二进制数
bin_instruction=$(echo "obase=2; ibase=16; $hex_instruction" | bc)

# 用零填充二进制数，确保它是 32 位
bin_instruction=$(printf "%032s" "$bin_instruction")

# 提取 opcode (低7位)
opcode=${bin_instruction:25:7}

# 提取 funct3 (第15-17位)
funct3=${bin_instruction:17:3}

# 提取 funct7 (第25-31位)
funct7=${bin_instruction:0:7}

# 输出结果
echo "Instruction: $bin_instruction"
echo "Opcode: $opcode"
echo "Funct3: $funct3"
echo "Funct7: $funct7"
