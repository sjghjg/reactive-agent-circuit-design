# Level 1 · 第一个数字逻辑验证实验

这是土壤干燥判断的入门练习。当前自动浇花产品使用土壤湿度传感器决定何时浇水；下面的文件只验证其中一个简单条件，不是完整控制器。现行需求见 [INPUT_SPEC.md](INPUT_SPEC.md)。

## 需求

`dry=1` 表示土壤干燥，`water_ok=1` 表示水箱有水，`fault=1` 表示传感器故障。仅当输入为 `110` 时，`pump_req` 才能为 `1`。这里的输出只是逻辑请求，不能直接为真实水泵供电。

## 文件

- `pump_gate.v`：符合需求的 RTL。
- `pump_gate_bug.v`：故意写错的 RTL，用于寻找反例。
- `tb_pump_gate.v`：检查全部 8 种输入组合的测试程序。测试期望来自需求中的唯一允许模式 `110`。

## 在 PowerShell 中运行

在本目录打开 PowerShell，然后执行：

```powershell
$iverilog = Join-Path $env:USERPROFILE 'scoop\apps\msys2\current\ucrt64\bin\iverilog.exe'
$vvp = Join-Path $env:USERPROFILE 'scoop\apps\msys2\current\ucrt64\bin\vvp.exe'
New-Item -ItemType Directory -Force build | Out-Null
& $iverilog -g2012 -s tb_pump_gate -o build\pump_good.vvp pump_gate.v tb_pump_gate.v
& $vvp build\pump_good.vvp
```

预期结果包含 `PASS: all 8 input combinations`。

再编译故意写错的版本；不要把两个 `pump_gate` 文件一起编译：

```powershell
& $iverilog -g2012 -s tb_pump_gate -o build\pump_bug.vvp pump_gate_bug.v tb_pump_gate.v
& $vvp build\pump_bug.vvp
```

这次应出现 `FAIL`，并显示一组具体输入、期望输出和实际输出。测试失败是本实验的预期结果。

## 你要回答

1. 为什么正确版只有 `110` 才输出 `1`？
2. 错误版第一次失败时，三个输入各是多少？它违反了哪一句需求？
3. 这个 3 输入组合逻辑共有多少种输入？为何本测试能覆盖全部输入？

完整控制器还需要传感器读数与校准、时钟与状态，才能判断何时启动、运行多久，以及取消后何时允许再次启动。完整路线与各阶段验收条件见 [PROJECT_PLAN.md](PROJECT_PLAN.md)。
