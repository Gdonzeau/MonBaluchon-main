//
//  MonBaluchonTests.swift
//  MonBaluchonTests
//
//  Created by Guillaume Donzeau on 18/05/2021.
//

import XCTest
@testable import MonBaluchon

class MonBaluchonTestsCurrency: XCTestCase {

    func testGivenStartConversionWhenStartThenUrlExists() {
        XCTAssertNotNil(currenciesAvailable)
    }
    func testGetConversionShouldPostFailedCallbackIfIncorrectUrl() {
        let errorExpected:APIErrors = .invalidURL
        var errorReceived:APIErrors = .noError
        let urlAdress = "Truc muche"
        XCTAssertNotEqual(errorExpected, errorReceived)
        // No URL to configure...
        let conversionService = ConversionService(
            session: URLSessionFake(data: nil, response: nil, error: nil))
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        conversionService.getConversion(stringAdress: urlAdress) { result in
            
            switch result {
            
            case.success( _):
                XCTFail()
                
            case.failure(let error):
                errorReceived = error
            }
            //Then
            XCTAssertEqual(errorExpected, errorReceived)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetConversionShouldPostFailedCallbackIfError() {
        let errorExpected:APIErrors = .errorGenerated
        var errorReceived:APIErrors = .noError
        let urlAdress = "http://www.bonneAdresseUrl.com"
        XCTAssertNotEqual(errorExpected, errorReceived)
        let conversionService = ConversionService(
            session: URLSessionFake(data: FakeResponseCurrencyRUB.currencyCorrectData, response: FakeResponseCurrencyRUB.responseOK, error: FakeResponseCurrencyRUB.error))
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        conversionService.getConversion(stringAdress: urlAdress) { result in
            
            switch result {
            
            case.success( _):
                XCTFail()
                
            case.failure(let error):
                errorReceived = error
            }
            //Then
            XCTAssertEqual(errorExpected, errorReceived)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetConversionShouldPostFailedCallbackIfNoData() {
        let errorExpected:APIErrors = .noData
        var errorReceived:APIErrors = .noError
        let urlAdress = "http://www.bonneAdresseUrl.com"
        XCTAssertNotEqual(errorExpected, errorReceived)
        let conversionService = ConversionService(
            session: URLSessionFake(data: nil, response: nil, error: nil))
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        conversionService.getConversion(stringAdress: urlAdress) { result in
            
            switch result {
            
            case.success( _):
                XCTFail()
                
            case.failure(let error):
                errorReceived = error
            }
            //Then
            XCTAssertEqual(errorExpected, errorReceived)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetConversionShouldPostFailedCallbackIfIncorrectResponse() {
        let errorExpected:APIErrors = .invalidStatusCode
        var errorReceived:APIErrors = .noError
        let urlAdress = "http://www.bonneAdresseUrl.com"
        XCTAssertNotEqual(errorExpected, errorReceived)
        let conversionService = ConversionService(
            session: URLSessionFake(data: FakeResponseCurrencyRUB.currencyCorrectData, response: FakeResponseCurrencyRUB.responseKO, error: nil))
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        conversionService.getConversion(stringAdress: urlAdress) { result in
            
            switch result {
            
            case.success( _):
                XCTFail()
                
            case.failure(let error):
                errorReceived = error
            }
            //Then
            XCTAssertEqual(errorExpected, errorReceived)
          //  XCTAssertEqual(currency, rate)
           
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetConversionShouldPostFailedCallbackIfIncorrectData() {
        let errorExpected:APIErrors = .badFile
        var errorReceived:APIErrors = .noError
        let urlAdress = "http://www.bonneAdresseUrl.com"
        XCTAssertNotEqual(errorExpected, errorReceived)
        let conversionService = ConversionService(
            session: URLSessionFake(data: FakeResponseCurrencyRUB.currencyIncorrectData, response: FakeResponseCurrencyRUB.responseOK, error: nil))
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        conversionService.getConversion(stringAdress: urlAdress) { result in
            
            switch result {
            
            case.success( _):
                XCTFail()
                
            case.failure(let error):
            print("Pas Youpi")
                errorReceived = error
            }
            //Then
            XCTAssertEqual(errorExpected, errorReceived)
          //  XCTAssertEqual(currency, rate)
           
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetConversionShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        //Given
        let currency = 89.282326
        var rateToCheck = 0.00
        let urlAdress = "http://www.bonneAdresseUrl.com"
        XCTAssertNotEqual(currency, rateToCheck)
        let conversionService = ConversionService(
            session: URLSessionFake(data: FakeResponseCurrencyRUB.currencyCorrectData, response: FakeResponseCurrencyRUB.responseOK, error: nil))
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        conversionService.getConversion(stringAdress: urlAdress) { result in
            
            switch result {
            
            case.success(let data):
                guard let rate = data.rates["RUB"] else {
                    return
                }
                rateToCheck = rate
                
            case.failure(let error):
            print(error)
            }
            //Then
            
            XCTAssertEqual(currency, rateToCheck)
           
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
}
