
# Double Ended Priority Queue

English | [简体中文](README_zh_CN.md)

A Double-ended Priority Queue (DEPQ) implementation in MoonBit that supports efficient access to both minimum and maximum elements. This data structure allows you to peek and pop from both ends of the priority queue in logarithmic time.

## 🚀 Key Features

• 📊 Dual Access – Efficiently access both minimum and maximum elements  
• ➕ Insert – Add elements while maintaining priority order  
• 👀 Peek Operations – View min/max elements without removal  
• 🔄 Pop Operations – Remove and return min/max elements  
• 📏 Size Management – Track queue length and check if empty  
• 🧹 Clear – Remove all elements from the queue  
• 🔄 Array Conversion – Convert queue to sorted array  
• 🔍 Type Safety – Generic implementation with Compare trait support  
• 📦 Batch Operations – Efficiently handle multiple elements at once  
• 🔎 Advanced Search – Find k-th elements and check existence  
• 📈 Statistics – Get comprehensive queue statistics and analysis  
• 🔢 Range Queries – Count elements within specified ranges  
• 🧮 Duplicate Handling – Proper support for duplicate elements

## 📥 Installation
```bash
moon add 0Ayachi0/Double_ended_priority_queue
```

## 🚀 Usage Guide

### 🔨 Create
You can create a `DoubleEndedPriorityQueue` using the `new()` or `from_array()` methods.

```moonbit
  let depq = @Double_ended_priority_queue.new()
  let depq2 = @Double_ended_priority_queue.from_array([3, 1, 4, 1, 5, 9, 2, 6])
```

### ➕ Insert Elements
Use the `push()` method to add elements to the queue.

```moonbit
  let depq = @Double_ended_priority_queue.new()
  depq.push(42)
  depq.push(17)
  depq.push(89)
  assert_eq!(depq.length(), 3)
```

### 📦 Batch Operations
Efficiently handle multiple elements with batch operations.

```moonbit
  let depq = @Double_ended_priority_queue.new()
  
  // Batch insert multiple elements
  depq.push_all([5, 3, 8, 1, 9, 2, 7, 4, 6])
  assert_eq!(depq.length(), 9)
  
  // Batch pop minimum values
  let min_values = depq.pop_min_n(3)
  assert_eq!(min_values, [1, 2, 3])
  
  // Batch pop maximum values
  let max_values = depq.pop_max_n(2)
  assert_eq!(max_values, [9, 8])
```

### 👀 Peek Operations
View the minimum or maximum elements without removing them.

```moonbit
  let depq = @Double_ended_priority_queue.from_array([3, 1, 4, 1, 5])
  assert_eq!(depq.peek_min(), Some(1))
  assert_eq!(depq.peek_max(), Some(5))
```

### 🔄 Pop Operations
Remove and return elements from either end of the queue.

```moonbit
  let depq = @Double_ended_priority_queue.from_array([5, 3, 8, 1, 9, 2])

  // Pop minimum values
  assert_eq!(depq.pop_min(), Some(1))
  assert_eq!(depq.pop_min(), Some(2))

  // Pop maximum values  
  assert_eq!(depq.pop_max(), Some(9))
  assert_eq!(depq.pop_max(), Some(8))
```

### 🔎 Advanced Search & Analysis
Find specific elements and analyze queue contents.

```moonbit
  let depq = @Double_ended_priority_queue.from_array([5, 3, 8, 1, 9, 2, 7, 4, 6])
  
  // Check if elements exist
  assert_eq!(depq.contains(5), true)
  assert_eq!(depq.contains(10), false)
  
  // Count occurrences of specific values
  let depq2 = @Double_ended_priority_queue.from_array([1, 2, 1, 3, 1])
  assert_eq!(depq2.count(1), 3)
  
  // Find k-th smallest/largest elements
  assert_eq!(depq.kth_min(3), Some(3))    // 3rd smallest
  assert_eq!(depq.kth_max(2), Some(8))    // 2nd largest
```

### 📈 Statistics & Range Queries
Get comprehensive statistics and perform range-based queries.

```moonbit
  let depq = @Double_ended_priority_queue.from_array([3, 1, 4, 1, 5, 9, 2, 6])
  
  // Get queue statistics
  let stats = depq.stats()
  assert_eq!(stats.size, 8)
  assert_eq!(stats.min, Some(1))
  assert_eq!(stats.max, Some(9))
  assert_eq!(stats.is_empty, false)
  
  // Count elements in range
  assert_eq!(depq.count_in_range(2, 5), 4)  // Elements: 2, 3, 4, 5
  assert_eq!(depq.count_in_range(1, 1), 2)  // Two occurrences of 1
```

### 📏 Size & Status
Check the current size and status of the queue.

```moonbit
  let depq = @Double_ended_priority_queue.from_array([1, 2, 3, 4, 5])
  assert_eq!(depq.length(), 5)
  assert_eq!(depq.is_empty(), false)

  depq.clear()
  assert_eq!(depq.length(), 0)
  assert_eq!(depq.is_empty(), true)
```

### 🧹 Clear
Remove all elements from the queue.

