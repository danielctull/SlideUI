
import SwiftUI

struct PresentationSize: Equatable {
    fileprivate let size: CGSize
}

extension PresentationSize {
    init() { self.init(size: .zero) }
}

extension PresentationSize {

    fileprivate struct Key: PreferenceKey {
        static var defaultValue = PresentationSize()
        static func reduce(value: inout PresentationSize, nextValue: () -> PresentationSize) {
            value = nextValue()
        }
    }
}

extension View {

    func onPresentationSizeChange(perform action: @escaping (PresentationSize) -> Void) -> some View {
        GeometryReader { geometry in
            preference(key: PresentationSize.Key.self, value: PresentationSize(size: geometry.size))
        }
        .onPreferenceChange(PresentationSize.Key.self, perform: action)
    }
}

extension PresentationSize {

    func render(@ViewBuilder _ view: @escaping () -> some View) -> some View {

        GeometryReader { geometry in
            let width = geometry.size.width / size.width
            let height = geometry.size.height / size.height
            let scale = min(width, height)

            view()
                .frame(width: size.width, height: size.height)
                .scaleEffect(scale)
                .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}
