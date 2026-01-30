//
//  MatchMarkerView.swift
//  Assignment1
//
//  Created by Chitose on 1/27/26.
//

import SwiftUI


enum Match {
    case exact
    case inexact
    case nomatch
}

struct MatchMarkerView: View {
    // MARK: Data In
    let matchs: [Match]
    var col: Int {
        max(2, (matchs.count + 1) / 2)
    }
    
    // MARK: - Body
    var body: some View {
        HStack {
            ForEach(0..<col, id: \.self) { index in
                VStack {
                    drawMarker(peg: index * 2)
                    drawMarker(peg: index * 2 + 1)
                }
            }
        }
    }
    
    func drawMarker(peg: Int) -> some View {
        let exactCount = matchs.count { $0 == .exact }
        let foundCount = matchs.count { $0 != .nomatch }
        return Circle()
            .fill(exactCount > peg ? Color.primary : Color.clear)
            .strokeBorder(foundCount > peg ? Color.primary : Color.clear, lineWidth: 2)
            .aspectRatio(1, contentMode: .fit)
    }
}

struct MatchMarkerPreview: View {
    let matchs: [Match]
    var body: some View {
        HStack {
            ForEach(0..<matchs.count, id: \.self) { _ in
                Circle()
            }
            MatchMarkerView(matchs: matchs)
            if matchs.count < 6 {
                ForEach(0..<(6 - matchs.count), id: \.self) { _ in
                    Circle().opacity(0)
                }
            }
        }
        .padding()
    }
}


#Preview {
    VStack {
        MatchMarkerPreview(matchs: [.exact, .inexact, .nomatch, .exact, .exact, .inexact])
        MatchMarkerPreview(matchs: [.exact, .exact, .exact, .exact])
        MatchMarkerPreview(matchs: [.inexact, .inexact, .inexact])
        MatchMarkerPreview(matchs: [.nomatch, .nomatch, .nomatch, .nomatch, .nomatch])
    }
}
