//
//  ContentView.swift
//  Timers
//
//  Created by Royal K on 2025-03-24.
//

import SwiftUI

struct ContentView: View {
    @State private var showTimer = false

    var body: some View {
        if showTimer {
            TimerView()
        } else {
            WelcomeView(showTimer: $showTimer)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
