//
//  ValueCache.swift
//  WolfFoundation
//
//  Created by Wolf McNally on 6/10/17.
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

public final class ValueCache<Name: Hashable> {
    private typealias Dict = [Name: Any]
    private var dict: Dict

    public init() {
        dict = Dict()
    }

    private init(d: Dict) {
        self.dict = d
    }

    public func copy() -> ValueCache {
        return .init(d: dict)
    }

    public func set<T>(_ key: Name, to value: T) {
        dict[key] = value
    }

    public func get<T>(_ key: Name) -> T? {
        return dict[key] as? T
    }

    public func get<T>(_ key: Name, with update: () -> T) -> T {
        if let value = dict[key] {
            return value as! T
        } else {
            let value = update()
            dict[key] = value
            return value
        }
    }

    public func get<T>(_ key: Name, _ update: @autoclosure () -> T) -> T {
        return get(key, with: update)
    }

    public func remove(_ key: Name) {
        dict[key] = nil
    }

    public func removeAll() {
        dict.removeAll()
    }

    public subscript<T>(key: Name) -> T? {
        get { return get(key) }

        set {
            if let value = newValue {
                set(key, to: value)
            } else {
                remove(key)
            }
        }
    }

    public subscript<T>(key: Name, update: @autoclosure () -> T) -> T {
        return get(key, update())
    }
}
