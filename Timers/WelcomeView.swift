//
//  WelcomeView.swift
//  Timers
//
//  Created by Royal K on 2025-03-24.
//

import SwiftUI

struct WelcomeView: View {
    @State private var progress: CGFloat = 0.0
    @Binding var showTimer: Bool

    var body: some View {
        VStack(spacing: 30) {
            Text("Welcome to Timer App")
                .font(.largeTitle)
                .bold()
                .padding(.bottom, 20)

            Image(systemName: "timer")
                .font(.system(size: 80))
                .foregroundColor(.orange)
                .padding(.bottom, 40)

            ProgressBarView(progress: progress)
                .frame(width: 300, height: 20)
                .padding(.bottom, 20)

            Button(action: {
                // Start the progress animation
                withAnimation {
                    progress = 1.0
                }

                // After animation completes, show timer
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.7) {
                    showTimer = true
                }
            }) {
                Text("Start Using App")
                    .font(.headline)
                    .padding()
                    .frame(width: 250)
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(15)
                    .shadow(radius: 3)
            }
            .padding(.top, 20)
        }
        .padding()
        .onAppear {
            // Reset progress when view appears
            progress = 0.0
        }
    }
}
