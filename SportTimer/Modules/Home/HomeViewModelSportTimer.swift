import Foundation
import CoreData
import Combine

class HomeViewModelSportTimer: ObservableObject {
    @Published var homeDataSportTimer: HomeModelSportTimer?
    private let coreDataManagerSportTimer = PersistenceControllerSportTimer.shared
    private var cancellables = Set<AnyCancellable>()

    func fetchHomeDataSportTimer() {
        let request: NSFetchRequest<WorkoutSportTimer> = WorkoutSportTimer.fetchRequest()
        
        do {
            let workouts = try coreDataManagerSportTimer.container.viewContext.fetch(request)
            
            let totalWorkouts = workouts.count
            let totalDuration = workouts.reduce(0) { $0 + TimeInterval($1.duration) }
            let recentWorkouts = Array(workouts.sorted(by: { $0.date! > $1.date! }).prefix(3))
            
            self.homeDataSportTimer = HomeModelSportTimer(totalWorkouts: totalWorkouts, totalDuration: totalDuration, recentWorkouts: recentWorkouts)
        } catch {
            print("Failed to fetch workouts: \(error)")
        }
    }
}
