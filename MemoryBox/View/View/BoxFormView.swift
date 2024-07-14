//
//  BoxFormView.swift
//  MemoryBox
//
//  Created by David Zhu on 2024-07-11.
//

//import SwiftUI
//
//struct BoxFormView: View {
//    @Bindable var box: Box
//    
//    var body: some View {
//        Form {
//            Section {
//                TextField("Name", text: $box.name)
//            }
//            Section {
//                Toggle(isOn: $box.isPrivate) {
//                    Label {
//                        Text(box.isPrivate ? "Private" : "Public")
//                            .foregroundColor(.primary)
//                    } icon: {
//                        Image(systemName: box.isPrivate ? "lock.fill" : "lock.open.fill")
//                            .foregroundStyle(Color.black)
//                    }
//                }
//                .tint(.green)
//            }
//        }
//    }
//}
