import SwiftUI
import CoreLocation

struct CommunityView: View {
    var body: some View {
        VStack(spacing: 0) {
            HeaderView().edgesIgnoringSafeArea(.top)
            DateSelectionView()
            BoardListView()
        }
        .background(Color.white)
    }
}

struct HeaderView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Spacer()
            }
            .padding(.horizontal)

            Text("게시판")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.white)
                .padding(.horizontal)
                .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top ?? 20) // Adjust for the notch
            
            Text("현재위치: 부산광역시 부산진구 엄광로 176")
                .font(.subheadline)
                .foregroundColor(.white)
                .padding(.horizontal)
        }
        .padding(.bottom)
        .frame(maxWidth: .infinity)
        .background(Color("BoardColor"))
        .cornerRadius(11, corners: [.bottomLeft, .bottomRight])
    }
}

struct DateSelectionView: View {
    var body: some View {
        HStack(spacing: 20) {
            DateButton(day: "12", weekday: "화", isSelected: true)
            DateButton(day: "13", weekday: "수", isSelected: false)
            DateButton(day: "14", weekday: "목", isSelected: false)
        }
        .padding()
    }
}

struct DateButton: View {
    let day: String
    let weekday: String
    let isSelected: Bool
    
    var body: some View {
        VStack {
            Text(day)
                .font(.title)
                .bold()
            Text(weekday)
                .font(.subheadline)
        }
        .padding()
        .background(isSelected ? Color.accentColor : Color.clear)
        .foregroundColor(isSelected ? .white : .primary)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.accentColor, lineWidth: isSelected ? 0 : 2)
        )
        .cornerRadius(16, corners: [.bottomLeft, .bottomRight])
    }
}

struct BoardListView: View {
    var body: some View {
        ScrollView {
            ForEach(0..<6) { index in
                BoardItemView(time: "11:00", location: "부산 광안리해수욕장", isUrgent: index == 1)
            }
        }
        .padding(.top)
    }
}

struct BoardItemView: View {
    let time: String
    let location: String
    let isUrgent: Bool
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(time)
                    .font(.headline)
                Text(location)
                    .font(.subheadline)
                    .bold()
                Text("남녀 모두")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            Spacer()
            Button(action: {
                // 신청 버튼 액션
            }) {
                Text(isUrgent ? "마감임박!" : "신청가능")
                    .font(.subheadline)
                    .padding()
                    .background(isUrgent ? Color.accentColor : Color("BoardColor"))
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: 2)
        .padding(.horizontal)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = 0.0
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}


struct CommunityView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityView()
    }
}
