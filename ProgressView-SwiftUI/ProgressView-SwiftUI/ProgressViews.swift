//
//  ProgressViews.swift
//  ProgressView-SwiftUI
//
//  Created by Pratik on 23/11/22.
//

import SwiftUI

struct SimpleBarProgressView: View {
    let progress: CGFloat
    
    private let bgColor = Color.green.opacity(0.2)
    private let fillColor = Color.green
    
    var body: some View {
        VStack {
            GeometryReader { bounds in
                Capsule(style: .circular)
                    .fill(bgColor)
                    .overlay {
                        HStack {
                            Capsule(style: .circular)
                                .fill(fillColor)
                                .frame(width: bounds.size.width * progress)
                            
                            Spacer(minLength: 0)
                        }
                    }
                    .clipShape(Capsule(style: .circular))
            }
            .frame(height: 15)
        }
    }
}


struct RingProgressView: View {
    let progress: CGFloat
    
    private let bgColor = Color.orange.opacity(0.2)
    private let fillColor = Color.orange
    
    var body: some View {
        Circle()
            .stroke(style: StrokeStyle(lineWidth: 40))
            .foregroundColor(bgColor)
            .overlay {
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(style: StrokeStyle(lineWidth: 40))
                    .foregroundStyle(AngularGradient(colors: [fillColor, fillColor.opacity(0.5)], center: .center))
            }
            .rotationEffect(.degrees(-90))
            .clipShape(Circle())
    }
}

struct CircularProgressView: View {
    let progress: CGFloat
    
    private let bgColor = Color.teal.opacity(0.2)
    private let fillColor = Color.teal
    
    var body: some View {
        Circle()
            .fill(bgColor)
            .overlay {
                FilledCircleShape(progress: progress)
                    .fill(AngularGradient(colors: [fillColor, fillColor.opacity(0.5)], center: .center))
                    .rotationEffect(.degrees(-90))
            }
    }
    
    struct FilledCircleShape: Shape {
        var progress: Double
        
        func path(in rect: CGRect) -> Path {
            var path = Path()
            
            let center = CGPoint(x: rect.midX, y: rect.midY)
            
            path.move(to: CGPoint(x: rect.maxX, y: rect.midY))
            path.addArc(center: center, radius: rect.width/2, startAngle: .degrees(0), endAngle: .degrees((360*progress)), clockwise: false)
            path.addLine(to: center)
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
            return path
        }
    }
}

struct RingDashProgressView: View {
    let progress: CGFloat
    
    private let bgColor = Color("dashRing").opacity(0.2)
    private let fillColor = Color("dashRing")
    
    var body: some View {
        Circle()
            .stroke(style: StrokeStyle(lineWidth: 50, lineCap: .butt, miterLimit: 0, dash: [10, 5], dashPhase: 0))
            .foregroundColor(bgColor)
            .overlay {
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(style: StrokeStyle(lineWidth: 50, lineCap: .butt, miterLimit: 0, dash: [10, 5], dashPhase: 0))
                    .foregroundColor(fillColor)
            }
            .rotationEffect(.degrees(-90))
            .clipShape(Circle())
    }
}


struct LoadingProgressView: View {
    var progress: CGFloat
    
    @State var rotationAngle: Double = 0
    var fillColor: Color = .red
    var count: Int = 20
    
    var body: some View {
        GeometryReader { bounds in
            ZStack {
                ForEach(0..<count) { i in
                    Circle()
                        .fill(fillColor.opacity(0.2))
                        .frame(width: getDotSize(i), height: getDotSize(i), alignment: .center)
                        .offset(x: (bounds.size.width / 2) - 10)
                        .rotationEffect(.degrees(.pi * 2 * Double(i * 3)))
                }
                
                
                ForEach(0..<count) { i in
                    Circle()
                        .fill(fillColor)
                        .frame(width: getDotSize(i), height: getDotSize(i), alignment: .center)
                        .offset(x: (bounds.size.width / 2) - 10)
                        .rotationEffect(.degrees(.pi * 2 * Double(i * 3)))
                        .opacity(CGFloat(i) < CGFloat(count) * progress ? 1 : 0)
                }
            }
            .frame(width: bounds.size.width, height: bounds.size.height, alignment: .center)
            .rotationEffect(.degrees(-90))
        }
    }
    
    private func getDotSize(_ index: Int) -> CGFloat {
        CGFloat(index)
    }
}

struct MilestoneProgressView: View {
    
    var progress: CGFloat
    private var count: Float = 3
    private var radius: CGFloat = 10
    private var lineWidth: CGFloat = 8
    private var color = Color("milestone")
    
    init(progress: CGFloat) {
        self.progress = progress
    }
    
    var body: some View {
        GeometryReader { bounds in
            VStack(spacing: 70) {
                MilestoneShape(count: Int(count), radius: radius)
                    .stroke(lineWidth: lineWidth)
                    .foregroundColor(color.opacity(0.3))
                    .padding(.horizontal, lineWidth/2)
                    .overlay {
                        MilestoneShape(count: Int(count), radius: radius)
                            .stroke(lineWidth: lineWidth)
                            .foregroundColor(color)
                            .padding(.horizontal, lineWidth/2)
                            .mask(
                                HStack {
                                    Rectangle()
                                    
                                        .frame(width: bounds.size.width * progress, alignment: .leading)
                                    Spacer(minLength: 0)
                                }
                            )
                    }
                    .padding(.horizontal, lineWidth/2)
            }
        }
    }
    
    struct MilestoneShape: Shape {
        let count: Int
        let radius: CGFloat
        
        func path(in rect: CGRect) -> Path {
            var path = Path()
            
            path.move(to: CGPoint(x: 0, y: rect.midY))
            
            var maxX: CGFloat = 0
            let remainingSpace: CGFloat = rect.width - (CGFloat(count)*radius*2)
            let lineLength: CGFloat = remainingSpace / CGFloat(count - 1)
            
            for i in 1...count {
                path.addEllipse(in: CGRect(origin: CGPoint(x: maxX, y: rect.midY - radius), size: CGSize(width: radius*2, height: radius*2)))
                maxX += radius*2
                path.move(to: CGPoint(x: maxX, y: rect.midY))
                if i != count {
                    maxX += lineLength
                    path.addLine(to: CGPoint(x: maxX, y: rect.midY))
                }
            }
            
            return path
        }
    }
}





struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
