
# 双端优先队列

简体中文 | English

一个用 MoonBit 实现的双端优先队列（DEPQ），支持高效访问最小和最大元素。这种数据结构允许你在对数时间内从优先队列的两端进行查看和弹出操作。

## 🚀 核心特性

• 📊 双端访问 – 高效访问最小和最大元素  
• ➕ 插入操作 – 在保持优先级顺序的同时添加元素  
• 👀 查看操作 – 查看最小/最大元素而不移除它们  
• 🔄 弹出操作 – 移除并返回最小/最大元素  
• 📏 大小管理 – 跟踪队列长度并检查是否为空  
• 🧹 清空操作 – 从队列中移除所有元素  
• 🔄 数组转换 – 将队列转换为排序数组  
• 🔍 类型安全 – 支持 Compare trait 的泛型实现  
• 📦 批量操作 – 高效处理多个元素  
• 🔎 高级搜索 – 查找第k个元素并检查存在性  
• 📈 统计分析 – 获取全面的队列统计信息和分析  
• 🔢 范围查询 – 统计指定范围内的元素数量  
• 🧮 重复元素处理 – 正确支持重复元素

## 📥 安装
```bash
moon add 0Ayachi0/Double_ended_priority_queue
```

## 🚀 使用指南

### 🔨 创建
你可以使用 `new()` 或 `from_array()` 方法创建 `DoubleEndedPriorityQueue`。

```moonbit
  let depq = @Double_ended_priority_queue.new()
  let depq2 = @Double_ended_priority_queue.from_array([3, 1, 4, 1, 5, 9, 2, 6])
```

### ➕ 插入元素
使用 `push()` 方法向队列添加元素。

```moonbit
  let depq = @Double_ended_priority_queue.new()
  depq.push(42)
  depq.push(17)
  depq.push(89)
  assert_eq!(depq.length(), 3)
```

### 📦 批量操作
通过批量操作高效处理多个元素。

```moonbit
  let depq = @Double_ended_priority_queue.new()
  
  // 批量插入多个元素
  depq.push_all([5, 3, 8, 1, 9, 2, 7, 4, 6])
  assert_eq!(depq.length(), 9)
  
  // 批量弹出最小值
  let min_values = depq.pop_min_n(3)
  assert_eq!(min_values, [1, 2, 3])
  
  // 批量弹出最大值
  let max_values = depq.pop_max_n(2)
  assert_eq!(max_values, [9, 8])
```

### 👀 查看操作
查看最小或最大元素而不移除它们。

```moonbit
  let depq = @Double_ended_priority_queue.from_array([3, 1, 4, 1, 5])
  assert_eq!(depq.peek_min(), Some(1))
  assert_eq!(depq.peek_max(), Some(5))
```

### 🔄 弹出操作
从队列的任一端移除并返回元素。

```moonbit
  let depq = @Double_ended_priority_queue.from_array([5, 3, 8, 1, 9, 2])

  // 弹出最小值
  assert_eq!(depq.pop_min(), Some(1))
  assert_eq!(depq.pop_min(), Some(2))

  // 弹出最大值  
  assert_eq!(depq.pop_max(), Some(9))
  assert_eq!(depq.pop_max(), Some(8))
```

### 🔎 高级搜索与分析
查找特定元素并分析队列内容。

```moonbit
  let depq = @Double_ended_priority_queue.from_array([5, 3, 8, 1, 9, 2, 7, 4, 6])
  
  // 检查元素是否存在
  assert_eq!(depq.contains(5), true)
  assert_eq!(depq.contains(10), false)
  
  // 统计特定值的出现次数
  let depq2 = @Double_ended_priority_queue.from_array([1, 2, 1, 3, 1])
  assert_eq!(depq2.count(1), 3)
  
  // 查找第k小/大的元素
  assert_eq!(depq.kth_min(3), Some(3))    // 第3小
  assert_eq!(depq.kth_max(2), Some(8))    // 第2大
```

### 📈 统计信息与范围查询
获取全面的统计信息并执行基于范围的查询。

```moonbit
  let depq = @Double_ended_priority_queue.from_array([3, 1, 4, 1, 5, 9, 2, 6])
  
  // 获取队列统计信息
  let stats = depq.stats()
  assert_eq!(stats.size, 8)
  assert_eq!(stats.min, Some(1))
  assert_eq!(stats.max, Some(9))
  assert_eq!(stats.is_empty, false)
  
  // 统计范围内的元素
  assert_eq!(depq.count_in_range(2, 5), 4)  // 元素：2, 3, 4, 5
  assert_eq!(depq.count_in_range(1, 1), 2)  // 两个1
```

### 📏 大小与状态
检查队列的当前大小和状态。

```moonbit
  let depq = @Double_ended_priority_queue.from_array([1, 2, 3, 4, 5])
  assert_eq!(depq.length(), 5)
  assert_eq!(depq.is_empty(), false)

  depq.clear()
  assert_eq!(depq.length(), 0)
  assert_eq!(depq.is_empty(), true)
```

### 🧹 清空
从队列中移除所有元素。

