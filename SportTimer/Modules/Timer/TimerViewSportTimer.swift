import SwiftUI

struct TimerViewSportTimer: View {
    @StateObject private var viewModelSportTimer = TimerViewModelSportTimer()

    var body: some View {
        NavigationView {
            ZStack {
                Color.backgroundSportTimer.edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 30) {
                    CircularProgressViewSportTimer(progress: viewModelSportTimer.modelSportTimer.timeElapsed)
                    
                    WorkoutTypePickerSportTimer(selection: $viewModelSportTimer.modelSportTimer.workoutType)
                    
                    NotesTextFieldSportTimer(notes: $viewModelSportTimer.modelSportTimer.notes)
                    
                    TimerControlsViewSportTimer(
                        isTimerActive: viewModelSportTimer.modelSportTimer.timerActive,
                        startAction: viewModelSportTimer.startTimerSportTimer,
                        pauseAction: viewModelSportTimer.pauseTimerSportTimer,
                        stopAction: {
                            viewModelSportTimer.saveWorkoutSportTimer()
                        }
                    )
                    
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Workout Timer")
        }
    }
}

private struct CircularProgressViewSportTimer: View {
    let progress: TimeInterval

    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20.0)
                .opacity(0.3)
                .foregroundColor(Color.primarySportTimer)
            
            Text(progress.formattedStringSportTimer())
                .font(.system(size: 60, weight: .bold))
        }
        .frame(width: 250, height: 250)
    }
}

private struct WorkoutTypePickerSportTimer: View {
    @Binding var selection: WorkoutTypeSportTimer

    var body: some View {
        Picker("Workout Type", selection: $selection) {
            ForEach(WorkoutTypeSportTimer.allCases) { type in
                Text(type.rawValue).tag(type)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
    }
}

private struct NotesTextFieldSportTimer: View {
    @Binding var notes: String

    var body: some View {
        TextField("Notes about your workout...", text: $notes)
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .shadow(radius: 5)
    }
}

private struct TimerControlsViewSportTimer: View {
    let isTimerActive: Bool
    let startAction: () -> Void
    let pauseAction: () -> Void
    let stopAction: () -> Void
    @State private var isPressed1 = false
    @State private var isPressed2 = false

    var body: some View {
        HStack(spacing: 20) {
            if !isTimerActive {
                Button(action: startAction) {
                    TimerButtonSportTimer(label: "Start", color: .successSportTimer)
                }
                .scaleEffect(isPressed1 ? 0.95 : 1.0)
                .pressEvents {
                    withAnimation(.easeInOut(duration: 0.1)) {
                        isPressed1 = true
                    }
                } onRelease: {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.5)) {
                        isPressed1 = false
                    }
                }
            } else {
                Button(action: pauseAction) {
                    TimerButtonSportTimer(label: "Pause", color: .secondarySportTimer)
                }
                .scaleEffect(isPressed1 ? 0.95 : 1.0)
                .pressEvents {
                    withAnimation(.easeInOut(duration: 0.1)) {
                        isPressed1 = true
                    }
                } onRelease: {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.5)) {
                        isPressed1 = false
                    }
                }
            }
            
            Button(action: stopAction) {
                TimerButtonSportTimer(label: "Stop & Save", color: .dangerSportTimer)
            }
            .scaleEffect(isPressed2 ? 0.95 : 1.0)
            .pressEvents {
                withAnimation(.easeInOut(duration: 0.1)) {
                    isPressed2 = true
                }
            } onRelease: {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.5)) {
                    isPressed2 = false
                }
            }
        }
    }
}

private struct TimerButtonSportTimer: View {
    let label: String
    let color: Color

    var body: some View {
        Text(label)
            .font(.system(size: 18, weight: .bold))
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(color)
            .cornerRadius(8)
            .shadow(radius: 5)
    }
}
