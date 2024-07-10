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
        .background(Color.green)
        .cornerRadius(15)
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

struct CollaboratorsView: View {
    let users: [User]
    private let avatarSize: CGFloat = 20
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(users.prefix(2)) { user in
                Group {
                    if let url = user.avatarURL {
                        AsyncImage(url: url) { image in
                            image.resizable().scaledToFit()
                        } placeholder: {
                            placeholderView(name: user.name)
                        }
                    } else {
                        placeholderView(name: user.name)
                    }
                }
                .frame(width: avatarSize, height: avatarSize)
                .clipShape(Circle())
            }
            
            if users.count > 2 {
                Text("+\(users.count - 2)")
                    .font(.caption2)
                    .foregroundColor(.secondary)
                    .frame(width: avatarSize, height: avatarSize)
                    .background(Color.gray.opacity(0.2))
                    .clipShape(Circle())
            }
        }
    }
    
    private func placeholderView(name: String) -> some View {
        Text(name.prefix(1).uppercased())
            .font(.system(size: avatarSize * 0.6))
            .frame(width: avatarSize, height: avatarSize)
            .background(Color.gray.opacity(0.2))
    }
}

#Preview {
    BoxView(box: MockData.boxes[0])
}
