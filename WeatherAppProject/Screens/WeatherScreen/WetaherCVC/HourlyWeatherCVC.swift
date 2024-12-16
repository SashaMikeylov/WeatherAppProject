//
//  HourlyWeather.swift
//  WeatherAppProject
//
//  Created by Александр Микейлов on 16.12.2024.
//

import UIKit

final class HourlyWeatherCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "HourlyWeatherCollectionViewCell"
    
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .black)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    private let hourLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .black)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private let iconImage: UIImageView = {
        let image = UIImageView()
        image.tintColor = .white
        return image
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
        addViews()
        setupConstraints()
    }
    
    private func setupCell() {
        self.backgroundColor = .newBlueColor2
        self.layer.cornerRadius = 8
    }
    
    private func addViews() {
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(hourLabel)
        stackView.addArrangedSubview(iconImage)
        stackView.addArrangedSubview(tempLabel)
    }
    
    private func setupConstraints() {
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        hourLabel.translatesAutoresizingMaskIntoConstraints = false
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8),
            
            iconImage.widthAnchor.constraint(equalToConstant: 40),
            iconImage.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        tempLabel.text = nil
        iconImage.image = nil
        hourLabel.text = nil
    }
    
    func configure(with viewModel: HourlyWeatherCollectionViewCellViewModel) {
        tempLabel.text = viewModel.displayTempC
        iconImage.loadImage(from: viewModel.fullIconUrl)
        hourLabel.text = viewModel.displayHour
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

