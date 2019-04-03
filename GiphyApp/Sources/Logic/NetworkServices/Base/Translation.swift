//
//  Translation.swift
//  GiphyApp
//
//  Created by Ahmad Ansari on 03/04/2019.
//  Copyright © 2019 Ahmad Ansari. All rights reserved.
//

import Foundation

enum DecodingError: Error {
    case typeMismatch
}

protocol Coder {
    func encode<T: Encodable>(obj: T) throws -> Data
    func decode<T: Decodable>(data: Data) throws -> T
    func decodeArray<T: Decodable>(data: Data) throws -> [T]
    func decode<T: Decodable>(object: Any) throws -> T
    func decodeArray<T: Decodable>(object: Any) throws -> [T]
    func decodeObjectToJson<T: Encodable, U>(object: T) throws -> U
}

extension Coder {
    func encode<T: Encodable>(obj: T) throws -> Data {
        return try JSONEncoder().encode(obj)
    }
    
    //Single Object
    func decode<T: Decodable>(data: Data) throws -> T {
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    func decode<T: Decodable>(object: Any) throws -> T {
        let decodedData = try data(object: object)
        return try decode(data: decodedData)
    }
    
    //Collection
    func decodeArray<T: Decodable>(data: Data) throws -> [T] {
        return try JSONDecoder().decode([T].self, from: data)
    }
    
    func decodeArray<T: Decodable>(object: Any) throws -> [T] {
        let decodedData = try data(object: object)
        return try decodeArray(data: decodedData)
    }
    
    func data(object: Any) throws -> Data {
        return try JSONSerialization.data(withJSONObject: object, options: JSONSerialization.WritingOptions.prettyPrinted)
    }
    
    //JSON
    func decodeObjectToJson<T: Encodable, U>(object: T) throws -> U {
        let data = try JSONEncoder().encode(object)
        let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
        guard let jsonObject = json as? U else {
            throw DecodingError.typeMismatch
        }
        
        return jsonObject
    }
}

class Translation: Coder {
    init() { }
}
