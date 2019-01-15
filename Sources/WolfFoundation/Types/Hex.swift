//
//  Hex.swift
//  WolfFoundation
//
//  Created by Wolf McNally on 11/29/18.
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

import WolfPipe
import Foundation

public enum HexTag { }
public typealias Hex = Tagged<HexTag, String>

public func tagHex(_ string: String) -> Hex {
    return Hex(rawValue: string)
}

private let hexDigits = Array("0123456789abcdef".utf16)

/// Encodes the data as hexadecimal.
public func toHex(_ data: Data) -> Hex {
    var chars: [unichar] = []
    chars.reserveCapacity(2 * data.count)
    for byte in data {
        chars.append(hexDigits[Int(byte / 16)])
        chars.append(hexDigits[Int(byte % 16)])
    }
    return String(utf16CodeUnits: chars, count: chars.count) |> tagHex
}

private func split(string: String, by size: Int) -> [String] {
    var parts = [String]()
    var start = string.startIndex
    while start != string.endIndex {
        let end = string.index(start, offsetBy: size, limitedBy: string.endIndex) ?? string.endIndex
        parts.append(String(string[start ..< end]))
        start = end
    }
    return parts
}

/// Decodes the hexadecimal string to data.
///
/// Throws if the string is not valid hexidecimal format.
public func toData(_ hex: Hex) throws -> Data {
    let string = hex®
    let charactersCount = string.count

    var data: Data

    if charactersCount == 1 {
        guard let b = UInt8(string, radix: 16) else {
            throw WolfFoundationError("Invalid hex encoding")
        }
        data = Data(count: 1)
        data[0] = b
    } else {
        guard charactersCount % 2 == 0 else {
            throw WolfFoundationError("Invalid hex encoding")
        }

        let bytesCount = charactersCount / 2

        data = Data(count: bytesCount)
        for (index, s) in split(string: string, by: 2).enumerated() {
            guard let b = UInt8(s, radix: 16) else {
                throw WolfFoundationError("Invalid hex encoding")
            }
            data[index] = b
        }
    }

    return data
}

public func dataLiteral(_ string: String) -> Data {
    return try! string |> tagHex |> toData
}
