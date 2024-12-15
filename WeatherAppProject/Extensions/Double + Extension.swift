//
//  Double + Extension.swift
//  WeatherAppProject
//
//  Created by Александр Микейлов on 15.12.2024.
//

import Foundation

extension Double {
    func toRoundOfInt() -> Int {
        let doubleValue = self
        let fractionalPart = doubleValue - Double(Int(doubleValue))
        if fractionalPart >= 0.5 {
            return Int(doubleValue) + 1
        } else {
            return Int(doubleValue)
        }
    }
}
