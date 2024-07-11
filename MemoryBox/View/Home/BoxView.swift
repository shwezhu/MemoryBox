//
//  BoxView.swift
//  MemoryBox
//
//  Created by David Zhu on 2024-07-05.
//

import SwiftUI

struct BoxView: View {
    let box: Box
    
    var body: some View {
        VStack(spacing: 10) {
            boxHeaderView
            boxFooterView
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.green, lineWidth: 1)
        )
    }
    
    private var boxHeaderView: some View {
        HStack(alignment: .center) {
            Text(box.name)
                .font(.headline)
                .lineLimit(1)
            Spacer()
            Text("\(box.postCount)")
                .font(.title2.bold())
        }
    }
    
    private var boxFooterView: some View {
        HStack {
            CollaboratorsView(users: box.collaborators)
            Spacer()
            privacyIcon
        }
    }
    
    private var privacyIcon: some View {
        Image(systemName: "lock.fill")
            .opacity(box.isPrivate ? 1 : 0)
    }
}

//#Preview {
//    BoxView(box: MockData.boxes[0])
//}
