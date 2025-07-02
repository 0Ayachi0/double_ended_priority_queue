///|
/// 测试创建空队列
test "new_empty_queue" {
  let depq : DoubleEndedPriorityQueue[Int] = new()
  assert_eq!(depq.length(), 0)
  assert_true!(depq.is_empty())
  assert_eq!(depq.peek_min(), None)
  assert_eq!(depq.peek_max(), None)
}

///|
/// 测试从数组创建队列
test "from_array" {
  let depq = from_array([3, 1, 4, 1, 5, 9, 2, 6])
  assert_eq!(depq.length(), 8)
  assert_false!(depq.is_empty())
  assert_eq!(depq.peek_min(), Some(1))
  assert_eq!(depq.peek_max(), Some(9))
}

///|
/// 测试单元素队列
test "single_element" {
  let depq = new()
  depq.push(42)
  assert_eq!(depq.length(), 1)
  assert_false!(depq.is_empty())
  assert_eq!(depq.peek_min(), Some(42))
  assert_eq!(depq.peek_max(), Some(42))
}

///|
/// 测试插入操作
test "push_operations" {
  let depq = new()

  // 插入第一个元素
  depq.push(5)
  assert_eq!(depq.length(), 1)
  assert_eq!(depq.peek_min(), Some(5))
  assert_eq!(depq.peek_max(), Some(5))

  // 插入更小的元素
  depq.push(3)
  assert_eq!(depq.length(), 2)
  assert_eq!(depq.peek_min(), Some(3))
  assert_eq!(depq.peek_max(), Some(5))

  // 插入更大的元素
  depq.push(7)
  assert_eq!(depq.length(), 3)
  assert_eq!(depq.peek_min(), Some(3))
  assert_eq!(depq.peek_max(), Some(7))

  // 插入中间值
  depq.push(4)
  assert_eq!(depq.length(), 4)
  assert_eq!(depq.peek_min(), Some(3))
  assert_eq!(depq.peek_max(), Some(7))
}

///|
/// 测试弹出最小值
test "pop_min_operations" {
  let depq = from_array([5, 3, 8, 1, 9, 2])

  // 弹出最小值
  assert_eq!(depq.pop_min(), Some(1))
  assert_eq!(depq.length(), 5)
  assert_eq!(depq.peek_min(), Some(2))
  assert_eq!(depq.peek_max(), Some(9))

  // 继续弹出最小值
  assert_eq!(depq.pop_min(), Some(2))
  assert_eq!(depq.length(), 4)
  assert_eq!(depq.peek_min(), Some(3))
  assert_eq!(depq.pop_min(), Some(3))
  assert_eq!(depq.length(), 3)
  assert_eq!(depq.peek_min(), Some(5))
}

///|
/// 测试弹出最大值
test "pop_max_operations" {
  let depq = from_array([5, 3, 8, 1, 9, 2])

  // 弹出最大值
  assert_eq!(depq.pop_max(), Some(9))
  assert_eq!(depq.length(), 5)
  assert_eq!(depq.peek_max(), Some(8))
  assert_eq!(depq.peek_min(), Some(1))

  // 继续弹出最大值
  assert_eq!(depq.pop_max(), Some(8))
  assert_eq!(depq.length(), 4)
  assert_eq!(depq.peek_max(), Some(5))
  assert_eq!(depq.pop_max(), Some(5))
  assert_eq!(depq.length(), 3)
  assert_eq!(depq.peek_max(), Some(3))
}

///|
/// 测试混合弹出操作
test "mixed_pop_operations" {
  let depq = from_array([1, 2, 3, 4, 5, 6, 7, 8, 9])

  // 交替弹出最小和最大值
  assert_eq!(depq.pop_min(), Some(1)) // [2,3,4,5,6,7,8,9]
  assert_eq!(depq.pop_max(), Some(9)) // [2,3,4,5,6,7,8]
  assert_eq!(depq.pop_min(), Some(2)) // [3,4,5,6,7,8]
  assert_eq!(depq.pop_max(), Some(8)) // [3,4,5,6,7]
  assert_eq!(depq.pop_min(), Some(3)) // [4,5,6,7]
  assert_eq!(depq.length(), 4)
  assert_eq!(depq.peek_min(), Some(4))
  assert_eq!(depq.peek_max(), Some(7))
}

