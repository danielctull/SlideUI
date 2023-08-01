
import SwiftUI

@freestanding(expression)
public macro CodePreview<Content: View>(@ViewBuilder _ content: () -> Content) -> CodePreview = #externalMacro(module: "SlideUIMacros", type: "CodePreviewMacro")

public struct CodePreview: View {

    let code: Code
    let output: AnyView

    public init(@ViewBuilder output: () -> some View, code: () -> Code) {
        self.code = code()
        self.output = AnyView(output())
    }

    public var body: some View {
        HStack {
            Color.clear.overlay {
                code
            }
            Color.clear.overlay {
                output
            }
        }
    }
}
