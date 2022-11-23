//
//  ProgressViews.swift
//  ProgressView-SwiftUI
//
//  Created by Pratik on 23/11/22.
//

import SwiftUI

struct SimpleBarProgressView: View {
    let progress: CGFloat
    
    private let bgColor = Color.purple.opacity(0.2)
    private let fillColor = Color.purple
    
    var body: some View {
        GeometryReader { bounds in
            Capsule(style: .circular)
                .fill(bgColor)
                .overlay {
                    HStack {
                        Capsule(style: .circular)
                            .fill(LinearGradient(colors: [fillColor, fillColor.opacity(0.5)], startPoint: .leading, endPoint: .trailing))
                            .frame(width: bounds.size.width * progress)
                        
                        Spacer(minLength: 0)
                    }
                }
                .clipShape(Capsule(style: .circular))
        }
    }
}


struct RingProgressView: View {
    let progress: CGFloat
    
    private let bgColor = Color.teal.opacity(0.2)
    private let fillColor = Color.teal
    
    var body: some View {
        Circle()
            .stroke(style: StrokeStyle(lineWidth: 15))
            .foregroundColor(bgColor)
            .overlay {
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(style: StrokeStyle(lineWidth: 15))
                    .foregroundStyle(AngularGradient(colors: [fillColor, fillColor.opacity(0.5)], center: .center))
            }
            .rotationEffect(.degrees(-90))
    }
}

struct CircularProgressView: View {
    let progress: CGFloat
    
    private let bgColor = Color.orange.opacity(0.2)
    private let fillColor = Color.orange
    
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
    
    private let bgColor = Color.blue.opacity(0.2)
    private let fillColor = Color.blue
    
    var body: some View {
        Circle()
            .stroke(style: StrokeStyle(lineWidth: 15, lineCap: .butt, miterLimit: 0, dash: [10, 5], dashPhase: 0))
            .foregroundColor(bgColor)
            .overlay {
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(style: StrokeStyle(lineWidth: 15, lineCap: .butt, miterLimit: 0, dash: [10, 5], dashPhase: 0))
                    .foregroundColor(fillColor)
            }
            .rotationEffect(.degrees(-90))
    }
}


struct LoadingProgressView: View {
    var progress: CGFloat
    
    @State var rotationAngle: Double = 0
    var fillColor: Color = .indigo
    var count: Int = 20
    
    var body: some View {
        GeometryReader { bounds in
            ZStack {
                ForEach(0..<count) { i in
                    Circle()
                        .fill(fillColor.opacity(0.2))
                        .frame(width: getDotSize(i), height: getDotSize(i), alignment: .center)
                        .offset(x: bounds.size.width / 2)
                        .rotationEffect(.degrees(.pi * 2 * Double(i * 3)))
                }
                
                
                ForEach(0..<count) { i in
                    Circle()
                        .fill(fillColor)
                        .frame(width: getDotSize(i), height: getDotSize(i), alignment: .center)
                        .offset(x: bounds.size.width / 2)
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
    
    @State private var count: Float = 3
    @State private var radius: CGFloat = 15
    @State private var lineWidth: CGFloat = 5
    @State private var progress: CGFloat = 0.5
    
    var body: some View {
        GeometryReader { bounds in
            VStack(spacing: 70) {
                MilestoneShape(count: Int(count), radius: radius)
                    .stroke(lineWidth: lineWidth)
                    .foregroundColor(.indigo.opacity(0.3))
                    .padding(.horizontal, lineWidth/2)
                    .frame(height: 100)
                    .overlay {
                        MilestoneShape(count: Int(count), radius: radius)
                            .stroke(lineWidth: lineWidth)
                            .foregroundColor(.indigo)
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
                
                controls
            }
        }
        .padding()
    }
    
    @ViewBuilder private var controls: some View {
        VStack(spacing: 30) {
            VStack(alignment: .leading) {
                Slider(value: $progress, in: 0...1)
                Text("Progress")
            }
            
            VStack(alignment: .leading) {
                Slider(value: $count, in: 3...7)
                Text("Count")
            }
            
            VStack(alignment: .leading) {
                Slider(value: $radius, in: 5...25)
                Text("Radius")
            }
            
            VStack(alignment: .leading) {
                Slider(value: $lineWidth, in: 2...30)
                Text("Line Width")
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
        MilestoneProgressView()
    }
}
