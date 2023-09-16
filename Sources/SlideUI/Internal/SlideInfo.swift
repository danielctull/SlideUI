
import SwiftUI

struct SlideInfo {
    let id: SlideID
    let notes: () -> AnyView

    init(id: SlideID, notes: @escaping () -> some View) {
        self.id = id
        self.notes = { AnyView(notes()) }
    }
}

extension SlideInfo {
    static let none = SlideInfo(id: .none, notes: EmptyView.init)
}

extension SlideInfo: Equatable {
    static func == (lhs: SlideInfo, rhs: SlideInfo) -> Bool {
        lhs.id == rhs.id
    }
}

extension SlideInfo: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
