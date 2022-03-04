//
//  ViewController.swift
//  WeatherApp
//
//  Created by Dave Gumba on 03.03.22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var minimumTemperatureLabel: UILabel!
    @IBOutlet weak var maximumTemperatureLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    
    private let weatherViewModel = WeatherViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewToViewModel()
    }
    
    fileprivate func bindViewToViewModel() {
        weatherViewModel.countryName.bind { [weak self] countryName in
            self?.countryLabel.text = countryName
        }
        
        weatherViewModel.cityName.bind { [weak self] cityName in
            self?.cityLabel.text = cityName
        }
        
        weatherViewModel.weatherDescription.bind { [weak self] weatherDescription in
            self?.weatherDescriptionLabel.text = weatherDescription
        }
        
        weatherViewModel.currentTemp.bind { [weak self] currentTemp in
            self?.currentTemperatureLabel.text = currentTemp
        }
        
        weatherViewModel.minTemp.bind { [weak self] minTemp in
            self?.minimumTemperatureLabel.text = minTemp
        }
        
        weatherViewModel.maxTemp.bind { [weak self] maxTemp in
            self?.maximumTemperatureLabel.text = maxTemp
        }
        
        weatherViewModel.windSpeed.bind { [weak self] windSpeed in
            self?.windSpeedLabel.text = windSpeed
        }
    }


}

