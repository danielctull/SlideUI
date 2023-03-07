
import SlideUI
import SwiftUI

struct ContentView: View {

    var body: some View {
        Presentation {
            Slide(header: "Slide 1") { Text("This is some content one") }
            Slide(header: "Slide 2") { Text("This is some content two") }
            Slide(header: "Slide 3") { Text("This is some content three") }
        }
        .slideStyle(CustomSlideStyle())
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
