import SwiftUI
struct SeriesCard: View {
 let item: Series
 @Environment(\.dismiss) var dismiss
 var body: some View {
 ScrollView {
 ZStack {
 Color.black.opacity(0.7)
 .ignoresSafeArea()

 VStack(alignment: .leading, spacing: 12) {

 // Botón de cerrar arriba a la derecha
 HStack {
 Spacer()
Button(action: {
 dismiss()
 }) {
 Image(systemName: "xmark.circle.fill")
 .font(.title2)
 .foregroundStyle(.white)
 }
.foregroundStyle(.opacity(0.3))
 .buttonStyle(.plain)
 }
 // Imagen de la serie
 AsyncImage(url: URL(string: item.image.trimmingCharacters(in:
.whitespacesAndNewlines))) { image in
 image
 .resizable()
.scaledToFit()
 } placeholder: {
 Color.gray
 }
 .frame(maxWidth: .infinity)
 .cornerRadius(10)

 Text(item.title)
 .font(.title)
 .bold()
 .foregroundColor(.white)
 HStack {
 Text(item.genre)
 .font(.subheadline)
 .foregroundColor(.secondary)
 Spacer()
Text(item.duration)
 .font(.subheadline)
 .foregroundColor(.secondary)
 }
 HStack {
 Image(systemName: "star.fill")
 .foregroundColor(.yellow)
 Text(String(format: "%.1f", item.rating))
 .font(.subheadline)
 .foregroundColor(.white)
 }
 Text(item.description)
 .font(.body)
 .foregroundColor(.white)
 .padding(.top, 4)
 Spacer()
 }
 .padding()
 }
 }
 }
}
