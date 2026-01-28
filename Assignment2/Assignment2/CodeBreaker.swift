//
//  CodeBreaker.swift
//  Assignment2
//
//  Created by Chitose on 1/27/26.
//

import SwiftUI

struct CodeBreaker {
    let masterCode: Code
    let guess: Code
    let attempts: [Code]
    let pegChoices: [Peg]
}

struct Code {
    let pegs: [Peg]
    
    enum Kind {
        case master
        case guess
        case attempt
        case missing
    }
}

typealias Peg = Color