```moonbit
  let depq = @Double_ended_priority_queue.from_array([1, 2, 3])
  depq.clear()
  assert_eq!(depq.length(), 0)
  assert_true!(depq.is_empty())
```

### 🔄 Array Conversion
Convert the queue to a sorted array for inspection or further processing.

```moonbit
  let depq = @Double_ended_priority_queue.from_array([3, 1, 4, 1, 5])
  let sorted_array = depq.to_array()
  // Returns elements in ascending order: [1, 1, 3, 4, 5]
```

### 🔍 Mixed Operations
Combine different operations for flexible queue management.

```moonbit
  let depq = @Double_ended_priority_queue.from_array([1, 2, 3, 4, 5, 6, 7, 8, 9])

  // Alternate between min and max operations
  assert_eq!(depq.pop_min(), Some(1))   // [2,3,4,5,6,7,8,9]
  assert_eq!(depq.pop_max(), Some(9))   // [2,3,4,5,6,7,8]
  assert_eq!(depq.pop_min(), Some(2))   // [3,4,5,6,7,8]
  assert_eq!(depq.pop_max(), Some(8))   // [3,4,5,6,7]

  assert_eq!(depq.peek_min(), Some(3))
  assert_eq!(depq.peek_max(), Some(7))
```

### 🔤 String Support
The queue works with strings, following MoonBit's string comparison rules (length first, then lexicographic).

```moonbit
  let depq = @Double_ended_priority_queue.from_array(["cat", "apple", "dog", "banana", "elephant"])
  assert_eq!(depq.peek_min(), Some("cat"))        // Shortest string
  assert_eq!(depq.peek_max(), Some("elephant"))   // Longest string
```

### 🧮 Duplicate Elements
The queue properly handles duplicate elements.

```moonbit
  let depq = @Double_ended_priority_queue.from_array([3, 1, 4, 1, 5, 9, 2, 6, 5, 3])
  assert_eq!(depq.pop_min(), Some(1))
  assert_eq!(depq.pop_min(), Some(1))  // Second occurrence of 1
  assert_eq!(depq.peek_min(), Some(2))
  
  // Count duplicates
  assert_eq!(depq.count(3), 2)
  assert_eq!(depq.count(5), 2)
```

## 📋 Complete API Reference

### Core Operations
- `new()` - Create empty queue
- `from_array(arr)` - Create from array
- `push(value)` - Insert element
- `pop_min()` - Remove minimum element
- `pop_max()` - Remove maximum element
- `peek_min()` - View minimum element
- `peek_max()` - View maximum element

### Batch Operations
- `push_all(arr)` - Insert multiple elements
- `pop_min_n(n)` - Remove n minimum elements
- `pop_max_n(n)` - Remove n maximum elements

### Search & Analysis
- `contains(value)` - Check if element exists
- `count(value)` - Count occurrences of value
- `kth_min(k)` - Find k-th smallest element
- `kth_max(k)` - Find k-th largest element

### Statistics
- `stats()` - Get comprehensive statistics
- `count_in_range(min, max)` - Count elements in range

### Utility
- `length()` - Get queue size
- `is_empty()` - Check if empty
- `clear()` - Remove all elements
- `to_array()` - Convert to sorted array

## 📊 Performance Characteristics

| Operation | Time Complexity |
|-----------|----------------|
| `new()` | O(1) |
| `push()` | O(log n) |
| `push_all(arr)` | O(k log n) where k = arr.length |
| `peek_min()` / `peek_max()` | O(1) |
| `pop_min()` / `pop_max()` | O(n)* |
| `pop_min_n(k)` / `pop_max_n(k)` | O(k × n)* |
| `contains()` / `count()` | O(n) |
| `kth_min()` / `kth_max()` | O(n log n) |
| `stats()` | O(1) for most fields |
| `count_in_range()` | O(n) |
| `length()` / `is_empty()` | O(1) |
| `clear()` | O(1) |
| `to_array()` | O(n log n) |

*Due to the dual-heap synchronization requirement

## 🏗️ Implementation Details

This Double-ended Priority Queue is implemented using:
- **Maximum Heap**: For efficient access to maximum elements
- **Minimum Heap**: Using reverse comparison wrapper for efficient access to minimum elements
- **Synchronization**: Both heaps are kept in sync to maintain consistency

The implementation uses MoonBit's built-in `@priority_queue` module with a custom `Reverse[T]` wrapper type to create the minimum heap behavior.

### Advanced Features
- **Batch Processing**: Optimized for handling multiple elements efficiently
- **Statistical Analysis**: Built-in statistics computation for data insights
- **Range Queries**: Efficient counting of elements within specified ranges
- **Duplicate Support**: Proper handling of duplicate elements with accurate counting
- **Type Safety**: Generic implementation with Compare trait support

## 📜 License
This project is licensed under the Apache-2.0 License. See LICENSE for details.

## 📢 Contact & Support
• MoonBit Community: moonbit-community  
• GitHub Issues: Report an Issue  

👋 If you like this project, give it a ⭐! Happy coding! 🚀
