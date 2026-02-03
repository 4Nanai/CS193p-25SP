//
//  ContentView.swift
//  Wordle
//
//  Created by Chitose on 1/30/26.
//

import SwiftUI

struct WordleView: View {
    // MARK: Data Owned by Me
    @State var game = WordBreaker()
    
    // MARK: - Body
    var body: some View {
        VStack {
            WordRowView(word: game.masterWord)
            Divider()
                .padding(.vertical, 5)
            WordRowView(
                word: game.guess
            )
            if !game.attempts.isEmpty {
                Text("History:")
                    .font(.callout)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            ScrollView {
                ForEach(game.attempts.indices, id: \.self) { index in
                    WordRowView(word: game.attempts[index])
                }
            }
            Spacer()
            HintView()
            guessButton
            KeyBoardView()
        }
        .padding()
    }
    
    var guessButton: some View {
        Button {
            withAnimation {
                game.attemptGuess()
            }
        } label: {
            Text("Guess")
                .font(.title2)
                .padding(5)
        }
        .buttonStyle(.glassProminent)
    }
}

#Preview {
    WordleView()
}
