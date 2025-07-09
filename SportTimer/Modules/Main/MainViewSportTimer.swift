import SwiftUI

struct MainViewSportTimer: View {
    @State private var activeTab: TabSportTimer = .home
    @Namespace private var animation
    @State private var tabShapePosition: CGPoint = .zero
    
    init() {
        UITabBar.appearance().isHidden = true
    }

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                switch activeTab {
                case .home:
                    HomeViewSportTimer(activeTab: $activeTab)
                case .timer:
                    TimerViewSportTimer()
                case .history:
                    HistoryViewSportTimer()
                case .profile:
                    ProfileViewSportTimer()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            customTabBar()
        }
        .ignoresSafeArea(.all, edges: .bottom)
    }
    
    @ViewBuilder
    func customTabBar(_ tint: Color = .blue, _ inactiveTint: Color = .black) -> some View {
        HStack(alignment: .bottom, spacing: 0) {
            ForEach(TabSportTimer.allCases, id: \.rawValue) {
                TabItemViewSportTimer(
                    tint: tint,
                    inactiveTint: inactiveTint,
                    tab: $0,
                    animation: animation,
                    activeTab: $activeTab,
                    position: $tabShapePosition
                )
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 20)
        .background(
            TabShapeSportTimer(midpoint: tabShapePosition.x)
                .fill(.white)
                .ignoresSafeArea()
                .shadow(color: tint.opacity(0.2), radius: 5, x: 0, y: -5)
        )
        .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7), value: activeTab)
    }
}

struct TabShapeSportTimer: Shape {
    var midpoint: CGFloat
    
    var animatableData: CGFloat {
        get { midpoint }
        set { midpoint = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        return Path { path in
            path.addPath(Rectangle().path(in: rect))
        }
    }
}
