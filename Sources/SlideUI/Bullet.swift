import SwiftUI

@Style
public struct Bullet<Content: View, Children: View>: View {

    @Environment(\.bulletStyle) private var style

    private let content: Content
    private let children: Children

    public init(@ViewBuilder content: () -> Content, @ViewBuilder children: () -> Children) {
        self.content = content()
        self.children = children()
    }

    public var body: some View {
        let configuration = BulletStyleConfiguration(
            content: content,
            children: children.indented())
        AnyView(style.resolve(configuration: configuration))
    }
}

extension Bullet where Children == EmptyView {

    public init(@ViewBuilder content: () -> Content) {
        self.init {
            content()
        } children: {
            EmptyView()
        }
    }
}

extension Bullet where Content == Text {

    public init(_ value: LocalizedStringKey, @ViewBuilder children: () -> Children) {
        self.init {
            Text(value)
        } children: {
            children()
        }
    }
}

extension Bullet where Content == Text, Children == EmptyView {

    public init(_ value: LocalizedStringKey) {
        self.init {
            Text(value)
        } children: {
            EmptyView()
        }
    }
}

// MARK: - Style

public struct BulletStyleConfiguration {

    public struct Content: View {
        fileprivate let base: AnyView
        public var body: some View { base }
    }

    public struct Children: View {
        fileprivate let base: AnyView
        public var body: some View { base }
    }

    public let content: Content
    public let children: Children

    fileprivate init(
        content: some View,
        children: some View
    ) {
        self.content = Content(base: AnyView(content))
        self.children = Children(base: AnyView(children))
    }
}

extension View {

    public func bulletStyle(_ style: some BulletStyle) -> some View {
        environment(\.bulletStyle, style)
    }
}

extension Scene {

    public func bulletStyle(_ style: some BulletStyle) -> some Scene {
        environment(\.bulletStyle, style)
    }
}

private enum BulletStyleKey: EnvironmentKey {
    static var defaultValue: any BulletStyle = DefaultBulletStyle()
}

extension EnvironmentValues {

    fileprivate var bulletStyle: any BulletStyle {
        get { self[BulletStyleKey.self] }
        set { self[BulletStyleKey.self] = newValue }
    }
}

private struct DefaultBulletStyle: BulletStyle {

    @Environment(\.indentationLevel) private var indentationLevel
    @Environment(\.presentationSize) private var size
    private var scale: Double { size.height / 250 }

    private var imageName: String {
        switch indentationLevel {
        case 0,  8: "circle.fill"
        case 1,  9: "circle"
        case 2, 10: "diamond.fill"
        case 3, 11: "diamond"
        case 4, 12: "square.fill"
        case 5, 13: "square"
        case 6, 14: "triangle.fill"
        case 7, 15: "triangle"
        default: "circle.fill"
        }
    }

    func makeBody(configuration: Configuration) -> some View {

        HStack(alignment: .firstTextCenter, spacing: 0) {

            Image(systemName: imageName)
                .resizable()
                .frame(width: scale * 4, height: scale * 4)
                .padding(.horizontal, scale * 6)

            configuration.content
        }

        configuration.children.padding(.leading, scale * 16)
    }
}

extension BulletStyle {

    fileprivate func resolve(configuration: Configuration) -> some View {
        ResolvedBulletStyle(style: self, configuration: configuration)
    }
}

private struct ResolvedBulletStyle<Style: BulletStyle>: View {

    let style: Style
    let configuration: Style.Configuration

    var body: some View {
        style.makeBody(configuration: configuration)
    }
}

// MARK: - IndentationLevel

public struct IndentationLevel: Equatable, Hashable, Sendable {
    private let amount: Int
}

extension IndentationLevel: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: IntegerLiteralType) {
        self.init(amount: value)
    }
}

extension IndentationLevel {

    fileprivate func increase() -> IndentationLevel {
        IndentationLevel(amount: amount + 1)
    }
}

extension View {
    fileprivate func indented() -> some View {
        modifier(IndentedViewModifier())
    }
}

private struct IndentedViewModifier: ViewModifier {
    
    @Environment(\.indentationLevel) private var indentation

    func body(content: Content) -> some View {
        content.environment(\.indentationLevel, indentation.increase())
    }
}

extension IndentationLevel {
    fileprivate struct EnvironmentKey: SwiftUI.EnvironmentKey {
        static let defaultValue: IndentationLevel = 0
    }
}

extension EnvironmentValues {
    public fileprivate(set) var indentationLevel: IndentationLevel {
        get { self[IndentationLevel.EnvironmentKey.self] }
        set { self[IndentationLevel.EnvironmentKey.self] = newValue }
    }
}

// MARK: - Alignment

extension VerticalAlignment {

    private enum FirstTextCenter: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            let rest = context[.lastTextBaseline] - context[.firstTextBaseline]
            let first = context.height - rest
            return first / 2
        }
    }

    /// A guide that marks the center of the top-most text in a view.
    ///
    /// Use this guide to align with the center of the top-most text in a
    /// view.
    public static let firstTextCenter = Self(FirstTextCenter.self)
}
