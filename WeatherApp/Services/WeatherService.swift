//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Dave Gumba on 03.03.22.
//

import Foundation

enum WeatherDataError: Error {
  case invalidResponse
  case noData
  case failedRequest
  case invalidData
}

class WeatherService {
    
    private static let baseURL = "https://www.metaweather.com/api/location/"
    private static let defaultLocationCode = "44418"
    
    static func fetchDailyWeatherData(for locationCode: String = defaultLocationCode, completion: @escaping (WeatherData?, WeatherDataError?) -> ()) {
        
        let urlString = baseURL + locationCode
        
        if let targetURL = URL(string: urlString) {
            URLSession.shared.dataTask(with: targetURL) { (data, response, error) in
              DispatchQueue.main.async {
                guard error == nil else {
                  completion(nil, .failedRequest)
                  return
                }
                
                guard let data = data else {
                  completion(nil, .noData)
                  return
                }
                
                guard let response = response as? HTTPURLResponse else {
                  completion(nil, .invalidResponse)
                  return
                }
                
                guard response.statusCode == 200 else {
                  completion(nil, .failedRequest)
                  return
                }
                
                do {
                  let decoder = JSONDecoder()
                  let weatherData: WeatherData = try decoder.decode(WeatherData.self, from: data)
                  completion(weatherData, nil)
                } catch {
                  completion(nil, .invalidData)
                }
              }
            }.resume()
        }
        
        
      }
}
