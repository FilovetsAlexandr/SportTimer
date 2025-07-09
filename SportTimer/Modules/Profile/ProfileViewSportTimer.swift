import SwiftUI
import PhotosUI

struct ProfileViewSportTimer: View {
    @StateObject private var viewModelSportTimer = ProfileViewModelSportTimer()
    @State private var selectedItem: PhotosPickerItem? = nil

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("User")) {
                    HStack {
                        Spacer()
                        VStack {
                            
                            PhotosPicker(
                                selection: $selectedItem,
                                matching: .images,
                                photoLibrary: .shared()) {
                                    if let image = viewModelSportTimer.profileDataSportTimer.userImage {
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 100, height: 100)
                                            .clipShape(Circle())
                                    } else {
                                        Image(systemName: "person.circle.fill")
                                            .resizable()
                                            .frame(width: 100, height: 100)
                                            .foregroundColor(.gray)
                                    }
                                }
                                .onChange(of: selectedItem) { newItem in
                                    Task {
                                        if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                            if let uiImage = UIImage(data: data) {
                                                viewModelSportTimer.setUserImageSportTimer(image: Image(uiImage: uiImage))
                                            }
                                        }
                                    }
                                }
                            
                            Text("Change Photo")
                                .font(.caption)
                                .foregroundColor(.accentColor)
                        }
                        Spacer()
                    }
                }
                
                Section(header: Text("Statistics")) {
                    StatisticRowSportTimer(title: "Total Workouts", value: "\(viewModelSportTimer.profileDataSportTimer.totalWorkouts)")
                    StatisticRowSportTimer(title: "Total Time", value: viewModelSportTimer.profileDataSportTimer.totalDuration.formattedStringSportTimer())
                }
                
                Section(header: Text("Settings")) {
                    Toggle("Sound", isOn: $viewModelSportTimer.isSoundEnabled)
                    Toggle("Vibration", isOn: $viewModelSportTimer.isVibrationEnabled)
                }
                
                Section(header: Text("Data Management")) {
                    Button(role: .destructive, action: {
                        viewModelSportTimer.clearAllDataSportTimer()
                    }) {
                        Text("Clear All Data")
                    }
                }
                
                Section(header: Text("About")) {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.0.0")
                    }
                }
            }
            .navigationTitle("Profile")
            .onAppear {
                viewModelSportTimer.fetchProfileDataSportTimer()
            }
        }
    }
}

private struct StatisticRowSportTimer: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text(value)
                .foregroundColor(.secondary)
        }
    }
}
