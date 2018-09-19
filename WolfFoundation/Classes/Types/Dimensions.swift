//
//  Dimensions.swift
//  WolfFoundation
//
//  Created by Wolf McNally on 2/13/17.
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

public struct Dimensions: Sequence {
    public let columns: Int
    public let rows: Int
    public let columnMajor: Bool

    public func makeIterator() -> Iterator {
        return Iterator(self)
    }

    public struct Iterator: IteratorProtocol {
        let dimensions: Dimensions
        var current: Position! = Position()

        public init(_ dimensions: Dimensions) {
            self.dimensions = dimensions
        }

        public mutating func next() -> Position? {
            guard current != nil else { return nil }

            let n = current

            if dimensions.columnMajor {
                if current.row == dimensions.rows - 1 {
                    if current.column == dimensions.columns - 1 {
                        current = nil
                    } else {
                        current.row = 0; current.column += 1
                    }
                } else {
                    current.row += 1
                }
            } else {
                if current.column == dimensions.columns - 1 {
                    if current.row == dimensions.rows - 1 {
                        current = nil
                    } else {
                        current.column = 0; current.row += 1
                    }
                } else {
                    current.column += 1
                }
            }

            return n
        }
    }

    public init(columns: Int, rows: Int, columnMajor: Bool = false) {
        self.columns = columns
        self.rows = rows
        self.columnMajor = columnMajor
    }

    public var columnsRange: AnySequence<Int> {
        return AnySequence<Int>(0 ..< columns)
    }

    public var rowsRange: AnySequence<Int> {
        return AnySequence<Int>(0 ..< rows)
    }
}
