import SwiftUI

struct HistoryViewSportTimer: View {
    @StateObject private var viewModelSportTimer = HistoryViewModelSportTimer()

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModelSportTimer.workoutsSportTimer, id: \.id) { workout in
                    WorkoutRowSportTimer(workout: workout)
                }
                .onDelete(perform: viewModelSportTimer.deleteWorkoutSportTimer)
            }
            .navigationTitle("History")
            .onAppear {
                viewModelSportTimer.fetchWorkoutsSportTimer()
            }
        }
    }
}

private struct WorkoutRowSportTimer: View {
    let workout: WorkoutSportTimer

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(workout.type ?? "N/A")
                    .font(.headline)
                Text("Duration: \(TimeInterval(workout.duration).formattedStringSportTimer())")
                    .font(.subheadline)
                Text(workout.date ?? Date(), style: .date)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
        .padding(.vertical, 5)
    }
}
