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
        self.guess = Word(word: "Guesss", kind: .guess)
        self.attempts = []
    }
    
    mutating func attemptGuess() {
        let currentGuess = Word(word: self.guess.word, kind: .attempts)
        self.attempts.append(currentGuess)
    }
}

enum Kind {
    case master
    case guess
    case attempts
}

struct Word {
    let word: String
    let kind: Kind
    
    init(word: String, kind: Kind) {
        self.word = word
        self.kind = kind
    }
}