///|
/// 测试清空到空队列
test "empty_queue_by_popping" {
  let depq = from_array([1, 2, 3])

  // 弹出所有元素
  assert_eq!(depq.pop_min(), Some(1))
  assert_eq!(depq.pop_max(), Some(3))
  assert_eq!(depq.pop_min(), Some(2))

  // 队列应该为空
  assert_eq!(depq.length(), 0)
  assert_true!(depq.is_empty())
  assert_eq!(depq.peek_min(), None)
  assert_eq!(depq.peek_max(), None)

  // 从空队列弹出应该返回None
  assert_eq!(depq.pop_min(), None)
  assert_eq!(depq.pop_max(), None)
}

///|
/// 测试clear操作
test "clear_operation" {
  let depq = from_array([10, 20, 30, 40, 50])
  assert_eq!(depq.length(), 5)
  assert_false!(depq.is_empty())
  depq.clear()
  assert_eq!(depq.length(), 0)
  assert_true!(depq.is_empty())
  assert_eq!(depq.peek_min(), None)
  assert_eq!(depq.peek_max(), None)
}

///|
/// 测试重复元素
test "duplicate_elements" {
  let depq = from_array([3, 1, 4, 1, 5, 9, 2, 6, 5, 3])
  assert_eq!(depq.length(), 10)
  assert_eq!(depq.peek_min(), Some(1))
  assert_eq!(depq.peek_max(), Some(9))

  // 弹出重复的最小值
  assert_eq!(depq.pop_min(), Some(1))
  assert_eq!(depq.peek_min(), Some(1)) // 还有另一个1
  assert_eq!(depq.pop_min(), Some(1))
  assert_eq!(depq.peek_min(), Some(2)) // 现在最小值是2
}

///|
/// 测试大小为1的特殊情况
test "single_element_operations" {
  let depq = new()
  depq.push(100)

  // 最小值和最大值应该相同
  assert_eq!(depq.peek_min(), Some(100))
  assert_eq!(depq.peek_max(), Some(100))

  // 弹出最小值
  assert_eq!(depq.pop_min(), Some(100))
  assert_true!(depq.is_empty())

  // 重新插入并弹出最大值
  depq.push(200)
  assert_eq!(depq.pop_max(), Some(200))
  assert_true!(depq.is_empty())
}

///|
/// 测试to_array转换
test "to_array_conversion" {
  let original = [3, 1, 4, 1, 5]
  let depq = from_array(original)
  let result = depq.to_array()
  assert_eq!(result.length(), 5)

  // 结果应该包含所有原始元素（可能顺序不同）
  result.sort()
  original.sort()
  assert_eq!(result, original)
}

///|
/// 测试负数和零
test "negative_numbers_and_zero" {
  let depq = from_array([-5, 0, 3, -2, 7, -1])
  assert_eq!(depq.peek_min(), Some(-5))
  assert_eq!(depq.peek_max(), Some(7))
  assert_eq!(depq.pop_min(), Some(-5))
  assert_eq!(depq.peek_min(), Some(-2))
  assert_eq!(depq.pop_max(), Some(7))
  assert_eq!(depq.peek_max(), Some(3))
}

///|
/// 测试大量数据的性能
///|
/// 测试大量数据的性能
test "large_dataset" {
  let arr = []
  for i = 0; i < 1000; i = i + 1 {
    arr.push(i % 100) // 0-99的循环
  }
  let depq = from_array(arr)
  assert_eq!(depq.length(), 1000)
  assert_eq!(depq.peek_min(), Some(0))
  assert_eq!(depq.peek_max(), Some(99))

  // 弹出一些元素
  for i = 0; i < 10; i = i + 1 {
    ignore(depq.pop_min().unwrap())
  }
  for i = 0; i < 10; i = i + 1 {
    ignore(depq.pop_max().unwrap())
  }
  assert_eq!(depq.length(), 980)
}

///|
/// 测试字符串类型
test "string_type" {
  let depq = from_array(["cat", "apple", "dog", "banana", "elephant"])

  // 根据 Moonbit 的字符串比较规则
  assert_eq!(depq.peek_min(), Some("cat")) // 最短的字符串
  assert_eq!(depq.peek_max(), Some("elephant")) // 最长的字符串
  assert_eq!(depq.pop_min(), Some("cat"))
  assert_eq!(depq.pop_max(), Some("elephant"))

  // 弹出后，剩余: ["dog", "apple", "banana"]
  // 排序: ["dog", "apple", "banana"]
  assert_eq!(depq.peek_min(), Some("dog")) // 长度3，最小
  assert_eq!(depq.peek_max(), Some("banana")) // 长度6，最大
}

