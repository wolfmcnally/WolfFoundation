//
//  Associated.swift
//  WolfFoundation
//
//  Created by Wolf McNally on 1/26/17.
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

public final class Associated<T>: NSObject, NSCopying {
    public typealias ValueType = T
    public let value: ValueType

    public init(_ value: ValueType) { self.value = value }

    public func copy(with zone: NSZone? = nil) -> Any {
        return type(of: self).init(value)
    }
}

extension Associated where T: NSCopying {
    public func copy(with zone: NSZone? = nil) -> Any {
        return type(of: self).init(value.copy(with: zone) as! ValueType)
    }
}

extension NSObject {
    public func setAssociatedValue<T>(_ value: T?, for key: UnsafeRawPointer) {
        let v = value.map { Associated<T>($0) }
        objc_setAssociatedObject(self, key, v, .OBJC_ASSOCIATION_COPY)
    }

    public func getAssociatedValue<T>(for key: UnsafeRawPointer) -> T? {
        return (objc_getAssociatedObject(self, key) as? Associated<T>).map { $0.value }
    }
}
