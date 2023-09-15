
import Foundation
import SwiftUI

struct SlideIndex: Equatable, Hashable {
    private let id = UUID().uuidString
}

extension SlideIndex: CustomStringConvertible {
    var description: String { "Index(\(id))" }
}

private struct SlideIndexKey: EnvironmentKey {
    static var defaultValue = SlideIndex()
}

extension EnvironmentValues {
    var currentSlide: SlideIndex {
        get { self[SlideIndexKey.self] }
        set { self[SlideIndexKey.self] = newValue }
    }
}

private struct SlideIndexPreferenceKey: PreferenceKey {
    static var defaultValue: [SlideIndex] = []
    static func reduce(value: inout [SlideIndex], nextValue: () -> [SlideIndex]) {
        value.append(contentsOf: nextValue())
    }
}

extension View {

    func register(_ index: SlideIndex) -> some View {
        preference(key: SlideIndexPreferenceKey.self, value: [index])
    }

    func slides(_ slides: @escaping ([SlideIndex]) -> Void) -> some View {
        onPreferenceChange(SlideIndexPreferenceKey.self, perform: slides)
    }
}
