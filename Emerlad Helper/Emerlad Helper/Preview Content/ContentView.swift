//
//  ContentView.swift
//  Emerlad Helper
//
//  Created by Natividad Michael Salinas II on 3/6/24.
//

import SwiftUI

struct ContentView: View {
    @State private var rotationAngle: Double = 0
    @State private var movingAngle: Double = 0
    @State private var showButtons: Bool = false

    var body: some View {
        
        VStack {
            Image("sunburst_duck")
                .frame(width: 400, height: 400)
                .rotation3DEffect(
                    .degrees(rotationAngle),
                    axis: (x: 0.0, y: 2.0, z: 0.0)
                )
                .clipShape(Circle())
                
                .onAppear {
                    withAnimation(.linear(duration: 2)) {
                        rotationAngle = 360
                        
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation(.easeOut(duration: 0.5)) {
                            showButtons = true
                                
                            
                        }
                    }
                }
                .padding()
            Text("Welcome to Emerald!")
                .bold()
                .padding()

            if showButtons {
                Button("Sign Up") {
                    // Sign Up action
                }
                .buttonStyle(CustomButtonStyle(backgroundColor: Color(hex: "fdd48d"), borderColor: Color(hex: "27ad6e")))
                .padding(.bottom, 8) // Adds space between the buttons

                Button("Log In") {
                    // Log In action
                }
                .buttonStyle(CustomButtonStyle(backgroundColor: Color(hex: "27ad6e"), borderColor: Color(hex: "fdd48d")))
            }
        }
        .padding()
        .transition(.move(edge: .bottom))
    }
}


struct CustomButtonStyle: ButtonStyle {
    var backgroundColor: Color
    var borderColor: Color
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .padding(.vertical, 15) // Increased vertical padding for a taller button
            .padding(.horizontal, 100) // Increased horizontal padding for wider buttons
            .background(backgroundColor)
            .cornerRadius(30) // Rounded corners for a modern, app-like feel
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(borderColor, lineWidth: 2)
            )
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}

// Extension to convert hex color codes to SwiftUI Color
extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >> 8) & 0xFF) / 255.0
        let b = Double(rgb & 0xFF) / 255.0
        
        self.init(red: r, green: g, blue: b)
    }
}
#Preview {
    ContentView()
}
