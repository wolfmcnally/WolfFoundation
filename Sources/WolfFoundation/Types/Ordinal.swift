//
//  Ordinal.swift
//  WolfFoundation
//
//  Created by Wolf McNally on 10/31/17.
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

public struct Ordinal {
    public let a: [Int]

    private init(_ a: [Int]) {
        self.a = a
    }

    public init() {
        self.init([0])
    }

    public init(before o: Ordinal) {
        a = [o.a[0] - 1]
    }

    public init(after o: Ordinal) {
        a = [o.a[0] + 1]
    }

    public init(after ord1: Ordinal, before ord2: Ordinal) {
        let len1 = ord1.a.count
        let len2 = ord2.a.count
        if len1 > len2 {
            a = Array(ord1.a.dropLast()) + [ord1.a.last! + 1]
        } else if len1 < len2 {
            a = Array(ord2.a.dropLast()) + [ord2.a.last! - 1]
        } else {
            a = ord1.a + [1]
        }
    }
}

extension Ordinal: Comparable {
    public static func == (lhs: Ordinal, rhs: Ordinal) -> Bool {
        return lhs.a == rhs.a
    }

    public static func < (lhs: Ordinal, rhs: Ordinal) -> Bool {
        return lhs.a.lexicographicallyPrecedes(rhs.a)
    }
}

extension Ordinal: CustomStringConvertible {
    public var description: String {
        return "(" + (a.map { String(describing: $0) }).joined(separator: ", ") + ")"
    }
}

extension Ordinal: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        a = try container.decode([Int].self)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(a)
    }
}

extension Ordinal {
    public struct DecodeError: Error { }

    public var encoded: String {
        return try! String(data: JSONEncoder().encode(self), encoding: .utf8)!
    }

    public init(encoded: String) throws {
        guard let data = encoded.data(using: .utf8) else {
            throw DecodeError()
        }

        self = try JSONDecoder().decode(Ordinal.self, from: data)
    }
}
