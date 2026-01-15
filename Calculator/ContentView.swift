import SwiftUI

struct ContentView: View {
    
    @StateObject private var vm = CalculatorViewModel()
    
    let utilityButtonColor = Color(
        red: 217 / 255,
        green: 217 / 255,
        blue: 223 / 255
    )
    
    let numberButtonColor = Color(
        red: 255 / 255,
        green: 255 / 255,
        blue: 254 / 255
    )
    
    let operatorButtonColor = Color(
        red: 98 / 255,
        green: 53 / 255,
        blue: 243 / 255
    )
    
    let displayTextColor = Color(
        red: 251 / 255,
        green: 250 / 255,
        blue: 251 / 255
    )
    
    let displayOperatorColor = Color(
        red: 86 / 255,
        green: 48 / 255,
        blue: 210 / 255
    )
    
    func buttonTapped(_ title: String) {
        if title == "," {
            vm.input(".")
        } else {
            vm.input(title)
        }
    }
    
    func calcButton(_ title: String, width: CGFloat, height: CGFloat) -> some View {
        Button(action: { buttonTapped(title) }) {
            Text(title)
                .frame(width: width, height: height)
                .contentShape(Rectangle())
                .background(
                    ["0","1","2","3","4","5","6","7","8","9",".",","].contains(title)
                    ? numberButtonColor
                    : ["C", "%", "±"].contains(title)
                        ? utilityButtonColor
                        : operatorButtonColor
                )
                .foregroundColor(
                    ["+", "−", "×", "÷", "="].contains(title)
                    ? .white
                    : .black
                )
                .cornerRadius(12)
        }
    }
    
    func emptyCell(size: CGFloat) -> some View {
        Color.clear.frame(width: size, height: size)
    }
    
    var body: some View {
        GeometryReader { geo in
            let spacing: CGFloat = 12
            let horizontalPadding: CGFloat = 16
            
            let availableWidth = geo.size.width - (horizontalPadding * 2) - (spacing * 3)
            let buttonSize = floor(availableWidth / 4)
            let wideSize = buttonSize * 2 + spacing
            
            VStack {
                Spacer()
                
                HStack(spacing: 6) {
                    Spacer()

                    Text(vm.display)
                        .font(.system(size: min(geo.size.width * 0.18, 64)))
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        .truncationMode(.head)
                        .foregroundColor(displayTextColor)

                    Text(vm.activeOperator)
                        .font(.system(size: 22))
                        .padding(.top, 8)
                        .foregroundColor(displayOperatorColor)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.bottom, 8)
                .padding(.horizontal, horizontalPadding)
                
                VStack(spacing: spacing) {
                    
                    HStack(spacing:spacing) {
                        calcButton("C", width: buttonSize, height: buttonSize)
                        calcButton("±", width: buttonSize, height: buttonSize)
                        calcButton("%", width: buttonSize, height: buttonSize)
                        calcButton("÷", width: buttonSize, height: buttonSize)
                    }
                    HStack(spacing: spacing) {
                        calcButton("7", width: buttonSize, height: buttonSize)
                        calcButton("8", width: buttonSize, height: buttonSize)
                        calcButton("9", width: buttonSize, height: buttonSize)
                        calcButton("×", width: buttonSize, height: buttonSize)
                    }
                    HStack(spacing: spacing) {
                        calcButton("4", width: buttonSize, height: buttonSize)
                        calcButton("5", width: buttonSize, height: buttonSize)
                        calcButton("6", width: buttonSize, height: buttonSize)
                        calcButton("−", width: buttonSize, height: buttonSize)
                    }
                    HStack(spacing: spacing) {
                        calcButton("1", width: buttonSize, height: buttonSize)
                        calcButton("2", width: buttonSize, height: buttonSize)
                        calcButton("3", width: buttonSize, height: buttonSize)
                        calcButton("+", width: buttonSize, height: buttonSize)
                    }
                    HStack(spacing: spacing) {
                        calcButton("0", width: wideSize, height: buttonSize)
                        calcButton(",", width: buttonSize, height: buttonSize)
                        calcButton("=", width: buttonSize, height: buttonSize)
                    }
                }
                .padding(.horizontal, horizontalPadding)
                .padding(.bottom, max(geo.safeAreaInsets.bottom, 8))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .padding(.top, 24)
        }
        .background(
            Color(red: 12 / 255,
                  green: 2 / 255,
                  blue: 49 / 255
            )
            .opacity(0.95)
            .ignoresSafeArea()
        )
            
        }
}

#Preview {
    ContentView()
}
