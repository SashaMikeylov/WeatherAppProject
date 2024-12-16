//
//  WeatherDailyCVC.swift
//  WeatherAppProject
//
//  Created by Александр Микейлов on 16.12.2024.
//

import UIKit

final class DailyWeatherCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "DailyWeatherCollectionViewCell"
    
    //MARK: - UI

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.textColor = .white
        return label
    }()
    private let conditionImage: UIImageView = {
        let imgView = UIImageView()
        imgView.tintColor = .label
        return imgView
    }()
    
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30, weight: .black)
        label.textColor = .white
        return label
    }()
    
    private let conditionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        label.textColor = .white
        return label
    }()
    
    //MARK: - INIT
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
        addViews()
        setUpConstraints()
    }
    
    private func setupCell() {
        self.backgroundColor = .newBlueColor2
        self.layer.cornerRadius = 8
    }
    
    private func addViews() {
        contentView.addSubviews(
            dateLabel,
            conditionImage,
            conditionLabel,
            tempLabel
        )
    }
    
    //MARK: - FUNCTIONS
    private func setUpConstraints() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        conditionImage.translatesAutoresizingMaskIntoConstraints = false
        conditionLabel.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            dateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12),
            
            conditionImage.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8),
            conditionImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12),
            conditionImage.widthAnchor.constraint(equalToConstant: 100),
            conditionImage.heightAnchor.constraint(equalToConstant: 100),
            
            tempLabel.centerYAnchor.constraint(equalTo: conditionImage.centerYAnchor),
            tempLabel.leftAnchor.constraint(equalTo: conditionImage.rightAnchor, constant: 12),
            
            conditionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12),
            conditionLabel.topAnchor.constraint(equalTo: conditionImage.bottomAnchor, constant: 8),
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dateLabel.text = nil
        conditionImage.image = nil
        conditionLabel.text = nil
        tempLabel.text = nil
    }
    
    func configure(with viewModel: DailyWeatherCollectionViewCellViewModel) {
        dateLabel.text = viewModel.displayDate
        tempLabel.text = viewModel.displayAvgTempC
        conditionLabel.text = viewModel.conditionTxt
        conditionImage.loadImage(from: viewModel.fullImageUrl)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

