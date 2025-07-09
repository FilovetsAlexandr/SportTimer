import SwiftUI

struct SplashScreenViewSportTimer: View {
    @StateObject private var viewModelSportTimer = SplashScreenViewModelSportTimer()
    @State private var isAnimating = false

    var body: some View {
        ZStack {
            if viewModelSportTimer.isLoadingFinished {
                MainViewSportTimer()
            } else {
                ZStack {

                    VStack(spacing: 120) {
                        Text("SportTimer")
                            .font(.system(size: 50, weight: .heavy, design: .rounded))
                            .foregroundColor(.black)
                            .scaleEffect(isAnimating ? 1.05 : 1.0)
                            .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 10)

                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                            .scaleEffect(2)
                    }
                }
                .onAppear {
                    viewModelSportTimer.startLoadingSportTimer()
                    withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                        isAnimating = true
                    }
                }
            }
        }
    }
}
