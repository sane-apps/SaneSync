import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "cloud.fill")
                .font(.system(size: 64))
                .foregroundStyle(.blue)

            Text("SaneSync")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("AI-Powered File Organization")
                .font(.title3)
                .foregroundStyle(.secondary)
        }
        .padding(40)
        .frame(minWidth: 400, minHeight: 300)
    }
}

#Preview {
    ContentView()
}
