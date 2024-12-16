//
//  WeatherAstroCVCM.swift
//  WeatherAppProject
//
//  Created by Александр Микейлов on 16.12.2024.
//

import UIKit


final class WeatherAstroCollectionViewCellViewModel {
    
    private let type: `Type`
    private let value: String
    
    init(type: `Type`, value: String) {
        self.type = type
        self.value = value
    }
    
    enum `Type` {
        case sunrise
        case sunset
        case humidity
        case wind
        
        var iconImage: UIImage? {
            switch self {
            case .sunrise:
                return UIImage(systemName: "sunrise.fill")
            case .sunset:
                return UIImage(systemName: "sunset.fill")
            case .humidity:
                return UIImage(systemName: "humidity.fill")
            case .wind:
                return UIImage(systemName: "wind")
            }
        }
    }
    
    public var iconImage: UIImage? {
        return type.iconImage
    }
    
    public var iconTintColor: UIColor {
        switch type {
        case .sunrise:
            return UIColor.systemYellow
        case .sunset:
            return UIColor.systemYellow
        case .humidity:
            return UIColor.systemBlue
        case .wind:
            return UIColor.white
        }
    }
    
    public var displayValue: String {
        switch type {
        case .sunrise:
            return value
        case .sunset:
            return value
        case .humidity:
            return value + " %"
        case .wind:
            return value + " km/h"
        }
    }
}

