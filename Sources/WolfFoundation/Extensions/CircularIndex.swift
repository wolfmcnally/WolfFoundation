//
//  CircularIndex.swift
//  WolfFoundation
//
//  Created by Wolf McNally on 9/15/18.
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

import Foundation

@inlinable public func makeCircularIndex(at index: Int, count: Int) -> Int {
    guard count > 0 else { return 0 }
    let i = index % count
    return i >= 0 ? i : i + count
}

extension Collection {
    @inlinable public func circularIndex(at index: Int) -> Index {
        return self.index(startIndex, offsetBy: makeCircularIndex(at: index, count: count))
    }

    @inlinable public func element(atCircularIndex index: Int) -> Element {
        return self[circularIndex(at: index)]
    }
}

extension MutableCollection {
    @inlinable public mutating func replaceElement(atCircularIndex index: Int, withElement element: Element) {
        self[circularIndex(at: index)] = element
    }
}