///|
/// 测试字符串类型（相同长度，字典序）
test "string_type_same_length" {
  let depq = from_array(["cat", "dog", "bat", "ant", "fox"])

  // 所有都是3个字符，按字典序排序
  assert_eq!(depq.peek_min(), Some("ant"))
  assert_eq!(depq.peek_max(), Some("fox"))
  assert_eq!(depq.pop_min(), Some("ant"))
  assert_eq!(depq.pop_max(), Some("fox"))
  assert_eq!(depq.peek_min(), Some("bat"))
  assert_eq!(depq.peek_max(), Some("dog"))
}

///|
/// 批量操作测试
test "test_batch_operations" {
  let depq = new()

  // 测试批量插入
  let values = [5, 3, 8, 1, 9, 2, 7, 4, 6]
  depq.push_all(values)
  assert_eq!(depq.length(), 9)

  // 测试批量弹出最小值
  let min_values = depq.pop_min_n(3)
  assert_eq!(min_values.length(), 3)
  assert_eq!(min_values[0], 1) // 最小值
  assert_eq!(min_values[1], 2) // 第二小
  assert_eq!(min_values[2], 3) // 第三小
  assert_eq!(depq.length(), 6)

  // 测试批量弹出最大值
  let max_values = depq.pop_max_n(2)
  assert_eq!(max_values.length(), 2)
  assert_eq!(max_values[0], 9) // 最大值
  assert_eq!(max_values[1], 8) // 第二大
  assert_eq!(depq.length(), 4)

  // 测试超出范围的批量弹出
  let remaining = depq.pop_min_n(10) // 请求10个，但只有4个
  assert_eq!(remaining.length(), 4)
  assert_eq!(depq.length(), 0)
  assert_true!(depq.is_empty())
}

///|
/// 查找和存在性检查测试
test "test_find_and_existence" {
  let depq = from_array([5, 3, 8, 1, 9, 2, 7, 4, 6, 1, 3])

  // 数据排序后：[1, 1, 2, 3, 3, 4, 5, 6, 7, 8, 9]

  // 测试元素存在性
  assert_true!(depq.contains(5))
  assert_true!(depq.contains(1))
  assert_true!(depq.contains(9))
  assert_false!(depq.contains(10))
  assert_false!(depq.contains(0))

  // 测试元素计数
  assert_eq!(depq.count(1), 2) // 1出现2次
  assert_eq!(depq.count(3), 2) // 3出现2次
  assert_eq!(depq.count(5), 1) // 5出现1次
  assert_eq!(depq.count(10), 0) // 10不存在

  // 测试第k小的元素
  match depq.kth_min(1) {
    Some(val) => assert_eq!(val, 1) // 第1小（最小）
    None => abort("Should find 1st min")
  }
  match depq.kth_min(3) {
    Some(val) => assert_eq!(val, 2) // 第3小
    None => abort("Should find 3rd min")
  }
  match depq.kth_min(5) {
    Some(val) => assert_eq!(val, 3) // 第5小是3，不是4
    None => abort("Should find 5th min")
  }
  match depq.kth_min(6) {
    Some(val) => assert_eq!(val, 4) // 第6小才是4
    None => abort("Should find 6th min")
  }

  // 测试第k大的元素
  match depq.kth_max(1) {
    Some(val) => assert_eq!(val, 9) // 第1大（最大）
    None => abort("Should find 1st max")
  }
  match depq.kth_max(3) {
    Some(val) => assert_eq!(val, 7) // 第3大
    None => abort("Should find 3rd max")
  }
  match depq.kth_max(5) {
    Some(val) => assert_eq!(val, 5) // 第5大
    None => abort("Should find 5th max")
  }

  // 测试边界情况
  assert_eq!(depq.kth_min(0), None) // k=0无效
  assert_eq!(depq.kth_min(-1), None) // k<0无效
  assert_eq!(depq.kth_min(20), None) // k超出范围
  assert_eq!(depq.kth_max(0), None) // k=0无效
  assert_eq!(depq.kth_max(20), None) // k超出范围
}

