// Copyright (c) 2024 dxmwl. All rights reserved.
// Use of this source code is governed by a MIT-style license that can be
// found in the LICENSE file.

import 'dart:math' as math;

/// Extension methods on [List] for common list operations.
///
/// This extension provides convenient methods for:
/// - Safe element access (first, last with defaults)
/// - List manipulation (unique, chunked, grouped)
/// - Statistical operations (sum, average, min, max)
/// - Conditional operations (whereNotNull, whereType)
/// - List transformations (sorted, reversed, shuffled)
///
/// Example usage:
/// ```dart
/// import 'package:tools_box/tools_box.dart';
///
/// void main() {
///   final numbers = [1, 2, 3, 4, 5];
///   print(numbers.sum); // 15
///   print(numbers.average); // 3.0
///
///   final items = ['a', 'b', null, 'c'];
///   print(items.whereNotNull); // ['a', 'b', 'c']
/// }
/// ```
extension ListUtils<T> on List<T> {
  /// Returns the first element of the list, or [defaultValue] if the list is empty.
  ///
  /// Parameters:
  /// - [defaultValue]: The value to return if list is empty (default: null)
  ///
  /// Returns the first element, or [defaultValue] if empty.
  ///
  /// Example:
  /// ```dart
  /// [1, 2, 3].firstOrDefault(); // 1
  /// <int>[].firstOrDefault(0); // 0
  /// <String>[].firstOrDefault('N/A'); // 'N/A'
  /// ```
  T? firstOrDefault([T? defaultValue]) => isEmpty ? defaultValue : first;

  /// Returns the last element of the list, or [defaultValue] if the list is empty.
  ///
  /// Parameters:
  /// - [defaultValue]: The value to return if list is empty (default: null)
  ///
  /// Returns the last element, or [defaultValue] if empty.
  ///
  /// Example:
  /// ```dart
  /// [1, 2, 3].lastOrDefault(); // 3
  /// <int>[].lastOrDefault(-1); // -1
  /// ```
  T? lastOrDefault([T? defaultValue]) => isEmpty ? defaultValue : last;

  /// Returns a new list with duplicate elements removed, preserving order.
  ///
  /// Uses the == operator and hashCode for equality comparison.
  ///
  /// Returns a new list containing only unique elements in original order.
  ///
  /// Example:
  /// ```dart
  /// [1, 2, 2, 3, 3, 3].unique; // [1, 2, 3]
  /// ['a', 'b', 'a', 'c'].unique; // ['a', 'b', 'c']
  /// ```
  List<T> get unique {
    final seen = <T>{};
    return where((element) => seen.add(element)).toList();
  }

  /// Splits the list into chunks of specified [size].
  ///
  /// The last chunk may contain fewer than [size] elements if the list
  /// length is not evenly divisible by [size].
  ///
  /// Parameters:
  /// - [size]: Maximum number of elements per chunk
  ///
  /// Returns a list of lists, each containing up to [size] elements.
  ///
  /// Throws [ArgumentError] if [size] is less than or equal to 0.
  ///
  /// Example:
  /// ```dart
  /// [1, 2, 3, 4, 5].chunked(2); // [[1, 2], [3, 4], [5]]
  /// [1, 2, 3, 4, 5, 6].chunked(3); // [[1, 2, 3], [4, 5, 6]]
  /// ```
  List<List<T>> chunked(int size) {
    if (size <= 0) throw ArgumentError('Size must be greater than 0');
    final result = <List<T>>[];
    for (var i = 0; i < length; i += size) {
      result.add(sublist(i, (i + size > length) ? length : i + size));
    }
    return result;
  }

