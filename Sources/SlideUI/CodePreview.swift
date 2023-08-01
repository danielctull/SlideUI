
import SwiftUI

@freestanding(expression)
public macro CodePreview<Content: View>(@ViewBuilder _ content: () -> Content) -> CodePreview<Content> = #externalMacro(module: "SlideUIMacros", type: "CodePreviewMacro")

public struct CodePreview<Content: View>: View {

    private let code: Code
    private let content: Content

    public init(@ViewBuilder content: () -> Content, code: () -> Code) {
        self.code = code()
        self.content = content()
    }

    public var body: some View {
        HStack {
            Color.clear.overlay {
                code
            }
            Color.clear.overlay {
                content
            }
        }
    }
}
