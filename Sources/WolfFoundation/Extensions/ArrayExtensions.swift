//
//  ArrayExtensions.swift
//  WolfFoundation
//
//  Created by Wolf McNally on 7/5/15.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import WolfNumerics

extension RangeReplaceableCollection {
    @discardableResult public mutating func arrange(from: Index, to: Index) -> Bool {
        precondition(indices.contains(from) && indices.contains(to), "invalid indexes")
        guard from != to else { return false }
        insert(remove(at: from), at: to)
        return true
    }
}

extension Sequence {
    public func flatJoined(separator: String = "") -> String {
        let a = compactMap { (i) -> String? in
            if let o = i as? OptionalProtocol {
                if o.isSome {
                    return o.unwrappedString()
                } else {
                    return nil
                }
            }
            return String(describing: i)
        }
        return a.joined(separator: separator)
    }

    public func filtermap<T>(_ transform: (Element) -> T?) -> [T] {
        var result = [T]()
        forEach {
            guard let t = transform($0) else { return }
            result.append(t)
        }
        return result
    }
}

extension Array {
    public func split(by size: Int) -> [[Element]] {
        return stride(from: 0, to: self.count, by: size).map { start in
            let end = self.index(start, offsetBy: size, limitedBy: self.count) ?? self.endIndex
            return Array(self[start ..< end])
        }
    }
}

/// Return the permutations of an array.
/// Algorithm by Nikolas Wirth.
/// Adapted from: https://github.com/raywenderlich/swift-algorithm-club/tree/master/Combinatorics
extension Array {
    /// Call the closure with each permutation of the array, stopping if the closure returns `true`.
    public func permute(_ f: ([Element]) -> Bool) {
        permute(count - 1, f)
    }

    /// Call the closure with each permutation of the array.
    public func permute(_ f: ([Element]) -> Void) {
        permute(count - 1) {
            f($0)
            return false
        }
    }

    /// Return all permutations of the array.
    public var permutations: [[Element]] {
        var result = [[Element]]()
        permute { result.append($0) }
        return result
    }

    private func permute(_ n: Int, _ f: ([Element]) -> Bool) {
        if n == 0 {
            if !f(self) { return }
        } else {
            var a = self
            a.permute(n - 1, f)
            for i in 0..<n {
                a.swapAt(i, n)
                a.permute(n - 1, f)
                a.swapAt(i, n)
            }
        }
    }
}
