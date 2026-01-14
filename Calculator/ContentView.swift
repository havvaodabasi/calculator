import SwiftUI

struct ContentView: View {
    
    @StateObject private var vm = CalculatorViewModel()
    
    func buttonTapped(_ title: String) {
        vm.input(title)
    }
    
    func calcButton(_ title: String, size: CGFloat) -> some View {
        Button(action: { buttonTapped(title) }) {
            Text(title)
                .frame(width: size, height: size)
                .contentShape(Rectangle())
                .background(Color(.systemGray5))
                .cornerRadius(size * 0.18)
        }
        
    }
    
    var body: some View {
        GeometryReader { geo in
            let spacing: CGFloat = 12
            let horizontalPadding: CGFloat = 16
            
            let availableWidth = geo.size.width - (horizontalPadding * 2) - (spacing * 3)
            let buttonSize = floor(availableWidth / 4)
            
            VStack {
                Spacer()
                
                HStack(spacing: 8) {
                    Spacer()
                    
                    Text(vm.display)
                        .font(.system(size: min(geo.size.width * 0.18, 64), weight: .regular, design: .default))
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        .truncationMode(.head)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.bottom, 8)
                        .padding(.horizontal, horizontalPadding)
                    
                    Text(vm.activeOperator)
                        .font(.system(size: 22))
                        .padding(.top, 8)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.bottom, 8)
                .padding(.horizontal)
                
                VStack(spacing: 12) {
                    HStack(spacing:12) {
                        calcButton("7", size: buttonSize)
                        calcButton("8", size: buttonSize)
                        calcButton("9", size: buttonSize)
                        calcButton("÷", size: buttonSize)
                    }
                    HStack(spacing: 12) {
                        calcButton("4", size: buttonSize)
                        calcButton("5", size: buttonSize)
                        calcButton("6", size: buttonSize)
                        calcButton("×", size: buttonSize)
                    }
                    HStack(spacing: 12) {
                        calcButton("1", size: buttonSize)
                        calcButton("2", size: buttonSize)
                        calcButton("3", size: buttonSize)
                        calcButton("−", size: buttonSize)
                    }
                    HStack(spacing: 12) {
                        calcButton("C", size: buttonSize)
                        calcButton("0", size: buttonSize)
                        calcButton("=", size: buttonSize)
                        calcButton("+", size: buttonSize)
                    }
                }
                .padding(.horizontal, horizontalPadding)
                .padding(.bottom, max(geo.safeAreaInsets.bottom, 8))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .padding(.top, 24)
        }
            
        }
}

#Preview {
    ContentView()
}
