import SwiftUI

struct ContentView: View {
    
    @StateObject private var vm = CalculatorViewModel()
    
    func buttonTapped(_ title: String) {
        vm.input(title)
    }
    
    func calcButton(_ title: String) -> some View {
        Button(action: { buttonTapped(title) }) {
            Text(title)
                .frame(width: 80, height: 80)
                .contentShape(Rectangle())
                .background(Color(.systemGray5))
                .cornerRadius(12)
        }
    }
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack(spacing: 8) {
                Spacer()
                
                Text(vm.display)
                    .font(.system(size: 50))
                
                Text(vm.activeOperator)
                    .font(.system(size: 22))
                    .padding(.top, 8)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.bottom, 8)
            .padding(.horizontal)
            
            VStack(spacing: 12) {
                HStack(spacing:12) {
                    calcButton("7")
                    calcButton("8")
                    calcButton("9")
                    calcButton("÷")
                }
                HStack(spacing: 12) {
                    calcButton("4")
                    calcButton("5")
                    calcButton("6")
                    calcButton("×")
                }
                HStack(spacing: 12) {
                    calcButton("1")
                    calcButton("2")
                    calcButton("3")
                    calcButton("−")
                }
                HStack(spacing: 12) {
                    calcButton("C")
                    calcButton("0")
                    calcButton("=")
                    calcButton("+")
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 8)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .padding(.top, 24)
    }
}

#Preview {
    ContentView()
}
