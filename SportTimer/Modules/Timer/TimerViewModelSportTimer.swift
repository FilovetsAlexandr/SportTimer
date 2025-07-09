import Foundation
import Combine
import CoreData

class TimerViewModelSportTimer: ObservableObject {
    @Published var modelSportTimer = TimerModelSportTimer()
    private var timerCancellable: AnyCancellable?
    private let coreDataManagerSportTimer = PersistenceControllerSportTimer.shared

    func startTimerSportTimer() {
        modelSportTimer.timerActive = true
        timerCancellable = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.modelSportTimer.timeElapsed += 1
            }
    }

    func pauseTimerSportTimer() {
        modelSportTimer.timerActive = false
        timerCancellable?.cancel()
    }

    func stopTimerSportTimer() {
        pauseTimerSportTimer()
        modelSportTimer.timeElapsed = 0
    }

    func saveWorkoutSportTimer() {
        let context = coreDataManagerSportTimer.container.newBackgroundContext()
        context.perform {
            let newWorkout = WorkoutSportTimer(context: context)
            newWorkout.id = UUID()
            newWorkout.date = Date()
            newWorkout.duration = Int32(self.modelSportTimer.timeElapsed)
            newWorkout.type = self.modelSportTimer.workoutType.rawValue
            newWorkout.notes = self.modelSportTimer.notes

            do {
                try context.save()
                DispatchQueue.main.async {
                    self.stopTimerSportTimer()
                    self.modelSportTimer.notes = ""
                }
            } catch {
                print("Failed to save workout: \(error)")
            }
        }
    }
}
