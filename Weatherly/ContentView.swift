import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = WeatherViewModel()
    @State private var cityInput: String = ""
    @FocusState private var isTextFieldFocused: Bool

    var body: some View {
        ZStack {
            viewModel.background
                .ignoresSafeArea()
                .animation(.easeInOut(duration: 1), value: viewModel.condition)

            VStack(spacing: 24) {
                // 🔍 Blurred Search Bar + 📍 GPS Button
                HStack {
                    HStack(spacing: 12) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)

                        TextField("Enter city name", text: $cityInput)
                            .focused($isTextFieldFocused)
                            .submitLabel(.search)
                            .onSubmit {
                                viewModel.fetchWeatherByCity(city: cityInput)
                                hideKeyboard()
                            }
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(16)
                    .shadow(radius: 4)

                    Button(action: {
                        cityInput = ""
                        viewModel.fetchWeather() // 👈 Go back to current location
                        hideKeyboard()
                    }) {
                        Image(systemName: "location.fill")
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Color.blue)
                            .clipShape(Circle())
                            .shadow(radius: 4)
                    }
                }
                .padding(.horizontal)

                Spacer()

                // 🌤️ Weather Info
                VStack(spacing: 10) {
                    Text(viewModel.cityName)
                        .font(.system(size: 36, weight: .bold))
                        .transition(.opacity.combined(with: .scale))

                    Text(viewModel.temperature)
                        .font(.system(size: 72, weight: .heavy))
                        .transition(.opacity.combined(with: .scale))

                    Text(viewModel.condition)
                        .font(.title2)

                    // 🌈 Animated Weather Layer
                    viewModel.weatherAnimation
                        .frame(height: 180)
                        .transition(.opacity)
                }
                .padding()
                .foregroundColor(viewModel.isDarkMode ? .white : .black)
                .animation(.easeInOut(duration: 0.5), value: viewModel.temperature)

                Spacer()

                // 🌗 Dark Mode Toggle
                Toggle(isOn: $viewModel.isDarkMode) {
                    Text("Dark Mode")
                        .font(.subheadline)
                }
                .padding(.horizontal)
                .toggleStyle(SwitchToggleStyle(tint: .blue))
            }
            .padding(.top, 40)
        }
        .preferredColorScheme(viewModel.isDarkMode ? .dark : .light)
        .onTapGesture {
            hideKeyboard()
        }
        .onAppear {
            viewModel.fetchWeather()
        }
    }
}
