//
//  PostView.swift
//  MemoryBox
//
//  Created by David Zhu on 2024-07-07.
//

import SwiftUI

struct PostView: View {
    // MARK: - Properties
    let post: Post
    let maxImagesToShow = 4
    @State private var showMenu = false
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            headerView
            contentView
            footerView
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(10)
    }
    
    // MARK: - Subviews
    
    /// Header view containing the post title and menu
    private var headerView: some View {
        HStack(alignment: .center) {
            Text(post.title)
                .font(.headline)
                .lineLimit(2)
            
            Spacer()
            
            Menu {
                menuContent
            } label: {
                Image(systemName: "ellipsis")
                    .foregroundColor(.secondary)
                    .frame(width: 44, height: 44) // 增加点击区域
            }
        }
        .padding(.bottom, 5)
    }
    
    /// Content view containing the post text and images
    private var contentView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(post.content)
                .font(.body)
            
            if !post.imageURLs.isEmpty {
                ImageGridView(imageURLs: Array(post.imageURLs.prefix(maxImagesToShow)))
            }
        }
    }
    
    /// Footer view containing author name and post date
    private var footerView: some View {
        HStack(alignment: .center) {
            Text(post.creator.name)
                .font(.caption)
                .foregroundColor(.secondary)
            Spacer()
            Text(formatDate(post.createdAt))
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
    
    // MARK: - Menu Content
    
    /// Menu options for the post
    private var menuContent: some View {
        Group {
            Button(action: onEdit) {
                Label("Edit", systemImage: "pencil")
            }
            
            Button(action: onFavorite) {
                Label("Favorite", systemImage: "heart")
            }
            
            Divider()
            
            Button(role: .destructive, action: onDelete) {
                Label("Delete", systemImage: "trash")
            }
        }
    }
    
    // MARK: - Helper Methods
    
    /// Formats the date for display
    /// - Parameter date: The date to format
    /// - Returns: A formatted string representation of the date
    private func formatDate(_ date: Date) -> String {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: date, to: Date())
        let formatter = DateFormatter()
        
        if let day = components.day {
            switch day {
            case 0:
                return "Today at " + formatter.string(from: date, format: "h:mm a")
            case 1:
                return "Yesterday at " + formatter.string(from: date, format: "h:mm a")
            default:
                return formatter.string(from: date, format: "MMM d, yyyy 'at' h:mm a")
            }
        }
        
        return formatter.string(from: date, format: "MMM d, yyyy 'at' h:mm a")
    }
    
    // MARK: - Action Methods
    
    private func onEdit() {
        // Implement edit action
    }
    
    private func onFavorite() {
        // Implement favorite action
    }
    
    private func onDelete() {
        // Implement delete action
    }
}

// MARK: - Extensions

extension DateFormatter {
    func string(from date: Date, format: String) -> String {
        self.dateFormat = format
        return self.string(from: date)
    }
}
//
//#Preview {
//    PostView(post: MockData.boxes[1].posts[0])
//}
