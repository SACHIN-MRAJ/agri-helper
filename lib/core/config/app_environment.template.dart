/// Enterprise Application Environment & Gateway Configuration Template
/// For local development or CI/CD deployments.
class AppEnvironment {
  // Gateway endpoints
  static const String _groqEndpoint =
      'https://api.groq.com/openai/v1/chat/completions';
  static const String _weatherEndpoint =
      'https://api.openweathermap.org/data/2.5/forecast';
  static const String _openMeteoEndpoint =
      'https://api.open-meteo.com/v1/forecast';
  static const String _openMeteoArchiveEndpoint =
      'https://archive-api.open-meteo.com/v1/archive';

  /// Resolves the Groq LLM API Key:
  /// Supply via --dart-define=GROQ_API_KEY=... or configure in app_environment.dart
  static String get groqApiKey {
    const fromEnv = String.fromEnvironment('GROQ_API_KEY');
    if (fromEnv.isNotEmpty) return fromEnv;
    return 'YOUR_GROQ_API_KEY';
  }

  /// Resolves the Weather Service API Key:
  /// Supply via --dart-define=WEATHER_API_KEY=... or configure in app_environment.dart
  static String get weatherApiKey {
    const fromEnv = String.fromEnvironment('WEATHER_API_KEY');
    if (fromEnv.isNotEmpty) return fromEnv;
    return 'YOUR_WEATHER_API_KEY';
  }

  /// Prepared Groq Chat completion endpoint
  static Uri get groqChatUri => Uri.parse(_groqEndpoint);

  /// Standardized Groq request headers
  static Map<String, String> get groqHeaders => {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $groqApiKey',
      };

  /// Constructs the OpenWeatherMap forecast URI
  static Uri weatherForecastUri({required double lat, required double lon}) {
    return Uri.parse(
      '$_weatherEndpoint?lat=$lat&lon=$lon&appid=$weatherApiKey&units=metric',
    );
  }

  /// Constructs Open-Meteo forecast URI
  static Uri meteoForecastUri({
    required double lat,
    required double lon,
    required String startDate,
    required String endDate,
  }) {
    return Uri.parse(
      '$_openMeteoEndpoint'
      '?latitude=$lat&longitude=$lon'
      '&current=temperature_2m'
      '&daily=precipitation_sum'
      '&start_date=$startDate&end_date=$endDate'
      '&timezone=auto',
    );
  }

  /// Constructs Open-Meteo historical archive URI
  static Uri meteoArchiveUri({
    required double lat,
    required double lon,
    required String startDate,
    required String endDate,
  }) {
    return Uri.parse(
      '$_openMeteoArchiveEndpoint'
      '?latitude=$lat&longitude=$lon'
      '&start_date=$startDate&end_date=$endDate'
      '&daily=temperature_2m_mean,precipitation_sum,relative_humidity_2m_mean'
      '&timezone=auto',
    );
  }

  /// Constructs Open-Meteo fallback recent history URI
  static Uri meteoRecentHistoryUri({
    required double lat,
    required double lon,
  }) {
    return Uri.parse(
      '$_openMeteoEndpoint'
      '?latitude=$lat&longitude=$lon'
      '&daily=temperature_2m_mean,precipitation_sum,relative_humidity_2m_mean'
      '&timezone=auto'
      '&past_days=92'
      '&forecast_days=1',
    );
  }

  /// Constructs Open-Meteo 14-day future forecast URI
  static Uri meteoFourteenDayForecastUri({
    required double lat,
    required double lon,
  }) {
    return Uri.parse(
      '$_openMeteoEndpoint'
      '?latitude=$lat&longitude=$lon'
      '&daily=temperature_2m_max,temperature_2m_min,precipitation_sum,'
      'precipitation_probability_max,relative_humidity_2m_max,'
      'wind_speed_10m_max,et0_fao_evapotranspiration'
      '&forecast_days=14'
      '&timezone=auto',
    );
  }
}
