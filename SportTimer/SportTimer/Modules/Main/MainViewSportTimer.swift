import SwiftUI

struct MainViewSportTimer: View {
    @StateObject private var viewModel = MainViewModelSportTimer()

    var body: some View {
        TabView(selection: $viewModel.selectedTab) {
            HomeViewSportTimer(mainViewModel: viewModel)
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(0)

            TimerViewSportTimer()
                .tabItem {
                    Label("Timer", systemImage: "timer")
                }
                .tag(1)

            HistoryViewSportTimer()
                .tabItem {
                    Label("History", systemImage: "clock.arrow.circlepath")
                }
                .tag(2)

            ProfileViewSportTimer()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
                .tag(3)
        }
    }
} 