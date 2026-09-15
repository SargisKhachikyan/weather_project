# Weather App

A simple Flutter app for checking the current weather by city name.

## Features

- Search for a city.
- View the city, country, and country flag.
- Check the temperature and feels-like temperature in Celsius.
- View wind speed in km/h.
- Save search history locally and clear it when needed.
- Display a background image based on the temperature.

## Backgrounds

| Temperature | Background |
|---|---|
| 20°C and above | Sunny |
| Above 0°C and below 20°C | Cloudy |
| 0°C and below | Snow |

Backgrounds are selected by temperature, not actual weather conditions. Rain and night images are included in the assets but are not selected automatically.

## Technologies

- **Flutter and Dart** — user interface and application code.
- **flutter_bloc** — state management.
- **http** — API requests.
- **get_it** — dependency management.
- **sqflite** — local search history.
- **path_provider** — local storage for country flags.
- **Firebase Core** — Firebase initialization.
- **flutter_local_notifications** — local notifications.

## Data Sources

- **Weatherstack** — current weather.
- **REST Countries API** — country codes.
- **FlagsAPI** — country flags.

## Project Structure

```text
lib/
├── main.dart
├── firebase_options.dart
├── home_page/
│   ├── home_page.dart
│   ├── state/
│   │   ├── weather_bloc.dart
│   │   ├── weather_events.dart
│   │   └── weather_state.dart
│   └── presentation/
│       └── widgets/
│           ├── weather_city_search.dart
│           ├── weather_location_header.dart
│           ├── weather_summary.dart
│           ├── weather_history_title.dart
│           ├── weather_history_list.dart
│           └── weather_sky_background.dart
├── models/
├── repository/
└── service/

assets/
└── weather/
    ├── sunny.jpg
    ├── clouds.jpg
    ├── rainy.jpg
    ├── snow.jpg
    └── night.jpg
```

## Getting Started

1. Install Flutter and the tools required for your target platform.
2. Download or clone the project.
3. Install dependencies:

   ```bash
   flutter pub get
   ```

4. Configure your API credentials in:
   - `lib/service/weather_api/weather_api.dart`
   - `lib/service/country_code_api/country_code_api.dart`

5. Configure Firebase for your application.
6. Connect a device or start a simulator, then run:

   ```bash
   flutter run
   ```

The current notification setup is iOS-only and displays a test notification at startup. Other platforms need additional notification configuration.

## Usage

Enter a city name in **Search city** and press the keyboard’s search button. The app displays the weather and saves a history entry containing the country, temperature, flag, and wind speed.

Press **Clear** to delete saved history.