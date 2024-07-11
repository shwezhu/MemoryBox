//
//  CollaboratorsView.swift
//  MemoryBox
//
//  Created by David Zhu on 2024-07-10.
//

import SwiftUI

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
