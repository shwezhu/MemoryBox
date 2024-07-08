import SwiftUI

struct ContentView1: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Group {
                    Text("2. aspectRatio(2, contentMode: .fill)")
                    Image(systemName: "star.fill")
                        .resizable()
                        // 宽2, 高1
                        .aspectRatio(2, contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .border(Color.black)
                }
                
                Group {
                    Text("3. aspectRatio(2, contentMode: .fill)")
                    Image(systemName: "star.fill")
                        .resizable()
                        .aspectRatio(2, contentMode: .fill)
                        .frame(width: 100, height: 100)
                        // fill 常与 .clipped() 搭配使用
                        .clipped()
                        .border(Color.black)
                }
                
                Group {
                    Text("4. aspectRatio(1, contentMode: .fit)")
                    Image(systemName: "star.fill")
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .border(Color.black)
                }
                
                Group {
                    Text("5. aspectRatio(2, contentMode: .fit)")
                    Image(systemName: "star.fill")
                        .resizable()
                        .aspectRatio(2, contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .border(Color.black)
                }
                
            }
            .padding()
        }
    }
}



#Preview {
    ContentView1()
}
