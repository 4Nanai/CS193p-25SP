//
//  Code.swift
//  Assignment2
//
//  Created by Chitose on 1/30/26.
//


import Foundation

struct Code: Equatable {
    var pegs: [Peg]
    var kind: Kind
    
    init(kind: Kind, count: Int) {
        self.pegs = Array(repeating: Code.missingPeg, count: count)
        self.kind = kind
    }
    
    static var missingPeg: Peg = .clear
    
    enum Kind: Equatable  {
        case master
        case guess
        case attempt([Match])
        case unknown
    }
    
    mutating func randomize(from pegChoice: [Peg], for count: Int) {
        for index in 0..<count {
            pegs[index] = pegChoice.randomElement() ?? Code.missingPeg
        }
    }
    
    var matchs: [Match] {
        switch kind {
        case .attempt(let matchs): return matchs
        default: return []
        }
    }
    
    func match(against masterCode: Code) -> [Match] {
        var results = Array<Match>(repeating: .nomatch, count: pegs.count)
        var masterPegs = masterCode.pegs
        for index in pegs.indices.reversed() {
            if masterPegs.count > index, masterPegs[index] == pegs[index] {
                results[index] = .exact
                masterPegs.remove(at: index)
            }
        }
        
        for index in pegs.indices {
            if results[index] != .exact {
                if let matchIndex = masterPegs.firstIndex(of: pegs[index]) {
                    results[index] = .inexact
                    masterPegs.remove(at: matchIndex)
                }
            }
        }
        
        return results
    }
}