  /// Groups elements by the key returned from [keyFn].
  ///
  /// Creates a map where keys are derived from elements using [keyFn],
  /// and values are lists of elements that share the same key.
  ///
  /// Type parameter [K] specifies the type of grouping keys.
  ///
  /// Parameters:
  /// - [keyFn]: Function to extract the group key from each element
  ///
  /// Returns a Map with keys from [keyFn] and values as lists of matching elements.
  ///
  /// Example:
  /// ```dart
  /// final people = [
  ///   Person(name: 'Alice', age: 25),
  ///   Person(name: 'Bob', age: 30),
  ///   Person(name: 'Charlie', age: 25),
  /// ];
  /// final grouped = people.groupBy((p) => p.age);
  /// // {25: [Alice, Charlie], 30: [Bob]}
  /// ```
  Map<K, List<T>> groupBy<K>(K Function(T) keyFn) {
    final map = <K, List<T>>{};
    for (final element in this) {
      final key = keyFn(element);
      map.putIfAbsent(key, () => []).add(element);
    }
    return map;
  }

  /// Returns all elements except the first [count] elements.
  ///
  /// If [count] is greater than or equal to list length, returns an empty list.
  ///
  /// Parameters:
  /// - [count]: Number of elements to skip (default: 1)
  ///
  /// Returns a new list without the first [count] elements.
  ///
  /// Example:
  /// ```dart
  /// [1, 2, 3, 4, 5].skipFirst(2); // [3, 4, 5]
  /// [1, 2, 3].skipFirst(5); // []
  /// ```
  List<T> skipFirst([int count = 1]) {
    if (count >= length) return [];
    return sublist(count);
  }

  /// Returns all elements except the last [count] elements.
  ///
  /// If [count] is greater than or equal to list length, returns an empty list.
  ///
  /// Parameters:
  /// - [count]: Number of elements to skip from end (default: 1)
  ///
  /// Returns a new list without the last [count] elements.
  ///
  /// Example:
  /// ```dart
  /// [1, 2, 3, 4, 5].skipLast(2); // [1, 2, 3]
  /// [1, 2, 3].skipLast(5); // []
  /// ```
  List<T> skipLast([int count = 1]) {
    if (count >= length) return [];
    return sublist(0, length - count);
  }

  /// Safely gets element at [index], returning [defaultValue] if out of bounds.
  ///
  /// Unlike direct indexing which throws RangeError, this method safely handles
  /// out-of-bounds access by returning a default value.
  ///
  /// Parameters:
  /// - [index]: The index to access
  /// - [defaultValue]: Value to return if index is invalid (default: null)
  ///
  /// Returns the element at [index], or [defaultValue] if out of range.
  ///
  /// Example:
  /// ```dart
  /// [1, 2, 3].getOrNull(1); // 2
  /// [1, 2, 3].getOrNull(10); // null
  /// [1, 2, 3].getOrNull(10, defaultValue: 0); // 0
  /// ```
  T? getOrNull(int index, {T? defaultValue}) =>
      (index >= 0 && index < length) ? this[index] : defaultValue;

  /// Checks if all elements satisfy the [predicate].
  ///
  /// Returns `true` if the list is empty or every element satisfies [predicate].
  /// Returns `false` if any element fails the predicate.
  ///
  /// Parameters:
  /// - [predicate]: Test function for each element
  ///
  /// Returns `true` if all elements match, `false` otherwise.
  ///
  /// Example:
  /// ```dart
  /// [2, 4, 6].all((n) => n.isEven); // true
  /// [2, 3, 6].all((n) => n.isEven); // false
  /// [].all((n) => n > 0); // true (vacuously true)
  /// ```
  bool all(bool Function(T) predicate) => every(predicate);

  /// Checks if any element satisfies the [predicate].
  ///
  /// Returns `true` if at least one element satisfies [predicate].
  /// Returns `false` if no elements match or list is empty.
  ///
  /// Parameters:
  /// - [predicate]: Test function for each element
  ///
  /// Returns `true` if any element matches, `false` otherwise.
  ///
  /// Example:
  /// ```dart
  /// [1, 3, 5].any((n) => n.isEven); // false
  /// [1, 2, 5].any((n) => n.isEven); // true
  /// [].any((n) => true); // false
  /// ```
  bool any(bool Function(T) predicate) => this.any(predicate);

