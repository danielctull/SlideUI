
import SlideUI
import SwiftUI

struct ContentView: View {

    @Environment(\.advance) var advance

    var body: some View {
        Presentation {
            MySlide(title: "Slide 1")
            MySlide(title: "Slide 2")
            MySlide(title: "Slide 3")
        }
    }
}

struct MySlide: View {

    @Environment(\.advance) private var advance
    let title: String

    var body: some View {
        Slide {
            Text(title)
            Button("Advance") {
                advance()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
