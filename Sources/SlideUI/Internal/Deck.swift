
struct Deck: Equatable, Hashable {
    private let slides: [SlideInfo]
    private var index = 0

    init() {
        slides = [.none]
    }

    init(slide: SlideInfo) {
        self.slides = [slide]
    }

    init(slides: [SlideInfo]) {
        if slides.isEmpty {
            self.slides = [.none]
        } else {
            self.slides = slides
        }
    }

    var current: SlideID {
        slides[index].id
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

    mutating func appendDeck(_ deck: Deck) {
        let slides = self.slides + deck.slides
        self = Deck(slides: slides.filter { $0 != .none })
    }
}