  /// Counts elements that satisfy the [predicate].
  ///
  /// Parameters:
  /// - [predicate]: Test function for each element
  ///
  /// Returns the number of elements where [predicate] returns true.
  ///
  /// Example:
  /// ```dart
  /// [1, 2, 3, 4, 5].count((n) => n > 3); // 2
  /// ['a', 'b', 'c'].count((s) => s.length > 1); // 0
  /// ```
  int count(bool Function(T) predicate) => where(predicate).length;

  /// Returns a new list with elements in random order.
  ///
  /// Creates a shuffled copy without modifying the original list.
  ///
  /// Returns a new randomly-ordered list.
  ///
  /// Example:
  /// ```dart
  /// [1, 2, 3, 4, 5].shuffledList; // e.g., [3, 1, 5, 2, 4]
  /// ```
  List<T> get shuffledList => List.from(this)..shuffle();

  /// Checks if the list contains no elements.
  ///
  /// Returns `true` if the list has zero elements, `false` otherwise.
  ///
  /// Example:
  /// ```dart
  /// <int>[].isNotEmptyList; // false
  /// [1, 2, 3].isNotEmptyList; // true
  /// ```
  bool get isNotEmptyList => isNotEmpty;

  /// Checks if the list contains elements.
  ///
  /// Alias for [isNotEmpty].
  ///
  /// Returns `true` if the list has one or more elements.
  ///
  /// Example:
  /// ```dart
  /// <int>[].hasElements; // false
  /// [1].hasElements; // true
  /// ```
  bool get hasElements => isNotEmpty;

  /// Swaps elements at positions [i] and [j].
  ///
  /// Modifies the list in place. Throws RangeError if indices are out of bounds.
  ///
  /// Parameters:
  /// - [i]: First index
  /// - [j]: Second index
  ///
  /// Example:
  /// ```dart
  /// final numbers = [1, 2, 3];
  /// numbers.swap(0, 2);
  /// print(numbers); // [3, 2, 1]
  /// ```
  void swap(int i, int j) {
    if (i < 0 || i >= length || j < 0 || j >= length) {
      throw RangeError('Index out of bounds');
    }
    final temp = this[i];
    this[i] = this[j];
    this[j] = temp;
  }

  /// Returns the element at [index] cyclically, wrapping around if needed.
  ///
  /// For negative indices, counts from the end. Wraps around for indices
  /// beyond list length.
  ///
  /// Parameters:
  /// - [index]: The index to access (can be negative or exceed length)
  ///
  /// Returns the element at the wrapped index position.
  ///
  /// Example:
  /// ```dart
  /// [1, 2, 3].cyclic(0); // 1
  /// [1, 2, 3].cyclic(3); // 1 (wraps around)
  /// [1, 2, 3].cyclic(-1); // 3 (from end)
  /// [1, 2, 3].cyclic(100); // 2 (100 % 3 = 1)
  /// ```
  T cyclic(int index) {
    if (isEmpty) throw StateError('Cannot get cyclic element from empty list');
    final adjustedIndex = ((index % length) + length) % length;
    return this[adjustedIndex];
  }

  /// Finds the first element that satisfies [predicate], or returns [defaultValue].
  ///
  /// Similar to [firstWhere] but returns a default value instead of throwing
  /// when no element is found.
  ///
  /// Parameters:
  /// - [predicate]: Test function for each element
  /// - [defaultValue]: Value to return if no match found (default: null)
  ///
  /// Returns the first matching element, or [defaultValue] if none found.
  ///
  /// Example:
  /// ```dart
  /// [1, 2, 3, 4, 5].findFirst((n) => n > 3); // 4
  /// [1, 2, 3].findFirst((n) => n > 10); // null
  /// [1, 2, 3].findFirst((n) => n > 10, defaultValue: 0); // 0
  /// ```
  T? findFirst(bool Function(T) predicate, {T? defaultValue}) {
    for (final element in this) {
      if (predicate(element)) return element;
    }
    return defaultValue;
  }

