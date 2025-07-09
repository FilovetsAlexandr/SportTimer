import SwiftUI

struct TabItemViewSportTimer: View {
    var tint: Color
    var inactiveTint: Color
    var tab: TabSportTimer
    var animation: Namespace.ID
    @Binding var activeTab: TabSportTimer
    @Binding var position: CGPoint
    @State private var tabPosition: CGPoint = .zero
    
    var body: some View {
        VStack(spacing: 5) {
            Image(systemName: activeTab == tab ? tab.selectedSystemImage : tab.systemImage)
                .font(.title2)
                .foregroundColor(activeTab == tab ? .white : inactiveTint)
                .frame(width: activeTab == tab ? 58 : 35, height: activeTab == tab ? 40 : 35)
                .background {
                    if activeTab == tab {
                        Circle()
                            .fill(tint)
                            .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                    }
                }
        }
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())
        .viewPosition { rect in
            tabPosition.x = rect.midX
            
            if activeTab == tab {
                position.x = rect.midX
            }
        }
        .onTapGesture {
            activeTab = tab
            
            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                position.x = tabPosition.x
            }
        }
    }
} 