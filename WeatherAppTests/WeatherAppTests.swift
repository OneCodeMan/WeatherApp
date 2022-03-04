//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Dave Gumba on 03.03.22.
//

import XCTest
@testable import WeatherApp

class WeatherAppTests: XCTestCase {
    
    var mockResponseJSON: Data!
    var mockWeatherData: WeatherData!

    override func setUpWithError() throws {
        let bundle = Bundle(for: type(of: self))
        let url = bundle.url(forResource: "WeatherAppMockData", withExtension: "json")!
        mockResponseJSON = try! Data(contentsOf: url)
        
        let decoder = JSONDecoder()
        mockWeatherData = try! decoder.decode(WeatherData.self, from: mockResponseJSON)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDecodeCountry() throws {
        XCTAssertEqual(mockWeatherData.country, "Canada")
    }

    func testDecodeCity() throws {
        XCTAssertEqual(mockWeatherData.city, "Toronto")
    }
    
    func testDecodeWeatherDescription() throws {
        XCTAssertEqual(mockWeatherData.weatherDescription, "Heavy Cloud")
    }
    
    func testDecodeCurrentTemp() throws {
        let currentTempParsed = Int(mockWeatherData.currentTemp.rounded(.toNearestOrAwayFromZero))
        XCTAssertEqual(currentTempParsed, 1)
    }
    
    func testDecodeMinTemp() throws {
        let minTempParsed = Int(mockWeatherData.minTemp.rounded(.toNearestOrAwayFromZero))
        XCTAssertEqual(minTempParsed, -9)
    }
    
    func testDecodeMaxTemp() throws {
        let maxTempParsed = Int(mockWeatherData.maxTemp.rounded(.toNearestOrAwayFromZero))
        XCTAssertEqual(maxTempParsed, 0)
    }
    
    func testDecodeWindSpeed() throws {
        XCTAssertEqual(Int(mockWeatherData.windSpeed), 9)
    }
    
}
