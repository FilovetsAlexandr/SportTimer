import SwiftUI

struct PositionKeySportTimer: PreferenceKey {
    static var defaultValue: CGRect = .zero
    
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

extension View {
    @ViewBuilder
    func viewPosition(completion: @escaping (CGRect) -> ()) -> some View {
        self
            .overlay {
                GeometryReader {
                    let rect = $0.frame(in: .global)
                    
                    Color.clear
                        .preference(key: PositionKeySportTimer.self, value: rect)
                        .onPreferenceChange(PositionKeySportTimer.self, perform: completion)
                }
            }
    }
} 