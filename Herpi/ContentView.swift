//
//  ContentView.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 09.06.25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text(L.Main.test)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
