import SwiftUI

class CalculatorViewModel: ObservableObject {
    @Published var display: String = "0"
    
    private var storedValue: Double? = nil
    private var pendingOp: String? = nil
    private var isEnteringSecondNumber = false
    
    private func format(_ value: Double) -> String {
        if value.truncatingRemainder(dividingBy: 1) == 0 {
            return String(Int(value))
        } else {
            return String(value)
        }
    }
    
    func input(_ title: String) {
        
        if ["+", "−", "×", "÷"].contains(title) {
            storedValue = Double(display)
            pendingOp = title
            isEnteringSecondNumber = true
            return
        }

        if title == "=" {
            guard let op = pendingOp,
                  let first = storedValue,
                  let second = Double(display) else { return }

            let result: Double
            switch op {
            case "+": result = first + second
            case "−": result = first - second
            case "×": result = first * second
            case "÷": result = first / second
            default: return
            }

            display = format(result)
            storedValue = nil
            pendingOp = nil
            isEnteringSecondNumber = false
            return
        }

        if title == "C" {
            display = "0"
            storedValue = nil
            pendingOp = nil
            isEnteringSecondNumber = false
            return
        }

        if title == "." {
            if isEnteringSecondNumber {
                display = "0"
                isEnteringSecondNumber = false
            }
            if display.contains(".") { return }
            display += "."
            return
        }

        if "0123456789".contains(title) {
            if isEnteringSecondNumber {
                display = "0"
                isEnteringSecondNumber = false
            }
            if display == "0" {
                display = title
            } else {
                display += title
            }
        }
    }
}
