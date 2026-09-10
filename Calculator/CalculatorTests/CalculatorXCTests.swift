//
//  CalculatorTests.swift
//  CalculatorTests
//
//  Created by Mangesh Shiudkar on 10/09/26.
//

import XCTest
@testable import Calculator

class CalculatorTests: XCTestCase {
    
    // Addition Tests
    func testAdditionPositiveCase() {
        let result = CalculatorEngine.performCalculation(lhs: 1, rhs: 1, op: .add)
        XCTAssertEqual(result, 2, "1 + 1 should equal 2")
    }

    func testAdditionNegativeCase() {
        let result = CalculatorEngine.performCalculation(lhs: 1,rhs: 1, op: .add)
        XCTAssertNotEqual(result, 1, "1 + 1 should not equal 1")
    }

    func testAdditionWithNegativeNumbers() {
        let result = CalculatorEngine.performCalculation(lhs: -5, rhs: 3,op: .add)
        XCTAssertEqual(result, -2, "-5 + 3 should equal -2")
    }

    //Subtraction Tests
    func testSubtractionPositiveCase() {
        let result = CalculatorEngine.performCalculation(lhs: 5, rhs: 3, op: .subtract)
        XCTAssertEqual(result, 2, "5 - 3 should equal 2")
    }

    func testSubtractionNegativeCase() {
        let result = CalculatorEngine.performCalculation(lhs: 5, rhs: 3,op: .subtract)
        XCTAssertNotEqual(result, 3, "5 - 3 should not equal 3")
    }

    func testSubtractionResultIsNegative() {
        let result = CalculatorEngine.performCalculation(lhs: 2, rhs: 5, op: .subtract)
        XCTAssertEqual(result, -3, "2 - 5 should equal -3")
    }

    // Multiplication Tests
    func testMultiplicationPositiveCase() {
        let result = CalculatorEngine.performCalculation(lhs: 4,rhs: 3, op: .multiply)
        XCTAssertEqual(result, 12, "4 * 3 should equal 12")
    }

    func testMultiplicationNegativeCase() {
        let result = CalculatorEngine.performCalculation(lhs: 4, rhs: 3, op: .multiply)
        XCTAssertNotEqual(result, 10, "4 * 3 should not equal 10")
    }

    func testMultiplicationByZero() {
        let result = CalculatorEngine.performCalculation(lhs: 7, rhs: 0, op: .multiply)
        XCTAssertEqual(result, 0, "Anything multiplied by 0 should equal 0")
    }

    // Division Tests
    func testDivisionPositiveCase() {
        let result = CalculatorEngine.performCalculation(lhs: 10, rhs: 2, op: .divide)
        XCTAssertEqual(result, 5, "10 / 2 should equal 5")
    }

    func testDivisionNegativeCase() {
        let result = CalculatorEngine.performCalculation(lhs: 10, rhs: 2, op: .divide)
        XCTAssertNotEqual(result, 4, "10 / 2 should not equal 4")
    }

    func testDivisionByZeroReturnsNil() {
        let result = CalculatorEngine.performCalculation(lhs: 5, rhs: 0,op: .divide)
        XCTAssertNil(result, "Dividing by zero should return nil")
    }

}
