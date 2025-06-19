import SwiftUI
struct MovieScroll: View {
 @State private var selectedItem: MovieItem? = nil
 @State private var movie: [MovieItem] = []
 var body: some View {
 VStack(alignment: .leading) {
 Text("Peliculas")
 .padding(.horizontal, 4)
 .font(.largeTitle)
 .fontWeight(.bold)
 .foregroundColor(.white)
 .lineLimit(1)
 ScrollView(.horizontal, showsIndicators: false) {
 HStack(spacing: 10) {
 ForEach(movie) { item in
 VStack(alignment: .leading, spacing: 4) {
 AsyncImage(url: URL(string: item.image)) { image in
 image
 .resizable()
 .scaledToFill()
 } placeholder: {
 ProgressView()
 }
.frame(width: 300, height: 200)
 .clipped()
.cornerRadius(6)
 Text(item.title)
 .font(.headline)
 .fontWeight(.medium)
 .foregroundColor(.white)
 .lineLimit(1)
 }
.onTapGesture {
 selectedItem = item
 }
 }
 }
 .padding(.horizontal, 4)
 }
 }
 .sheet(item: $selectedItem) { item in
 MovieCard(item: item)
 }
 .task {
 await fetchMovie()
 }
 }
 func fetchMovie() async {
 guard let url = URL(string: "https://stingray-app2efs5.ondigitalocean.app/SV") else { return }
 do {
 let (data, _) = try await URLSession.shared.data(from: url)
 let decoded = try JSONDecoder().decode([MovieItem].self, from: data)
 movie = decoded
 print("✅ Movie cargado: \(movie.count) elementos")
 } catch {
 print("❌ Error al cargar Movie: \(error.localizedDescription)")
 }
 }
}
