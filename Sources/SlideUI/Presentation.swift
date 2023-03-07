
import SwiftUI

public struct Presentation<Content: View>: View {

    @State private var index = 0
    let content: () -> Content

    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    public var body: some View {
        PresentationLayout(index: index) {
            content()
        }
        .advance { index += 1 }
    }
}

public struct PresentationLayout: Layout {

    private let index: Int
    public init(index: Int) {
        self.index = index
    }

    public func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        proposal.replacingUnspecifiedDimensions()
    }

    public func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {

        let index = min(subviews.count - 1, index)

        for (i, subview) in subviews.enumerated() {
            if i == index {
                subview.place(at: .zero, proposal: proposal)
            } else {
                subview.place(at: .zero, anchor: .bottomTrailing, proposal: proposal)
            }
        }
    }
}
