import Foundation
import AVFoundation

class MeditationDetailViewModel: ObservableObject {
    
    @Published var player: AVPlayer?
    @Published var currentURL: URL?
    @Published var progress: Double = 0.0
    @Published var isPlaying = false
    @Published var model: MeditationModel
    
    private var timeObserverToken: Any?
    
    var isLiveStream: Bool {
        guard let duration = player?.currentItem?.duration else { return false }
        return duration.isIndefinite
    }
    
    init(model: MeditationModel) {
        // Set up audio session for playback
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to set audio session: \(error)")
        }
        self.model = model
        self.currentURL = model.audioURL
        self.player = AVPlayer(url: currentURL!)
        addPeriodicTimeObserver()
    }
    
    deinit {
        if let token = timeObserverToken {
            player?.removeTimeObserver(token)
        }
    }
    
    private func addPeriodicTimeObserver() {
        let duration = Double(model.time * 60)
        timeObserverToken = player?.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 1), queue: .main) { [weak self] time in
            guard let self = self else { return }
            let currentSeconds = CMTimeGetSeconds(time)
            self.progress = duration > 0 ? currentSeconds / duration : 0
        }
    }
    
    func pausePlayTrackTapped() {
        isPlaying.toggle()
        if  isPlaying {
            player?.play()
        } else {
            player?.pause()
        }
    }
}
