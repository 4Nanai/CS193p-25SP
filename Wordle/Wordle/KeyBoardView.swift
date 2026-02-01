//
//  KeyBoardView.swift
//  Wordle
//
//  Created by Chitose on 1/31/26.
//

import SwiftUI

struct KeyBoardView: View {
    
    // MARK: - Body
    var body: some View {
        let firstRow = "QWERTYUIOP"
        let secondRow = "ASDFGHJKL"
        let thirdRow = "ZXCVBNM"
        
        return VStack {
            HStack {
                ForEach(
                    Array(firstRow.enumerated()),
                    id: \.offset
                ) { _, char in
                    keyButton(char)
                }
            }
            
            HStack {
                ForEach(
                    Array(secondRow.enumerated()),
                    id: \.offset
                ) { index, char in
                    keyButton(char)
                }
            }
            .padding(.horizontal)
            
            HStack {
                ForEach(
                    Array(thirdRow.enumerated()),
                    id: \.offset
                ) { _, char in
                    keyButton(char)
                }
            }
            .padding(.horizontal, 50)
        }
        
        func keyButton(_ char: Character) -> some View {
            Button {
                print("\(char) Pressed")
            } label: {
                Text(String(char))
                    .font(.system(size: 20, weight: .medium))
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(10)
            }
            .buttonStyle(.plain)
        }
    }
}

#Preview {
    KeyBoardView()
}
