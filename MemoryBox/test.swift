import SwiftUI

struct ContentView1: View {
    let imageURL = "https://pub-2a6758f3b2d64ef5bb71ba1601101d35.r2.dev/blogs/2024/07/e19fa93e872678fb08908fd096f87647.jpg"
    
    var body: some View {
        VStack {
            Text("Hello, world, Hello, world")
                .fixedSize()

                .border(Color.red)
                .padding(8)
        }
        .frame(width: 100, height: 200)
        .border(Color.green, width: 5)
    }
    
    private func imageView(url: String) -> some View {
        AsyncImage(url: URL(string: url)) { image in
            image
                .resizable()
                .aspectRatio(1, contentMode: .fill)
        } placeholder: {
            ProgressView()
        }
    }
}

struct ImageGridView1: View {
    let imageURLs = ["https://pub-2a6758f3b2d64ef5bb71ba1601101d35.r2.dev/blogs/2024/07/64e19f21acd27f6429b66d96365358f9.jpg",
        "https://pub-2a6758f3b2d64ef5bb71ba1601101d35.r2.dev/blogs/2024/07/aefa5f11046572011338797e0365a566.jpg"]
    let cornerRadius: CGFloat = 10

    var body: some View {
        VStack {
            LazyVGrid(columns: [.init(.flexible()), .init(.flexible())]) {
                ForEach(imageURLs.prefix(4).indices, id: \.self) { index in
                    gridItem(url: imageURLs[index])
                        .border(Color.green, width: 5)
                }
            }
            .padding()
        }
    }
    
    private func gridItem(url: String) -> some View {
        AsyncImage(url: URL(string: url)) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(minWidth: 0, minHeight: 0)
                .clipped()
        } placeholder: {
            ProgressView()
        }
    }
}

#Preview {
    ImageGridView1()
}
