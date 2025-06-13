//
//  SunAnimationView.swift
//  Weatherly
//
//  Created by Krishay Gahlaut on 13/06/25.
//
import SwiftUI

struct SunAnimationView: View {
    @State private var pulse = false

    var body: some View {
        ZStack {
            Circle()
                .fill(Color.yellow.opacity(0.3))
                .frame(width: 200, height: 200)
                .scaleEffect(pulse ? 1.3 : 1)
                .animation(Animation.easeInOut(duration: 2).repeatForever(), value: pulse)

            Image(systemName: "sun.max.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100)
                .foregroundColor(.yellow)
        }
        .onAppear {
            pulse = true
        }
        .ignoresSafeArea()
    }
}
