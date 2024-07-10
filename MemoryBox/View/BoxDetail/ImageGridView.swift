import SwiftUI

struct ImageGridView: View {
    let imageURLs: [String]
    let cornerRadius: CGFloat = 10
    
    var body: some View {
        if imageURLs.count == 1 {
            gridItem(url: imageURLs[0])
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                .scaledToFit()
        } else {
            LazyVGrid(columns: [.init(.adaptive(minimum: 120))]) {
                ForEach(imageURLs.prefix(4).indices, id: \.self) { index in
                    gridItem(url: imageURLs[index])
                        .scaledToFill()
                        .frame(minWidth: 0, minHeight: 0)
                        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                }
            }
        }
    }
    
    private func gridItem(url: String) -> some View {
        AsyncImage(url: URL(string: url)) { image in
            image
                .resizable()
        } placeholder: {
            ProgressView()
        }
    }
}