///|
/// 统计和分析功能测试
test "test_stats_and_analysis" {
  // 测试空队列统计
  let empty_depq = new()
  let empty_stats = empty_depq.stats()
  assert_eq!(empty_stats.size, 0)
  assert_eq!(empty_stats.min, None)
  assert_eq!(empty_stats.max, None)
  assert_true!(empty_stats.is_empty)

  // 测试非空队列统计
  let depq = from_array([3, 1, 4, 1, 5, 9, 2, 6])
  let stats = depq.stats()
  assert_eq!(stats.size, 8)
  assert_eq!(stats.min, Some(1))
  assert_eq!(stats.max, Some(9))
  assert_false!(stats.is_empty)

  // 测试范围内元素计数
  assert_eq!(depq.count_in_range(1, 3), 4) // 1, 1, 2, 3
  assert_eq!(depq.count_in_range(4, 6), 3) // 4, 5, 6
  assert_eq!(depq.count_in_range(7, 10), 1) // 9
  assert_eq!(depq.count_in_range(10, 20), 0) // 无元素

  // 测试边界值
  assert_eq!(depq.count_in_range(1, 1), 2) // 只有1，出现2次
  assert_eq!(depq.count_in_range(9, 9), 1) // 只有9，出现1次
  assert_eq!(depq.count_in_range(5, 4), 0) // min > max，无效范围
}

///|
/// 单元素和特殊情况测试
test "test_single_element_and_special_cases" {
  // 测试单个元素
  let single_depq = from_array([42])
  assert_eq!(single_depq.length(), 1)
  assert_eq!(single_depq.peek_min(), Some(42))
  assert_eq!(single_depq.peek_max(), Some(42))
  assert_eq!(single_depq.kth_min(1), Some(42))
  assert_eq!(single_depq.kth_max(1), Some(42))
  let single_stats = single_depq.stats()
  assert_eq!(single_stats.min, Some(42))
  assert_eq!(single_stats.max, Some(42))
  assert_eq!(single_stats.size, 1)

  // 测试相同元素
  let same_depq = from_array([5, 5, 5, 5])
  assert_eq!(same_depq.length(), 4)
  assert_eq!(same_depq.peek_min(), Some(5))
  assert_eq!(same_depq.peek_max(), Some(5))
  assert_eq!(same_depq.count(5), 4)
  assert_eq!(same_depq.count_in_range(5, 5), 4)

  // 所有k-th查询都应该返回5
  for i = 1; i <= 4; i = i + 1 {
    assert_eq!(same_depq.kth_min(i), Some(5))
    assert_eq!(same_depq.kth_max(i), Some(5))
  }
}

///|
/// 批量操作边界测试
test "test_batch_operations_boundary" {
  let depq = from_array([1, 2, 3])

  // 测试弹出比现有元素更多的数量
  let all_mins = depq.pop_min_n(5) // 请求5个，但只有3个
  assert_eq!(all_mins.length(), 3)
  assert_eq!(all_mins, [1, 2, 3])
  assert_eq!(depq.length(), 0)

  // 在空队列上执行批量操作
  let empty_result = depq.pop_max_n(3)
  assert_eq!(empty_result.length(), 0)
  assert_eq!(depq.length(), 0)

  // 重新添加元素测试
  depq.push_all([10, 20, 30])
  assert_eq!(depq.length(), 3)
  assert_eq!(depq.peek_min(), Some(10))
  assert_eq!(depq.peek_max(), Some(30))
}

///|
/// 大数据量测试
test "test_large_dataset" {
  let depq = new()

  // 添加大量元素
  for i = 1; i <= 100; i = i + 1 {
    depq.push(i)
  }
  assert_eq!(depq.length(), 100)
  assert_eq!(depq.peek_min(), Some(1))
  assert_eq!(depq.peek_max(), Some(100))

  // 测试k-th查询
  assert_eq!(depq.kth_min(1), Some(1))
  assert_eq!(depq.kth_min(50), Some(50))
  assert_eq!(depq.kth_min(100), Some(100))
  assert_eq!(depq.kth_max(1), Some(100))
  assert_eq!(depq.kth_max(50), Some(51))
  assert_eq!(depq.kth_max(100), Some(1))

  // 测试范围计数
  assert_eq!(depq.count_in_range(1, 10), 10)
  assert_eq!(depq.count_in_range(50, 60), 11) // 50到60包含
  assert_eq!(depq.count_in_range(90, 100), 11)

  // 批量弹出测试
  let first_10_mins = depq.pop_min_n(10)
  assert_eq!(first_10_mins.length(), 10)
  for i = 0; i < 10; i = i + 1 {
    assert_eq!(first_10_mins[i], i + 1)
  }
  assert_eq!(depq.length(), 90)
  let first_5_maxs = depq.pop_max_n(5)
  assert_eq!(first_5_maxs.length(), 5)
  for i = 0; i < 5; i = i + 1 {
    assert_eq!(first_5_maxs[i], 100 - i)
  }
  assert_eq!(depq.length(), 85)
}

