//
//  WordRowView.swift
//  Wordle
//
//  Created by Chitose on 1/30/26.
//

import SwiftUI

struct WordRowView: View {
    // MARK: Data In
    let word: Word
    var matchs: [Match]? = nil
    
    // MARK: - Body
    var body: some View {
        HStack {
            ForEach(Array(word.word.enumerated()), id: \.offset) {
                index,
                char in
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(getBackground(for: index))
                    .aspectRatio(1, contentMode: .fit)
                    .overlay {
                        Text(String(char))
                            .font(.system(size: 80))
                            .minimumScaleFactor(0.1)
                    }
            }
        }
    }
    
    private func getBackground(for index: Int) -> Color {
        guard let matchs = matchs, matchs.indices.contains(index) else {
            return .nomatch
        }
        return matchs[index].getColor()
    }
}

enum Match {
    case exact
    case inexact
    case nomatch
    
    func getColor() -> Color {
        switch self {
        case .exact: return .exact
        case .inexact: return .inexact
        case .nomatch: return .nomatch
        }
    }
}

extension Color {
    static func gray(_ brightness: CGFloat) -> Color {
        Color(hue: 148/360, saturation: 0, brightness: brightness)
    }
    static func green(_ brightness: CGFloat) -> Color {
        Color(hue: 120/360, saturation: 1.0, brightness: brightness)
    }
    static func yellow(_ brightness: CGFloat) -> Color {
        Color(hue: 60/360, saturation: 1.0, brightness: brightness)
    }
    
    static let nomatch = gray(0.75)
    static let inexact = yellow(0.85)
    static let exact = green(0.8)
}

#Preview {
    WordRowView(
        word: Word(word: "Hello", kind: .master),
        matchs: [.exact, .inexact, .exact, .nomatch]
    )
    .padding()
}
