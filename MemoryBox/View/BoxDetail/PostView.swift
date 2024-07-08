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
            postHeader
                .padding(.bottom, 5)
            postContent
            postFooter
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(10)
    }
    
    var postHeader: some View {
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
    
    var postContent: some View {
        VStack(alignment: .leading) {
            Text(post.content)
                .font(.body)
            ImageGridView(post: post)
        }
    }
    
    var postFooter: some View {
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

#Preview {
    PostView(post: MockData.boxes[0].posts[0])
}
