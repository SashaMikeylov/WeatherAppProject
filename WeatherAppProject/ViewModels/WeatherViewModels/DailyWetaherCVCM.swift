//
//  DailyWetaherCVCM.swift
//  WeatherAppProject
//
//  Created by Александр Микейлов on 16.12.2024.
//

import UIKit

final class DailyWeatherCollectionViewCellViewModel {
    let date: String
    let imageUrl: String
    let avgTempC: Double
    let conditionTxt: String
    
    init(forecastDay: Forecastday) {
        self.date = forecastDay.date
        self.avgTempC = forecastDay.day.avgtempC
        self.conditionTxt = forecastDay.day.condition.text
        self.imageUrl = forecastDay.day.condition.icon
    }
    
    public var displayAvgTempC: String {
        return "\(avgTempC.toRoundOfInt()) C°"
    }
    
    public var fullImageUrl: URL {
        return URL(string: "https:" + imageUrl)!
    }

    public var displayDate: String {
        return date.toDate(format: "yyyy-MM-dd", toFormat: "EEEE, MMM d")
    }
}

