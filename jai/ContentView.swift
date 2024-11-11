import SwiftUI

struct ContentView: View {
    var platforms: [Platform] = [.init(name: "xBox", imageName: "xbox.logo", color: .purple),
                                .init(name: "Playstation", imageName: "playstation.logo", color: .green),
                                .init(name: "PC", imageName: "pc", color: .pink),
                                .init(name: "Mobile", imageName: "iphone.gen2", color: .mint)]
    
    var games: [Game] = [.init(name: "Minecraft", rating: "100"),
                         .init(name: "God Of War", rating: "100"),
                         .init(name: "Dota 2", rating: "100"),
                         .init(name: "Fortnite", rating: "100")]
    
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                Section("Platforms") {
                    ForEach(platforms, id: \.name) { platform in
                        NavigationLink(value: platform) {
                            Label(platform.name, systemImage: platform.imageName)
                                .foregroundColor(platform.color)
                        }
                    }
                }
                Section("Games") {
                    ForEach(games, id: \.name) { game in
                        NavigationLink(value: game) {
                            Text(game.name)
                        }
                    }
                }
            }
            .navigationTitle("Gaming")
            .navigationDestination(for: Platform.self) { platform in
                ZStack {
                    platform.color.ignoresSafeArea()
                    
                    VStack {
                        Label(platform.name, systemImage: platform.imageName)
                            .font(.largeTitle).bold()
                        List {
                            ForEach(games, id: \.name) { game in
                                NavigationLink(value: game) {
                                    Text(game.name)
                                }
                            }
                        }
                    }
                }
            }
            .navigationDestination(for: Game.self) { game in
                VStack(spacing: 20) {
                    Text("\(game.name) - \(game.rating)")
                        .font(.largeTitle.bold())
                    
                    Button("Recomended game") {
                        path.append(games.randomElement()!)
                    }
                    
                    Button("Go to another platform") {
                        path.append(platforms.randomElement()!)
                    }
                    
                    Button("Go home") {
                        path.removeLast(path.count)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Platform: Hashable {
    let name: String
    let imageName: String
    let color: Color
}

struct Game: Hashable {
    let name: String
    let rating: String
}
