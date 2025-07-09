import Foundation

enum WorkoutTypeSportTimer: String, CaseIterable, Identifiable {
    case strength = "Strength"
    case cardio = "Cardio"
    case yoga = "Yoga"
    case stretching = "Stretching"
    case other = "Other"

    var id: String { self.rawValue }
}

struct TimerModelSportTimer {
    var timeElapsed: TimeInterval = 0
    var workoutType: WorkoutTypeSportTimer = .strength
    var notes: String = ""
    var timerActive: Bool = false
}
