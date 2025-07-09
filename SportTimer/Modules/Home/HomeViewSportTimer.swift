import SwiftUI

struct HomeViewSportTimer: View {
    @StateObject private var viewModelSportTimer = HomeViewModelSportTimer()
    @Binding var activeTab: TabSportTimer

    var body: some View {
        NavigationView {
            ZStack {
                Color.backgroundSportTimer.edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    HeaderViewSportTimer()
                    
                    if let homeData = viewModelSportTimer.homeDataSportTimer {
                        StatisticsViewSportTimer(totalWorkouts: homeData.totalWorkouts, totalDuration: homeData.totalDuration)
                        
                        StartWorkoutButtonSportTimer(activeTab: $activeTab)
                        
                        RecentWorkoutsViewSportTimer(workouts: homeData.recentWorkouts)
                        
                    } else {
                        ProgressView()
                    }
                    
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Home SportTimer")
            .navigationBarHidden(true)
            .onAppear {
                viewModelSportTimer.fetchHomeDataSportTimer()
            }
        }
    }
}

private struct HeaderViewSportTimer: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Hello, User!")
                    .font(.system(size: 32, weight: .bold))
                Text("Welcome to Sport Timer")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.textSecondarySportTimer)
            }
            Spacer()
        }
    }
}

private struct StatisticsViewSportTimer: View {
    let totalWorkouts: Int
    let totalDuration: TimeInterval

    var body: some View {
        HStack(spacing: 20) {
            StatisticCardSportTimer(title: "Total Workouts", value: "\(totalWorkouts)")
            StatisticCardSportTimer(title: "Total Time", value: totalDuration.formattedStringSportTimer())
        }
    }
}

private struct StatisticCardSportTimer: View {
    let title: String
    let value: String

    var body: some View {
        VStack {
            Text(title)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.textSecondarySportTimer)
            Text(value)
                .font(.system(size: 24, weight: .bold))
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 5)
    }
}

private struct StartWorkoutButtonSportTimer: View {
    @Binding var activeTab: TabSportTimer
    @State private var isPressed = false
    var body: some View {
        Button(action: {
            activeTab = .timer // Переключаемся на вкладку Таймера
        }) {
            Text("Start Workout")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(Color.primarySportTimer)
                .cornerRadius(8)
                .shadow(radius: 5)
        }
        .scaleEffect(isPressed ? 0.95 : 1.0)
        .pressEvents {
            withAnimation(.easeInOut(duration: 0.1)) {
                isPressed = true
            }
        } onRelease: {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.5)) {
                isPressed = false
            }
        }
    }
}

private struct RecentWorkoutsViewSportTimer: View {
    let workouts: [WorkoutSportTimer]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Recent Workouts")
                .font(.system(size: 22, weight: .bold))
            
            if workouts.isEmpty {
                Text("No recent workouts")
                    .foregroundColor(.textSecondarySportTimer)
            } else {
                ForEach(workouts, id: \.id) { workout in
                    WorkoutCardSportTimer(workout: workout)
                }
            }
        }
    }
}

private struct WorkoutCardSportTimer: View {
    let workout: WorkoutSportTimer

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(workout.type ?? "N/A")
                    .font(.system(size: 18, weight: .semibold))
                Text(workout.date?.formatted() ?? "N/A")
                    .font(.system(size: 14))
                    .foregroundColor(.textSecondarySportTimer)
            }
            Spacer()
            Text(TimeInterval(workout.duration).formattedStringSportTimer())
                .font(.system(size: 16, weight: .semibold))
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 5)
    }
}

extension TimeInterval {
    func formattedStringSportTimer() -> String {
        let interval = Int(self)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        let hours = (interval / 3600)
        
        if hours > 0 {
            return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        } else {
            return String(format: "%02d:%02d", minutes, seconds)
        }
    }
}
