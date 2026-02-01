//
//  ContentView.swift
//  Wordle
//
//  Created by Chitose on 1/30/26.
//

import SwiftUI

struct WordleView: View {
    
    // MARK: - Body
    var body: some View {
        VStack {
            WordRowView(word: "hello")
            Divider()
                .padding(.vertical, 5)
            WordRowView(word: "guess", matchs: [.exact, .inexact, .exact, .nomatch, .nomatch])
            Spacer()
            HintView()
            guessButton
            KeyBoardView()
        }
        .padding()
    }
    
    var guessButton: some View {
        Button {
            print("Guess")
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
