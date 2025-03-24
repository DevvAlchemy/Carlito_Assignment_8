//
//  TimerView.swift
//  Timers
//
//  Created by Royal K on 2025-03-24.
//

import SwiftUI

struct TimerView: View {
    @State private var timeElapsed: TimeInterval = 0
    @State private var timer: Timer? = nil
    @State private var isRunning = false
    @State private var lapTimes: [TimeInterval] = []

    var body: some View {
        VStack(spacing: 25) {
            Text("Timer")
                .font(.largeTitle)
                .bold()
                .padding(.top)

            // timer display
            ZStack {
                Circle()
                    .stroke(lineWidth: 15)
                    .opacity(0.3)
                    .foregroundColor(.orange)

                Circle()
                    .trim(from: 0.0, to: min(CGFloat(timeElapsed.truncatingRemainder(dividingBy: 60)) / 60, 1.0))
                    .stroke(style: StrokeStyle(lineWidth: 15, lineCap: .round, lineJoin: .round))
                    .foregroundColor(.orange)
                    .rotationEffect(Angle(degrees: 270))
                    .animation(.linear, value: timeElapsed)

                VStack {
                    Text(formattedTime(timeElapsed))
                        .font(.system(size: 45, weight: .bold, design: .monospaced))
                        .monospacedDigit()
                }
            }
            .frame(width: 300, height: 300)
            .padding()

            // Timer controls
            HStack(spacing: 30) {
                Button(action: {
                    if isRunning {
                        pauseTimer()
                    } else {
                        startTimer()
                    }
                }) {
                    Image(systemName: isRunning ? "pause.circle.fill" : "play.circle.fill")
                        .font(.system(size: 70))
                        .foregroundColor(isRunning ? .orange : .green)
                }

                Button(action: {
                    lapTimes.insert(timeElapsed, at: 0)
                }) {
                    Image(systemName: "stopwatch.fill")
                        .font(.system(size: 70))
                        .foregroundColor(.blue)
                }

                Button(action: resetTimer) {
                    Image(systemName: "arrow.counterclockwise.circle.fill")
                        .font(.system(size: 70))
                        .foregroundColor(.red)
                }
            }
            .padding()

            // Lap times list
            if !lapTimes.isEmpty {
                Text("Lap Times")
                    .font(.headline)
                    .padding(.top)

                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(0..<lapTimes.count, id: \.self) { index in
                            HStack {
                                Text("Lap \(lapTimes.count - index)")
                                    .fontWeight(.medium)
                                Spacer()
                                Text(formattedTime(lapTimes[index]))
                                    .monospacedDigit()
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 5)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                        }
                    }
                    .padding(.horizontal)
                }
                .frame(maxHeight: 200)
            }

            Spacer()
        }
        .padding()
    }

    private func startTimer() {
        isRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
            timeElapsed += 0.01
        }
    }

    private func pauseTimer() {
        isRunning = false
        timer?.invalidate()
        timer = nil
    }

    private func resetTimer() {
        pauseTimer()
        timeElapsed = 0
        lapTimes = []
    }

    private func formattedTime(_ timeInterval: TimeInterval) -> String {
        let minutes = Int(timeInterval) / 60
        let seconds = Int(timeInterval) % 60
        let hundredths = Int((timeInterval.truncatingRemainder(dividingBy: 1)) * 100)

        return String(format: "%02d:%02d.%02d", minutes, seconds, hundredths)
    }
}

#Preview {
    TimerView()
}
