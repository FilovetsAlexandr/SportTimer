import SwiftUI

@main
struct SportTimerAppSportTimer: App {
    let persistenceControllerSportTimer = PersistenceControllerSportTimer.shared

    var body: some Scene {
        WindowGroup {
            SplashScreenViewSportTimer()
                .environment(\.managedObjectContext, persistenceControllerSportTimer.container.viewContext)
                .preferredColorScheme(.light)
                .statusBarHidden()
        }
    }
}
