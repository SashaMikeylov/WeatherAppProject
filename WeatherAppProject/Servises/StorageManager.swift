//
//  StorageManager.swift
//  WeatherAppProject
//
//  Created by Александр Микейлов on 15.12.2024.
//

import Foundation

class StorageManager {
    static let shared = StorageManager()
    
    private let citiesKey: String = "cities"
    private init() {}
    
    func saveCities(_ cities: [City]) {
        UserDefaults.standard.set(encodable: cities, forKey: citiesKey)
    }
    
    func loadCities() -> [City]? {
        guard let cities = UserDefaults.standard.object([City].self, forKey: citiesKey) else { return []}
        return cities
    }
    
    func removeCity(_ city: City) {
        var cities = loadCities() ?? []
        if let index = cities.firstIndex(where: { $0.name == city.name }) {
            cities.remove(at: index)
            saveCities(cities)
        }
    }
}

extension UserDefaults {
    func set<T: Encodable>(encodable: T, forKey key: String) {
        if let data = try? JSONEncoder().encode(encodable) {
            set(data, forKey: key)
        }
    }
    
    func object<T: Decodable>(_ type: T.Type, forKey key: String) -> T? {
        if let data = object(forKey: key) as? Data,
           let value = try? JSONDecoder().decode(type, from: data) {
            return value
        }
        return nil
    }
}
