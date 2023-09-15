
import Foundation
import SwiftUI

struct SlideID: Equatable, Hashable {
    private let id = UUID().uuidString
}

extension SlideID: CustomStringConvertible {
    var description: String { "Index(\(id))" }
}

// MARK: - Environment

private struct SlideIndexKey: EnvironmentKey {
    static var defaultValue = SlideID()
}

extension EnvironmentValues {
    var currentSlide: SlideID {
        get { self[SlideIndexKey.self] }
        set { self[SlideIndexKey.self] = newValue }
    }
}

// MARK: - Registration

private struct SlideIndexPreferenceKey: PreferenceKey {
    static var defaultValue: [SlideID] = []
    static func reduce(value: inout [SlideID], nextValue: () -> [SlideID]) {
        value.append(contentsOf: nextValue())
    }
}

extension View {

    func register(_ index: SlideID) -> some View {
        preference(key: SlideIndexPreferenceKey.self, value: [index])
    }

    func slides(_ slides: @escaping ([SlideID]) -> Void) -> some View {
        onPreferenceChange(SlideIndexPreferenceKey.self, perform: slides)
    }
}
