//
//  TweakOperator.swift
//  WolfFoundation
//
//  Created by Wolf McNally on 1/16/18.
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

///
/// Tweak-Operator
///
/// The special character here ("‡") is called the "double dagger" and is typed by pressing Option-Shift-7.
///
prefix operator ‡

///
/// Note that all uses of the Tweak-Operator SHOULD be idempotent.
/// i.e.:
///     let a = A()
///     ‡a          // a MAY have changed state
///     ‡a          // a SHOULD NOT have changed state
///

#if canImport(UIKit)

import UIKit

@discardableResult public prefix func ‡<T: UIView> (rhs: T) -> T {
    rhs.translatesAutoresizingMaskIntoConstraints = false
    return rhs
}

#elseif canImport(AppKit)

import AppKit

@discardableResult public prefix func ‡<T: NSView> (rhs: T) -> T {
    rhs.translatesAutoresizingMaskIntoConstraints = false
    return rhs
}

#endif
