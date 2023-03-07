
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
        .slideStyle(CustomSlideStyle())
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

struct CustomSlideStyle: SlideStyle {

    func makeBody(configuration: Configuration) -> some View {
        VStack {
            configuration.content
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .border(.red)
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
