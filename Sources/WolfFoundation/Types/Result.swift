//
//  Result.swift
//  WolfFoundation
//
//  Created by Wolf McNally on 12/5/18.
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

/// A type-erased error which wraps an arbitrary error instance. This should be
/// useful for generic contexts.
///
/// Based on https://github.com/antitypical/Result
public struct AnyError: Swift.Error {
    /// The underlying error.
    public let error: Swift.Error

    public init(_ error: Swift.Error) {
        if let anyError = error as? AnyError {
            self = anyError
        } else {
            self.error = error
        }
    }
}

/// An “error” that is impossible to construct.
///
/// This can be used to describe `Result`s where failures will never
/// be generated. For example, `Result<Int, NoError>` describes a result that
/// contains an `Int`eger and is guaranteed never to be a `failure`.
///
/// Based on https://github.com/antitypical/Result
public enum NoError: Swift.Error, Equatable {
    public static func == (lhs: NoError, rhs: NoError) -> Bool { }
}

///// Protocol used to constrain `tryMap` to `Result`s with compatible `Error`s.
//public protocol ErrorConvertible: Swift.Error {
//    static func error(from error: Swift.Error) -> Self
//}
//
//public extension Result where Error: ErrorConvertible {
//    /// Returns the result of applying `transform` to `Success`es’ values, or wrapping thrown errors.
//    public func tryMap<U>(_ transform: (Value) throws -> U) -> Result<U, Error> {
//        return flatMap { value in
//            do {
//                return .value(try transform(value))
//            } catch {
//                let convertedError = Error.error(from: error)
//                // Revisit this in a future version of Swift. https://twitter.com/jckarter/status/672931114944696321
//                return .error(convertedError)
//            }
//        }
//    }
//}

//extension AnyError: ErrorConvertible {
//    public static func error(from error: Error) -> AnyError {
//        return AnyError(error)
//    }
//}

extension AnyError: CustomStringConvertible {
    public var description: String {
        return String(describing: error)
    }
}

extension AnyError: LocalizedError {
    public var errorDescription: String? {
        return error.localizedDescription
    }

    public var failureReason: String? {
        return (error as? LocalizedError)?.failureReason
    }

    public var helpAnchor: String? {
        return (error as? LocalizedError)?.helpAnchor
    }

    public var recoverySuggestion: String? {
        return (error as? LocalizedError)?.recoverySuggestion
    }
}

// Based on: https://github.com/apple/swift-evolution/blob/master/proposals/0235-add-result.md
// Anticipating inclusion in Swift 5.

/// A value that represents either a success or failure, capturing associated
/// values in both cases.
public enum Result<Value, Error: Swift.Error> {
    /// A success, storing a `Value`.
    case value(Value)

    /// A failure, storing an `Error`.
    case error(Error)

    /// Evaluates the given transform closure when this `Result` instance is
    /// `.value`, passing the value as a parameter.
    ///
    /// Use the `map` method with a closure that returns a non-`Result` value.
    ///
    /// - Parameter transform: A closure that takes the successful value of the
    ///   instance.
    /// - Returns: A new `Result` instance with the result of the transform, if
    ///   it was applied.
    public func map<NewValue>(
        _ transform: (Value) -> NewValue
        ) -> Result<NewValue, Error> {
        switch self {
        case let .value(value):
            return .value(transform(value))
        case let .error(error):
            return .error(error)
        }
    }

    /// Evaluates the given transform closure when this `Result` instance is
    /// `.error`, passing the error as a parameter.
    ///
    /// Use the `mapError` method with a closure that returns a non-`Result`
    /// value.
    ///
    /// - Parameter transform: A closure that takes the failure value of the
    ///   instance.
    /// - Returns: A new `Result` instance with the result of the transform, if
    ///   it was applied.
    public func mapError<NewError>(
        _ transform: (Error) -> NewError
        ) -> Result<Value, NewError> {
        switch self {
        case let .value(value):
            return .value(value)
        case let .error(error):
            return .error(transform(error))
        }
    }

    /// Evaluates the given transform closure when this `Result` instance is
    /// `.value`, passing the value as a parameter and flattening the result.
    ///
    /// - Parameter transform: A closure that takes the successful value of the
    ///   instance.
    /// - Returns: A new `Result` instance, either from the transform or from
    ///   the previous error value.
    public func flatMap<NewValue>(
        _ transform: (Value) -> Result<NewValue, Error>
        ) -> Result<NewValue, Error> {
        switch self {
        case let .value(value):
            return transform(value)
        case let .error(error):
            return .error(error)
        }
    }

    /// Evaluates the given transform closure when this `Result` instance is
    /// `.error`, passing the error as a parameter and flattening the result.
    ///
    /// - Parameter transform: A closure that takes the error value of the
    ///   instance.
    /// - Returns: A new `Result` instance, either from the transform or from
    ///   the previous success value.
    public func flatMapError<NewError>(
        _ transform: (Error) -> Result<Value, NewError>
        ) -> Result<Value, NewError> {
        switch self {
        case let .value(value):
            return .value(value)
        case let .error(error):
            return transform(error)
        }
    }

    /// Unwraps the `Result` into a throwing expression.
    ///
    /// - Returns: The success value, if the instance is a success.
    /// - Throws:  The error value, if the instance is a failure.
    public func unwrapped() throws -> Value {
        switch self {
        case let .value(value):
            return value
        case let .error(error):
            throw error
        }
    }
}

//extension Result where Error == Swift.Error {
//    /// Create an instance by capturing the output of a throwing closure.
//    ///
//    /// - Parameter catching: A throwing closure to evaluate.
//    @_transparent
//    public init(catching body: () throws -> Value) {
//        do {
//            let value = try body()
//            self = .value(value)
//        } catch {
//            self = .error(error)
//        }
//    }
//}

public protocol ResultSummary {
    var isSuccess: Bool { get }
    var isCanceled: Bool { get }
    var message: String? { get }
    var code: Int? { get }
}

extension ResultSummary {
    public var message: String? {
        guard let e = self as? MessageError else { return nil }
        return e.message
    }
    
    public var code: Int? {
        guard let e = self as? CodedError else { return nil }
        return e.code
    }
}

extension Result: ResultSummary {
    public var isSuccess: Bool {
        switch self {
        case .value:
            return true
        case .error:
            return false
        }
    }
}

extension Result : Equatable where Value : Equatable, Error : Equatable { }

extension Result : Hashable where Value : Hashable, Error : Hashable {
    public func hash(into hasher: inout Hasher) {
        switch self {
        case let .value(value):
            hasher.combine(value)
            hasher.combine(Optional<Error>.none)
        case let .error(error):
            hasher.combine(Optional<Value>.none)
            hasher.combine(error)
        }
    }
}

/// Canceled means the original process should not be called back at all.
public struct Canceled: Swift.Error {
    init() { }
}

public let canceled = Canceled()

extension Result {
    public var isCanceled: Bool {
        switch self {
        case .value:
            return false
        case .error(let error):
            return error is Canceled
        }
    }
}

/// Aborted means there was no error, but the original process should not take action associated with success or failure.
public struct Aborted: Swift.Error {
    init() { }
}

public let aborted = Aborted()

extension Result {
    public var isAborted: Bool {
        switch self {
        case .value:
            return false
        case .error(let error):
            return error is Aborted
        }
    }
}
