
import Foundation
import SwiftUI

struct SlideID: Equatable, Hashable {
    private let id = UUID().uuidString
}

extension SlideID {
    static let none = SlideID()
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
    static var defaultValue: Deck = Deck()
    static func reduce(value: inout Deck, nextValue: () -> Deck) {
        value.appendDeck(nextValue())
    }
}

extension View {

    func register(_ id: SlideID) -> some View {
        preference(key: SlideIndexPreferenceKey.self, value: Deck(slide: id))
    }

    func deck(_ action: @escaping (Deck) -> Void) -> some View {
        onPreferenceChange(SlideIndexPreferenceKey.self, perform: action)
    }
}
