//
//  CalculatorPage.swift
//  Calculator
//
//  Created by Mangesh Shiudkar on 10/09/26.
//

import XCTest

class CalculatorPage {
    
    private let app: XCUIApplication
    
    // Display
    lazy var displayLabel = app.staticTexts["display_a11y_ID"]
    
    //Number Buttons
    private lazy var zeroButton = app.buttons["zero_a11y_ID"]
    private lazy var oneButton = app.buttons["one_a11y_ID"]
    private lazy var twoButton = app.buttons["two_a11y_ID"]
    private lazy var fourButton = app.buttons["four_a11y_ID"]
    private lazy var fiveButton = app.buttons["five_a11y_ID"]
    private lazy var eightButton = app.buttons["eight_a11y_ID"]
    private lazy var nineButton = app.buttons["nine_a11y_ID"]
    
    // Operator Buttons
    private lazy var plusButton = app.buttons["addition_operator_a11y_ID"]
    private lazy var minusButton = app.buttons["subtraction_operator_a11y_ID"]
    private lazy var multiplyButton = app.buttons["multiplication_operator_a11y_ID"]
    private lazy var divideButton = app.buttons["division_operator_a11y_ID"]
    private lazy var equalButton = app.buttons["equal_operator_a11y_ID"]
    private lazy var clearButton = app.buttons["clear_a11y_ID"]
    
    init(app: XCUIApplication?) {
        guard let app = app else {
            XCTFail("XCUIApplication instance was nil when initializing CalculatorPage")
            fatalError("XCUIApplication instance was nil")
        }
        self.app = app
    }
    
    // Number Button Actions
    @discardableResult
    func tapZero() -> Self {
        zeroButton.tap()
        return self
    }
    
    @discardableResult
    func tapOne() -> Self {
        oneButton.tap()
        return self
    }
    
    @discardableResult
    func tapTwo() -> Self {
        twoButton.tap()
        return self
    }
    
    @discardableResult
    func tapFour() -> Self {
        fourButton.tap()
        return self
    }
    
    @discardableResult
    func tapFive() -> Self {
        fiveButton.tap()
        return self
    }
    
    @discardableResult
    func tapEight() -> Self {
        eightButton.tap()
        return self
    }
    
    @discardableResult
    func tapNine() -> Self {
        nineButton.tap()
        return self
    }
    
    //Operator Actions
    @discardableResult
    func tapPlus() -> Self {
        plusButton.tap()
        return self
    }
    
    @discardableResult
    func tapMinus() -> Self {
        minusButton.tap()
        return self
    }
    
    @discardableResult
    func tapMultiply() -> Self {
        multiplyButton.tap()
        return self
    }
    
    @discardableResult
    func tapDivide() -> Self {
        divideButton.tap()
        return self
    }
    
    @discardableResult
    func tapEqual() -> Self {
        equalButton.tap()
        return self
    }
    
    @discardableResult
    func tapClear() -> Self {
        clearButton.tap()
        return self
    }
}
