
import SlideUI
import SwiftUI

struct ContentView: View {

    @Environment(\.advance) var advance

    var body: some View {
        Presentation {
            MySlide(title: "Slide 1", content: "This is some content one")
            MySlide(title: "Slide 2", content: "This is some content two")
            MySlide(title: "Slide 3", content: "This is some content three")
        }
        .slideStyle(CustomSlideStyle())
    }
}

struct MySlide: View {

    @Environment(\.advance) private var advance
    let title: String
    let content: String

    var body: some View {
        Slide(header: title) {
            Text(content)
            Button("Advance") {
                advance()
            }
        }
    }
}

struct CustomSlideStyle: SlideStyle {

    func makeBody(configuration: Configuration) -> some View {
        VStack {

            configuration.header
                .fontWidth(.expanded)
                .textCase(.uppercase)
                .font(.system(size: 100, weight: .ultraLight))
                .foregroundColor(.yellow)
                .frame(maxWidth: .infinity, alignment: .leading)

            configuration.content
                .font(.system(size: 60, weight: .light))
                .frame(maxHeight: .infinity)

            configuration.footer
                .font(.system(size: 30, weight: .light))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(30)
        .foregroundColor(.white)
        .background(.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
