import Foundation

class MenuViewModel: ObservableObject {
    
    @Published var selectedButton: String?
    @Published var catergories = ["All", "Sleep", "Inner Peace", "Stress", "Anxiety"]
    @Published var meditationCollection = [
        MeditationModel(
            text: "Zen Meditation",
            image: .meditation,
            background: .orangeMain,
            time: 20,
            index: 0,
            audioURL: URL(string: "http://mediaserv30.live-streams.nl:8086/live")!,
            category: "Inner Peace"
        ),
        MeditationModel(
            text: "Reflection",
            image: .reflection,
            background: .blueMain,
            time: 6,
            index: 1,
            audioURL: URL(string: "http://mediaserv33.live-streams.nl:8034/live")!,
            category: "Stress"
        ),
        MeditationModel(
            text: "Visualization",
            image: .visualization,
            background: .pinkMain,
            time: 13,
            index: 2,
            audioURL: URL(string: "http://mediaserv38.live-streams.nl:8006/live")!,
            category: "Anxiety"
        ),
        MeditationModel(
            text: "Loving Kindness",
            image: .kindness,
            background: .yellow,
            time: 15,
            index: 3,
            audioURL: URL(string: "http://mediaserv33.live-streams.nl:8036/live")!,
            category: "Inner Peace"
        ),
        MeditationModel(
            text: "Focused Attention",
            image: .focused,
            background: .purpleMain,
            time: 10,
            index: 4,
            audioURL: URL(string: "http://mediaserv30.live-streams.nl:8000/live")!,
            category: "Sleep"
        )
        /* Example for local file
        MeditationModel(
            text: "Test Audio",
            image: .meditation,
            background: .orangeMain,
            time: 2,
            index: 5,
            audioURL: Bundle.main.url(
                forResource: "test",
                withExtension: "mp3"
            )!,
            category: "Sleep"
        )
        */
    ]
    
    var filteredMeditations: [MeditationModel] {
        guard let selectedCategory = selectedButton else {
            return meditationCollection
        }
        
        if selectedCategory == "All" {
            return meditationCollection
        }
        
        return meditationCollection.filter { $0.category == selectedCategory }
    }
    
    init() {
        selectedButton = catergories.first
    }
}
