import Foundation

struct WeatherService {
    static func fetchWeather(lat: Double, lon: Double, apiKey: String, completion: @escaping (WeatherModel) -> Void) {
        let urlStr = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(apiKey)&units=metric"
        guard let url = URL(string: urlStr) else { return }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data {
                if let decoded = try? JSONDecoder().decode(WeatherModel.self, from: data) {
                    completion(decoded)
                }
            }
        }.resume()
    }

    static func fetchWeatherByCity(city: String, apiKey: String, completion: @escaping (WeatherModel) -> Void) {
        let cityQuery = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? city
        let urlStr = "https://api.openweathermap.org/data/2.5/weather?q=\(cityQuery)&appid=\(apiKey)&units=metric"
        guard let url = URL(string: urlStr) else { return }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data {
                if let decoded = try? JSONDecoder().decode(WeatherModel.self, from: data) {
                    completion(decoded)
                }
            }
        }.resume()
    }
}
