# Verilog in Vscode

## 目录

- [Verilog in Vscode](#verilog-in-vscode)
  - [目录](#目录)
  - [阅前须知](#阅前须知)
  - [前置安装：解决部分插件的Requirement](#前置安装解决部分插件的requirement)
  - [安装插件](#安装插件)
  - [插件配置](#插件配置)
  - [使用流程](#使用流程)
  - [补充](#补充)


## 阅前须知

  - 管脚等仍需使用专门的软件
  - 安装过程非唯一解
  - 此处采用Testbench测试
    *过大的测试模拟，Vscode会很吃力，建议使用专门软件（示例：数码管扫描显示）*
  - 如有意料之外的报错，请积极使用搜索引擎，亦可提出[issues](https://github.com/HDU-RISC-V/risc-v/issues)


## 前置安装：解决部分插件的Requirement

  - [iverilog](https://iverilog.fandom.com/wiki/Installation_Guide)
  - Ctags: [Windows](https://github.com/universal-ctags/ctags-win32), [Mac](https://github.com/universal-ctags/ctags/blob/master/docs/autotools.rst), [Linux](https://github.com/universal-ctags/homebrew-universal-ctags)
  - Python3环境，并安装chardet库（可能还需要urllib3等库）


## 安装插件
  |                      插件名                      |       作者        |         作用         |
  | :----------------------------------------------: | :---------------: | :------------------: |
  |                   Verilog HDL                    |    leafvmaple     |       语言支持       |
  | Verilog-HDL/SystemVerilog/Bluespec SystemVerilog | Masahiro Hiramori | 集成包（语言检查等） |
  |                Verilog_Testbench                 |     Truecrab      |        tb测试        |
  |                    WaveTrace                     |     wavetrace     |      波形图查看      |
  |                 Verilog Snippet                  |        czh        |       代码片段       |



## 插件配置
  ```json
    "verilog.ctags.path": "D:\\Verilog\\ctags\\ctags.exe",  // ctags.exe对应Path, 不能包含空格
    "verilog.linting.linter": "iverilog", // 默认为None, 选其他语法检查器也行, 但大概率会需要再额外下载
  ``` 


## 使用流程
  1. 模块编写: 创建文件（如test.v） $\rightarrow$ 编写verilog代码 
  2. 模块运行: 点击右上角的绿色按钮 Verilog: Run Verilog HDL Code（或命令面板运行） $\rightarrow$ 若正常则生成out文件（如test.out），否则终端会报错
  3. 生成测试模板：保持模块文件（如test.v）的窗口显示 $\rightarrow$ 调出命令面板ctrl+shift+p $\rightarrow$ 输入并运行`testbench`命令 $\rightarrow$ 终端打印出生成的测试模板
  4. 需手动添加include语句（如``` `include "test.v"```）
  5. 模拟测试的主要部分，示例代码如下
      ``` v
      initial
      begin
        $dumpfile("test.vcd");  // 需手动添加，用于生成波形图文件
        $dumpvars; // 需手动添加
        #10;
        a = 3'b100;
        b = 3'b010;
        #10;
        $display("[####]\na = %b,\nb = %b", a, b);
        $finish;
      end
      ``` 
      *测试文件运行同“模块运行”*

  6. 波形图查看：打开vcd文件（如test.vcd） $\rightarrow$ 点击Add: Signals按钮 $\rightarrow$ 选择对应要查看的变量（双击载入/点击变量再点击Add: Signals按钮）
  7. 支持进制切换和波种切换（自己摸索吧）


## 补充

  1. linting只有执行保存（Ctrl+S）后才会生效（进行语法检查）
  2. 当workspaceFolder所在路径中含有中文时，iverilog会失效
  3. 如有urllib3和chardet版本冲突，请卸载二者，更新request
      ```shell
      $ pip uninstall urllib3 chardet
      $ pip install --upgrade requests
      ```
  4. 如pip找不到正确版本的chardet，请更新pip
      ```shell
      $ python -m pip install --upgrade pip
      ```