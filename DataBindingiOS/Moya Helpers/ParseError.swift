//
//  ParseError.swift
//  MoyaTest
//
//  Created by tr on 6/27/18.
//  Copyright © 2018 tr. All rights reserved.
//

import Foundation


public enum ParseError: LocalizedError {
    case invalid
}

extension ParseError {
    public var errorDescription: String? {
        return "invalid JSON string"
    }
}
