import SwiftUI
import NMapsMap
import CoreLocation
import WebKit
struct RunMapView: View {
    @State private var mapView: NMFMapView?
    @State private var elapsedTime: TimeInterval = 0 // 경과 시간 (초)
    @State private var distanceTraveled: Double = 0.0 // 달린 거리 (Km)
    @State private var timer: Timer? // 타이머
    @State private var isRunning: Bool = false // 타이머 실행 상태
    @State private var showStartDialog: Bool = false // 시작 Dialog 표시 여부
    @State private var showWebView: Bool = false // WebView 표시 여
    
    var body: some View {
        ZStack {
            // 지도 뷰
            NaverMapView(mapView: $mapView, onUpdateDistance: updateDistance)
                .frame(width: UIScreen.main.bounds.width, height: 500)
                .cornerRadius(10)
                .padding(.top, -355)
                .padding()
            
            VStack {
                Spacer()
                
                // 스톱워치 및 달린 거리 UI
                VStack {
                    Text("⏱ 러닝 시간")
                        .font(.headline)
                    Text(formatElapsedTime(elapsedTime))
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 8)
                    
                    Text("🏃 달린거리")
                        .font(.headline)
                    Text(String(format: "%.2f Km", distanceTraveled))
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                .frame(maxWidth: 300)
                .padding()
                .background(Color.white.opacity(0.8))
                .cornerRadius(15)
//                .shadow(radius: 5)
                .padding(.bottom, 15)
                
                // 시작/정지 버튼
                Button(action: {
                    if isRunning {
                        toggleStopwatch()
                    } else {
                        showStartDialog = true
                    }
                }) {
                    Text(isRunning ? "Stop" : "Start")
                        .frame(maxWidth: 200)
                        .padding()
                        .background(isRunning ? Color.gray : Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 30)
                .alert(isPresented: $showStartDialog) {
                    Alert(
                        title: Text("러닝 시작").font(.headline),
                        message: Text("어떻게 러닝을 시작하시겠습니까?").font(.subheadline),
                        primaryButton: .default(Text("달리러 가기")) {
                            startSoloRun()
                        },
                        secondaryButton: .default(Text("약속잡기")) {
                            showWebView = true
                        }
                    )
                }
                

            }
            
            // 현재 위치 버튼
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    NaverMapView.CurrentLocationButton {
                        moveToCurrentLocation()
                    }
                    .padding(.trailing, 25)
                    .padding(.bottom, 310)
                }
            }
        }
        .sheet(isPresented: $showWebView) {
            MyWebview(urlToLoad: "https://runnershigh-web.vercel.app/")
        }
    }
    
    private func moveToCurrentLocation() {
        guard let mapView = mapView else { return }
        let locationOverlay = mapView.locationOverlay
        let location = locationOverlay.location
        let cameraUpdate = NMFCameraUpdate(scrollTo: location)
        cameraUpdate.animation = .easeIn
        mapView.moveCamera(cameraUpdate)
    }

    private func startSoloRun() {
        toggleStopwatch()
    }

    // 스톱워치 토글
    private func toggleStopwatch() {
        if isRunning {
            stopStopwatch()
        } else {
            startStopwatch()
        }
        isRunning.toggle()
    }
    
    // 스톱워치 시작
    private func startStopwatch() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            elapsedTime += 1
        }
    }
    
    // 스톱워치 정지
    private func stopStopwatch() {
        timer?.invalidate()
        timer = nil
    }
    
    // 시간 형식화
    private func formatElapsedTime(_ time: TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = (Int(time) % 3600) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    // 거리 업데이트
    private func updateDistance(newDistance: Double) {
        distanceTraveled += newDistance
    }
}

struct NaverMapView: UIViewRepresentable {
    @Binding var mapView: NMFMapView?
    var onUpdateDistance: (Double) -> Void // 거리 업데이트 콜백
    
    static func CurrentLocationButton(action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(systemName: "location.fill")
                .padding()
                .background(Color.white)
                .clipShape(Circle())
                .shadow(radius: 3)
        }
    }
    
    struct WebView: UIViewRepresentable {
        let url: URL

        func makeUIView(context: Context) -> WKWebView {
            let webView = WKWebView()
            let request = URLRequest(url: url)
            webView.load(request)
            return webView
        }

        func updateUIView(_ uiView: WKWebView, context: Context) {}
    }

    class Coordinator: NSObject, CLLocationManagerDelegate {
        var parent: NaverMapView
        let locationManager = CLLocationManager()
        private var lastLocation: CLLocation?
        
        init(parent: NaverMapView) {
            self.parent = parent
            super.init()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.requestWhenInUseAuthorization()
        }
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let location = locations.last else { return }
            
            // 지도 이동 및 내 위치 업데이트
            DispatchQueue.main.async {
                guard let mapView = self.parent.mapView else { return }
                
                // 지도 위치 업데이트
                let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: location.coordinate.latitude, lng: location.coordinate.longitude))
                cameraUpdate.animation = .easeIn
                mapView.moveCamera(cameraUpdate)
                mapView.locationOverlay.location = NMGLatLng(lat: location.coordinate.latitude, lng: location.coordinate.longitude)
            }
            
            // 거리 계산
            if let lastLocation = lastLocation {
                let distance = location.distance(from: lastLocation) / 1000 // meters to kilometers
                parent.onUpdateDistance(distance)
            }
            
            // 마지막 위치 업데이트
            lastLocation = location
        }
        
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print("Location update failed: \(error.localizedDescription)")
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> NMFMapView {
        let mapView = NMFMapView()
        self.mapView = mapView
        
        // 초기 위치 (서울)
        let initialPosition = NMFCameraPosition(NMGLatLng(lat: 37.5666102, lng: 126.9783881), zoom: 15)
        mapView.moveCamera(NMFCameraUpdate(position: initialPosition))
        
        // 내 위치 오버레이 표시
        mapView.locationOverlay.hidden = false
        
        // 위치 업데이트 요청
        context.coordinator.locationManager.startUpdatingLocation()
        
        return mapView
    }
    
    func updateUIView(_ uiView: NMFMapView, context: Context) {}
}


struct RunMapView_Previews: PreviewProvider {
    static var previews: some View {
        RunMapView()
    }
}
