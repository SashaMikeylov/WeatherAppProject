//
//  WeatherModel.swift
//  WeatherAppProject
//
//  Created by Александр Микейлов on 15.12.2024.
//

import Foundation

// MARK: - Welcome
struct Weather: Codable {
    let location: Location
    let current: Current
    let forecast: Forecast
}


// MARK: - Location
struct Location: Codable {
    let name, country: String
    let localtime: String

    enum CodingKeys: String, CodingKey {
        case name, country
        case localtime
    }
}

// MARK: - Current
struct Current: Codable {
    let tempC: Double
    let condition: Condition
    let feelslikeC: Double
    let humidity: Double
    let windKph: Double

    enum CodingKeys: String, CodingKey {
        case tempC = "temp_c"
        case condition
        case feelslikeC = "feelslike_c"
        case humidity
        case windKph = "wind_kph"
    }
}

// MARK: - Condition
struct Condition: Codable {
    let text: String
    let icon: String
    let code: Int
}


// MARK: - Forecast
struct Forecast: Codable {
    let forecastday: [Forecastday]
}

// MARK: - Forecastday
struct Forecastday: Codable {
    let date: String
    let day: Day
    let astro: Astro
    let hour: [Hour]

    enum CodingKeys: String, CodingKey {
        case date
        case day, astro, hour
    }
}

// MARK: - Day
struct Day: Codable {
    let avgtempC: Double
    let condition: Condition

    enum CodingKeys: String, CodingKey {
        case avgtempC = "avgtemp_c"
        case condition
    }
}

// MARK: - Astro
struct Astro: Codable {
    let sunrise, sunset: String

    enum CodingKeys: String, CodingKey {
        case sunrise, sunset
    }
}

// MARK: - Hour
struct Hour: Codable {
    let time: String
    let tempC: Double
    let condition: Condition

    enum CodingKeys: String, CodingKey {
        case time
        case tempC = "temp_c"
        case condition
    }
}

