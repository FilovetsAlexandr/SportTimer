import SwiftUI

struct SplashScreenViewSportTimer: View {
    @StateObject private var viewModelSportTimer = SplashScreenViewModelSportTimer()

    var body: some View {
        ZStack {
            if viewModelSportTimer.isLoadingFinished {
                MainViewSportTimer()
            } else {
                Text("Loading SportTimer...")
                    .font(.largeTitle)
                    .onAppear {
                        viewModelSportTimer.startLoadingSportTimer()
                    }
            }
        }
    }
}
