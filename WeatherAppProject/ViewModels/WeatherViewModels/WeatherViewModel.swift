//
//  WeatherViewModel.swift
//  WeatherAppProject
//
//  Created by Александр Микейлов on 16.12.2024.
//

import UIKit

protocol WeatherViewViewModelDelegate: AnyObject {
    func didLoadWeather()
}

final class WeatherViewViewModel {
    
    enum SectionType {
        case current(viewModel: CurrentWeatherCollectionViewCellViewModel)
        case hourly(viewModels: [HourlyWeatherCollectionViewCellViewModel])
        case astro(viewModels: [WeatherAstroCollectionViewCellViewModel])
        case daily(viewModels: [DailyWeatherCollectionViewCellViewModel])
    }
    
    weak var delegate: WeatherViewViewModelDelegate?
    public var sections: [SectionType] = []
    var weather: Weather? = nil
    private let dataFetcherServise = DataFetcherService()
    var isFetchWeather: Bool = true
    let emptyViewText = "No weather information was found for this city. Please try searching for another city near your area."
    
    init() {
        if weather == nil {
            isFetchWeather = false
        } else {
            isFetchWeather = true
        }
    }
    
    func fetchWeatherByCity(city: String) {
        dataFetcherServise.fetchWeatherByCity(city: city) { weather in
            self.weather = weather
            self.setupSections()
            self.delegate?.didLoadWeather()
        }
    }
    
    func fetchWeatherByLocation() {
        LocationManager.shared.getCurrentLocation { location in
            let lat = String(location.coordinate.latitude)
            let lon = String(location.coordinate.longitude)
            self.dataFetcherServise.fetchWeatherByLocation(lat: lat, lon: lon) { weather in
                self.weather = weather
                self.setupSections()
                self.delegate?.didLoadWeather()
            }
        }
    }
    
    private func setupSections() {
        guard let hourlyForecast = weather?.forecast.forecastday.first?.hour else { return }
        let hourlyViewModels = hourlyForecast.map { HourlyWeatherCollectionViewCellViewModel(hour: $0) }
        guard let dailyForecastWeather = weather?.forecast.forecastday else { return }
        let dailyViewModels = dailyForecastWeather.map { DailyWeatherCollectionViewCellViewModel(forecastDay: $0)}
        
        sections = [
            .current(viewModel: .init(
                location: weather!.location,
                currentWeather: weather!.current
            )),
            .hourly(viewModels: hourlyViewModels),
            .astro(viewModels: [
                .init(type: .humidity, value: "\(weather?.current.humidity ?? 0)"),
                .init(type: .wind, value: "\(weather?.current.windKph ?? 0)"),
                .init(type: .sunrise, value: "\(weather?.forecast.forecastday[0].astro.sunrise ?? "no")"),
                .init(type: .sunset, value: "\(weather?.forecast.forecastday[0].astro.sunset ?? "no")")
            ]),
            .daily(viewModels: dailyViewModels)
        ]
    }
    
    
    //MARK: - Create sections layout
    func createCurrentWeatherLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(300))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0)
        return section
    }
    
    
    func hourlyWeatherInfoSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .absolute(100),
                heightDimension: .absolute(150)),
            subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 16)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    func weatherAstroInfoSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .absolute(UIScreen.main.bounds.width / 2 - 8),
                heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0)
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(UIScreen.main.bounds.width / 2 - 8)),
            subitems: [item, item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    func dailyWeatherInfoSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .absolute(UIScreen.main.bounds.width * 0.8),
                heightDimension: .absolute(200)),
            subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 16)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
}
