import SwiftUI

struct BounceButtonAnimationSportTimer: ViewModifier {
    func body(content: Content) -> some View {
        content
            .scaleEffect(1.0)
            .animation(.spring(response: 0.4, dampingFraction: 0.5), value: 1.0)
    }
}

extension View {
    func bounceAnimationSportTimer() -> some View {
        self.modifier(BounceButtonAnimationSportTimer())
    }
} 