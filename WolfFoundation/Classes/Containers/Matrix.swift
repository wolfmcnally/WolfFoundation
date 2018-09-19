//
//  Matrix.swift
//  WolfFoundation
//
//  Created by Wolf McNally on 2/23/16.
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

public class Matrix<T> {
    public typealias ValueType = T
    typealias RowType = [ValueType?]
    private var rows = [RowType]()
    public private(set) var columnsCount: Int = 0
    public var rowsCount: Int {
        return rows.count
    }

    public init() { }

    public func removeAll() {
        rows = [RowType]()
        columnsCount = 0
    }

    public func object(atPosition position: Position) -> ValueType? {
        guard position.row < rowsCount else {
            return nil
        }

        let row = rows[position.row]
        guard position.column < row.count else {
            return nil
        }

        return row[position.column]
    }

    public func set(object value: ValueType?, atPosition position: Position) {
        while rowsCount <= position.row {
            rows.append(RowType())
        }

        while rows[position.row].count <= position.column {
            rows[position.row].append(nil)
            if rows[position.row].count > columnsCount {
                columnsCount = rows[position.row].count
            }
        }

        rows[position.row][position.column] = value
    }

    public func compact() {
        columnsCount = 0
        var removingRows = true

        for rowIndex in (0..<rowsCount).reversed() {
            let originalColumnsCount = rows[rowIndex].count
            var newColumnsCount = originalColumnsCount
            for columnIndex in (0..<originalColumnsCount).reversed() {
                if rows[rowIndex][columnIndex] == nil {
                    rows[rowIndex].removeLast()
                    newColumnsCount -= 1
                } else {
                    break
                }
            }

            if newColumnsCount > columnsCount {
                columnsCount = newColumnsCount
            }

            if removingRows {
                if newColumnsCount == 0 {
                    rows.removeLast()
                } else {
                    removingRows = false
                }
            }
        }
    }
}
