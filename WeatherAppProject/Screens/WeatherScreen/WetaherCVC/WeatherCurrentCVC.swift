//
//  WeatherCurrent.swift
//  WeatherAppProject
//
//  Created by Александр Микейлов on 16.12.2024.
//

import UIKit

final class CurrentWeatherCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "CurrentWeatherCollectionViewCell"
    
    //MARK: - UI
    private let countryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .black)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let regionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    private let conditionImage: UIImageView = {
        let imgView = UIImageView()
        imgView.tintColor = .label
        imgView.translatesAutoresizingMaskIntoConstraints = false

        return imgView
    }()
    
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30, weight: .black)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    private let conditionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    private let feelsLikeTempCLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .black)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    //MARK: - INIT
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .secondarySystemBackground
        setupCell()
        addViews()
        setUpConstraints()
    }
    
    private func setupCell() {
        self.layer.cornerRadius = 8
    }
    
    private func addViews() {
        contentView.addSubviews(
            regionLabel,
            dateLabel,
            conditionImage,
            conditionLabel,
            tempLabel,
            feelsLikeTempCLabel,
            countryLabel
        )
    }
    
    //MARK: - FUNCTIONS
    private func setUpConstraints() {
        
        NSLayoutConstraint.activate([
            countryLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            countryLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12),
            
            regionLabel.topAnchor.constraint(equalTo: countryLabel.bottomAnchor, constant: 12),
            regionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12),
            regionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12),
            
            conditionImage.topAnchor.constraint(equalTo: regionLabel.bottomAnchor, constant: 20),
            conditionImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12),
            conditionImage.widthAnchor.constraint(equalToConstant: 120),
            conditionImage.heightAnchor.constraint(equalToConstant: 120),
            
            tempLabel.bottomAnchor.constraint(equalTo: conditionImage.centerYAnchor, constant: -4),
            tempLabel.leftAnchor.constraint(equalTo: conditionImage.rightAnchor, constant: 12),
            
            conditionLabel.leftAnchor.constraint(equalTo: conditionImage.rightAnchor, constant: 12),
            conditionLabel.topAnchor.constraint(equalTo: conditionImage.centerYAnchor, constant: 4),
            
            feelsLikeTempCLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12),
            feelsLikeTempCLabel.topAnchor.constraint(equalTo: conditionImage.bottomAnchor, constant: 20),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            dateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        regionLabel.text = nil
        dateLabel.text = nil
        tempLabel.text = nil
        conditionImage.image = nil
        conditionLabel.text = nil
        countryLabel.text = nil
    }

    
    func configure(with viewModel: CurrentWeatherCollectionViewCellViewModel) {
        regionLabel.text = viewModel.name
        dateLabel.text = viewModel.displayDate
        tempLabel.text = viewModel.displayTempC
        conditionLabel.text = viewModel.conditionInfo
        conditionImage.loadImage(from: viewModel.fullUrl)
        feelsLikeTempCLabel.text = viewModel.displayFeelsLikeTempC
        countryLabel.text = viewModel.country
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
