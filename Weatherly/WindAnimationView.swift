//
//  WindAnimationView.swift
//  Weatherly
//
//  Created by Krishay Gahlaut on 13/06/25.
//

import SwiftUI

struct WindAnimationView: View {
    @State private var offsetX: CGFloat = -300

    var body: some View {
        ZStack {
            ForEach(0..<5) { i in
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.white.opacity(0.4))
                    .frame(width: 80, height: 4)
                    .offset(x: offsetX + CGFloat(i) * 50, y: CGFloat(i) * 40 - 100)
                    .animation(Animation.linear(duration: 4).repeatForever(autoreverses: false), value: offsetX)
            }
        }
        .onAppear {
            offsetX = UIScreen.main.bounds.width + 200
        }
        .ignoresSafeArea()
    }
}
