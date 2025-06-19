import SwiftUI
struct MovieCard: View {
 let item: MovieItem
 @Environment(\.dismiss) var dismiss
 var body: some View {
 ScrollView {
 ZStack {
 Color.black.opacity(0.7)
 .ignoresSafeArea()

 VStack(alignment: .leading, spacing: 12) {
 VStack(alignment: .trailing){
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
 Spacer()


 AsyncImage(url: URL(string:
item.image.trimmingCharacters(in: .whitespacesAndNewlines))) { image in
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
 }
 Text(item.description)
 .font(.body)
 .padding(.top, 4)
 Spacer()
 }
 .padding()
 }
 }
 }
