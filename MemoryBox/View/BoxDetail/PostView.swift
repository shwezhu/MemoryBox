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
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
            
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
    let spacing: CGFloat = 4
    let cornerRadius: CGFloat = 10

    var body: some View {
        GeometryReader { geometry in
            if imageURLs.count == 1 {
                // 单张图片时的布局
                singleImageView(url: imageURLs[0], size: geometry.size.width)
                    .frame(width: geometry.size.width, height: geometry.size.width)
                    .aspectRatio(1, contentMode: .fit)
            } else {
                // 多张图片时的网格布局
                let singleImageSize = calcSingleImageSize(for: geometry.size.width)
                // 第一个 spacing 指定水平距离, 第二个指定垂直距离.
                LazyVGrid(columns: [GridItem(.flexible(), spacing: spacing), GridItem(.flexible())], spacing: spacing) {
                    ForEach(imageURLs.prefix(4).indices, id: \.self) { index in
                        imageView(url: imageURLs[index], size: singleImageSize)
                    }
                }
                .frame(width: geometry.size.width, height: calculateGridHeight(imageCount: imageURLs.count, singleImageSize: singleImageSize))
            }
        }
        .scaledToFit()
    }
    
    private func calcSingleImageSize(for width: CGFloat) -> CGFloat {
        (width - spacing) / 2
    }
    
    private func calculateGridHeight(imageCount: Int, singleImageSize: CGFloat) -> CGFloat {
        switch imageCount {
        case 0:
            return 0
        case 1, 2:
            return singleImageSize
        default:
            return singleImageSize * 2 + spacing
        }
    }
    
    private func singleImageView(url: String, size: CGFloat) -> some View {
        AsyncImage(url: URL(string: url)) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size, height: size)
                    .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            case .failure:
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color.gray.opacity(0.3))
            @unknown default:
                EmptyView()
            }
        }
        .frame(width: size, height: size)
    }
    
    private func imageView(url: String, size: CGFloat) -> some View {
        AsyncImage(url: URL(string: url)) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size, height: size)
                    .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            case .failure:
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color.gray.opacity(0.3))
            @unknown default:
                EmptyView()
            }
        }
        .frame(width: size, height: size)
    }
}

#Preview {
    PostView(post: MockData.boxes[1].posts[1])
}
