import SwiftUI

public protocol CodeHighlighting: DynamicProperty {
    func color(for token: Token) -> Color
}

extension View {
    public func codeHighlighting(_ style: some CodeHighlighting) -> some View {
        environment(\.codeHighlighting, style)
    }
}

extension Scene {
    public func codeHighlighting(_ style: some CodeHighlighting) -> some Scene {
        environment(\.codeHighlighting, style)
    }
}

private struct CodeHighlightingKey: EnvironmentKey {
    static var defaultValue: any CodeHighlighting = DefaultCodeHighlighting()
}

private struct DefaultCodeHighlighting: CodeHighlighting {
    func color(for token: Token) -> Color { .black }
}

extension EnvironmentValues {
    var codeHighlighting: any CodeHighlighting {
        get { self[CodeHighlightingKey.self] }
        set { self[CodeHighlightingKey.self] = newValue }
    }
}
