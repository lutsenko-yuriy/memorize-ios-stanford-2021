//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Yuriy Lutsenko on 19.11.2022.
//

import SwiftUI

@main
struct MemorizeApp: App {
    let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
