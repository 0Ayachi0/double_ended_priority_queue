// Double_ended_priority_queue.mbt

///|
/// 创建一个新的空双端优先队列
///
/// # Example
/// ```
/// let depq : DoubleEndedPriorityQueue[Int] = new()
/// assert_eq!(depq.length(), 0)
/// ```
pub fn new[T : Compare]() -> DoubleEndedPriorityQueue[T] {
  {
    max_heap: @priority_queue.new(),
    min_heap: @priority_queue.new(),
    length: 0,
  }
}

///|
/// 从数组创建双端优先队列
///
/// # Example
/// ```
/// let depq = from_array([3, 1, 4, 1, 5])
/// assert_eq!(depq.length(), 5)
/// ```
pub fn from_array[T : Compare](arr : Array[T]) -> DoubleEndedPriorityQueue[T] {
  let depq = new()
  for item in arr {
    depq.push(item)
  }
  depq
}

///|
/// 向双端优先队列中插入元素
///
/// # Example
/// ```
/// let depq = new()
/// depq.push(42)
/// assert_eq!(depq.length(), 1)
/// ```
pub fn push[T : Compare](self : DoubleEndedPriorityQueue[T], value : T) -> Unit {
  // 插入到最大堆
  self.max_heap.push(value)
  // 插入到最小堆（使用Reverse包装）
  self.min_heap.push({ value, })
  self.length += 1
}

///|
/// 查看最小值但不移除
///
/// # Example
/// ```
/// let depq = from_array([3, 1, 4, 1, 5])
/// assert_eq!(depq.peek_min(), Some(1))
/// ```
pub fn peek_min[T : Compare](self : DoubleEndedPriorityQueue[T]) -> T? {
  if self.length == 0 {
    return None
  }

  // 直接从 max_heap 中找最小值
  let arr = self.max_heap.to_array()
  if arr.is_empty() {
    return None
  }

  // 手动排序并取最小值
  arr.sort()
  Some(arr[0])
}

///|
/// 查看最大值但不移除
///
/// # Example
/// ```
/// let depq = from_array([3, 1, 4, 1, 5])
/// assert_eq!(depq.peek_max(), Some(5))
/// ```
pub fn peek_max[T](self : DoubleEndedPriorityQueue[T]) -> T? {
  self.max_heap.peek()
}

///|
/// 弹出并返回最小值
///
/// # Example
/// ```
/// let depq = from_array([3, 1, 4, 1, 5])
/// let min_val = depq.pop_min()
/// assert_eq!(min_val, Some(1))
/// ```
pub fn pop_min[T : Compare](self : DoubleEndedPriorityQueue[T]) -> T? {
  if self.length == 0 {
    return None
  }

  // 找到最小值
  let arr = self.max_heap.to_array()
  if arr.is_empty() {
    return None
  }
  arr.sort()
  let min_val = arr[0]

  // 从两个堆中移除这个值
  self.remove_from_max_heap(min_val)
  self.remove_from_min_heap(min_val)
  self.length -= 1
  Some(min_val)
}

///|
/// 弹出并返回最大值
///
/// # Example
/// ```
/// let depq = from_array([3, 1, 4, 1, 5])
/// let max_val = depq.pop_max()
/// assert_eq!(max_val, Some(5))
/// ```
pub fn pop_max[T : Compare](self : DoubleEndedPriorityQueue[T]) -> T? {
  if self.length == 0 {
    return None
  }

  // 从最大堆中弹出最大值
  let max_val = self.max_heap.pop()
  match max_val {
    Some(val) => {
      // 从最小堆中移除相同的值
      self.remove_from_min_heap(val)
      self.length -= 1
      Some(val)
    }
    None => None
  }
}

///|
/// 获取队列长度
///
/// # Example
/// ```
/// let depq = from_array([1, 2, 3])
/// assert_eq!(depq.length(), 3)
/// ```
pub fn length[T](self : DoubleEndedPriorityQueue[T]) -> Int {
  self.length
}

