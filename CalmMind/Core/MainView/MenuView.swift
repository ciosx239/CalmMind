import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel: MenuViewModel
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: [GridItem(.flexible())], spacing: 16) {
                    ForEach(viewModel.catergories, id: \.self) { item in
                        CategoryCell(text: item, isSelected: viewModel.selectedButton == item) {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                viewModel.selectedButton = item
                            }
                        }
                        .animation(.easeInOut(duration: 0.2), value: viewModel.selectedButton)
                    }
                }
                .padding()
            }
            .frame(height: 80)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    if let firstMeditation = viewModel.filteredMeditations.first {
                        openDetailView(firstMeditation)
                            .padding(.horizontal)
                            .transition(.asymmetric(
                                insertion: .move(edge: .top).combined(with: .opacity),
                                removal: .move(edge: .top).combined(with: .opacity)
                            ))
                    }
                    HStack(alignment: .top, spacing: 10) {
                        LazyVGrid(columns: [
                            GridItem(.flexible(), spacing: 0),
                        ], spacing: 16) {
                            ForEach(Array(viewModel.filteredMeditations.enumerated()), id: \.element.id) { index, item in
                                if index % 2 == 0 && index != 0 {
                                    openDetailView(item)
                                        .transition(.asymmetric(
                                            insertion: .move(edge: .leading).combined(with: .opacity),
                                            removal: .move(edge: .leading).combined(with: .opacity)
                                        ))
                                }
                            }
                        }
                        
                        LazyVGrid(columns: [
                            GridItem(.flexible(), spacing: 0),
                        ], spacing: 16) {
                            ForEach(Array(viewModel.filteredMeditations.enumerated()), id: \.element.id) { index, item in
                                if index % 2 != 0 {
                                    openDetailView(item)
                                        .transition(.asymmetric(
                                            insertion: .move(edge: .trailing).combined(with: .opacity),
                                            removal: .move(edge: .trailing).combined(with: .opacity)
                                        ))
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .animation(.easeInOut(duration: 0.4), value: viewModel.filteredMeditations)
                }
            }
        }
        .navigationBarItems(
            leading: HStack {
                Image(.logo)
                    .font(.title)
                Text("Hi, Hannah")
                    .fontWeight(.medium)
                    .font(.system(size: 24))
            },
//            trailing: Button(action: {
//                print("Navigation button tapped")
//            }) {
//                Image(.burger)
//            }
        )
        .navigationBarBackButtonHidden(true)
    }
    
    func openDetailView(_ model: MeditationModel) -> NavigationLink<MeditationCell, MeditationDetailView> {
        return NavigationLink(destination: MeditationDetailView(model: model)) {
            MeditationCell(viewModel: model)
        }
    }
}

#Preview {
    NavigationView {
        MainView(viewModel: MenuViewModel())
    }
}
