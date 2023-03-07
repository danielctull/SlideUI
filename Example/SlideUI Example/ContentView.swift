
import SlideUI
import SwiftUI

struct ContentView: View {

    @Environment(\.advance) var advance

    var body: some View {
        Slide {
            Text("Hello, world!")
            Button("Advance", action: advance)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
