//
//  ViewController.swift
//  WeatherAppProject
//
//  Created by Александр Микейлов on 12.12.2024.
//

import UIKit

final class WeatherViewController: UIViewController {
    
    //MARK: - UI
    private var collectionView: UICollectionView!
    private var spinnerView = UIActivityIndicatorView()
    private let emptyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .black)
        label.textColor = UIColor.secondaryLabel
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "phon")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    //MARK: - VARIABLES
    private let viewModel = WeatherViewViewModel()
    private var cityName: String = ""
    
    //MARK: - INIT
    init(cityName: String) {
        super.init(nibName: nil, bundle: nil)
        self.cityName = cityName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - VIEW WILL APPEAR
    override func viewWillAppear(_ animated: Bool) {
        if cityName.isEmpty {
            viewModel.fetchWeatherByLocation()
        } else {
            viewModel.fetchWeatherByCity(city: cityName)
        }
    }
    
    //MARK: - VIEW DIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .newBlueColor
        collectionView = createCollectionView()
        setupNavigationBar()
        addSubviews()
        addConstraints()
        delegatesSelf()
        setupSpinner()
    }
    
    //MARK: - FUNCTIONS
    private func setupNavigationBar() {
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: .black),
            NSAttributedString.Key.foregroundColor: UIColor.label
        ]
        navigationController?.navigationBar.isHidden = true
        
    }
    
    private func addSubviews() {
        view.addSubview(imageView)
        view.addSubview(collectionView)
    }
    
    private func addConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            return self.createSection(for: sectionIndex)
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(CurrentWeatherCollectionViewCell.self, forCellWithReuseIdentifier: CurrentWeatherCollectionViewCell.cellIdentifier)
        collectionView.register(HourlyWeatherCollectionViewCell.self, forCellWithReuseIdentifier: HourlyWeatherCollectionViewCell.cellIdentifier)
        collectionView.register(WeatherAstroCollectionViewCell.self, forCellWithReuseIdentifier: WeatherAstroCollectionViewCell.cellIdentifier)
        collectionView.register(DailyWeatherCollectionViewCell.self, forCellWithReuseIdentifier: DailyWeatherCollectionViewCell.cellIdentifier)
        return collectionView
    }
    
    private func createSection(for sectionIndex: Int) -> NSCollectionLayoutSection {
        let sectionType = viewModel.sections[sectionIndex]
        switch sectionType {
        case .current:
            return viewModel.createCurrentWeatherLayoutSection()
        case .hourly:
            return viewModel.hourlyWeatherInfoSection()
        case .astro:
            return viewModel.weatherAstroInfoSection()
        case .daily:
            return viewModel.dailyWeatherInfoSection()
        }
    }
    
    private func delegatesSelf() {
        collectionView.delegate = self
        collectionView.dataSource = self
        viewModel.delegate = self
    }
    
    private func setupSpinner() {
        spinnerView.style = .large
        spinnerView.color = .gray
        spinnerView.center = view.center
        view.addSubview(spinnerView)
        spinnerView.startAnimating()
        spinnerView.hidesWhenStopped = true
    }
}

//MARK: - UICOLLECTIONVIEW DELEGATE AND DATA SOURCE
extension WeatherViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = viewModel.sections[section]
        switch sectionType {
        case .current:
            return 1
        case .hourly(let viewModels):
            return viewModels.count
        case .astro(let viewModels):
            return viewModels.count
        case .daily(let viewModels):
            return viewModels.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let sectionType = viewModel.sections[indexPath.section]
        switch sectionType {
            
        case .current(viewModel: let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CurrentWeatherCollectionViewCell.cellIdentifier, for: indexPath) as? CurrentWeatherCollectionViewCell else { return UICollectionViewCell() }
            cell.configure(with: viewModel)
            return cell
        case .hourly(viewModels: let viewModels):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyWeatherCollectionViewCell.cellIdentifier, for: indexPath) as? HourlyWeatherCollectionViewCell else { return UICollectionViewCell() }
            cell.configure(with: viewModels[indexPath.row])
            return cell
        case .astro(viewModels: let viewModels):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherAstroCollectionViewCell.cellIdentifier, for: indexPath) as? WeatherAstroCollectionViewCell else { return UICollectionViewCell() }
            cell.configure(with: viewModels[indexPath.row])
            return cell
        case .daily(viewModels: let viewModels):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DailyWeatherCollectionViewCell.cellIdentifier, for: indexPath) as? DailyWeatherCollectionViewCell else { return UICollectionViewCell() }
            cell.configure(with: viewModels[indexPath.row])
            return cell
        }
    }
}

//MARK: - WEATHER VIEW VIEWMODEL DELEGATE
extension WeatherViewController: WeatherViewViewModelDelegate {
    func didLoadWeather() {
        spinnerView.stopAnimating()
        collectionView.reloadData()
        UIView.animate(withDuration: 0.5) {
            self.collectionView.alpha = 1
        }
        
        if viewModel.sections.isEmpty {
            emptyLabel.text = viewModel.emptyViewText
            collectionView.backgroundView = emptyLabel
        } else {
            collectionView.backgroundView = nil
        }
    }
}





