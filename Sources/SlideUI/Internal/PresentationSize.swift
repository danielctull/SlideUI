
import SwiftUI

private struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

extension View {

    private func size(_ size: CGSize) -> some View {
        preference(key: SizePreferenceKey.self, value: size)
    }

    private func onSizeChange(perform action: @escaping (CGSize) -> Void) -> some View {
        onPreferenceChange(SizePreferenceKey.self, perform: action)
    }
}

extension View {

    func bindSize(to binding: Binding<CGSize>) -> some View {
        GeometryReader { geometry in
            self.size(geometry.size)
        }
        .onSizeChange { binding.wrappedValue = $0 }
    }
}
