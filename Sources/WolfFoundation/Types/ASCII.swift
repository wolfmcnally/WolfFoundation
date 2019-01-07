//
//  ASCII.swift
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

extension StringProtocol {
    public var ascii: [Int8] {
        return unicodeScalars.compactMap { $0.isASCII ? Int8($0.value) : nil }
    }

    public var asciiCharacter: Int8? {
        return ascii.first
    }

    public var asciiByte: UInt8 {
        return UInt8(asciiCharacter ?? 0)
    }
}

extension Character {
    public var ascii: Int8? {
        let a = self.unicodeScalars.first!
        return a.isASCII ? Int8(a.value) : nil
    }
}
