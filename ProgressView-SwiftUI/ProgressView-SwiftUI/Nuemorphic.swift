//
//  Nuemorphic.swift
//  ProgressView-SwiftUI
//
//  Created by Pratik on 03/12/22.
//

import SwiftUI

struct NuemorphicRing: View {
    var progress: CGFloat
    
    var fillColor: Color = .purple
    var otherColor: Color = cellColor
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20)
                .foregroundColor(Color("lightShadow"))
                .shadow(color: Color("darkShadow"), radius: 10, x: 10, y: 10)
                .shadow(color: Color("lightShadow"), radius: 10, x: -10, y: -10)
                .padding(10)
            
            Circle()
                .fill(Color("lightShadow"))
                .shadow(color: Color("darkShadow"), radius: 10, x: 10, y: 10)
                .shadow(color: Color("lightShadow"), radius: 10, x: -10, y: -10)
                .padding(20 + 15)
            
            Circle()
                .trim(from: 0, to: progress)
                .stroke(style: StrokeStyle(lineWidth: 15, lineCap: .round))
                .foregroundColor(fillColor)
                .padding(7.5 + 20)
                .rotationEffect(.degrees(-90))
        }
    }
}


struct NuemorphicCircleButton: View {
    var progress: CGFloat
    
    let colors: [UIColor] = [.orange, .white, .cyan]
    
    var body: some View {
        GeometryReader { bounds in
            ZStack {
                Circle()
                    .trim(from: 0, to: 0.5)
                    .stroke(style: StrokeStyle(lineWidth: 7, lineCap: .round))
                    .foregroundStyle(AngularGradient(colors: [.orange, .white, .teal], center: .center, startAngle: .degrees(0), endAngle: .degrees(180)))
                    .padding(3.5)
                
                Circle()
                    .fill(Color.white)
                    .overlay {
                        Circle()
                            .fill(Color(uiColor: colors.intermediate(percentage: progress*100)))
                            .opacity(0.6)
                            .overlay {
                                Capsule()
                                    .fill(.black)
                                    .frame(width: 14, height: 5, alignment: .center)
                                    .offset(x: (bounds.size.width/2) - 32)
                            }
                    }
                    .padding(20)
                    .shadow(color: Color("darkShadow"), radius: 10, x: 0, y: 0)
                    .rotationEffect(.degrees(progressAngle()))
            }
            .rotationEffect(.degrees(180))
        }
    }
    
    private func progressAngle() -> Double {
        Double(180) * progress
    }
}

struct Nuemorphic_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            cellColor
                .ignoresSafeArea()
            NuemorphicCircleButton(progress: 0.3)
                .frame(width: 150, height: 150, alignment: .center)
        }
        .preferredColorScheme(.dark)
    }
}
