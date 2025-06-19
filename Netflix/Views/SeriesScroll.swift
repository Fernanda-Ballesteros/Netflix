import SwiftUI
struct SeriesScroll: View {
 @State private var selectedItem: Series? = nil
 @State private var seriesList: [Series] = []
 var body: some View {
 VStack(alignment: .leading) {
 Text("Series")
 .padding(.horizontal, 4)
 .font(.largeTitle)
 .fontWeight(.bold)
 .foregroundColor(.white)
 .lineLimit(1)
 ScrollView(.horizontal, showsIndicators: false) {
 HStack(spacing: 10) {
 ForEach(seriesList) { item in
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
 SeriesCard(item: item)
 }
 .task {
 await fetchSeries()
 }
 }
 func fetchSeries() async {
 guard let url = URL(string: "https://stingray-app2efs5.ondigitalocean.app/series") else { return }
 do {
 let (data, _) = try await URLSession.shared.data(from: url)
 let decoded = try JSONDecoder().decode([Series].self, from: data)
 seriesList = decoded
 print("✅ Series cargadas: \(seriesList.count)")
 } catch {
 print("❌ Error al cargar series: \(error.localizedDescription)")
 }
 }
}
#Preview {
 SeriesScroll()
}
