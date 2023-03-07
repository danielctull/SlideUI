
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
        Slide(header: title, footer: "Daniel Tull") {
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
                .font(.system(size: 80, weight: .bold, design: .rounded))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()

            configuration.content
                .font(.system(size: 30, design: .rounded))
                .frame(maxHeight: .infinity)

            configuration.footer
                .font(.system(size: 20, design: .rounded))
                .padding(5)
                .frame(maxWidth: .infinity)
                .background(.orange)
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .border(.orange)
        .padding()
        .background(Color.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
