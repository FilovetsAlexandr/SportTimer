import SwiftUI

struct HistoryViewSportTimer: View {
    @StateObject private var viewModelSportTimer = HistoryViewModelSportTimer()

    var body: some View {
        NavigationView {
            VStack {
                if viewModelSportTimer.groupedWorkouts.isEmpty && viewModelSportTimer.searchText.isEmpty {
                    Text("No workouts yet. Complete a workout to see it here.")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.secondary)
                        .padding()
                } else if viewModelSportTimer.groupedWorkouts.isEmpty && !viewModelSportTimer.searchText.isEmpty {
                    Text("No results for \"\(viewModelSportTimer.searchText)\"")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.secondary)
                        .padding()
                } else {
                    List {
                        ForEach(viewModelSportTimer.groupedWorkouts.keys.sorted(by: >), id: \.self) { date in
                            Section(header: Text(date, style: .date)) {
                                ForEach(viewModelSportTimer.groupedWorkouts[date] ?? [], id: \.id) { workout in
                                    WorkoutRowSportTimer(workout: workout)
                                }
                                .onDelete { indexSet in
                                    guard let workouts = viewModelSportTimer.groupedWorkouts[date] else { return }
                                    for index in indexSet {
                                        viewModelSportTimer.deleteWorkoutSportTimer(workout: workouts[index])
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("History")
            .searchable(text: $viewModelSportTimer.searchText, prompt: "Search by type or notes")
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
                if let notes = workout.notes, !notes.isEmpty {
                    Text("Notes: \(notes)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                Text(workout.date ?? Date(), style: .time)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
        .padding(.vertical, 5)
    }
}
