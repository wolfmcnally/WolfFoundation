//
//  SortWeight.swift
//  WolfFoundation
//
//  Created by Wolf McNally on 10/27/17.
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

public enum SortWeight: Comparable, CustomStringConvertible {
    case int(Int)
    case double(Double)
    case string(String)
    case ordinal(Ordinal)
    indirect case list([SortWeight])

    public var description: String {
        switch self {
        case .int(let i):
            return String(describing: i)
        case .double(let d):
            return String(describing: d)
        case .string(let s):
            return "\"\(String(describing: s))\""
        case .ordinal(let o):
            return String(describing: o)
        case .list(let o):
            return String(describing: o)
        }
    }

    private static func comparisonError(lhs: SortWeight, rhs: SortWeight) -> Never {
        print("Cannot compare mismatched elements: \(lhs) and \(rhs).")
        preconditionFailure()
    }

    public static func == (lhs: SortWeight, rhs: SortWeight) -> Bool {
        switch lhs {
        case .int(let i1):
            switch rhs {
            case .int(let i2):
                return i1 == i2
            default:
                comparisonError(lhs: lhs, rhs: rhs)
            }
        case .double(let d1):
            switch rhs {
            case .double(let d2):
                return d1 == d2
            default:
                comparisonError(lhs: lhs, rhs: rhs)
            }
        case .string(let s1):
            switch rhs {
            case .string(let s2):
                return s1 == s2
            default:
                comparisonError(lhs: lhs, rhs: rhs)
            }
        case .ordinal(let o1):
            switch rhs {
            case .ordinal(let o2):
                return o1 == o2
            default:
                comparisonError(lhs: lhs, rhs: rhs)
            }
        case .list(let o1):
            switch rhs {
            case .list(let o2):
                return o1 == o2
            default:
                comparisonError(lhs: lhs, rhs: rhs)
            }
        }
    }

    public static func < (lhs: SortWeight, rhs: SortWeight) -> Bool {
        switch lhs {
        case .int(let i1):
            switch rhs {
            case .int(let i2):
                return i1 < i2
            default:
                comparisonError(lhs: lhs, rhs: rhs)
            }
        case .double(let d1):
            switch rhs {
            case .double(let d2):
                return d1 < d2
            default:
                comparisonError(lhs: lhs, rhs: rhs)
            }
        case .string(let s1):
            switch rhs {
            case .string(let s2):
                return s1 < s2
            default:
                comparisonError(lhs: lhs, rhs: rhs)
            }
        case .ordinal(let o1):
            switch rhs {
            case .ordinal(let o2):
                return o1 < o2
            default:
                comparisonError(lhs: lhs, rhs: rhs)
            }
        case .list(let o1):
            switch rhs {
            case .list(let o2):
                return o1.lexicographicallyPrecedes(o2)
            default:
                comparisonError(lhs: lhs, rhs: rhs)
            }
        }
    }
}
