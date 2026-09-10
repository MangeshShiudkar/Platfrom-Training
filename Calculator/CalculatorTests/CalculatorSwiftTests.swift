//
//  CalculatorSwiftTests.swift
//  CalculatorTests
//
//  Created by Mangesh Shiudkar on 10/09/26.
//

import Testing
@testable import Calculator
 
@Suite("Calculator Swift Testing")
struct CalculatorSwiftTests {
 
    //Addition
    @Test("Addition: 5 + 3 = 8")
    func testAddition() {
        let result = CalculatorEngine.performCalculation(lhs: 5, rhs: 3, op: .add)
        #expect(result == 8)
    }
 
    @Test("Addition negative case: 5 + 3 != 10")
    func testAdditionNegative() {
        let result = CalculatorEngine.performCalculation(lhs: 5, rhs: 3, op: .add)
        #expect(result != 10)
    }
 
    //Subtraction
    @Test("Subtraction: 9 - 4 = 5")
    func testSubtraction() {
        let result = CalculatorEngine.performCalculation(lhs: 9, rhs: 4, op: .subtract)
        #expect(result == 5)
    }
 
    @Test("Subtraction negative case: 9 - 4 != 4")
    func testSubtractionNegative() {
        let result = CalculatorEngine.performCalculation(lhs: 9, rhs: 4, op: .subtract)
        #expect(result != 4)
    }
 
    //Multiplication
    @Test("Multiplication: 6 * 7 = 42")
    func testMultiplication() {
        let result = CalculatorEngine.performCalculation(lhs: 6, rhs: 7, op: .multiply)
        #expect(result == 42)
    }
 
    @Test("Multiplication negative case: 6 * 7 != 40")
    func testMultiplicationNegative() {
        let result = CalculatorEngine.performCalculation(lhs: 6, rhs: 7, op: .multiply)
        #expect(result != 40)
    }
 
    //Division
    @Test("Division: 20 / 4 = 5")
    func testDivision() {
        let result = CalculatorEngine.performCalculation(lhs: 20, rhs: 4, op: .divide)
        #expect(result == 5)
    }
 
    @Test("Division negative case: 20 / 4 != 4")
    func testDivisionNegative() {
        let result = CalculatorEngine.performCalculation(lhs: 20, rhs: 4, op: .divide)
        #expect(result != 4)
    }
 
    @Test("Division by zero returns nil")
    func testDivisionByZero() {
        let result = CalculatorEngine.performCalculation(lhs: 8, rhs: 0, op: .divide)
        #expect(result == nil)
    }
 
    //Parameterized (covers all four operators in one test)
    @Test("Parameterized arithmetic checks", arguments: [
        (2.0, 3.0, CalcButton.add, 5.0),
        (10.0, 4.0, CalcButton.subtract, 6.0),
        (3.0, 5.0, CalcButton.multiply, 15.0),
        (12.0, 3.0, CalcButton.divide, 4.0)
    ])
    func testAllOperators(lhs: Double, rhs: Double, op: CalcButton, expected: Double) {
        let result = CalculatorEngine.performCalculation(lhs: lhs, rhs: rhs, op: op)
        #expect(result == expected)
    }
}
 
