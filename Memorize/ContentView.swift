//
//  ContentView.swift
//  Memorize
//
//  Created by Yuriy Lutsenko on 19.11.2022.
//

import SwiftUI

struct ContentView: View {
    var emojis = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
    
    @State var emojiCount = 4
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 75, maximum: 100))]) {
                    ForEach(emojis[0..<emojiCount], id: \.self) {
                        CardView(content: "\($0)")
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
            Spacer()
            HStack {
                removeButton
                Spacer()
                addButton
            }
            .font(.largeTitle)
            .padding(.horizontal)
        }
        .padding(.horizontal)
    }
    
    var addButton: some View {
        Button(
            action: {
                if emojiCount < emojis.count {
                    emojiCount += 1
                }
            },
            label: {
                Image(systemName: "plus.circle")
            }
        )
    }
    
    var removeButton: some View {
        Button(
            action: {
                if emojiCount > 1 {
                    emojiCount -= 1
                }
            },
            label: {
                Image(systemName: "minus.circle")
            }
        )
    }
}

struct CardView: View {
    var content: String
    @State var isFaceUp: Bool = false
    
    var body: some View {
        let shape = RoundedRectangle(cornerRadius: 20.0)
        ZStack {
            if isFaceUp {
                shape.fill(.white)
                shape.strokeBorder(lineWidth: 3.0)
                    .foregroundColor(.red)
                Text(content).font(.largeTitle)
            } else {
                shape.fill(.red)
            }
        }.onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
        ContentView()
            .preferredColorScheme(.light)
    }
}
