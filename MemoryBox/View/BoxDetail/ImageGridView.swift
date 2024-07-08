//
//  ImageGridView.swift
//  MemoryBox
//
//  Created by David Zhu on 2024-07-08.
//

import SwiftUI

struct ImageGridView: View {
    let post: Post
    let spacing: CGFloat = 4 // 图片之间的间距
    let cornerRadius: CGFloat = 10 // 圆角大小
    let colums = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        GeometryReader { geometry in
            let dimension = calcDimension(for: geometry.size.width)
            
            LazyVGrid(columns: colums, spacing: spacing) {
                ForEach(post.imageURLs.prefix(4).indices, id: \.self) { index in
                    imageView(url: post.imageURLs[index], size: dimension)
                }
            }
            .frame(height: post.imageURLs.count > 0 ? (post.imageURLs.count == 1 ? dimension : dimension * 2 + spacing) : 0)
        }
        .aspectRatio(1, contentMode: .fit)
    }
    
    private func calcDimension(for width: CGFloat) -> CGFloat {
        (width - spacing) / 2
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
