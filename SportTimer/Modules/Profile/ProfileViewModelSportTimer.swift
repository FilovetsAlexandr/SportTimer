import Foundation
import CoreData
import Combine
import SwiftUI

class ProfileViewModelSportTimer: ObservableObject {
    @Published var profileDataSportTimer = ProfileModelSportTimer()
    private let coreDataManagerSportTimer = PersistenceControllerSportTimer.shared

    func fetchProfileDataSportTimer() {
        let request: NSFetchRequest<WorkoutSportTimer> = WorkoutSportTimer.fetchRequest()
        
        do {
            let workouts = try coreDataManagerSportTimer.container.viewContext.fetch(request)
            let totalWorkouts = workouts.count
            let totalDuration = workouts.reduce(0) { $0 + TimeInterval($1.duration) }
            
            DispatchQueue.main.async {
                self.profileDataSportTimer.totalWorkouts = totalWorkouts
                self.profileDataSportTimer.totalDuration = totalDuration
            }
        } catch {
            print("Failed to fetch workouts: \(error)")
        }
    }
    
    func clearAllDataSportTimer() {
        let context = coreDataManagerSportTimer.container.newBackgroundContext()
        context.perform {
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = WorkoutSportTimer.fetchRequest()
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

            do {
                try context.execute(deleteRequest)
                try context.save()
                self.fetchProfileDataSportTimer()
            } catch {
                print("Failed to clear all data: \(error)")
            }
        }
    }

    func setUserImageSportTimer(image: Image) {
        profileDataSportTimer.userImage = image
    }
}
