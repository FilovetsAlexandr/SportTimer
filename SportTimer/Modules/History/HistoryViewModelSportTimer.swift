import Foundation
import CoreData
import Combine

class HistoryViewModelSportTimer: ObservableObject {
    @Published var workoutsSportTimer = [WorkoutSportTimer]()
    private let coreDataManagerSportTimer = PersistenceControllerSportTimer.shared

    func fetchWorkoutsSportTimer() {
        let request: NSFetchRequest<WorkoutSportTimer> = WorkoutSportTimer.fetchRequest()
        let sortDescriptor = NSSortDescriptor(keyPath: \WorkoutSportTimer.date, ascending: false)
        request.sortDescriptors = [sortDescriptor]
        
        do {
            workoutsSportTimer = try coreDataManagerSportTimer.container.viewContext.fetch(request)
        } catch {
            print("Failed to fetch workouts: \(error)")
        }
    }

    func deleteWorkoutSportTimer(at offsets: IndexSet) {
        let context = coreDataManagerSportTimer.container.viewContext
        for index in offsets {
            let workout = workoutsSportTimer[index]
            context.delete(workout)
        }

        do {
            try context.save()
            workoutsSportTimer.remove(atOffsets: offsets)
        } catch {
            print("Failed to delete workout: \(error)")
        }
    }
}