///|
/// 检查队列是否为空
///
/// # Example
/// ```
/// let depq : DoubleEndedPriorityQueue[Int] = new()
/// assert_eq!(depq.is_empty(), true)
/// ```
pub fn is_empty[T](self : DoubleEndedPriorityQueue[T]) -> Bool {
  self.length == 0
}

///|
/// 清空队列
///
/// # Example
/// ```
/// let depq = from_array([1, 2, 3])
/// depq.clear()
/// assert_eq!(depq.length(), 0)
/// ```
pub fn clear[T](self : DoubleEndedPriorityQueue[T]) -> Unit {
  self.max_heap.clear()
  self.min_heap.clear()
  self.length = 0
}

///|
/// 从最大堆中移除指定元素（辅助函数）
fn remove_from_max_heap[T : Compare](
  self : DoubleEndedPriorityQueue[T],
  value : T
) -> Unit {
  let temp_array = []
  let mut found = false

  // 弹出所有元素，跳过第一个匹配的元素
  while self.max_heap.is_empty() == false {
    let item = self.max_heap.pop().unwrap()
    if item == value && found == false {
      found = true // 跳过第一个匹配的元素
    } else {
      temp_array.push(item)
    }
  }

  // 将剩余元素重新插入
  for item in temp_array {
    self.max_heap.push(item)
  }
}

///|
/// 从最小堆中移除指定元素（辅助函数）
fn remove_from_min_heap[T : Compare](
  self : DoubleEndedPriorityQueue[T],
  value : T
) -> Unit {
  let temp_array = []
  let mut found = false

  // 弹出所有元素，跳过第一个匹配的元素
  while self.min_heap.is_empty() == false {
    let item = self.min_heap.pop().unwrap()
    if item.value == value && found == false {
      found = true // 跳过第一个匹配的元素
    } else {
      temp_array.push(item)
    }
  }

  // 将剩余元素重新插入
  for item in temp_array {
    self.min_heap.push(item)
  }
}

///|
/// 转换为数组（排序后）
///|
/// 转换为数组（排序后）
pub fn to_array[T : Compare](self : DoubleEndedPriorityQueue[T]) -> Array[T] {
  let temp_arr = []
  let result_arr = []

  // 创建最大堆的副本，避免破坏原始数据
  let temp_heap = @priority_queue.copy(self.max_heap)

  // 逐个弹出元素（从大到小）到临时数组
  while temp_heap.is_empty() == false {
    temp_arr.push(temp_heap.pop().unwrap())
  }

  // 从后往前添加到结果数组，得到从小到大的顺序
  for i = temp_arr.length() - 1; i >= 0; i = i - 1 {
    result_arr.push(temp_arr[i])
  }
  result_arr
}

///|
/// Show实现
pub impl[T : Show + Compare] Show for DoubleEndedPriorityQueue[T] with output(
  self,
  logger
) {
  logger.write_string("DoubleEndedPriorityQueue([")
  let arr = self.to_array()
  for i = 0; i < arr.length(); i = i + 1 {
    if i > 0 {
      logger.write_string(", ")
    }
    arr[i].output(logger)
  }
  logger.write_string("])")
}

///|
/// 批量插入元素
///
/// # Example
/// ```
/// let depq = new()
/// depq.push_all([3, 1, 4, 1, 5])
/// assert_eq!(depq.length(), 5)
/// ```
pub fn push_all[T : Compare](
  self : DoubleEndedPriorityQueue[T],
  arr : Array[T]
) -> Unit {
  for item in arr {
    self.push(item)
  }
}

///|
/// 批量弹出最小值
///
/// # Example
/// ```
/// let depq = from_array([5, 3, 8, 1, 9, 2])
/// let mins = depq.pop_min_n(3)
/// assert_eq!(mins, [1, 2, 3])
/// ```
pub fn pop_min_n[T : Compare](
  self : DoubleEndedPriorityQueue[T],
  n : Int
) -> Array[T] {
  let result = []
  let mut count = 0
  while count < n && self.is_empty() == false {
    match self.pop_min() {
      Some(val) => {
        result.push(val)
        count += 1
      }
      None => break
    }
  }
  result
}

