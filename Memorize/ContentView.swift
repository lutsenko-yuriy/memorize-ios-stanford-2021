//
//  ContentView.swift
//  Memorize
//
//  Created by Yuriy Lutsenko on 19.11.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        return ZStack {
            RoundedRectangle(cornerRadius: 20.0)
                .stroke(lineWidth: 3.0)
                .foregroundColor(.red)
            
            Text("Hello world!")
                .foregroundColor(.orange)
        }
        .padding(.horizontal)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
