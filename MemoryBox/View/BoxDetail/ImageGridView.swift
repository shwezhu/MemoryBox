import SwiftUI

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
                
                LazyVGrid(columns: [GridItem(.flexible(), spacing: spacing), GridItem(.flexible())], spacing: spacing) {
                    ForEach(imageURLs.prefix(4).indices, id: \.self) { index in
                        imageView(url: imageURLs[index], size: singleImageSize)
                    }
                }
                .frame(width: geometry.size.width, height: calculateGridHeight(imageCount: imageURLs.count, singleImageSize: singleImageSize))
            }
        }
        .aspectRatio(1, contentMode: .fit)
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
