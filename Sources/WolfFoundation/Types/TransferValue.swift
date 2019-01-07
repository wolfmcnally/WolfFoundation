//
//  TransferValue.swift
//  WolfFoundation
//
//  Created by Wolf McNally on 12/4/16.
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

public class TransferValue<T: Any>: Reference {
    public let defaultValue: T

    public typealias Source = () -> T?
    public typealias Sink = (T) -> Void

    public init(withDefault defaultValue: T, sink: Sink?) {
        self.defaultValue = defaultValue
        if let sink = sink {
            self.sink = sink
        }
    }

    public var source: Source? {
        didSet {
            transfer()
        }
    }

    public var sink: Sink? {
        didSet {
            transfer()
        }
    }

    public var hasReferent: Bool { return true }

    public var referent: T {
        return source?() ?? defaultValue
    }

    public func transfer() {
        sink?(referent)
    }
}
