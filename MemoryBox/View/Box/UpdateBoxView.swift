//
//  UpdateBoxView.swift
//  MemoryBox
//
//  Created by David Zhu on 2024-07-14.
//

import SwiftUI

struct UpdateBoxView: View {
    let box: BoxPost
    
    var body: some View {
        BoxForm(viewModel: BoxForm.ViewModel(box: box))
    }
}

