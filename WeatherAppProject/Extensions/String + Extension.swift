//
//  String + Extension.swift
//  WeatherAppProject
//
//  Created by Александр Микейлов on 15.12.2024.
//

import Foundation

extension String {
    func toDate(format: String, toFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = toFormat
            let formattedDate = dateFormatter.string(from: date)
            return formattedDate
        } else {
            return "error formatted date"
        }
    }
}
