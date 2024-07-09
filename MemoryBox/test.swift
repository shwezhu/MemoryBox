import SwiftUI

struct ContentView1: View {
    var body: some View {
        VStack {
            Text("Hello, World!")
                .background(.red)
            Text("More text")
                .background(.blue)
        }
    }
}
#Preview {
    ContentView1()
}
