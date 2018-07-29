//
//  WeatherService.swift
//  DataBindingiOS
//
//  Created by Mohamed Salah on 7/29/18.
//

import Moya

enum WeatherService {
    case get(cityName: String)
}

extension WeatherService: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.apixu.com/v1")!
    }
    
    var path: String {
        return "/current.json"
    }
    
    var method: Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .get(let cityName):
            let params = [
                "key": "5d15d6dee5254bd6acd122402182907",
                "q": cityName
            ]
            
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
}
