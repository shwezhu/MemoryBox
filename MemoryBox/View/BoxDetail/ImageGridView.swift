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
    let cornerRadius: CGFloat = 10

    var body: some View {
        // GeometryReader用于获取父视图的尺寸信息
        GeometryReader { geometry in
            let singleImageSize = calcSingleImageSize(for: geometry.size.width)
            
            // 第一个 spacing 指定水平距离, 第二个指定垂直距离.
            LazyVGrid(columns: [GridItem(.flexible(), spacing: spacing), GridItem(.flexible())], spacing: spacing) {
                ForEach(post.imageURLs.prefix(4).indices, id: \.self) { index in
                    imageView(url: post.imageURLs[index], size: singleImageSize)
                }
            }
            // 设置网格的frame，宽度为可用宽度，高度根据图片数量动态计算
            .frame(width: geometry.size.width, height: calculateGridHeight(imageCount: post.imageURLs.count, singleImageSize: singleImageSize))
        }
        // 设置整个视图的宽高比为1:1
        .aspectRatio(1, contentMode: .fit)
    }
    
    private func calcSingleImageSize(for width: CGFloat) -> CGFloat {
        (width - spacing) / 2
    }
    
    private func calculateGridHeight(imageCount: Int, singleImageSize: CGFloat) -> CGFloat {
        switch imageCount {
        case 0:
            return 0
        case 1:
            return singleImageSize
        default:
            return singleImageSize * 2 + spacing
        }
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
