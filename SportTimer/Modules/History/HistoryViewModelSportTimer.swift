import Foundation
import CoreData
import Combine

class HistoryViewModelSportTimer: ObservableObject {
    @Published var groupedWorkouts = [Date: [WorkoutSportTimer]]()
    @Published var searchText = ""

    private let coreDataManagerSportTimer = PersistenceControllerSportTimer.shared
    private var cancellables = Set<AnyCancellable>()

    init() {
        $searchText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] _ in
                self?.fetchWorkoutsSportTimer()
            }
            .store(in: &cancellables)
    }

    func fetchWorkoutsSportTimer() {
        let request: NSFetchRequest<WorkoutSportTimer> = WorkoutSportTimer.fetchRequest()
        let sortDescriptor = NSSortDescriptor(keyPath: \WorkoutSportTimer.date, ascending: false)
        request.sortDescriptors = [sortDescriptor]

        if !searchText.isEmpty {
            request.predicate = NSPredicate(format: "type CONTAINS[c] %@ OR notes CONTAINS[c] %@", searchText, searchText)
        }

        DispatchQueue.global(qos: .userInitiated).async {
            do {
                let result = try self.coreDataManagerSportTimer.container.viewContext.fetch(request)
                DispatchQueue.main.async {
                    self.groupedWorkouts = self.groupWorkouts(result)
                }
            } catch {
                print("Failed to fetch workouts: \(error)")
            }
        }
    }

    private func groupWorkouts(_ workouts: [WorkoutSportTimer]) -> [Date: [WorkoutSportTimer]] {
        return Dictionary(grouping: workouts) { workout -> Date in
            return Calendar.current.startOfDay(for: workout.date ?? Date())
        }
    }

    func deleteWorkoutSportTimer(workout: WorkoutSportTimer) {
        let context = coreDataManagerSportTimer.container.viewContext
        context.delete(workout)

        do {
            try context.save()
            fetchWorkoutsSportTimer()
        } catch {
            print("Failed to delete workout: \(error)")
        }
    }
}
