import XCTest
import MyLibrary
@testable import MyLibrary

final class MyLibraryTests: XCTestCase {
    func testIsLuckyBecauseWeAlreadyHaveLuckyNumber() async {
        // Given
        let mockWeatherService = MockWeatherService(
            shouldSucceed: true,
            shouldReturnTemperatureWithAnEight: false
        )

        let myLibrary = MyLibrary(weatherService: mockWeatherService)

        // When
        let isLuckyNumber = await myLibrary.isLucky(8)

        // Then
        XCTAssertNotNil(isLuckyNumber)
        XCTAssert(isLuckyNumber == true)
    }

    func testIsLuckyBecauseWeatherHasAnEight() async throws {
        // Given
        let mockWeatherService = MockWeatherService(
            shouldSucceed: true,
            shouldReturnTemperatureWithAnEight: true
        )

        let myLibrary = MyLibrary(weatherService: mockWeatherService)

        // When
        let isLuckyNumber = await myLibrary.isLucky(0)

        // Then
        XCTAssertNotNil(isLuckyNumber)
        XCTAssert(isLuckyNumber == true)
    }

    func testIsNotLucky() async {
        // Given
        let mockWeatherService = MockWeatherService(
            shouldSucceed: true,
            shouldReturnTemperatureWithAnEight: false
        )

        let myLibrary = MyLibrary(weatherService: mockWeatherService)

        // When
        let isLuckyNumber = await myLibrary.isLucky(7)

        // Then
        XCTAssertNotNil(isLuckyNumber)
        XCTAssert(isLuckyNumber == false)
    }

    func testIsNotLuckyBecauseServiceCallFails() async {
        // Given
        let mockWeatherService = MockWeatherService(
            shouldSucceed: false,
            shouldReturnTemperatureWithAnEight: false
        )

        let myLibrary = MyLibrary(weatherService: mockWeatherService)

        // When
        let isLuckyNumber = await myLibrary.isLucky(7)

        // Then
        XCTAssertNil(isLuckyNumber)
    }
    
    // test code coverage of WeatherService
    func testCodeCoverageOfWeatherService() async {
        
        let myLibrary = MyLibrary(weatherService: nil)
        let isLuckyNumber = await myLibrary.isLucky(7)
        
        XCTAssert(isLuckyNumber != nil)
    }
    
    // test getTemperature
    func testGetTemperature() async throws {

        // expected output
        let filePath = try XCTUnwrap(Bundle.module.path(forResource:"data", ofType: "json"))
        let jsonString = try String(contentsOfFile: filePath)
        let jsonData = Data(jsonString.utf8)
        let jsonDecoder = JSONDecoder()
        let weather = try jsonDecoder.decode(Weather.self, from: jsonData)
        let expectedOutput = Int(weather.main.temp)

        // actual output
        let weatherServceImplementation = WeatherServiceImpl()
        do{
            let actualOutput = try await weatherServceImplementation.getTemperature()
            XCTAssertEqual(expectedOutput, actualOutput)
        } catch {
            XCTAssert(false)
        }
    }
    
    // test getTempFail
    func testGetTempFail() async throws {
        let weatherServiceImplementation = WeatherServiceImpl(url: "http://localhost:8000/data/2.5/temp/lat=44.5904&lon=-123.2722&appid=sealion")
        do{
            let actualOutput = try await weatherServiceImplementation.getTemperature()
            XCTAssert(false)
        } catch {
            XCTAssert(true)
        }
    }
    
    // integration test
    func testIntegration() async throws{
        let myLibrary = MyLibrary(weatherService: nil)
        let isLuckyNumber = await myLibrary.isLucky(3)
        
        XCTAssert(isLuckyNumber == true)
    }
    
    

}

