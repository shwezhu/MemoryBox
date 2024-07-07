//
//  PostView.swift
//  MemoryBox
//
//  Created by David Zhu on 2024-07-07.
//

import SwiftUI

import SwiftUI

struct PostView: View {
    let post: Post
    
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
        .shadow(radius: 2)
    }
    
    var postHeader: some View {
        HStack(alignment: .center) {
            Text(post.title)
                .font(.headline)
            
        }
    }
    
    var postContent: some View {
        VStack(alignment: .leading) {
            Text(post.content)
                .font(.body)
                .lineLimit(nil)
            
            if let imageURL = post.imageURL {
                AsyncImage(url: imageURL) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxHeight: 200)
                        .cornerRadius(8)
                } placeholder: {
                    ProgressView()
                }
            }
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
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

#Preview {
    PostView(post: MockData.boxes[0].posts[0])
}
