import SlideUI
import SwiftUI
import XcodeCodeHighlighting

extension PresentationSize {
    var scale: Double { height / 250 }
}

// MARK: - Title

extension SlideStyle where Self == TitleSlideStyle {
    static var title: TitleSlideStyle { TitleSlideStyle() }
}

struct TitleSlideStyle: SlideStyle {
    
    @Environment(\.presentationSize.scale) private var scale

    func makeBody(configuration: Configuration) -> some View {
        configuration.content
            .font(.system(size: 32 * scale, weight: .heavy))
            .fontWidth(.expanded)
            .padding(30)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .foregroundColor(.purple)
            .background(.white)
    }
}

// MARK: - Content

extension SlideStyle where Self == ContentSlideStyle {
    static var content: ContentSlideStyle { ContentSlideStyle() }
}

struct ContentSlideStyle: SlideStyle {

    @Environment(\.presentationSize.scale) private var scale

    func makeBody(configuration: Configuration) -> some View {
        VStack {

            configuration.header
                .font(.system(size: 24 * scale, weight: .heavy))
                .fontWidth(.expanded)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.purple)

            VStack(spacing: scale * 8) {
                configuration.content
                    .font(.system(size: 16 * scale, weight: .regular))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxHeight: .infinity)

            configuration.footer
                .font(.system(size: 12 * scale, weight: .light))
                .frame(maxWidth: .infinity)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(8 * scale)
        .foregroundColor(.black)
        .background(.white)
        .bulletStyle(.custom)
        .codeStyle(.custom)
        .codeHighlighting(.xcodeClassicLight)
    }
}

// MARK: - Code

extension CodeStyle where Self == CustomCodeStyle {
    static var custom: Self { Self() }
}

struct CustomCodeStyle: CodeStyle {

    @Environment(\.presentationSize.scale) private var scale

    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.code
                .font(.system(size: 12 * scale, weight: .regular, design: .monospaced))

            Spacer()

            configuration.preview

            Spacer()
        }
    }
}

// MARK: - Bullet

extension BulletStyle where Self == CustomBulletStyle {
    static var custom: Self { Self() }
}

private struct CustomBulletStyle: BulletStyle {

    @Environment(\.indentationLevel) private var indentationLevel
    @Environment(\.presentationSize.scale) private var scale

    private var imageName: String {
        switch indentationLevel {
        case 0, 2, 4: "diamond.fill"
        case 1, 3, 5: "diamond"
        default: "circle.fill"
        }
    }

    func makeBody(configuration: Configuration) -> some View {

        HStack(alignment: .firstTextCenter, spacing: 0) {

            Image(systemName: imageName)
                .resizable()
                .frame(width: scale * 5, height: scale * 5)
                .padding(.horizontal, scale * 5)
                .foregroundColor(.purple)

            configuration.content
        }

        configuration.children
            .padding(.leading, scale * 15)
    }
}
