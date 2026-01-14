import SwiftUI

final class CalculatorViewModel: ObservableObject {
    @Published var display: String = "0"
    @Published var activeOperator: String = ""

    private var storedValue: Double? = nil
    private var pendingOp: String? = nil
    private var isEnteringSecondNumber = false

    private var lastOp: String? = nil
    private var lastOperand: Double? = nil

    private var isError = false

    func input(_ title: String) {
        if isError {
            if title == "C" { clearAll() }
            return
        }

        if title == "C" {
            clearAll()
            return
        }
        
        if title == "±" {
            toggleSign()
            return
        }

        if title == "%" {
            applyPercent()
            return
        }

        if ["+", "−", "×", "÷"].contains(title) {
            handleOperator(title)
            return
        }

        if title == "=" {
            handleEquals()
            return
        }

        if title == "." {
            beginSecondNumberIfNeeded(for: title)
            if display.contains(".") { return }
            display += "."
            return
        }

        if "0123456789".contains(title) {
            beginSecondNumberIfNeeded(for: title)
            if display == "0" {
                display = title
            } else {
                display += title
            }
        }
    }

    private func handleOperator(_ op: String) {
        if pendingOp != nil, isEnteringSecondNumber {
            pendingOp = op
            activeOperator = op
            return
        }

        if let existingOp = pendingOp, let first = storedValue, let second = Double(display) {
            guard let result = compute(first: first, op: existingOp, second: second) else {
                setError()
                return
            }
            display = format(result)
            storedValue = result
        } else {
            storedValue = Double(display)
        }

        pendingOp = op
        activeOperator = op
        isEnteringSecondNumber = true

        lastOp = nil
        lastOperand = nil
    }

    private func handleEquals() {
        if pendingOp == nil {
            guard let op = lastOp,
            let operand = lastOperand,
            let current = Double(display)
        else {
            return
        }
        guard let result = compute(first: current, op: op, second: operand)
        else {
            setError()
            return
        }
            display = format(result)
            return
        }

        guard let op = pendingOp,
        let first = storedValue,
        let second = Double(display)
        else {
            return
        }

        guard let result = compute(first: first, op: op, second: second)
        else {
            setError()
            return
        }

        display = format(result)
        activeOperator = ""

        lastOp = op
        lastOperand = second

        pendingOp = nil
        storedValue = nil
        isEnteringSecondNumber = false
    }

    private func beginSecondNumberIfNeeded(for title: String) {
        if isEnteringSecondNumber {
            display = "0"
            isEnteringSecondNumber = false
            activeOperator = ""
        }
    }

    private func compute(first: Double, op: String, second: Double) -> Double? {
        switch op {
        case "+": return first + second
        case "−": return first - second
        case "×": return first * second
        case "÷":
            if second == 0 { return nil }   // Error
            return first / second
        default:
            return nil
        }
    }
    
    private func toggleSign() {
        guard let value = Double(display) else { return }
        let newValue = -value
        display = format(newValue)
    }

    private func applyPercent() {
        guard let value = Double(display) else { return }
        display = format(value / 100.0)
    }

    private func setError() {
        display = "Error"
        isError = true
        pendingOp = nil
        storedValue = nil
        isEnteringSecondNumber = false
        lastOp = nil
        lastOperand = nil
        activeOperator = ""
    }

    private func clearAll() {
        display = "0"
        storedValue = nil
        pendingOp = nil
        isEnteringSecondNumber = false
        lastOp = nil
        lastOperand = nil
        isError = false
        activeOperator = ""
    }

    private func format(_ value: Double) -> String {
        if value.isNaN || value.isInfinite { return "Error" }

        if value.truncatingRemainder(dividingBy: 1) == 0 {
            if value <= Double(Int.max) && value >= Double(Int.min) {
                return String(Int(value))
            } else {
                return String(format: "%.0e", value)
            }
           } else {
               return String(format: "%.12g", value)
           }
    }
}
