import SwiftUI
// MARK: - Calculator Engine (Extracted Business Logic)
struct CalculatorEngine {
    static func performCalculation(lhs: Double, rhs: Double, op: CalcButton?) -> Double? {
        guard let op = op else { return rhs }
        switch op {
        case .add: return lhs + rhs
        case .subtract: return lhs - rhs
        case .multiply: return lhs * rhs
        case .divide: return rhs != 0 ? lhs / rhs : nil
        default: return rhs
        }
    }
}
// MARK: - Calculator App View
struct ContentView: View {
    @State private var displayValue: String = "0"
    @State private var storedNumber: Double? = nil
    @State private var currentOp: CalcButton? = nil
    @State private var typingNextNumber: Bool = false
    // Calculator Button Grid Layout
    let grid: [[CalcButton]] = [
        [.clear, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal]
    ]
    var body: some View {
        VStack(spacing: 12) {
            Spacer()
            // Display Screen
            Text(displayValue)
                .font(.system(size: 54, weight: .bold))
                .foregroundColor(.white)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding()
                .background(Color.black.opacity(0.8))
                .cornerRadius(12)
                .padding(.horizontal)
                .accessibilityIdentifier("display_a11y_ID")
            // Button Pad
            VStack(spacing: 10) {
                ForEach(grid, id: \.self) { row in
                    HStack(spacing: 10) {
                        ForEach(row, id: \.self) { btn in
                            Button(action: {
                                self.didTap(btn)
                            }) {
                                Text(btn.rawValue)
                                    .font(.title.bold())
                                    .frame(maxWidth: .infinity, minHeight: 65)
                                    .background(btn.bgColor)
                                    .foregroundColor(.white)
                                    .cornerRadius(32)
                            }
                            .accessibilityIdentifier(btn.a11yID)
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
        .padding(.bottom)
        .background(Color.black.ignoresSafeArea())
    }
    // MARK: - Calculator UI Actions
    private func didTap(_ btn: CalcButton){
        switch btn {
        case .add, .subtract, .multiply, .divide:
            handleOperation(btn)
        case .equal:
            handleEqual()
        case .clear:
            clearAll()
        case .decimal:
            handleDecimal()
        default: // Numbers 0-9
            handleNumber(btn.rawValue)
        }
    }
    private func handleNumber(_ digit: String) {
        if typingNextNumber || displayValue == "0" || displayValue == "Error" {
            displayValue = digit
            typingNextNumber = false
        } else {
            displayValue += digit
        }
    }
    private func handleDecimal() {
        if typingNextNumber || displayValue == "Error" {
            displayValue = "0."
            typingNextNumber = false
        } else if !displayValue.contains(".") {
            displayValue += "."
        }
    }
    private func handleOperation(_ op: CalcButton) {
        if let stored = storedNumber, let current = Double(displayValue), !typingNextNumber {
            let result = CalculatorEngine.performCalculation(lhs: stored, rhs: current, op: currentOp)
            displayValue = formatResult(result)
            storedNumber = Double(displayValue)
        } else {
            storedNumber = Double(displayValue)
        }
        currentOp = op
        typingNextNumber = true
    }
    private func handleEqual() {
        guard let op = currentOp, let stored = storedNumber, let current = Double(displayValue) else { return }
        let result = CalculatorEngine.performCalculation(lhs: stored, rhs: current, op: op)
        displayValue = formatResult(result)
        storedNumber = nil
        currentOp = nil
        typingNextNumber = true
    }
    private func formatResult(_ value: Double?) -> String {
        guard let val = value, !val.isNaN, !val.isInfinite else {
            return "Error"
        }
        if val.truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.0f", val)
        } else {
            return "\(val)"
        }
    }
    private func clearAll() {
        displayValue = "0"
        storedNumber = nil
        currentOp = nil
        typingNextNumber = false
    }
}
// MARK: - Button Model & Identifiers
enum CalcButton: String, CaseIterable, Hashable {
    case zero = "0", one = "1", two = "2", three = "3", four = "4"
    case five = "5", six = "6", seven = "7", eight = "8", nine = "9"
    case add = "+", subtract = "-", multiply = "×", divide = "÷", equal = "=", clear = "C", decimal = "."
    var bgColor: Color {
        switch self {
        case .add, .subtract, .multiply, .divide, .equal:
            return .orange
        case .clear:
            return .red
        default:
            return Color(.darkGray)
        }
    }
    var a11yID: String {
        switch self {
        case .add: return "addition_operator_a11y_ID"
        case .subtract: return "subtraction_operator_a11y_ID"
        case .multiply: return "multiplication_operator_a11y_ID"
        case .divide: return "division_operator_a11y_ID"
        case .equal: return "equal_operator_a11y_ID"
        case .clear: return "clear_a11y_ID"
        case .decimal: return "decimal_a11y_ID"
        case .zero: return "zero_a11y_ID"
        case .one: return "one_a11y_ID"
        case .two: return "two_a11y_ID"
        case .three: return "three_a11y_ID"
        case .four: return "four_a11y_ID"
        case .five: return "five_a11y_ID"
        case .six: return "six_a11y_ID"
        case .seven: return "seven_a11y_ID"
        case .eight: return "eight_a11y_ID"
        case .nine: return "nine_a11y_ID"
        }
    }
}
