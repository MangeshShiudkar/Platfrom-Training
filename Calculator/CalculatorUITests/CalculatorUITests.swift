//
//  CalculatorUITests.swift
//  CalculatorUITests
//
//  Created by Mangesh Shiudkar on 10/09/26.
//

import XCTest

final class CalculatorUITests: XCTestCase {
    // Creating app and page object variables to use in all test cases
    private var app: XCUIApplication!
    private var page: CalculatorPage!
    
    // This method runs before each test case
    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        let application = XCUIApplication()
        application.launch()
        self.app = application
        page = CalculatorPage(app: app)
    }
    
    // This method runs after each test case
    override func tearDownWithError() throws {
        app = nil
        page = nil
        try super.tearDownWithError()
    }
    
    // Testing addition operation
    func testAddition() {
        page.tapOne()
            .tapPlus()
            .tapFive()
            .tapEqual()
        
        XCTAssertEqual(page.displayLabel.label, "6", "Calculator display should show 6 after performing 1 + 5")
    }
    
    // Testing addition with incorrect expected result
    func testAdditionNegativeCase() {
        page.tapTwo()
            .tapPlus()
            .tapFive()
            .tapEqual()
        
        XCTAssertNotEqual(page.displayLabel.label, "6", "Calculator display should not show 6 after performing 2 + 5")
    }
    
    // Testing subtraction operation
    func testSubtraction() {
        page.tapNine()
            .tapMinus()
            .tapFour()
            .tapEqual()
        
        XCTAssertEqual(page.displayLabel.label, "5", "Calculator display should show 5 after performing 9 - 4")
    }
    
    // Testing multiplication operation
    func testMultiplication() {
        page.tapFour()
            .tapMultiply()
            .tapFive()
            .tapEqual()
        
        XCTAssertEqual(page.displayLabel.label, "20", "Calculator display should show 20 after performing 4 * 5")
    }
    
    // Testing division operation
    func testDivision() {
        page.tapEight()
            .tapDivide()
            .tapTwo()
            .tapEqual()
        
        XCTAssertEqual(page.displayLabel.label, "4", "Calculator display should show 4 after performing 8 / 2")
    }
    
    // Testing division by zero case
    func testDivisionByZero() {
        page.tapEight()
            .tapDivide()
            .tapZero()
            .tapEqual()
        
        XCTAssertEqual(page.displayLabel.label, "Error", "Calculator display should show Error after performing 8 / 0")
    }
    
    // Testing clear button functionality
    func testClearButton() {
        page.tapFive()
            .tapPlus()
            .tapFour()
            .tapClear()
        XCTAssertEqual(page.displayLabel.label, "0", "Calculator display should show 0 after tapping on Clear button")
    }
    
    // Testing multiple operations together
    func testChainedOperation() {
        page.tapTwo()
            .tapPlus()
            .tapFour()
            .tapMinus()
            .tapOne()
            .tapEqual()
        XCTAssertEqual(page.displayLabel.label, "5", "Calculator display should show 5 after performing 2 + 4 - 1")
    }
}