///|
/// 批量弹出最大值
///
/// # Example
/// ```
/// let depq = from_array([5, 3, 8, 1, 9, 2])
/// let maxs = depq.pop_max_n(3)
/// assert_eq!(maxs, [9, 8, 5])
/// ```
pub fn pop_max_n[T : Compare](
  self : DoubleEndedPriorityQueue[T],
  n : Int
) -> Array[T] {
  let result = []
  let mut count = 0
  while count < n && self.is_empty() == false {
    match self.pop_max() {
      Some(val) => {
        result.push(val)
        count += 1
      }
      None => break
    }
  }
  result
}

///|
/// 检查元素是否存在
///
/// # Example
/// ```
/// let depq = from_array([3, 1, 4, 1, 5])
/// assert_eq!(depq.contains(4), true)
/// assert_eq!(depq.contains(10), false)
/// ```
pub fn contains[T : Compare + Eq](
  self : DoubleEndedPriorityQueue[T],
  value : T
) -> Bool {
  let arr = self.to_array()
  for item in arr {
    if item == value {
      return true
    }
  }
  false
}

///|
/// 统计指定元素的数量
///
/// # Example
/// ```
/// let depq = from_array([1, 2, 1, 3, 1])
/// assert_eq!(depq.count(1), 3)
/// ```
pub fn count[T : Compare + Eq](
  self : DoubleEndedPriorityQueue[T],
  value : T
) -> Int {
  let arr = self.to_array()
  let mut count = 0
  for item in arr {
    if item == value {
      count += 1
    }
  }
  count
}

///|
/// 查找第k小的元素（不移除）
///
/// # Example
/// ```
/// let depq = from_array([5, 3, 8, 1, 9, 2])
/// assert_eq!(depq.kth_min(2), Some(2)) // 第2小的是2
/// ```
pub fn kth_min[T : Compare](self : DoubleEndedPriorityQueue[T], k : Int) -> T? {
  if k <= 0 || k > self.length {
    return None
  }
  let arr = self.to_array()
  Some(arr[k - 1])
}

///|
/// 查找第k大的元素（不移除）
///
/// # Example
/// ```
/// let depq = from_array([5, 3, 8, 1, 9, 2])
/// assert_eq!(depq.kth_max(2), Some(8)) // 第2大的是8
/// ```
pub fn kth_max[T : Compare](self : DoubleEndedPriorityQueue[T], k : Int) -> T? {
  if k <= 0 || k > self.length {
    return None
  }
  let arr = self.to_array()
  Some(arr[self.length - k])
}

///|
/// 获取队列的统计信息
pub struct QueueStats[T] {
  size : Int
  min : T?
  max : T?
  is_empty : Bool
}

///|
/// 获取统计信息
///
/// # Example
/// ```
/// let depq = from_array([3, 1, 4, 1, 5])
/// let stats = depq.stats()
/// assert_eq!(stats.size, 5)
/// assert_eq!(stats.min, Some(1))
/// assert_eq!(stats.max, Some(5))
/// ```
pub fn stats[T : Compare](self : DoubleEndedPriorityQueue[T]) -> QueueStats[T] {
  {
    size: self.length,
    min: self.peek_min(),
    max: self.peek_max(),
    is_empty: self.is_empty(),
  }
}

///|
/// 计算范围内元素数量
///
/// # Example
/// ```
/// let depq = from_array([1, 3, 5, 7, 9])
/// assert_eq!(depq.count_in_range(3, 7), 3) // 3, 5, 7
/// ```
pub fn count_in_range[T : Compare](
  self : DoubleEndedPriorityQueue[T],
  min_val : T,
  max_val : T
) -> Int {
  let arr = self.to_array()
  let mut count = 0
  for item in arr {
    if item >= min_val && item <= max_val {
      count += 1
    }
  }
  count
}
