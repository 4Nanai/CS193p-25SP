//
//  CodeBreaker.swift
//  Assignment2
//
//  Created by Chitose on 1/27/26.
//

import Foundation

struct CodeBreaker {
    var masterCode: Code
    var guess: Code
    var attempts: [Code] = []
    var pegChoices: [Peg]
    
    var gameMode: GameMode
    
    let initMode: GameMode
    let initSet: [Peg]
    
    // Configurable peg count
    var pegCount: Int
    
    init(pegChoices: [Peg], pegCount: Int, mode gameMode: GameMode) {
        self.pegChoices = pegChoices
        
        // Init game state
        self.initSet = pegChoices
        self.initMode = gameMode
        self.gameMode = gameMode
        
        // Configurable pegCount
        self.pegCount = pegCount
        self.masterCode = Code(kind: .master, count: pegCount)
        self.guess = Code(kind: .guess, count: pegCount)
        masterCode.randomize(from: pegChoices, for: pegCount)
        print(masterCode)
    }
    
    init() {
        let gameMode = GameMode.random()
        self.init(
            pegChoices: gameMode.theme,
            pegCount: Int.random(in: 3...6),
            mode: gameMode
        )
    }
    
    mutating func changeGuessPeg(at index: Int) {
        let currentPeg = guess.pegs[index]
        if let currentIndex = pegChoices.firstIndex(of: currentPeg) {
            let nextPeg = pegChoices[(currentIndex + 1) % pegChoices.count]
            guess.pegs[index] = nextPeg
//            print(nextPeg.description)
        }
        else {
            guess.pegs[index] = pegChoices.first ?? Code.missingPeg
        }
    }
    
    mutating func attemptGuess() {
        // Ignore attempt with no pegs chosen
        if guess.pegs == Array(repeating: Code.missingPeg, count: guess.pegs.count) {
            return
        }
        
        var newAttempt = guess
        newAttempt.kind = Code.Kind.attempt(guess.match(against: masterCode))
        
        // Ignore attempt already tried
        if (attempts.firstIndex(of: newAttempt) != nil) {
            return
        }
        
        attempts.append(newAttempt)
    }
    
    mutating func restartGame() {
        let randomCount = Int.random(in: 3...6)
        self.gameMode = self.gameMode.nextGame()
        if self.gameMode == self.initMode {
            self.pegChoices = self.initSet
        } else {
            self.pegChoices = gameMode.theme
        }
            
        self.masterCode = Code(kind: .master, count: randomCount)
        self.masterCode.randomize(from: self.pegChoices, for: randomCount)
        self.guess = Code(kind: .guess, count: randomCount)
        attempts = []
        print("MasterCode:", masterCode)
    }
}



enum Peg: Equatable {
    case color(String)
    case emoji(String)
    case clear
    
    var description: String {
        switch self {
        case .color(let name): return name
        case .emoji(let text): return text
        case .clear: return "clear"
        }
    }
}

enum GameMode: CaseIterable {
    case color
    case face
    case earth
    
    var theme: [Peg] {
        switch self {
        case .color:
            return [
                .color("red"), .color("blue"), .color("yellow"),
                    .color("green"), .color("purple"), .color("orange")
            ]
        case .face:
            return [
                .emoji("😑"), .emoji("😁"), .emoji("😉"),
                    .emoji("😩"), .emoji("😅"), .emoji("😇")
            ]
        case .earth:
            return [
                .emoji("🐶"),.emoji("🐱"), .emoji("🐭"),
                    .emoji("🐹"), .emoji("🐰"), .emoji("🦊")
            ]
        }
    }
    
    static func random() -> GameMode {
        GameMode.allCases.randomElement() ?? .face
    }
    
    func nextGame() -> GameMode {
        GameMode.allCases.filter {
            $0 != self
        }.randomElement() ?? self
    }
}
