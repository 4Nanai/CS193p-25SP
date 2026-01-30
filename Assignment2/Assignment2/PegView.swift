//
//  PegView.swift
//  Assignment2
//
//  Created by Chitose on 1/30/26.
//

import SwiftUI

struct PegView: View {
    // MARK: Data In
    let peg: Peg
    
    // MARK: - Body
    let pegShape = Circle()
    
    var body: some View {
        pegShape
            .fill(.clear)
            .overlay {
                switch peg {
                case .clear:
                    pegShape
                        .strokeBorder(.gray, lineWidth: 2)
                        .aspectRatio(1, contentMode: .fit)
                case .color(let name):
                    pegShape
                        .fill(Color(name: name) ?? .gray)
                case .emoji(let text):
                    Text(text)
                        .font(.system(size: 120))
                        .minimumScaleFactor(9/120)
                }
            }
            .contentShape(Circle())
    }
}

#Preview {
    PegView(peg: .emoji("🦊"))
}
