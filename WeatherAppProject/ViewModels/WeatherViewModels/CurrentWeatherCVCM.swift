//
//  CurrentWeatherCVCM.swift
//  WeatherAppProject
//
//  Created by Александр Микейлов on 16.12.2024.
//

import UIKit


final class CurrentWeatherCollectionViewCellViewModel {
    
    let country: String
    let name: String
    let date: String
    let imageUrl: String
    let tempC: Double
    let conditionInfo: String
    let feelsLikeTempC: Double
    
    init(location: Location, currentWeather: Current) {
        self.name = location.name
        self.date = location.localtime
        self.imageUrl = currentWeather.condition.icon
        self.tempC = currentWeather.tempC
        self.conditionInfo = currentWeather.condition.text
        self.feelsLikeTempC = currentWeather.feelslikeC
        self.country = location.country
    }
    
    public var displayTempC: String {
        return "\(tempC.toRoundOfInt()) C°"
    }
    
    public var fullUrl: URL {
        guard let url = URL(string:"https:\(imageUrl)") else { return URL(filePath: "") }
        return url
    }
    
    public var displayFeelsLikeTempC: String {
        return "Feels like \(feelsLikeTempC.toRoundOfInt()) C°"
    }
    
    public var displayDate: String {
        return date.toDate(format: "yyyy-MM-dd HH:mm", toFormat: "EEEE, MMM d")
    }
}

