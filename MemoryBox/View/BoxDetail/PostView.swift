//
//  PostView.swift
//  MemoryBox
//
//  Created by David Zhu on 2024-07-07.
//

import SwiftUI

struct PostView: View {
    let post: Post
    let maxImagesToShow = 4
    @State private var showMenu = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .center) {
                Text(post.title)
                    .font(.headline)
                
                Spacer()
                
                Menu {
                    menuContent
                } label: {
                    Image(systemName: "ellipsis")
                        .foregroundColor(.secondary)
                        .padding()
                }
            }
            .padding(.bottom, 5)
            
            // MARK: - Content
            Text(post.content)
                .font(.body)
            ImageGridView(imageURLs: post.imageURLs)
            
            // MARK: - Footer
            HStack(alignment: .center) {
                Text(post.author.name)
                    .font(.caption)
                    .foregroundColor(.secondary)
                Spacer()
                Text(formatDate(post.createdAt))
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .cornerRadius(10)
    }
    
    var menuContent: some View {
        VStack() {
            Button(action: {
                // Add edit action
            }) {
                Label("Edit", systemImage: "pencil")
            }
            
            Button(action: {
                // Add edit action
            }) {
                Label("Favorite", systemImage: "heart")
            }
            
            Divider()
            
            Button(role: .destructive , action: onDelete) {
                Label("Delete", systemImage: "trash")
            }
        }
    }
    
    private func formatDate(_ date: Date) -> String {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: date, to: Date())
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        
        if let day = components.day {
            if day == 0 {
                return "Today at " + formatter.string(from: date)
            } else if day == 1 {
                return "Yesterday at " + formatter.string(from: date)
            }
        }
        
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
    private func onDelete() {
        
    }
}

struct ImageGridView: View {
    let imageURLs: [String]
    let cornerRadius: CGFloat = 10
    
    var body: some View {
        if imageURLs.count == 1 {
            gridItem(url: imageURLs[0])
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                .scaledToFit()
        } else {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                ForEach(imageURLs.prefix(4).indices, id: \.self) { index in
                    GeometryReader { geo in
                        gridItem(url: imageURLs[index])
                    }
                    .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                    .scaledToFit()
                }
            }
        }
    }
    
    private func gridItem(url: String) -> some View {
        AsyncImage(url: URL(string: url)) { image in
            image
                .resizable()
                .scaledToFill()
        } placeholder: {
            ProgressView()
        }
    }
}

#Preview {
    PostView(post: MockData.boxes[0].posts[0])
}
