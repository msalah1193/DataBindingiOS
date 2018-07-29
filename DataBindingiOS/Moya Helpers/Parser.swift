//
//  Parser.swift
//  MoyaTest
//
//  Created by tr on 6/27/18.
//  Copyright © 2018 tr. All rights reserved.
//

import Foundation

typealias ParseCompletion<T: Codable> = (ParseResult<T>) -> Void
protocol Parser {
    static func parse<T>(_ response: Data, completion: ParseCompletion<T>)
}

struct DefualtParser: Parser {
    static func parse<T>(_ response: Data, completion: ParseCompletion<T>) {
        print(String(data: response, encoding: .utf8) ?? "")
        do {
            let mappedObject = try JSONDecoder().decode(T.self, from: response)
            completion(.object(mappedObject))
        } catch {
            print(error.localizedDescription)
            completion(.failure(ParseError.invalid))
        }
    }
}
