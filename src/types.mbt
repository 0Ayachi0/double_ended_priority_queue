///|
/// 反向比较包装器，用于创建最小堆
pub struct Reverse[T] {
  value : T
} derive(Show, Eq)

///|
/// 为Reverse实现反向比较
pub impl[T : Compare] Compare for Reverse[T] with compare(self, other) {
  // 反向比较：大的变小，小的变大
  other.value.compare(self.value)
}

///|
/// 双端优先队列 - 使用反向比较器实现
/// 这是最高效的实现方案
pub struct DoubleEndedPriorityQueue[T] {
  /// 最大堆 - 直接使用priority_queue（默认是最大堆）
  max_heap : @priority_queue.T[T]
  /// 最小堆 - 使用Reverse包装器实现
  min_heap : @priority_queue.T[Reverse[T]]
  /// 当前元素数量
  mut length : Int
}
