import SlideUI
import SwiftUI

@main
struct PresentationApp: App {
    var body: some Scene {
      Presentation {

          Slide {
              Text("Welcome to SlideUI")
          }
          .slideStyle(.title)

          Slide(header: "What is SlideUI?") {
              Bullet("Write presentations using declarative SwiftUI syntax!")
              Bullet("Fully customise styling") {
                  Bullet("SlideStyle")
                  Bullet("CodeStyle")
                  Bullet("BulletStyle")
              }
              Bullet("Presenter display which shows notes.")
          } notes: {
              Text("Notes to remember my talking points:")
              Text("• Separation of content and style.")
              Text("• Ability to restyle all slides at once.")
          }

          Slide(header: "Embed SwiftUI views") {
              Circle()
                  .frame(width: 200, height: 200)
                  .foregroundColor(.red)
                  .frame(maxWidth: .infinity, alignment: .center)
          }

          Slide(header: "Compiler-checked Swift") {

              Text("Using #Code macro allows writing code that is checked by the compiler")

              #Code {
                  struct Foo {
                      let bar: Bar
                  }

                  let foo = Foo(bar: Bar())
                  print(foo.bar)
              }
          }

          Slide(header: "SwiftUI Previews") {

              Text("If the #Code block outputs a SwiftUI view, this will be rendered alongside the code.")

              #Code {
                  Circle()
                      .frame(width: 200, height: 200)
                      .foregroundColor(.red)
              }
          }
      }
      .slideStyle(.content)
    }
}

private struct Bar {}