///|
/// 统计信息准确性测试
test "test_stats_accuracy" {
  // 测试不同分布的数据
  let ascending = from_array([1, 2, 3, 4, 5])
  let ascending_stats = ascending.stats()
  assert_eq!(ascending_stats.min, Some(1))
  assert_eq!(ascending_stats.max, Some(5))
  assert_eq!(ascending_stats.size, 5)
  let descending = from_array([5, 4, 3, 2, 1])
  let descending_stats = descending.stats()
  assert_eq!(descending_stats.min, Some(1))
  assert_eq!(descending_stats.max, Some(5))
  assert_eq!(descending_stats.size, 5)
  let random = from_array([3, 1, 4, 1, 5, 9, 2, 6])
  let random_stats = random.stats()
  assert_eq!(random_stats.min, Some(1))
  assert_eq!(random_stats.max, Some(9))
  assert_eq!(random_stats.size, 8)

  // 验证范围计数的准确性
  // 原数据排序后：[1, 1, 2, 3, 4, 5, 6, 9]
  assert_eq!(random.count_in_range(1, 9), 8) // 全部元素：[1, 1, 2, 3, 4, 5, 6, 9]
  assert_eq!(random.count_in_range(2, 8), 5) // 范围[2,8]的元素：[2, 3, 4, 5, 6]
  assert_eq!(random.count_in_range(1, 1), 2) // 只有1，出现2次：[1, 1]
  assert_eq!(random.count_in_range(9, 9), 1) // 只有9，出现1次：[9]
  assert_eq!(random.count_in_range(3, 5), 3) // 范围[3,5]的元素：[3, 4, 5]
  assert_eq!(random.count_in_range(0, 0), 0) // 不存在的范围
  assert_eq!(random.count_in_range(10, 20), 0) // 不存在的范围
}

///|
/// 重复元素处理测试
test "test_duplicate_elements" {
  let depq = from_array([3, 1, 3, 2, 1, 3, 2, 1])

  // 验证重复元素的计数
  assert_eq!(depq.count(1), 3)
  assert_eq!(depq.count(2), 2)
  assert_eq!(depq.count(3), 3)
  assert_eq!(depq.count(4), 0)

  // 验证k-th查询考虑重复元素
  assert_eq!(depq.kth_min(1), Some(1)) // 第1个1
  assert_eq!(depq.kth_min(2), Some(1)) // 第2个1
  assert_eq!(depq.kth_min(3), Some(1)) // 第3个1
  assert_eq!(depq.kth_min(4), Some(2)) // 第1个2
  assert_eq!(depq.kth_min(5), Some(2)) // 第2个2
  assert_eq!(depq.kth_min(6), Some(3)) // 第1个3

  // 测试批量弹出重复元素
  let min_3 = depq.pop_min_n(3)
  assert_eq!(min_3, [1, 1, 1]) // 应该按顺序弹出所有的1
  assert_eq!(depq.length(), 5)

  // 验证剩余元素
  assert_eq!(depq.count(1), 0) // 所有1都被弹出
  assert_eq!(depq.count(2), 2) // 2还在
  assert_eq!(depq.count(3), 3) // 3还在
}

///|
/// 性能相关的功能测试
test "test_performance_features" {
  let depq = new()

  // 测试大量相同元素的处理
  for i = 0; i < 50; i = i + 1 {
    depq.push(42)
  }
  assert_eq!(depq.length(), 50)
  assert_eq!(depq.count(42), 50)
  assert_eq!(depq.peek_min(), Some(42))
  assert_eq!(depq.peek_max(), Some(42))

  // 所有k-th查询都应该返回42
  for k = 1; k <= 50; k = k + 1 {
    assert_eq!(depq.kth_min(k), Some(42))
    assert_eq!(depq.kth_max(k), Some(42))
  }

  // 范围查询
  assert_eq!(depq.count_in_range(42, 42), 50)
  assert_eq!(depq.count_in_range(41, 43), 50)
  assert_eq!(depq.count_in_range(43, 50), 0)

  // 批量操作效率测试（间接）
  let batch_result = depq.pop_min_n(25)
  assert_eq!(batch_result.length(), 25)
  assert_eq!(depq.length(), 25)

  // 验证剩余元素仍然正确
  assert_eq!(depq.count(42), 25)
}
