//
//  DataFetcher.swift
//  WeatherAppProject
//
//  Created by Александр Микейлов on 15.12.2024.
//

import Foundation

final class DataFetcherService {
    
    var networkDataFetcher: DataFetcher
    
    init (networkDataFetcher: DataFetcher = NetworkDataFetcher()) {
        self.networkDataFetcher = networkDataFetcher
    }
    
    //MARK: - Data by city
    
    func fetchWeatherByCity(city: String, completion: @escaping (Weather?) -> Void) {
        let fetchWeatherByCityUrl = API.cityURL(city: city).url
        networkDataFetcher.fetchGenericJSONData(urlString: fetchWeatherByCityUrl, response: completion)
    }
    
    //MARK: - Data by coord
    func fetchWeatherByLocation(lat: String, lon: String, completion: @escaping (Weather?) -> Void) {
        let fetchWeatherByLocationUrl = API.coordURL(lat: lat, lon: lon).url
        networkDataFetcher.fetchGenericJSONData(urlString: fetchWeatherByLocationUrl, response: completion)
    }
    
    //MARK: - All citiyes
    
    func readJSONFromFile(completion: @escaping([City]) -> Void) {
        if let path = Bundle.main.path(forResource: "citylist", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let cities = try JSONDecoder().decode([City].self, from: data)
                completion(cities)
            } catch {
                print("Xatolik: \(error)")
            }
        }
    }
}
