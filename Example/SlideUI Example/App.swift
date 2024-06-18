
import SlideUI
import SwiftUI

@main
struct PresentationApp: App {
    var body: some Scene {
      Presentation {

          Slide {
              Code {
                  """
                  // This is a comment
                  private final class Tokenizer2: SyntaxRewriter {

                      var tokens: [Token] = []

                      func visit(outside token: TokenSyntax) -> TokenSyntax {
                          print(token, token.tokenKind, token.kind)
                          tokens.append(contentsOf: token.tokens)
                          return super.visit(token)
                      }
                  }
                  """
              }
          }

          Slide(header: "Red Square") {

              Text("This is how to make a red square.")

              #Code {
                  Color.red.frame(width: 100, height: 100)
              }
          }

          Slide(header: "No Preview!") {

              Text("This is how to make a red square.")

              #Code {
                  Color.red.frame(width: 100, height: 100)
              }
              .codeStyle(.previewHidden)
          }

          Slide(header: "Showing some code") {
              #Code {
                  struct Foo {
                      let bar: Bar
                  }

                  let foo = Foo(bar: Bar())
                  print(foo.bar)
              }
          }
      }
      .slideStyle(.custom)
    }
}

private struct Bar {}
