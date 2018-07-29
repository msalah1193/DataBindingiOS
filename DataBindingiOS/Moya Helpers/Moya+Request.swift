//
//  Moya+Request.swift
//  Merck Events
//
//  Created by OSX on 6/26/18.
//  Copyright © 2018 SICT Systems. All rights reserved.
//

import Moya

extension MoyaProvider {
    func request<T>(_ target: Target, parser: Parser.Type, completion: @escaping ParseCompletion<T>) {
        self.request(target) { result in
            switch result {
            case .success(let moyaResponse):
                do {
                    try _ = moyaResponse.filterSuccessfulStatusCodes()
                    parser.parse(moyaResponse.data, completion: completion)
                    
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}


