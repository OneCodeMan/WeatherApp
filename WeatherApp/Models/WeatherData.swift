//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Dave Gumba on 03.03.22.
//

import Foundation

struct WeatherData: Decodable {
    let city: String
    let parent: Parent
    let consolidatedWeather: [WeatherReport]
    
    enum CodingKeys: String, CodingKey {
        case city = "title"
        case parent
        case consolidatedWeather = "consolidated_weather"
    }
    
    //MARK: - Convenience getters
    var country: String {
        parent.country
    }
    
    var created: String {
        consolidatedWeather[0].created
    }
    
    var applicableDate: String {
        consolidatedWeather[0].applicableDate
    }
    
    var weatherDescription: String {
        consolidatedWeather[0].weatherStateName
    }
    
    var currentTemp: Double {
        consolidatedWeather[0].currentTemp
    }
    
    var maxTemp: Double {
        consolidatedWeather[0].maxTemp
    }
    
    var minTemp: Double {
        consolidatedWeather[0].minTemp
    }
    
    var windSpeed: Double {
        consolidatedWeather[0].windSpeed
    }
    
    var predictability: Int {
        consolidatedWeather[0].predictability
    }
}

struct Parent: Decodable {
    let country: String
    
    enum CodingKeys: String, CodingKey {
        case country = "title"
    }
}

struct WeatherReport: Decodable {
    let created: String
    let applicableDate: String
    let weatherStateName: String
    let currentTemp: Double
    let minTemp: Double
    let maxTemp: Double
    let windSpeed: Double
    let predictability: Int
    
    enum CodingKeys: String, CodingKey {
        case created
        case applicableDate = "applicable_date"
        case weatherStateName = "weather_state_name"
        case currentTemp = "the_temp"
        case minTemp = "min_temp"
        case maxTemp = "max_temp"
        case windSpeed = "wind_speed"
        case predictability
    }
}
