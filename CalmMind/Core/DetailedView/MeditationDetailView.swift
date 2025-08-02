import SwiftUI
import AVKit

struct MeditationDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: MeditationDetailViewModel
    
    init(model: MeditationModel) {
        self.viewModel = MeditationDetailViewModel(model: model)
    }
    
    var body: some View {
        ZStack {
            NavigationView {
                VStack(spacing: 0) {
                    Spacer()
                    
                    CircleView(image: viewModel.model.image,
                               backgroundColor: viewModel.model.background)
                        .padding(.horizontal, 32)
                        .padding(.top, 32)
                    
                    Text(viewModel.model.text)
                        .fontWeight(.medium)
                        .font(.system(size: 24))
                        .padding(.top)
                    
                    Text("Inner Peace")
                        .fontWeight(.medium)
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                    
                    HStack(alignment: .center) {
                        Button(action: {
                            viewModel.pausePlayTrackTapped()
                        }) {
                            Image(viewModel.isPlaying ? .pause : .play)
                                .resizable()
                                .frame(width: 32, height: 32)
                                .padding()
                                .background(viewModel.model.background)
                                .foregroundColor(Color.white)
                                .cornerRadius(32)
                        }
                        .frame(width: 64, height: 64)
                    }
                    .padding(.top, 34)
                    
                    // Only show progress bar if not a live stream
                    if !viewModel.isLiveStream {
                        HStack(alignment: .center) {
                            Text("00:02")
                                .fontWeight(.regular)
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                            
                            MusicTimelineProgressView(progress: $viewModel.progress,
                                                      mainColor: viewModel.model.background)
                            .tint(.yeallowMain)
                            
                            Text("00:0\(viewModel.model.time)")
                                .fontWeight(.regular)
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                        }
                        .padding(.top, 34)
                        .padding(.leading, 30)
                        .padding(.trailing, 30)
                    }
                    
                    Spacer()
                    
                }
                .background(Color.white)
                .cornerRadius(24)
                .navigationBarItems(
                    leading: HStack {
                        Button {
                            self.presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image(.chevronArrowLeft)
                                .font(.title)
                        }
                    }
                )
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    MeditationDetailView(
        model: MeditationModel(
            text: "Reflection",
            image: .reflection,
            background: .blueMain,
            time: 6,
            index: 1,
            audioURL: URL(
                string: "http://mediaserv33.live-streams.nl:8034/live"
            )!,
            category: "Inner Peace"
        )
    )
}

//https://www.hionline.eu/streaming-url/
