import Foundation

class SettingsManager {
    static let shared = SettingsManager()

    private let defaults = UserDefaults.standard

    private struct Keys {
        static let isVibrationEnabled = "isVibrationEnabled"
        static let isSoundEnabled = "isSoundEnabled"
    }

    var isVibrationEnabled: Bool {
        get {
            return defaults.object(forKey: Keys.isVibrationEnabled) as? Bool ?? true
        }
        set {
            defaults.set(newValue, forKey: Keys.isVibrationEnabled)
        }
    }

    var isSoundEnabled: Bool {
        get {
            return defaults.object(forKey: Keys.isSoundEnabled) as? Bool ?? true
        }
        set {
            defaults.set(newValue, forKey: Keys.isSoundEnabled)
        }
    }

    private init() {}
} 