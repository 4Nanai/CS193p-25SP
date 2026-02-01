//
//  HintView.swift
//  Wordle
//
//  Created by Chitose on 1/31/26.
//

import SwiftUI

struct HintView: View {
    // MARK: - Body
    var body: some View {
        HStack {
            Spacer()
            HintContent(color: .exact, content: "Exact")
            Spacer()
            HintContent(color: .inexact, content: "Inexact")
            Spacer()
            HintContent(color: .nomatch, content: "No Match")
            Spacer()
        }
    }
}

struct HintContent: View {
    // MARK: Data In
    let color: Color
    let content: String
    
    // MARK: - Body
    var body: some View {
        HStack(spacing: 5) {
            Circle()
                .fill(color)
                .frame(width: 13)
                .aspectRatio(1, contentMode: .fit)
            Text(content)
                .font(.body)
        }
    }
}

#Preview {
    HintView()
}
