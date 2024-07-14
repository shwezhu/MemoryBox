//
//  AsyncImage.swift
//  MemoryBox
//
//  Created by David Zhu on 2024-07-10.
//

import SwiftUI

struct CustomAsyncImageView: View {
    let url: String
    
    var body: some View {
        AsyncImage(url: URL(string: url)) { image in
            image
                .resizable()
        } placeholder: {
            ProgressView()
        }
    }
}
