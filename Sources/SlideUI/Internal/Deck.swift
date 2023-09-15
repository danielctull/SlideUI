
struct Deck: Equatable, Hashable {
    fileprivate let slides: [SlideID]
    private var index = 0

    init(slide: SlideID) {
        self.slides = [slide]
    }

    init?(slides: [SlideID]) {
        guard !slides.isEmpty else { return nil }
        self.slides = slides
    }

    var current: SlideID {
        slides[index]
    }

    mutating func next() {
        if index < slides.count - 1 {
            self.index = index + 1
        }
    }

    mutating func previous() {
        if index > 0 {
            self.index = index - 1
        }
    }
}

extension Optional<Deck> {

    mutating func appendDeck(_ deck: Deck?) {
        switch (self, deck) {
        case (let .some(lhs), let .some(rhs)):
            var slides = lhs.slides
            slides.append(contentsOf: rhs.slides)
            self = Deck(slides: slides)
        case (.none, let .some(rhs)):
            self = rhs
        case (.some, .none):
            return
        case (.none, .none):
            return
        }
    }
}
