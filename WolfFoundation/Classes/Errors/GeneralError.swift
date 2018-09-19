//
//  GeneralError.swift
//  WolfFoundation
//
//  Created by Wolf McNally on 7/8/15.
//  Copyright © 2015 Wolf McNally.
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

/// Represents a non-specific error result.
public struct GeneralError: DescriptiveError {
    /// A human-readable error message
    public var message: String

    /// A numeric code for the error
    public var code: Int

    public init(message: String, code: Int = 1) {
        self.message = message
        self.code = code
    }

    public var identifier: String {
        return "GeneralError(\(code))"
    }

    public let isCancelled = false
}

/// Provides string conversion for GeneralError.
extension GeneralError: CustomStringConvertible {
    public var description: String {
        return "GeneralError(\(message), code: \(code))"
    }
}
