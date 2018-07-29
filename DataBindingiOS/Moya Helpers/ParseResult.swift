//
//  ParseResult.swift
//  MoyaTest
//
//  Created by tr on 6/27/18.
//  Copyright © 2018 tr. All rights reserved.
//

import Foundation

public enum ParseResult<T: Codable> {
    case object(T)
    case failure(Error)
}

extension ParseResult {
    var object: T? {
        if case let .object(object) = self {
            return object
        }
        
        return nil
    }
    
    var error: Error? {
        switch self {
        case .failure(let error):
            return error
        default:
            return nil
        }
    }
}
