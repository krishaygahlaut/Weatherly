import Foundation
import SwiftUI
import CoreLocation

class WeatherViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    // MARK: - Published UI Properties
    @Published var temperature: String = "--"
    @Published var condition: String = "--"
    @Published var cityName: String = "Loading..."
    @Published var isDarkMode = false
    @Published var background: AnyView = AnyView(Color.blue)
    @Published var weatherAnimation: AnyView = AnyView(EmptyView())

    // MARK: - Private Properties
    private let locationManager = CLLocationManager()
    private let apiKey = "3adad987f9d770b8092fb58c5f025340"

    // MARK: - Init
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    // MARK: - Fetch Weather (GPS)
    func fetchWeather(lat: Double = 28.61, lon: Double = 77.20) {
        WeatherService.fetchWeather(lat: lat, lon: lon, apiKey: apiKey) { weather in
            DispatchQueue.main.async {
                self.updateData(weather)
            }
        }
    }

    // MARK: - Fetch Weather (City)
    func fetchWeatherByCity(city: String) {
        WeatherService.fetchWeatherByCity(city: city, apiKey: apiKey) { weather in
            DispatchQueue.main.async {
                self.updateData(weather)
            }
        }
    }

    // MARK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            fetchWeather(lat: location.coordinate.latitude, lon: location.coordinate.longitude)
        }
    }

    // MARK: - Update Data
    private func updateData(_ weather: WeatherModel) {
        self.temperature = "\(Int(weather.main.temp))°"
        self.condition = weather.weather.first?.main ?? "Clear"
        self.cityName = weather.name
        self.updateUI(condition: self.condition)
    }

    // MARK: - Dynamic UI Based on Condition
    private func updateUI(condition: String) {
        withAnimation {
            switch condition.lowercased() {
            case "clouds":
                background = AnyView(
                    LinearGradient(colors: [.gray, .blue.opacity(0.6)], startPoint: .top, endPoint: .bottom)
                )
                weatherAnimation = AnyView(
                    CloudAnimationView()
                )

            case "rain":
                background = AnyView(
                    LinearGradient(colors: [.gray, .blue.opacity(0.4)], startPoint: .top, endPoint: .bottom)
                )
                weatherAnimation = AnyView(
                    RainAnimationView()
                )

            case "clear":
                background = AnyView(
                    LinearGradient(colors: [.cyan, .blue], startPoint: .top, endPoint: .bottom)
                )
                weatherAnimation = AnyView(
                    SunAnimationView()
                )

            case "wind":
                background = AnyView(
                    LinearGradient(colors: [.gray.opacity(0.2), .blue], startPoint: .top, endPoint: .bottom)
                )
                weatherAnimation = AnyView(
                    WindAnimationView()
                )

            default:
                background = AnyView(Color.blue)
                weatherAnimation = AnyView(EmptyView())
            }
        }
    }
}
