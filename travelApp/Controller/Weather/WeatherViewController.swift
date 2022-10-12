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
    
    @IBOutlet weak var imgNantes: UIImageView!
    @IBOutlet weak var imgNYC: UIImageView!
    
    override func viewDidLoad() {
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
                self?.messageAlert(alert: .invalideResponse)
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
        let weatherTemp = Int(list.main.temp)
        tempLabel.text = String(weatherTemp)
    }
    
    // Get icon
    private func weatherIcon(list: CurrentLocalWeather, imgView: UIImageView) {
        let weatherIcon = list.weather[0].icon
        imgView.image = UIImage(named: weatherIcon)
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
        weatherIcon(list: weatherNantes, imgView: imgNantes)
        
        // Weather to New York
        let weatherNYC = weatherUpdated.list[1]
        weatherCondition(list: weatherNYC, conditionLabel: weatherConditionNYC)
        weatherTemperature(list: weatherNYC, tempLabel: temperatureNYC)
        weatherIcon(list: weatherNYC, imgView: imgNYC)
    }
    
    private func toggleActivityIndicator(shown: Bool) {
        compare.isHidden = shown
        activityIndicator.isHidden = !shown
    }

    private func setUpDesign() {
        self.weatherConditionNYC.text = ""
        self.temperatureNYC.text = ""
        self.imgNYC.isHidden = true
        self.weatherConditionNantes.text = ""
        self.temperatureNantes.text = ""
        self.imgNantes.isHidden = true
    }
    
    func messageAlert(alert: WeatherDataError) {
        var message: String
        switch alert {
        case .countUpdatedCities:
            message = "Updated city account error for weather"
        case .invalideResponse:
            message = "Error in response Api"
        case .errorApiKey:
            message = "Error in apy key"
        }
        
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
