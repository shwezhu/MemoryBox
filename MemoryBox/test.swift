import SwiftUI

struct ContentView1: View {
    var body: some View {
        Grid {
            GridRow {
                Text("1")
                Text("2")
                Text("3")
            }
            GridRow {
                Text("4")
                Text("5")
                Text("6")
            }
            GridRow {
                Text("7")
                Text("8")
                Text("9")
            }
        }
    }
}



#Preview {
    ContentView1()
}
