//
//  WordBreaker.swift
//  Wordle
//
//  Created by Chitose on 2/2/26.
//

import Foundation

struct WordBreaker {
    var masterWord: Word
    var guess: Word
    var attempts: [Word] = []
    
    init(masterWord: Word, guess: Word) {
        self.masterWord = masterWord
        self.guess = guess
        self.attempts = []
    }
    
    init() {
        self.masterWord = Word(word: "Master", kind: .master)
        self.guess = Word(word: "Handle", kind: .guess)
        self.attempts = []
    }
    
    mutating func attemptGuess() {
        let currentGuess = Word(
            word: self.guess.word,
            kind: .attempts(findMatches())
        )
        self.attempts.append(currentGuess)
    }
    
    private func findMatches() -> [Match] {
        var result = Array(
            repeating: Match.nomatch,
            count: masterWord.word.count
        )
        var masterCharArray = Array(masterWord.word)
        for (index, char) in guess.word.reversed().enumerated() {
            let forwardIndex = guess.word.count - index - 1
            if forwardIndex < masterCharArray.count, char == masterCharArray[forwardIndex] {
                result[forwardIndex] = .exact
                masterCharArray.remove(at: forwardIndex)
            }
        }
        for (index, char) in guess.word.enumerated() {
            if result[index] != .exact, let findIndex = masterCharArray.firstIndex(
                of: char
            ) {
                result[index] = .inexact
                masterCharArray.remove(at: findIndex)
            }
        }
        return result
    }
}

enum Kind {
    case master
    case guess
    case attempts([Match])
}

struct Word {
    let word: String
    let kind: Kind
    
    init(word: String, kind: Kind) {
        self.word = word
        self.kind = kind
    }
}
