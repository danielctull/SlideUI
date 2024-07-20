
import SwiftUI

@freestanding(expression)
public macro Code<Preview: View>(@ViewBuilder preview: () -> Preview) -> Code<Preview> = #externalMacro(module: "SlideUIMacros", type: "CodePreviewMacro")

@freestanding(expression)
public macro Code(code: () -> Any) -> Code<EmptyView> = #externalMacro(module: "SlideUIMacros", type: "CodeMacro")

public struct Code<Preview: View>: View {

    @Environment(\.codeStyle) private var style
    private let code: String
    private let preview: Preview

    public init(
        code: () -> String,
        @ViewBuilder preview: () -> Preview
    ) {
        self.code = code()
        self.preview = preview()
    }

    public var body: some View {
        let configuration = CodeStyleConfiguration(
            code: TokensView(code: code),
            preview: preview)
        AnyView(style.resolve(configuration: configuration))
    }
}

extension Code where Preview == EmptyView {

    public init(code: () -> String) {
        self.init(code: code, preview: EmptyView.init)
    }
}

// MARK: - Tokens View

private struct TokensView: View {

    @Environment(\.codeHighlighting) private var highlighting
    private let code: String
    private let tokens: [Token]

    init(code: String) {
        self.code = code
        self.tokens = Array(code: code)
    }

    public var body: some View {
        // Putting the coloring into overlay allows fast size calculations.
        Text(code)
            .hidden()
            .overlay {
                tokens.map { token in
                    Text(token.value)
                        .foregroundColor(highlighting.color(for: token))
                }
                .reduce(Text(""), +)
            }
    }
}

// MARK: - Style

private struct DefaultCodeStyle: CodeStyle {

    nonisolated init() {}

    @Environment(\.presentationSize) private var size
    private var scale: Double { size.height / 250 }

    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.code
                .font(.system(size: 16 * scale, weight: .regular, design: .monospaced))

            Spacer()
            
            configuration.preview
            
            Spacer()
        }
    }
}

extension View {

    public func codeStyle(_ style: some CodeStyle) -> some View {
        environment(\.codeStyle, style)
    }
}


extension Scene {

    public func codeStyle(_ style: some CodeStyle) -> some Scene {
        environment(\.codeStyle, style)
    }
}

@MainActor
public protocol CodeStyle: DynamicProperty {

    typealias Configuration = CodeStyleConfiguration
    associatedtype Body : View

    /// Creates a view that represents the body of a code view.
    ///
    /// The system calls this method for each ``Code`` instance in a
    /// view hierarchy where this style is the current code style.
    ///
    /// - Parameter configuration: The properties of the code view.
    @ViewBuilder @MainActor
    func makeBody(configuration: Self.Configuration) -> Self.Body
}

private struct CodeStyleKey: EnvironmentKey {
    static var defaultValue: any CodeStyle { DefaultCodeStyle() }
}

extension EnvironmentValues {

    fileprivate var codeStyle: any CodeStyle {
        get { self[CodeStyleKey.self] }
        set { self[CodeStyleKey.self] = newValue }
    }
}

public struct CodeStyleConfiguration {

    public struct Code: View {
        fileprivate let base: AnyView
        public var body: some View { base }
    }

    public struct Preview: View {
        fileprivate let base: AnyView
        public var body: some View { base }
    }

    public let code: Code
    public let preview: Preview

    @MainActor
    fileprivate init(code: some View, preview: some View) {
        self.code = Code(base: AnyView(code))
        self.preview = Preview(base: AnyView(preview))
    }
}

extension CodeStyle {

    fileprivate func resolve(configuration: Configuration) -> some View {
        ResolvedCodeStyle(style: self, configuration: configuration)
    }
}

private struct ResolvedCodeStyle<Style: CodeStyle>: View {

    let style: Style
    let configuration: Style.Configuration

    var body: some View {
        style.makeBody(configuration: configuration)
    }
}
