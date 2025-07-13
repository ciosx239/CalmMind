import SwiftUI

@main
struct CalmMindApp: App {
    var body: some Scene {
        WindowGroup {
            OnboardingView()
                .preferredColorScheme(.light)
        }
    }
}
