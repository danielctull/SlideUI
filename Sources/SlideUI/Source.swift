
import SwiftUI

@freestanding(expression)
public macro Source(_ source: () -> Any) -> Source = #externalMacro(module: "SlideUIMacros", type: "SourceMacro")

public struct Source: View {

    @Environment(\.sourceStyle) private var style
    private let source: String

    public init(source: String) {
        self.source = source
    }

    public var body: some View {
        let configuration = SourceStyleConfiguration(source: Text(source))
        AnyView(style.resolve(configuration: configuration))
    }
}

// MARK: - Default Style

private struct DefaultSourceStyle: SourceStyle {

    func makeBody(configuration: Configuration) -> some View {
        configuration.source
            .font(.system(size: 48, weight: .regular, design: .monospaced))
    }
}

// MARK: - Style

extension View {

    func sourceStyle(_ style: some SourceStyle) -> some View {
        environment(\.sourceStyle, style)
    }
}

protocol SourceStyle: DynamicProperty {

    typealias Configuration = SourceStyleConfiguration
    associatedtype Body : View

    /// Creates a view that represents the body of a source view.
    ///
    /// The system calls this method for each ``SourceView`` instance in a
    /// view hierarchy where this style is the current source style.
    ///
    /// - Parameter configuration: The properties of the source view.
    @ViewBuilder func makeBody(configuration: Self.Configuration) -> Self.Body
}

private struct SourceStyleKey: EnvironmentKey {
    static var defaultValue: any SourceStyle = DefaultSourceStyle()
}

extension EnvironmentValues {

    fileprivate var sourceStyle: any SourceStyle {
        get { self[SourceStyleKey.self] }
        set { self[SourceStyleKey.self] = newValue }
    }
}

struct SourceStyleConfiguration {

    /// A type-erased source view.
    struct Source: View {
        fileprivate init(_ view: some View) {
            base = AnyView(view)
        }
        private let base: AnyView
        var body: some View { base }
    }

    let source: Source

    fileprivate init(source: some View) {
        self.source = Source(source)
    }
}

extension SourceStyle {

    fileprivate func resolve(configuration: Configuration) -> some View {
        ResolvedSourceStyle(style: self, configuration: configuration)
    }
}

private struct ResolvedSourceStyle<Style: SourceStyle>: View {

    let style: Style
    let configuration: Style.Configuration

    var body: some View {
        style.makeBody(configuration: configuration)
    }
}
