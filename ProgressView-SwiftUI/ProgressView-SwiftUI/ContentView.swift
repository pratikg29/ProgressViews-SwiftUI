//
//  ContentView.swift
//  ProgressView-SwiftUI
//
//  Created by Pratik on 23/11/22.
//

import SwiftUI

let bgColor = Color(uiColor: .systemGroupedBackground) //Color(white: 0.95)
let cellColor = Color(uiColor: .secondarySystemGroupedBackground) //Color.white

struct ContentView: View {
    @State private var progress: CGFloat = 0.3
    var body: some View {
        ZStack {
//            Color(white: 0.95)
            bgColor
                .ignoresSafeArea()
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150), spacing: 20, alignment: .center)],
                          alignment: .center,
                          spacing: 20,
                          pinnedViews: []) {
                    CellView {
                        RingProgressView(progress: progress)
                    }
                    
                    CellView {
                        CircularProgressView(progress: progress)
                    }
                    
                    CellView {
                        RingDashProgressView(progress: progress)
                    }
                    
                    CellView {
                        LoadingProgressView(progress: progress)
                    }
                    
                    CellView {
                        SimpleBarProgressView(progress: progress)
                            .frame(height: 30)
                    }
                    
                    CellView {
                        MilestoneProgressView(progress: progress)
                            .frame(height: 30)
                    }
                    
                    CellView {
                        NuemorphicRing(progress: progress)
                    }
                    
                    CellView {
                        NuemorphicCircleButton(progress: progress)
                    }
                }
            }
            .padding(.horizontal)
            
            VStack {
                Spacer()
                
                Slider(value: $progress, in: 0...1)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 20, style: .continuous).fill(cellColor))
                    .padding(.horizontal)
            }
        }
    }
}

struct CellView<Content: View>: View {
    let content: () -> Content
    var body: some View {
        content()
            .aspectRatio(1, contentMode: .fit)
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(cellColor)
            )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
    }
}
