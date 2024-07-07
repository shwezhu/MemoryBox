//
//  BoxView.swift
//  MemoryBox
//
//  Created by David Zhu on 2024-07-05.
//

import SwiftUI

struct BoxView: View {
    let box: Box
    
    var body: some View {
        VStack(spacing: 10) {
            boxHeaderView
            boxFooterView
        }
        .padding()
        .background(Color.green)
        .cornerRadius(15)
    }
    
    private var boxHeaderView: some View {
        HStack(alignment: .center) {
            Text(box.name)
                .bold()
                .lineLimit(1)
            Spacer()
            Text("\(box.postCount)")
                .font(.title2)
                .bold()
        }
    }
    
    private var boxFooterView: some View {
        HStack {
            collaboratorsView
            Spacer()
            privacyIcon
        }
    }
    
    // 将协作者视图抽取为单独的计算属性，提高可读性
    private var collaboratorsView: some View {
        HStack {
            ForEach(box.collaborators.prefix(2)) { collaborator in
                CircularAvatarView(user: collaborator)
            }
            if box.collaborators.count > 2 {
                Text("+\(box.collaborators.count - 2)") // 显示更多协作者的具体数量
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    }
    
    // 将隐私图标抽取为单独的计算属性，提高可读性
    private var privacyIcon: some View {
        Image(systemName: "lock.fill")
            .opacity(box.isPrivate ? 1 : 0)
            .accessibility(label: Text(box.isPrivate ? "Private" : "Public")) // 添加无障碍标签
    }
}

struct CircularAvatarView: View {
    let user: User
    
    var body: some View {
        Group {
            if let url = user.avatarURL {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .success(let image):
                        image.resizable().scaledToFill()
                    case .failure(_):
                        placeholderView
                    case .empty:
                        ProgressView() // 添加加载指示器
                    @unknown default:
                        placeholderView
                    }
                }
            } else {
                placeholderView
            }
        }
        .frame(width: 20, height: 20)
        .clipShape(Circle())
    }
    
    private var placeholderView: some View {
        Text(name)
            .font(.caption2) // 使用更小的字体以确保填充整个圆形
            .frame(width: 20, height: 20)
            .background(Color.gray.opacity(0.2))
    }
    
    private var name: String {
        String(user.name.prefix(1).uppercased()) // 始终使用第一个字符，并转换为大写
    }
}

#Preview {
    BoxView(box: MockData.boxes[0])
}
