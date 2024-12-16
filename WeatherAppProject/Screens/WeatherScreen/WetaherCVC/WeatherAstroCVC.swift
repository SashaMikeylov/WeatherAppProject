//
//  WeatherAstroCVC.swift
//  WeatherAppProject
//
//  Created by Александр Микейлов on 16.12.2024.
//

import UIKit

final class WeatherAstroCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "WeatherAstroCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageV = UIImageView()
        imageV.tintColor = .white
        
        imageV.translatesAutoresizingMaskIntoConstraints = false
        return imageV
    }()
    
    private let astroLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 26, weight: .semibold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .newBlueColor2
        self.layer.cornerRadius = 8
        
        contentView.addSubviews(imageView, astroLabel)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 80),
            imageView.heightAnchor.constraint(equalToConstant: 70),
            
            astroLabel.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            astroLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        astroLabel.text = nil
    }
    
    func configure(with viewModel: WeatherAstroCollectionViewCellViewModel) {
        imageView.image = viewModel.iconImage
        astroLabel.text = viewModel.displayValue
        imageView.tintColor = viewModel.iconTintColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
