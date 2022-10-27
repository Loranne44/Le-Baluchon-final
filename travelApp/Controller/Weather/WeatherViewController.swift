//
//  WeatherViewController.swift
//  travelApp
//
//  Created by Loranne Joncheray on 08/09/2022.
//

import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var weatherConditionNantes: UILabel!
    @IBOutlet weak var temperatureNantes: UILabel!
    @IBOutlet weak var weatherConditionNYC: UILabel!
    @IBOutlet weak var temperatureNYC: UILabel!
    @IBOutlet weak var compare: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var iconNantes: UIImageView!
    @IBOutlet weak var iconNYC: UIImageView!
    
    override func viewDidLoad() {
        activityIndicator.isHidden = true
        setUpDesign()
    }
    
    
    @IBAction func compareButton(_ sender: Any) {
        getWeather()
    }
    
    private func getWeather() {
        WeatherService.shared.getWeather { [weak self] (success, weather) in
            self?.toggleActivityIndicator(shown: true)
            if let weather = weather {
                self?.updateWeather(weatherUpdated: weather)
                self?.toggleActivityIndicator(shown: false)
            } else {
                self?.toggleActivityIndicator(shown: false)
                self?.messageAlert(alert: .invalidResponse)
                self?.setUpDesign()
            }
        }
    }
    
    // Get weather condition
    private func weatherCondition(list: CurrentLocalWeather, conditionLabel: UILabel) {
        guard let weatherCondition = list.weather.first?.description.localizedCapitalized else { return }
        conditionLabel.text = weatherCondition
    }
    
    // Get the temperature
    private func weatherTemperature(list: CurrentLocalWeather, tempLabel: UILabel) {
        let weatherTemp = list.main.temp
        tempLabel.text = String(format: "%.1f", weatherTemp)
    }
    
    // Get icon
    private func weatherIcon(list: CurrentLocalWeather, iconView: UIImageView) {
        guard let weatherIcon = list.weather.first?.icon else { return }
        iconView.image = UIImage(named: weatherIcon)
    }
    
    // Update weather
    private func updateWeather(weatherUpdated: WeatherData) {
        guard weatherUpdated.list.count >= 2 else {
            messageAlert(alert: .countUpdatedCities)
            return }
        
        // Weather to Nantes
        let weatherNantes = weatherUpdated.list[0]
        weatherCondition(list: weatherNantes, conditionLabel: weatherConditionNantes)
        weatherTemperature(list: weatherNantes, tempLabel: temperatureNantes)
        weatherIcon(list: weatherNantes, iconView: iconNantes)
        
        // Weather to New York
        let weatherNYC = weatherUpdated.list[1]
        weatherCondition(list: weatherNYC, conditionLabel: weatherConditionNYC)
        weatherTemperature(list: weatherNYC, tempLabel: temperatureNYC)
        weatherIcon(list: weatherNYC, iconView: iconNYC)
    }
    
    private func toggleActivityIndicator(shown: Bool) {
        compare.isHidden = shown
        activityIndicator.isHidden = !shown
    }

    private func setUpDesign() {
        self.weatherConditionNYC.text = ""
        self.temperatureNYC.text = ""
        self.iconNYC.isHidden = true
        self.weatherConditionNantes.text = ""
        self.temperatureNantes.text = ""
        self.iconNantes.isHidden = true
    }
    
    func messageAlert(alert: WeatherDataError) {
        let alertVC = UIAlertController(title: "Error", message: alert.message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
