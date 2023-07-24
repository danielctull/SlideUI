
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
        .overlay {
            HStack(spacing: 0) {
                Color.white.opacity(0.0000001).onTapGesture { index -= 1 }
                Color.white.opacity(0.0000001).onTapGesture { index += 1 }
            }
        }
    }
}

fileprivate struct PresentationLayout: Layout {

    private let index: Int
    fileprivate init(index: Int) {
        self.index = index
    }

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        proposal.replacingUnspecifiedDimensions()
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {

        let index = max(min(subviews.count - 1, index), 0)

        for (i, subview) in subviews.enumerated() {
            if i == index {
                subview.place(at: .zero, proposal: proposal)
            } else {
                subview.place(at: .zero, anchor: .bottomTrailing, proposal: proposal)
            }
        }
    }
}
