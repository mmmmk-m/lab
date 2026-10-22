import Foundation

var firstArray = Array(0..<1_000_000)

var secondArray = firstArray

secondArray.append(1_000_000)

assert(firstArray.count == 1_000_000)
assert(secondArray.count == 1_000_001)