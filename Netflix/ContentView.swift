import SwiftUI

struct ContentView: View {
    @State private var banners: [Banner] = []
    @State private var selectedIndex = 0
    let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()

    var body: some View {
        ScrollView {
            VStack {
                HStack(alignment: .center) {
                    Text("Inicio")
                        .padding(.horizontal, 15)
                        .padding(.vertical, 5)
                        .background(Color.white)
                        .foregroundColor(.black)
                        .clipShape(Capsule())
                        .fontWeight(.bold)
                    Spacer()
                    Image("netflix_logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                }
                .padding(.top, 50)

                HStack {
                    Text("Tendencias")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .lineLimit(1)
                    Spacer()
                }
                .padding(.horizontal, 30)
                .padding(.top, 20)

                // Carrusel dinámico desde API
                ScrollViewReader { proxy in
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(Array(banners.enumerated()), id: \.1.id) { index, banner in
                                ZStack {
                                    AsyncImage(url: URL(string: banner.image)) { image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                    } placeholder: {
                                        Color.gray
                                    }
                                    .frame(width: 600, height: 400)
                                    .clipped()
                                    .cornerRadius(15)
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text(banner.title.uppercased())
                                            .font(.largeTitle)
                                            .foregroundColor(.white)
                                            .bold()
                                        HStack {
                                            Image(systemName: "arrow.up.circle")
                                                .foregroundStyle(.red)
                                            Text("#\(index + 1) Tendencia hoy")
                                                .fontWeight(.bold)
                                                .foregroundStyle(.red)
                                        }
                                        Text(banner.description)
                                            .font(.caption)
                                            .bold()
                                            .foregroundColor(.white)
                                        if let duration = banner.duration {
                                            Text(duration)
                                                .font(.caption)
                                                .foregroundColor(.white.opacity(0.8))
                                        }
                                    }
                                    .padding()
                                    .frame(maxWidth: 600, alignment: .leading)
                                    .background(Color.black.opacity(0.5))
                                    .cornerRadius(10)
                                    .padding()
                                    .offset(y: 120)
                                }
                                .frame(width: 600, height: 400)
                                .id(index)
                            }
                        }
                        .padding(.horizontal, 30)
                    }
                    .onReceive(timer) { _ in
                        withAnimation {
                            selectedIndex = (selectedIndex + 1) % max(banners.count, 1)
                            proxy.scrollTo(selectedIndex, anchor: .center)
                        }
                    }
                }
                .frame(height: 400)
                // Scrolls adicionales
                SeriesScroll()
                    .padding()
                MovieScroll()
                    .padding()
            }
            .padding(.horizontal)
        }
        .task {
            await fetchBanners()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            RadialGradient(
                gradient: Gradient(colors: [Color(red: 0.4, green: 0, blue: 0), .black]),
                center: .center,
                startRadius: 0,
                endRadius: 500
            )
        )
        .ignoresSafeArea()
    }

    func fetchBanners() async {
        let urls = [
            "https://stingray-app-2efs5.ondigitalocean.app/series",
            "https://stingray-app-2efs5.ondigitalocean.app/SV"
        ]
        var allItems: [Banner] = []
        for urlString in urls {
            if let url = URL(string: urlString) {
                do {
                    let (data, _) = try await URLSession.shared.data(from: url)
                    let decoded = try JSONDecoder().decode([Banner].self, from: data)
                    allItems += decoded
                } catch {
                    print("❌ Error cargando desde \(urlString): \(error.localizedDescription)")
                }
            }
        }
        banners = Array(allItems.prefix(3))
        print("✅ Se cargaron \(banners.count) banners combinados")
    }
}

#Preview {
    ContentView()
}
