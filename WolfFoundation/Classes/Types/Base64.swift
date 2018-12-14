//
//  Base64.swift
//  WolfFoundation
//
//  Created by Wolf McNally on 9/22/18.
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

public enum Base64Tag { }
public typealias Base64 = Tagged<Base64Tag, String>

public func tagBase64(_ string: String) -> Base64 {
    return Base64(rawValue: string)
}

/// Encodes the data as base-64.
public func toBase64(_ data: Data) -> Base64 {
    return data.base64EncodedString() |> tagBase64
}

/// Decodes the base-64 string to data
///
/// Throws if the string is not base-64 format.
public func toData(_ base64: Base64) throws -> Data {
    guard let data = Data(base64Encoded: base64.rawValue) else {
        throw WolfFoundationError("Invalid Base64 encoding.")
    }
    return data
}
