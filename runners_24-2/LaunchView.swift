import SwiftUI

struct LaunchView: View {
    @Binding var isLaunch: Bool // ContentView와 상태를 공유하기 위한 Binding
    @State private var showSecondImage = false // 두 번째 이미지를 표시할 상태

    var body: some View {
        ZStack {
            // 첫 번째 이미지
            Image("LaunchImage")
                .resizable()
                .scaledToFit()
                .frame(width: 440, height: 956)
                .animation(.easeInOut(duration: 1), value: showSecondImage) // 페이드 전환 애니메이션
                .onAppear {
                    // 일정 시간 후 두 번째 이미지로 전환
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.showSecondImage = true
                    }
                }
            
            // 두 번째 이미지
            Image("Launch_touch")
                .resizable()
                .scaledToFit()
                .frame(width: 440, height: 956)
                .opacity(showSecondImage ? 1 : 0) // 첫 번째 이미지가 사라질 때 두 번째 이미지 페이드인
                .animation(.easeInOut(duration: 1), value: showSecondImage) // 페이드 전환 애니메이션
                .onTapGesture {
                    // 화면을 터치하면 LaunchView를 종료하고 다음 화면으로 전환
                    self.isLaunch = false
                }
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView(isLaunch: .constant(true)) // Preview용으로 상태 제공
    }
}
