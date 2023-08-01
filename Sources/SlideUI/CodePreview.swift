
import SwiftUI

@freestanding(expression)
public macro CodePreview<V: View>(_ view: V) -> CodePreview = #externalMacro(module: "SlideUIMacros", type: "CodePreviewMacro")

public struct CodePreview: View {

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
