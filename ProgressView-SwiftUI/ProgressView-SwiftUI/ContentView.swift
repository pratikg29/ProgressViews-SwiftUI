//
//  ContentView.swift
//  ProgressView-SwiftUI
//
//  Created by Pratik on 23/11/22.
//

import SwiftUI

struct ContentView: View {
    @State private var progress: CGFloat = 0.3
    var body: some View {
        VStack(spacing: 20) {
            SimpleBarProgressView(progress: progress)
                .frame(width: 200, height: 20, alignment: .center)
            RingProgressView(progress: progress)
                .frame(width: 100, height: 100, alignment: .center)
            CircularProgressView(progress: progress)
                .frame(width: 100, height: 100, alignment: .center)
            RingDashProgressView(progress: progress)
                .frame(width: 100, height: 100, alignment: .center)
            LoadingProgressView(progress: progress)
                .frame(width: 100, height: 100, alignment: .center)
            
            Slider(value: $progress, in: 0...1)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
