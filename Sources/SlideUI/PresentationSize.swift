
import SwiftUI

public struct PresentationSize: Equatable, Hashable, Sendable {
    public let width: Double
    public let height: Double
}

extension PresentationSize {

    fileprivate init(_ size: CGSize) {
        self.init(width: size.width, height: size.height)
    }

    static let zero = Self(width: 0, height: 0)
}

extension PresentationSize {

    fileprivate struct Key: PreferenceKey {
        static let defaultValue = PresentationSize.zero
        static func reduce(value: inout PresentationSize, nextValue: () -> PresentationSize) {
            value = nextValue()
        }
    }
}

extension View {

    func onPresentationSizeChange(perform action: @escaping (PresentationSize) -> Void) -> some View {
        GeometryReader { geometry in
            preference(key: PresentationSize.Key.self, value: PresentationSize(geometry.size))
        }
        .onPreferenceChange(PresentationSize.Key.self, perform: action)
    }
}

extension PresentationSize {

    func render(@ViewBuilder _ view: @escaping () -> some View) -> some View {

        GeometryReader { geometry in
            let width = geometry.size.width / self.width
            let height = geometry.size.height / self.height
            let scale = min(width, height)

            view()
                .frame(width: self.width, height: self.height)
                .scaleEffect(scale)
                .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}
