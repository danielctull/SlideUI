
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

    func register<Header: View, Content: View, Footer: View, Notes: View>(
        slide: Slide<Header, Content, Footer, Notes>
    ) -> some View {
        let info = SlideInfo(id: slide.id, content: { slide.resolvedContent },  notes: slide.notes)
        return preference(key: SlideIndexPreferenceKey.self, value: Deck(slide: info))
    }

    func deck(_ action: @escaping (Deck) -> Void) -> some View {
        onPreferenceChange(SlideIndexPreferenceKey.self, perform: action)
    }
}
