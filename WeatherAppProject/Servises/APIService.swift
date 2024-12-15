//
//  APIService.swift
//  WeatherAppProject
//
//  Created by Александр Микейлов on 15.12.2024.
//

import Foundation

enum API {
    case cityURL(city: String)
    case coordURL(lat: String, lon: String)
    
    var url: String {
        switch self {
        case .cityURL(let city):
            let apiKey = "e0385f6a11c64c40b7264614241104"
            let urlString = "https://api.weatherapi.com/v1/forecast.json?key=\(apiKey)&q=\(city)&days=10"
            return urlString
        case .coordURL(let lat, let lon):
            let apiKey = "e0385f6a11c64c40b7264614241104"
            let urlString = "https://api.weatherapi.com/v1/forecast.json?key=\(apiKey)&q=\(lat),\(lon)&days=10"
            return urlString
        }
    }
}
