
import SwiftUI

public struct TokenView: View {
    
    @Environment(\.codeStyle) var style
    let tokens: [Token]
    
    public init(tokens: [Token]) {
        self.tokens = tokens
    }
    
    public var body: some View {
        tokens.reduce(Text("")) { accumulated, token in
            let text: Text = Text(token.value)
                .font(style.font(token))
                .foregroundColor(style.color(token))
            return accumulated + text
        }
    }
}

// MARK: - Code Style

extension View {

    public func codeStyle(_ style: CodeStyle) -> some View {
        environment(\.codeStyle, style)
    }
}

private struct CodeStyleKey: EnvironmentKey {
    static var defaultValue = CodeStyle.plain
}

extension EnvironmentValues {

    fileprivate var codeStyle: CodeStyle {
        get { self[CodeStyleKey.self] }
        set { self[CodeStyleKey.self] = newValue }
    }
}

public struct CodeStyle {

    let color: (Token) -> Color
    let font: (Token) -> Font

    public init(
        color: @escaping (Token) -> Color,
        font: @escaping (Token) -> Font
    ) {
        self.color = color
        self.font = font
    }
}

extension CodeStyle {

    static let plain = Self(
        color: { _ in .black },
        font: { _ in .system(size: 18, weight: .regular, design: .monospaced) })
}