  /// Finds the last element that satisfies [predicate], or returns [defaultValue].
  ///
  /// Parameters:
  /// - [predicate]: Test function for each element
  /// - [defaultValue]: Value to return if no match found (default: null)
  ///
  /// Returns the last matching element, or [defaultValue] if none found.
  ///
  /// Example:
  /// ```dart
  /// [1, 2, 3, 4, 3].findLast((n) => n == 3); // last 3
  /// [1, 2, 3].findLast((n) => n > 10); // null
  /// ```
  T? findLast(bool Function(T) predicate, {T? defaultValue}) {
    T? result;
    for (final element in this) {
      if (predicate(element)) result = element;
    }
    return result ?? defaultValue;
  }
}

/// Extension methods on [List<num>] for numeric operations.
///
/// Provides statistical and mathematical operations on lists of numbers.
///
/// Example usage:
/// ```dart
/// final numbers = [1, 2, 3, 4, 5];
/// print(numbers.sum); // 15
/// print(numbers.average); // 3.0
/// print(numbers.minValue); // 1
/// print(numbers.maxValue); // 5
/// ```
extension NumericListUtils on List<num> {
  /// Calculates the sum of all numbers in the list.
  ///
  /// Returns 0 for an empty list.
  ///
  /// Example:
  /// ```dart
  /// [1, 2, 3].sum; // 6
  /// [].sum; // 0
  /// [1.5, 2.5, 3.0].sum; // 7.0
  /// ```
  num get sum => fold<num>(0, (prev, element) => prev + element);

  /// Calculates the arithmetic mean (average) of all numbers.
  ///
  /// Returns 0 for an empty list to avoid division by zero.
  ///
  /// Example:
  /// ```dart
  /// [1, 2, 3].average; // 2.0
  /// [10, 20].average; // 15.0
  /// [].average; // 0.0
  /// ```
  double get average => isEmpty ? 0.0 : sum / length;

  /// Returns the minimum value in the list.
  ///
  /// Throws StateError if the list is empty.
  ///
  /// Example:
  /// ```dart
  /// [3, 1, 4, 1, 5].minValue; // 1
  /// [-5, 0, 10].minValue; // -5
  /// ```
  num get minValue => reduce(math.min);

  /// Returns the maximum value in the list.
  ///
  /// Throws StateError if the list is empty.
  ///
  /// Example:
  /// ```dart
  /// [3, 1, 4, 1, 5].maxValue; // 5
  /// [-5, 0, 10].maxValue; // 10
  /// ```
  num get maxValue => reduce(math.max);

  /// Returns both minimum and maximum values as a list.
  ///
  /// Returns `[min, max]`. Throws StateError if list is empty.
  ///
  /// Example:
  /// ```dart
  /// [3, 1, 4, 1, 5].minMax; // [1, 5]
  /// ```
  List<num> get minMax => [minValue, maxValue];

  /// Calculates the median (middle) value of the sorted list.
  ///
  /// For odd-length lists, returns the middle element.
  /// For even-length lists, returns the average of two middle elements.
  ///
  /// Returns 0 for an empty list.
  ///
  /// Example:
  /// ```dart
  /// [1, 3, 2].median; // 2
  /// [1, 2, 3, 4].median; // 2.5
  /// [].median; // 0.0
  /// ```
  double get median {
    if (isEmpty) return 0.0;
    final sorted = List<num>.from(this)..sort();
    final mid = sorted.length ~/ 2;
    if (sorted.length.isOdd) return sorted[mid].toDouble();
    return (sorted[mid - 1] + sorted[mid]) / 2;
  }
}