```moonbit
  let depq = @Double_ended_priority_queue.from_array([1, 2, 3])
  depq.clear()
  assert_eq!(depq.length(), 0)
  assert_true!(depq.is_empty())
```

### 🔄 数组转换
将队列转换为排序数组以便检查或进一步处理。

```moonbit
  let depq = @Double_ended_priority_queue.from_array([3, 1, 4, 1, 5])
  let sorted_array = depq.to_array()
  // 返回升序排列的元素：[1, 1, 3, 4, 5]
```

### 🔍 混合操作
结合不同操作进行灵活的队列管理。

```moonbit
  let depq = @Double_ended_priority_queue.from_array([1, 2, 3, 4, 5, 6, 7, 8, 9])

  // 在最小和最大操作之间交替
  assert_eq!(depq.pop_min(), Some(1))   // [2,3,4,5,6,7,8,9]
  assert_eq!(depq.pop_max(), Some(9))   // [2,3,4,5,6,7,8]
  assert_eq!(depq.pop_min(), Some(2))   // [3,4,5,6,7,8]
  assert_eq!(depq.pop_max(), Some(8))   // [3,4,5,6,7]

  assert_eq!(depq.peek_min(), Some(3))
  assert_eq!(depq.peek_max(), Some(7))
```

### 🔤 字符串支持
队列支持字符串，遵循 MoonBit 的字符串比较规则（先按长度，再按字典序）。

```moonbit
  let depq = @Double_ended_priority_queue.from_array(["cat", "apple", "dog", "banana", "elephant"])
  assert_eq!(depq.peek_min(), Some("cat"))        // 最短字符串
  assert_eq!(depq.peek_max(), Some("elephant"))   // 最长字符串
```

### 🧮 重复元素
队列正确处理重复元素。

```moonbit
  let depq = @Double_ended_priority_queue.from_array([3, 1, 4, 1, 5, 9, 2, 6, 5, 3])
  assert_eq!(depq.pop_min(), Some(1))
  assert_eq!(depq.pop_min(), Some(1))  // 第二个1
  assert_eq!(depq.peek_min(), Some(2))
  
  // 统计重复元素
  assert_eq!(depq.count(3), 2)
  assert_eq!(depq.count(5), 2)
```

## 📋 完整API参考

### 核心操作
- `new()` - 创建空队列
- `from_array(arr)` - 从数组创建
- `push(value)` - 插入元素
- `pop_min()` - 移除最小元素
- `pop_max()` - 移除最大元素
- `peek_min()` - 查看最小元素
- `peek_max()` - 查看最大元素

### 批量操作
- `push_all(arr)` - 插入多个元素
- `pop_min_n(n)` - 移除n个最小元素
- `pop_max_n(n)` - 移除n个最大元素

### 搜索与分析
- `contains(value)` - 检查元素是否存在
- `count(value)` - 统计值的出现次数
- `kth_min(k)` - 查找第k小的元素
- `kth_max(k)` - 查找第k大的元素

### 统计信息
- `stats()` - 获取全面统计信息
- `count_in_range(min, max)` - 统计范围内的元素

### 实用工具
- `length()` - 获取队列大小
- `is_empty()` - 检查是否为空
- `clear()` - 移除所有元素
- `to_array()` - 转换为排序数组

## 📊 性能特征

| 操作 | 时间复杂度 |
|------|----------|
| `new()` | O(1) |
| `push()` | O(log n) |
| `push_all(arr)` | O(k log n) 其中 k = arr.length |
| `peek_min()` / `peek_max()` | O(1) |
| `pop_min()` / `pop_max()` | O(n)* |
| `pop_min_n(k)` / `pop_max_n(k)` | O(k × n)* |
| `contains()` / `count()` | O(n) |
| `kth_min()` / `kth_max()` | O(n log n) |
| `stats()` | 大部分字段为 O(1) |
| `count_in_range()` | O(n) |
| `length()` / `is_empty()` | O(1) |
| `clear()` | O(1) |
| `to_array()` | O(n log n) |

*由于双堆同步要求

## 🏗️ 实现细节

这个双端优先队列使用以下方式实现：
- **最大堆**：用于高效访问最大元素
- **最小堆**：使用反向比较包装器来高效访问最小元素
- **同步机制**：两个堆保持同步以维护一致性

该实现使用 MoonBit 内置的 `@priority_queue` 模块，配合自定义的 `Reverse[T]` 包装类型来创建最小堆行为。

### 高级特性
- **批量处理**：针对高效处理多个元素进行了优化
- **统计分析**：内置统计计算功能，提供数据洞察
- **范围查询**：高效统计指定范围内的元素
- **重复元素支持**：正确处理重复元素并提供精确计数
- **类型安全**：支持 Compare trait 的泛型实现

## 📜 许可证
本项目采用 Apache-2.0 许可证。详情请参阅 LICENSE 文件。

## 📢 联系与支持
• MoonBit 社区：moonbit-community  
• GitHub Issues：报告问题  

👋 如果你喜欢这个项目，请给它一个 ⭐！编程愉快！🚀
