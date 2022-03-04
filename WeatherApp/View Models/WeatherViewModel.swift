//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Dave Gumba on 03.03.22.
//

import Foundation

public class WeatherViewModel {
    
    var isLoading: Bool
    
    let countryName = Box("Loading...")
    let cityName = Box("Loading...")
    let weatherDescription = Box("Loading...")
    let currentTemp = Box("...")
    let minTemp = Box("...")
    let maxTemp = Box("...")
    let windSpeed = Box("...")
    
    init() {
        self.isLoading = true
        fetchWeatherForToday()
    }
    
    private func fetchWeatherForToday() {
        WeatherService.fetchDailyWeatherData { [weak self] (weatherData, weatherDataError) in
            guard let self = self,
                  let results = weatherData else {
                      self?.isLoading = false
                      
                      switch (weatherDataError) {
                      case .invalidResponse:
                          self?.handleErrorMessage(message: "Invalid Response")
                          break
                      case .noData:
                          self?.handleErrorMessage(message: "No Data")
                          break
                      case .failedRequest:
                          self?.handleErrorMessage(message: "Failed Request")
                          break
                      case .invalidData:
                          self?.handleErrorMessage(message: "Invalid Data")
                          break
                      default:
                          break
                      }
                      return
                  }
            self.isLoading = false
            self.countryName.value = results.country
            self.cityName.value = results.city
            self.weatherDescription.value = results.weatherDescription
            self.currentTemp.value = "\(self.parseTemperature(temperature: results.currentTemp))°C"
            self.minTemp.value = "Low: \(self.parseTemperature(temperature: results.minTemp))°C"
            self.maxTemp.value = "High: \(self.parseTemperature(temperature: results.maxTemp))°C"
            self.windSpeed.value = "Wind Speed: \(self.parseWindSpeed(windSpeed: results.windSpeed)) km/h"
        }
    }
    
    private func handleErrorMessage(message: String) {
        self.countryName.value = "N/A"
        self.cityName.value = "N/A"
        self.currentTemp.value = message
        self.weatherDescription.value = "N/A"
    }
    
    private func parseTemperature(temperature: Double) -> Int {
        let parsedTemperature = Int(temperature.rounded())
        return parsedTemperature
    }
    
    private func parseWindSpeed(windSpeed: Double) -> Double {
        let parsedWindSpeed = windSpeed.rounded(.toNearestOrEven)
        return parsedWindSpeed
    }
}
