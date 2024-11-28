import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()

    override init() {
        super.init()
        locationManager.delegate = self
    }

    // 위치 권한 요청 메소드
    func requestLocationPermission() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestWhenInUseAuthorization()  // "위치 사용 시" 권한 요청
            locationManager.startUpdatingLocation()
        }
    }

    // 위치 업데이트 성공 시 호출되는 메소드
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            print("현재 위치: \(location.coordinate.latitude), \(location.coordinate.longitude)")
        }
    }

    // 위치 업데이트 실패 시 호출되는 메소드
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("위치 오류: \(error.localizedDescription)")
    }
}
