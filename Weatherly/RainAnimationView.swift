//
//  RainAnimationView.swift
//  Weatherly
//
//  Created by Krishay Gahlaut on 13/06/25.
//

import SwiftUI

struct RainAnimationView: View {
    @State private var animate = false

    var body: some View {
        ZStack {
            ForEach(0..<100) { drop in
                Rectangle()
                    .fill(Color.white.opacity(0.5))
                    .frame(width: 2, height: CGFloat.random(in: 10...20))
                    .position(
                        x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                        y: animate ? UIScreen.main.bounds.height + 20 : -20
                    )
                    .animation(
                        Animation.linear(duration: Double.random(in: 0.8...1.5))
                            .repeatForever(autoreverses: false)
                            .delay(Double.random(in: 0...1)),
                        value: animate
                    )
            }
        }
        .onAppear {
            animate = true
        }
        .ignoresSafeArea()
    }
}
