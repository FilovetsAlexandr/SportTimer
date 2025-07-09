import Foundation
import Combine

class SplashScreenViewModelSportTimer: ObservableObject {
    @Published var isLoadingFinished = false
    private var cancellables = Set<AnyCancellable>()

    func startLoadingSportTimer() {
        let randomDuration = Double.random(in: 1...2)
        Timer.publish(every: randomDuration, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                self.isLoadingFinished = true
            }
            .store(in: &cancellables)
    }
}
