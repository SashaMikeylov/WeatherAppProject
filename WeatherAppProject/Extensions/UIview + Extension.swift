//
//  UIview + Extension.swift
//  WeatherAppProject
//
//  Created by Александр Микейлов on 15.12.2024.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            self.addSubview(view)
        }
    }
}
