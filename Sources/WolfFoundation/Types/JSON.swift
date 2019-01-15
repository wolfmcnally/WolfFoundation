//
//  JSON.swift
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

import Foundation
import WolfPipe

public func toJSON<T: Encodable>(outputFormatting: JSONEncoder.OutputFormatting) -> (_ value: T) throws -> Data {
    return { value in
        let encoder = JSONEncoder()
        encoder.outputFormatting = outputFormatting
        return try encoder.encode(value)
    }
}

public func toJSONString<T: Encodable>(outputFormatting: JSONEncoder.OutputFormatting) -> (_ value: T) throws -> String {
    return { value in
        try value |> toJSON(outputFormatting: outputFormatting) |> fromUTF8
    }
}

public func toJSON<T>(_ value: T) throws -> Data where T: Encodable {
    return try value |> toJSON(outputFormatting: [])
}

public func toJSONString<T>(_ value: T) throws -> String where T: Encodable {
    return try value |> toJSONString(outputFormatting: [])
}

public func fromJSON<T: Decodable>(_ t: T.Type) -> (_ data: Data) throws -> T {
    return { data in
        return try JSONDecoder().decode(t.self, from: data)
    }
}

public func fromJSONString<T: Decodable>(_ t: T.Type) -> (_ string: String) throws -> T {
    return { string in
        return try string |> toUTF8 |> fromJSON(t)
    }
}
