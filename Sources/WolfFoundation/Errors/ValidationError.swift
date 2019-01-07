//
//  ValidationError.swift
//  WolfFoundation
//
//  Created by Wolf McNally on 2/2/16.
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

public struct ValidationError: MessageError {
    public let isCancelled = false

    public let message: String
    public let violation: String
    public let source: String?

    public init(message: String, violation: String, source: String? = nil) {
        self.message = message
        self.violation = violation
        self.source = source
    }

    public var identifier: String {
        if let fieldIdentifier = source {
            return "\(fieldIdentifier)-\(violation)"
        } else {
            return "\(violation)"
        }
    }
}

extension ValidationError: CustomStringConvertible {
    public var description: String {
        return "ValidationError(\(message) [\(identifier)])"
    }
}
