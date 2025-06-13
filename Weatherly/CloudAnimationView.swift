//
//  CloudAnimationView.swift
//  Weatherly
//
//  Created by Krishay Gahlaut on 13/06/25.
//
import SwiftUI

struct CloudAnimationView: View {
    @State private var cloudOffset: CGFloat = -200

    var body: some View {
        ZStack {
            ForEach(0..<5) { i in
                Image(systemName: "cloud.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150)
                    .opacity(0.3)
                    .offset(x: cloudOffset + CGFloat(i) * 80, y: CGFloat(i % 3) * 40 - 80)
                    .animation(Animation.linear(duration: 20).repeatForever(autoreverses: false), value: cloudOffset)
            }
        }
        .onAppear {
            cloudOffset = UIScreen.main.bounds.width + 200
        }
        .foregroundColor(.white)
        .ignoresSafeArea()
    }
}
