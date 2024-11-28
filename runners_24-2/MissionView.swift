import SwiftUI

struct MissionView: View {
    var body: some View {
        VStack {
            Text("미션리스트")
                .font(.largeTitle)
                .bold()
        }
    }
}

struct MissionView_Previews: PreviewProvider {
    static var previews: some View {
        MissionView()
    }
}
