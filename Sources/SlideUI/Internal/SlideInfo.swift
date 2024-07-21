
import SwiftUI

struct SlideInfo {
    let id: SlideID
    let content: () -> AnyView
    let notes: () -> AnyView

    init(id: SlideID, content: @escaping () -> some View, notes: @escaping () -> some View) {
        self.id = id
        self.content = { AnyView(content()) }
        self.notes = { AnyView(notes()) }
    }
}

extension SlideInfo {
    static var none: SlideInfo { SlideInfo(id: .none, content: EmptyView.init, notes: EmptyView.init) }
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
