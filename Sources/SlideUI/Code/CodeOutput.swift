
import SwiftUI

@freestanding(expression)
public macro CodeOutput<V: View>(_ view: V) -> CodeOutputView = #externalMacro(module: "SlideUIMacros", type: "CodeOutputMacro")

public struct CodeOutputView: View {

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
