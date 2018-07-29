//
//  WeatherManager.swift
//  DataBindingiOS
//
//  Created by Mohamed Salah on 7/29/18.
//

import Foundation
import Moya
import Result

protocol WeatherManager {
    func getCurrent(in name: String, completion: @escaping ParseCompletion<City>)
}

struct WeatherAPIManager: WeatherManager {
    private var provider: MoyaProvider<WeatherService>
    
    init(provider: MoyaProvider<WeatherService> = MoyaProvider<WeatherService>()) {
        self.provider = provider
    }
    
    func getCurrent(in name: String, completion: @escaping ParseCompletion<City>) {
        provider.request(.get(cityName: name), parser: DefualtParser.self, completion: completion)
    }
}
