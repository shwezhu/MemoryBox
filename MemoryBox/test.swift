import SwiftUI

import SwiftUI

struct ContentView1: View {
    var body: some View {
        VStack(spacing: 20) {
            // Adaptive columns example
            HStack {
                Color.red.frame(width: 50)
                Color.green.frame(maxWidth: .infinity)
                Color.blue.frame(maxWidth: .infinity)
            }
            .frame(height: 50)
            .border(Color.black)
            
            // Flexible columns example
            HStack {
                Color.red.frame(width: 50)
                Color.green.frame(minWidth: 50, maxWidth: 100)
                Color.blue.frame(minWidth: 50, maxWidth: .infinity)
            }
            .frame(height: 50)
            .border(Color.black)
        }
        .padding()
    }
}

#Preview {
    ContentView1()
}
