//
//  BoxGridView.swift
//  MemoryBox
//
//  Created by David Zhu on 2024-07-06.
//

import SwiftUI

struct BoxGridView: View {
    let boxes: [Box]
    let columns: [GridItem] = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(boxes) { box in
                    NavigationLink(destination: BoxDetailView(boxName: box.name, posts: box.posts)) {
                        BoxView(box: box)
                    }
                    .buttonStyle(PlainButtonStyle())  // Prevent the default behavior of NavigationLink (e.g., blue color)
                }
            }
        }
        .padding(10)
    }
}

#Preview {
    BoxGridView(boxes: MockData.boxes)
}
