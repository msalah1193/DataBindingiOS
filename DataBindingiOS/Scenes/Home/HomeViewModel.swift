//
//  HomeViewModel.swift
//  DataBindingiOS
//
//  Created by Mohamed Salah on 7/29/18.
//

import Foundation
import Bond
import ReactiveKit

enum CityCode: String {
    case cairo = "Cairo"
    case london = "London"
}

struct CityViewModel {
    var temp: String
    var conditionIcon: URL?
    var conditionText: String
    
    init(_ city: City) {
        temp = "\(city.current.tempC)°"
        conditionIcon = URL(string: "https:\(city.current.condition.icon)")
        conditionText = city.current.condition.text
    }
}

protocol HomeViewModel {
    var disposeBag: DisposeBag { get }
    var cityViewModel: Observable<CityViewModel?> { get }
    var cityCode: Observable<CityCode> { get }
    var isLoadingData: Observable<Bool> { get }
    var networkError: Observable<String> { get }
}

struct DefaultHomeViewModel: HomeViewModel {
    private var weatherManager: WeatherManager
    
    var disposeBag = DisposeBag()
    var cityCode: Observable<CityCode>
    
    var cityViewModel: Observable<CityViewModel?> = Observable(nil)
    var isLoadingData: Observable<Bool> = Observable(false)
    var networkError: Observable<String> = Observable("")

    init(weatherManager: WeatherManager = WeatherAPIManager(), cityCode: CityCode = .cairo) {
        self.weatherManager = weatherManager
        self.cityCode = Observable(cityCode)
        
        observeChanges()
    }
    
    private func observeChanges() {
        cityCode.observeNext { value in
            self.getWeather(with: value)
        }.dispose(in: disposeBag)
    }
    
    private func getWeather(with code: CityCode) {
        networkError.value = ""
        isLoadingData.value = true
        
        weatherManager.getCurrent(in: code.rawValue, completion: { result in
            self.isLoadingData.value = false
            
            switch result {
            case .object(let city):
                self.cityViewModel.value = CityViewModel(city)
            case .failure(let error):
                self.networkError.value = error.localizedDescription
            }
        })
    }
    
}


