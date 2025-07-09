import Foundation
import Combine
import CoreData
import AVFoundation
import UIKit

class TimerViewModelSportTimer: ObservableObject {
    @Published var modelSportTimer = TimerModelSportTimer()
    private var timerCancellable: AnyCancellable?
    private let coreDataManagerSportTimer = PersistenceControllerSportTimer.shared
    private var isPaused = false
    private let soundManager = SoundManager.shared
    private let impactGenerator = UIImpactFeedbackGenerator(style: .medium)

    func startTimerSportTimer() {
        modelSportTimer.timerActive = true
        isPaused = false
        playFeedback()
        timerCancellable = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.modelSportTimer.timeElapsed += 1
            }
    }

    func pauseTimerSportTimer() {
        if isPaused {
            startTimerSportTimer()
        } else {
            modelSportTimer.timerActive = false
            timerCancellable?.cancel()
            isPaused = true
            playFeedback()
        }
    }

    func stopTimerSportTimer() {
        modelSportTimer.timerActive = false
        timerCancellable?.cancel()
        modelSportTimer.timeElapsed = 0
        isPaused = false
        playFeedback()
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
    
    private func playFeedback() {
        if SettingsManager.shared.isSoundEnabled {
            soundManager.playSound(named: "tapSportTimer.wav")
        }
        if SettingsManager.shared.isVibrationEnabled {
            impactGenerator.impactOccurred()
        }
    }
}
