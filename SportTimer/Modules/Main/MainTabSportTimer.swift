import SwiftUI

enum TabSportTimer: String, CaseIterable {
    case home = "Home"
    case timer = "Timer"
    case history = "History"
    case profile = "Profile"

    var systemImage: String {
        switch self {
        case .home:
            return "house"
        case .timer:
            return "timer"
        case .history:
            return "clock.arrow.circlepath"
        case .profile:
            return "person"
        }
    }

    var selectedSystemImage: String {
        switch self {
        case .home:
            return "house.fill"
        case .timer:
            return "timer"
        case .history:
            return "clock.arrow.circlepath"
        case .profile:
            return "person.fill"
        }
    }
} 