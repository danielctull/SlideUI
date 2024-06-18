
import SlideUI
import SwiftUI
import XcodeCodeHighlighting

extension SlideStyle where Self == CustomSlideStyle {
    static var custom: CustomSlideStyle { CustomSlideStyle() }
}

struct CustomSlideStyle: SlideStyle {

    func makeBody(configuration: Configuration) -> some View {
        VStack {

            configuration.header
                .fontWidth(.expanded)
                .textCase(.uppercase)
                .font(.system(size: 100, weight: .ultraLight))
                .foregroundColor(.yellow)
                .frame(maxWidth: .infinity, alignment: .leading)

            configuration.content
                .font(.system(size: 60, weight: .light))
                .frame(maxHeight: .infinity)

            configuration.footer
                .font(.system(size: 30, weight: .light))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(30)
        .foregroundColor(.black)
        .background(.white)
        .codeStyle(.vertical)
        .codeHighlighting(.xcodeClassicLight)
    }
}

extension Font {

    static func test(_ weight: Font.Weight, italic: Bool) -> Self {
        if italic {
            .system(size: .font, weight: weight, design: .monospaced).italic()
        } else {
            .system(size: .font, weight: weight, design: .monospaced)
        }
    }
}

extension CGFloat {
    fileprivate static let font = Self(40)
}
