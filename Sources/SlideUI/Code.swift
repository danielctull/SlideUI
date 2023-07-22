
import SwiftUI

@freestanding(expression)
public macro Code<V: View>(_ view: V) -> CodeView = #externalMacro(module: "SlideUIMacros", type: "CodeMacro")

public struct CodeView: View {

    let code: String
    let output: AnyView

    public init(@ViewBuilder output: () -> some View, code: () -> String) {
        self.code = code()
        self.output = AnyView(output())
    }

    public var body: some View {
        HStack {
            Color.clear.overlay {
                Text(code)
            }
            Color.clear.overlay {
                output
            }
        }
    }
}
