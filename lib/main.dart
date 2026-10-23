import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'core/config/app_environment.dart';
// marketplace and selva_work imports removed
// ═══════════════════════════════════════════════════════════
//  SIH25044 — AI Crop Yield Prediction & Optimization
//  Government of Odisha | Smart India Hackathon 2025
// ═══════════════════════════════════════════════════════════

// ─── Language Notifier (drives global rebuilds) ──────────────
final ValueNotifier<String> langNotifier = ValueNotifier<String>('en');

// ─── AppText — all UI strings in one place ───────────────────
class AppText {
  static String get currentLang => langNotifier.value;
  static set currentLang(String v) => langNotifier.value = v;

  static String get(String key) =>
      _strings[currentLang]?[key] ?? _strings['en']![key] ?? key;

  static const Map<String, Map<String, String>> _strings = {
    // ── ENGLISH ──────────────────────────────────────────────
    'en': {
      // App general
      'app_name': 'Agri Helper',
      'ai_crop_yield': 'AI Crop Yield Prediction',
      'sih_2025': 'Smart India Hackathon 2025',

      // Nav bar
      'nav_home': 'Home',
      'nav_predict': 'Predict',
      'nav_weather': 'Weather',
      'nav_advisory': 'Advisory',

      // Home screen
      'namaskara': 'Namaskara! 🌾',
      'season_label': 'Season',
      'rainfall_label': 'Rainfall',
      'temp_label': 'Temp',
      'quick_actions': 'Quick Actions',
      'predict_yield': 'Predict Yield',
      'enter_farm_details': 'Enter farm details',
      'scan_soil': 'Scan Soil',
      'ai_soil_analysis': 'AI soil analysis',
      'analysis': 'Analysis',
      'view_advisory': 'View all predictions',
      'recommended_crops': 'Recommended Crops',
      'recommendations_based': 'Recommendations based on current conditions',
      'season_suffix': 'Season',

      // IMD messages
      'imd_heavy_rain':
          '⚠️ IMD: Heavy rainfall expected. Avoid field work and pesticide spraying.',
      'imd_moderate_rain':
          '🌧 IMD: Moderate rainfall expected. Good for sowing.',
      'imd_high_temp': '🔥 IMD: High temperature alert. Increase irrigation.',
      'imd_cool': '❄ IMD: Cool weather conditions. Suitable for rabi crops.',
      'imd_stable': '✅ IMD: Weather conditions are stable for farming.',

      // Predict screen
      'predict': 'Predict Yield',
      'voice_input': 'Voice Input',
      'voice_snack': 'Voice input: Add speech_to_text package',
      'step_farm_info': 'Farm Info',
      'step_soil_water': 'Soil & Water',
      'step_predict': 'Predict',
      'crop_selection': 'Crop Selection',
      'crop_type_hint': 'Crop Type (Type or Select)',
      'select_crop': 'Select Crop',
      'season_dropdown': 'Season',
      'soil_land': 'Soil & Land',
      'soil_type_hint': 'Soil Type (Type or Select)',
      'select_soil': 'Select Soil',
      'farm_area': 'Farm Area (acres)',
      'acres_suffix': 'acres',
      'enter_farm_area': 'Enter farm area',
      'nutrients': 'Nutrients',
      'nitrogen': 'Nitrogen (N)',
      'phosphorus': 'Phosphorus (P)',
      'potassium': 'Potassium (K)',
      'climate_data': 'Climate Data',
      'annual_rainfall': 'Annual Rainfall',
      'mm_suffix': 'mm',
      'enter_rainfall': 'Enter rainfall data',
      'avg_temperature': 'Average Temperature',
      'celsius_suffix': '°C',
      'enter_temperature': 'Enter temperature',
      'predict_btn': 'Predict Yield with AI',
      'sowing_date_label': 'Sowing Date (Optional)',
      'sowing_date_hint': 'Select sowing date',
      'sowing_date_helper': 'Leave blank if not yet sown',

      // Result screen
      'agri_result': 'Agri Analysis Result',
      'recommended_crop': 'Recommended Crop',
      'kg_expected': 'kg expected yield',
      'smart_plan': "📋 Today's Smart Plan",
      'risk_level': 'Risk Level',
      'plan_skip_irr': '🌧 Rain expected → Skip irrigation',
      'plan_irrigate': '💧 Irrigate early morning (6 AM)',
      'plan_add_nitrogen': '🧪 Low moisture → Add Nitrogen fertilizer',
      'plan_monitor_temp': '🌡 Monitor temperature regularly',
      'risk_high': '🔴 High Risk',
      'risk_medium': '🟡 Medium Risk',
      'risk_low': '🟢 Low Risk',
      'summary_crop': '🌱 Crop',
      'summary_action': '📅 Action: Follow smart plan',
      'summary_irrigation': '💧 Irrigation: Based on rainfall',
      'summary_risk': '⚠ Risk',

      // Weather screen
      'weather_climate': 'Weather & Climate',
      'humidity': 'Humidity',
      'wind': 'Wind',
      'visibility_label': 'Visibility',
      'five_day_forecast': '5-Day Forecast',
      'agri_weather_impact': 'Agri-Weather Impact',
      'loading_insights': 'Loading weather insights...',
      'agri_heavy_rain':
          '🌧 Heavy rain expected. Avoid pesticide spraying and delay field work.',
      'agri_moderate_rain':
          '🌦 Moderate rain. Good for sowing but avoid fertilizers.',
      'agri_high_temp': '🔥 High temperature. Increase irrigation.',
      'agri_cool': '❄ Cool weather. Good for rabi crops.',
      'agri_strong_wind': '💨 Strong winds. Avoid spraying chemicals.',
      'agri_stable': '✅ Weather is stable. Good for farming.',

      // Advisory screen
      'crop_advisory': 'Crop Advisory',
      'season_alerts': 'Season Alerts',
      'kharif_alert':
          '⚠️  Kharif sowing window: June 15 – July 10. Optimal for rice across India\'s coastal and inland regions.',
      'best_crops': 'Best Crops for Your Region',
      'crop_rice': 'Rice (Paddy)',
      'tip_rice':
          'Sow MTU-7029 or Swarna varieties. Use System of Rice Intensification (SRI) to save 30% water.',
      'crop_maize': 'Maize',
      'tip_maize':
          'Plant in rows 60×20 cm. Apply zinc sulfate 25 kg/ha for better germination.',
      'crop_groundnut': 'Groundnut',
      'tip_groundnut':
          'Suitable for sandy loam soils. Treat seeds with Rhizobium culture before sowing.',

      // Profile screen
      'farmer_profile': 'Farmer Profile',
      'hello_farmer': 'Hello Farmer 👨‍🌾',
      'manage_location': 'Manage your location',
      'current_location': 'Current Location',
      'enter_location_manual': 'Enter Location Manually',
      'set_location': 'Set Location',
      'detect_location': 'Detect Location',
      'language': 'Language',

      // Snackbars / messages
      'turn_on_location': 'Turn ON location services',
      'permission_denied': 'Permission denied',
      'permission_permanently_denied': 'Permission permanently denied',
      'location_updated': '📍 Location updated successfully',
      'location_set': '📍 Location set',
      'location_not_found': '❌ Location not found',
      'failed_location': 'Failed to get location',

      // Seasons
      'kharif': 'Kharif',
      'rabi': 'Rabi',
      'zaid': 'Zaid',
      'kharif_season': 'Kharif (Jun–Oct)',
      'rabi_season': 'Rabi (Nov–Apr)',
      'zaid_season': 'Zaid (Apr–Jun)',

      // Crop names
      'rice': 'Rice',
      'wheat': 'Wheat',
      'maize': 'Maize',
      'groundnut': 'Groundnut',
      'mustard': 'Mustard',
      'sugarcane': 'Sugarcane',
      'cotton': 'Cotton',
      'millets': 'Millets',
      'pigeon_pea': 'Pigeon Pea (Arhar)',
      'green_gram': 'Green Gram (Moong)',
      'black_gram': 'Black Gram (Urad)',
      'sesame': 'Sesame',
      'ragi': 'Ragi',

      // Soil types
      'red_soil': 'Red Soil',
      'black_soil': 'Black Soil',
      'alluvial': 'Alluvial',
      'laterite': 'Laterite',
      'sandy_loam': 'Sandy Loam',

      // Misc
      'loading': 'Loading...',
      'unknown': 'Unknown',

      // AI Result Screen (new)
      'ai_result_title': 'AI Crop Analysis',
      'fetching_history': 'Fetching 5-year weather history...',
      'asking_claude': 'Asking Groq AI...',
      'expected_yield': 'Expected Yield',
      'per_acre': 'per acre',
      'total_yield': 'Total Yield',
      'ai_rating': 'AI Rating',
      'rating_good': '✅ Good',
      'rating_moderate': '🟡 Moderate',
      'rating_risk': '🔴 Risk',
      'historical_weather': '📊 Historical Weather (5 Years)',
      'avg_temp_hist': 'Avg Temp',
      'avg_rain_hist': 'Avg Rainfall',
      'avg_hum_hist': 'Avg Humidity',
      'similar_years': '🕐 Similar Past Years',
      'ai_suggestions': '🤖 AI Smart Suggestions',
      'saved_to_advisory': '✅ Saved to Advisory!',
      'error_fetch': 'Error fetching data. Please try again.',
      'year_label': 'Year',
      'temp_chart': 'Temperature (°C)',
      'rain_chart': 'Rainfall (mm/day)',
      'humidity_chart': 'Humidity (%)',

      // Advisory Screen (new — shows saved predictions)
      'advisory_title': 'My Advisory',
      'no_predictions':
          'No predictions yet.\nGo to Predict tab and run your first AI analysis!',
      'last_analysis': 'Last Analyses',
      'tap_for_details': 'Tap for details',
      'analysis_on': 'Analysis on',
      'delete_confirm': 'Delete this analysis?',
      'delete': 'Delete',
      'cancel': 'Cancel',

      // Predict screen (hardcoded strings fixed)
      'predict_appbar': 'Crop & Farm Details',
      'predict_subtitle':
          'Enter your crop and farm info — weather, soil & nutrients are fetched automatically',
      'weather_auto_fetched': 'Weather auto-fetched ✓',
      'weather_fetch_failed': 'Weather fetch failed — using defaults',
      'fetching_live_weather': 'Fetching live weather...',
      'crop_variety_section': 'Crop & Variety Selection',
      'select_crop_label': 'Select Crop *',
      'select_crop_hint': 'Select Crop',
      'select_variety_label': 'Select Variety *',
      'select_variety_hint': 'Select Variety',
      'please_select_variety': 'Please select variety',
      'season_auto': 'Season (auto-detected)',
      'location_details': 'Location Details',
      'district_label': 'District *',
      'district_hint': 'Select district',
      'district_helper': 'Auto-filled from GPS',
      'please_select_district': 'Please select district',
      'farm_details': 'Farm Details',
      'irrigation_label': 'Irrigation Type *',
      'irrigation_hint': 'Select irrigation',
      'please_select_irrigation': 'Please select irrigation type',
      'fertilizer_major_label': 'Fertilizer (Major)',
      'fertilizer_hint': 'Select fertilizer or Other',
      'soil_auto_label': 'Soil Type',
      'soil_helper': 'Auto-detected from district — you can override',
      'npk_pre_filled':
          'Values pre-filled based on your district soil health data. You can override below.',
      'with_balanced_npk': 'With balanced\nNPK application',

      // Result screen (hardcoded strings fixed)
      'prediction_results': 'Prediction Results',
      'predicted_yield': 'Predicted Yield',
      'total_production': 'Total Production',
      'confidence': 'Confidence',
      'range': 'Range',
      'profit_potential': 'Profit Potential',
      'nutrient_status': 'Nutrient Status & Deficit Analysis',
      'fertilizer_recommendations': 'Fertilizer Recommendations',
      'fertilizer_sub': 'Precise application rates based on soil analysis',
      'yield_scenarios': 'Yield Improvement Scenarios',
      'yield_scenarios_sub':
          'Potential yield increase with optimized nutrient management',
      'current_prediction': 'Current Prediction',
      'plus_10kg_n': '+10kg Nitrogen',
      'balanced_npk': 'Balanced NPK',
      'increase_label': 'increase',
      'ai_farming_advice': 'AI-Powered Farming Advice',
      'personalized_recs': 'Personalized Recommendations',
      'crop_analysis_summary': 'Crop Analysis Summary',
      'tailored_advice': 'Tailored advice for your selection',
      'season_ready': 'Season-Ready',
      'optimized': 'Optimized',
      'risk_alerts': 'Risk Alerts',
      'alert_badge': 'Alert',
      'optimal_growth_tab': 'Optimal Growth',
      'fertilizer_plan_tab': 'Fertilizer Plan',
      'pest_alerts_tab': 'Pest Alerts',
      'water_schedule_tab': 'Water Schedule',
      'retry': 'Retry',
      'for_acres': 'acres of farmland',
      'q_acre': 'q/acre',
      'quintals': 'quintals',
      'per_inr_acre': '/acre',
      'recommendations_count': 'recommendations',
      'recommendation_single': 'recommendation',

      // Nutrient status labels
      'deficient': 'Deficient',
      'excess': 'Excess',
      'optimal': 'Optimal',
      'status_label': 'Status',

      // Quick tab content
      'tab_optimal_1': '🌱 {crop} requires high water availability',
      'tab_optimal_2': '📅 Expected growing period: 120 days',
      'tab_optimal_3':
          '💧 Your {irrigation} irrigation is well-suited for this crop',
      'tab_fertilizer_1': '🧪 Urea: {urea} kg/acre at top dressing',
      'tab_fertilizer_2': '🧪 DAP: {dap} kg/acre at basal application',
      'tab_fertilizer_3': '🧪 MOP: {mop} kg/acre as required',
      'tab_pest_1': '🐛 Monitor for stem borer during tillering stage',
      'tab_pest_2': '🍃 Watch for blast disease in humid conditions',
      'tab_pest_3':
          '⚠️ Apply recommended pesticides only when threshold is reached',
      'tab_water_1': '💧 Maintain 5 cm standing water during active tillering',
      'tab_water_2': '🌾 Reduce irrigation 2 weeks before harvest',
      'tab_water_3':
          '📊 Use AWD (Alternate Wetting & Drying) to save 30% water',

      // Fertilizer warning messages
      'nitrogen_high_warn':
          'Nitrogen level is high ({n} kg/ha). Reduce N fertilizer to prevent environmental damage.',
      'potassium_high_warn':
          'Potassium level is high ({k} kg/ha). Consider reducing K application.',
    },

    // ── HINDI ────────────────────────────────────────────────
    'hi': {
      'app_name': 'एग्री हेल्पर',
      'ai_crop_yield': 'AI फसल उपज भविष्यवाणी',
      'sih_2025': 'स्मार्ट इंडिया हैकाथॉन 2025',

      'nav_home': 'होम',
      'nav_predict': 'अनुमान',
      'nav_weather': 'मौसम',
      'nav_advisory': 'सलाह',

      'namaskara': 'नमस्कार! 🌾',
      'season_label': 'मौसम',
      'rainfall_label': 'वर्षा',
      'temp_label': 'तापमान',
      'quick_actions': 'त्वरित क्रियाएं',
      'predict_yield': 'उत्पादन का अनुमान',
      'enter_farm_details': 'खेत की जानकारी दर्ज करें',
      'scan_soil': 'मिट्टी स्कैन करें',
      'ai_soil_analysis': 'AI मिट्टी विश्लेषण',
      'analysis': 'विश्लेषण',
      'view_advisory': 'सभी अनुमान देखें',
      'recommended_crops': 'अनुशंसित फसलें',
      'recommendations_based': 'वर्तमान स्थितियों पर आधारित सिफारिशें',
      'season_suffix': 'सीज़न',

      'imd_heavy_rain':
          '⚠️ IMD: भारी वर्षा की संभावना। मैदानी काम और कीटनाशक न करें।',
      'imd_moderate_rain':
          '🌧 IMD: मध्यम वर्षा की संभावना। बुवाई के लिए अच्छा समय।',
      'imd_high_temp': '🔥 IMD: उच्च तापमान चेतावनी। सिंचाई बढ़ाएं।',
      'imd_cool': '❄ IMD: ठंडा मौसम। रबी फसलों के लिए उपयुक्त।',
      'imd_stable': '✅ IMD: मौसम की स्थिति खेती के लिए स्थिर है।',

      'predict': 'उत्पादन का अनुमान',
      'voice_input': 'आवाज़ इनपुट',
      'voice_snack': 'आवाज़ इनपुट: speech_to_text पैकेज जोड़ें',
      'step_farm_info': 'खेत जानकारी',
      'step_soil_water': 'मिट्टी और पानी',
      'step_predict': 'अनुमान',
      'crop_selection': 'फसल चयन',
      'crop_type_hint': 'फसल प्रकार (टाइप या चुनें)',
      'select_crop': 'फसल चुनें',
      'season_dropdown': 'सीज़न',
      'soil_land': 'मिट्टी और भूमि',
      'soil_type_hint': 'मिट्टी प्रकार (टाइप या चुनें)',
      'select_soil': 'मिट्टी चुनें',
      'farm_area': 'खेती का क्षेत्र (एकड़)',
      'acres_suffix': 'एकड़',
      'enter_farm_area': 'खेत का क्षेत्रफल दर्ज करें',
      'nutrients': 'पोषक तत्व',
      'nitrogen': 'नाइट्रोजन (N)',
      'phosphorus': 'फास्फोरस (P)',
      'potassium': 'पोटेशियम (K)',
      'climate_data': 'जलवायु डेटा',
      'annual_rainfall': 'वार्षिक वर्षा',
      'mm_suffix': 'मिमी',
      'enter_rainfall': 'वर्षा डेटा दर्ज करें',
      'avg_temperature': 'औसत तापमान',
      'celsius_suffix': '°C',
      'enter_temperature': 'तापमान दर्ज करें',
      'predict_btn': 'AI से उत्पादन का अनुमान लगाएं',
      'sowing_date_label': 'बुवाई की तारीख (वैकल्पिक)',
      'sowing_date_hint': 'बुवाई की तारीख चुनें',
      'sowing_date_helper': 'यदि अभी बुवाई नहीं हुई तो खाली छोड़ें',

      'agri_result': 'कृषि विश्लेषण परिणाम',
      'recommended_crop': 'अनुशंसित फसल',
      'kg_expected': 'किग्रा अपेक्षित उत्पादन',
      'smart_plan': '📋 आज की स्मार्ट योजना',
      'risk_level': 'जोखिम स्तर',
      'plan_skip_irr': '🌧 वर्षा की संभावना → सिंचाई छोड़ें',
      'plan_irrigate': '💧 सुबह 6 बजे सिंचाई करें',
      'plan_add_nitrogen': '🧪 कम नमी → नाइट्रोजन उर्वरक डालें',
      'plan_monitor_temp': '🌡 नियमित रूप से तापमान की निगरानी करें',
      'risk_high': '🔴 उच्च जोखिम',
      'risk_medium': '🟡 मध्यम जोखिम',
      'risk_low': '🟢 कम जोखिम',
      'summary_crop': '🌱 फसल',
      'summary_action': '📅 क्रिया: स्मार्ट योजना का पालन करें',
      'summary_irrigation': '💧 सिंचाई: वर्षा पर आधारित',
      'summary_risk': '⚠ जोखिम',

      'weather_climate': 'मौसम और जलवायु',
      'humidity': 'आर्द्रता',
      'wind': 'हवा',
      'visibility_label': 'दृश्यता',
      'five_day_forecast': '5 दिन का पूर्वानुमान',
      'agri_weather_impact': 'कृषि-मौसम प्रभाव',
      'loading_insights': 'मौसम जानकारी लोड हो रही है...',
      'agri_heavy_rain':
          '🌧 भारी वर्षा की संभावना। कीटनाशक न करें और मैदानी काम टालें।',
      'agri_moderate_rain':
          '🌦 मध्यम वर्षा। बुवाई के लिए अच्छा लेकिन खाद न डालें।',
      'agri_high_temp': '🔥 उच्च तापमान। सिंचाई बढ़ाएं।',
      'agri_cool': '❄ ठंडा मौसम। रबी फसलों के लिए अच्छा।',
      'agri_strong_wind': '💨 तेज़ हवाएं। रसायन न छिड़कें।',
      'agri_stable': '✅ मौसम स्थिर है। खेती के लिए अच्छा।',

      'crop_advisory': 'फसल सलाह',
      'season_alerts': 'सीज़न अलर्ट',
      'kharif_alert':
          '⚠️  खरीफ बुवाई अवधि: 15 जून – 10 जुलाई। तटीय ओडिशा में धान के लिए सर्वोत्तम।',
      'best_crops': 'आपके क्षेत्र के लिए सर्वश्रेष्ठ फसलें',
      'crop_rice': 'धान (चावल)',
      'tip_rice':
          'MTU-7029 या स्वर्णा किस्मों की बुवाई करें। SRI पद्धति से 30% पानी बचाएं।',
      'crop_maize': 'मक्का',
      'tip_maize':
          '60×20 सेमी पंक्तियों में रोपें। बेहतर अंकुरण के लिए 25 किग्रा/हेक्टेयर जिंक सल्फेट डालें।',
      'crop_groundnut': 'मूंगफली',
      'tip_groundnut':
          'बलुई दोमट मिट्टी के लिए उपयुक्त। बुवाई से पहले राइजोबियम कल्चर से बीज उपचारित करें।',

      'farmer_profile': 'किसान प्रोफाइल',
      'hello_farmer': 'नमस्ते किसान 👨‍🌾',
      'manage_location': 'अपना स्थान प्रबंधित करें',
      'current_location': 'वर्तमान स्थान',
      'enter_location_manual': 'स्थान मैन्युअल रूप से दर्ज करें',
      'set_location': 'स्थान सेट करें',
      'detect_location': 'स्थान पहचानें',
      'language': 'भाषा',

      'turn_on_location': 'लोकेशन सेवाएं चालू करें',
      'permission_denied': 'अनुमति अस्वीकार',
      'permission_permanently_denied': 'अनुमति स्थायी रूप से अस्वीकार',
      'location_updated': '📍 स्थान सफलतापूर्वक अपडेट हुआ',
      'location_set': '📍 स्थान सेट हुआ',
      'location_not_found': '❌ स्थान नहीं मिला',
      'failed_location': 'स्थान प्राप्त करने में विफल',

      'kharif': 'खरीफ',
      'rabi': 'रबी',
      'zaid': 'जायद',
      'kharif_season': 'खरीफ (जून–अक्टूबर)',
      'rabi_season': 'रबी (नवंबर–अप्रैल)',
      'zaid_season': 'जायद (अप्रैल–जून)',

      'rice': 'चावल',
      'wheat': 'गेहूं',
      'maize': 'मक्का',
      'groundnut': 'मूंगफली',
      'mustard': 'सरसों',
      'sugarcane': 'गन्ना',
      'cotton': 'कपास',
      'millets': 'बाजरा',
      'pigeon_pea': 'अरहर दाल',
      'green_gram': 'मूंग दाल',
      'black_gram': 'उड़द दाल',
      'sesame': 'तिल',
      'ragi': 'रागी',

      'red_soil': 'लाल मिट्टी',
      'black_soil': 'काली मिट्टी',
      'alluvial': 'जलोढ़ मिट्टी',
      'laterite': 'लेटराइट',
      'sandy_loam': 'बलुई दोमट',

      'loading': 'लोड हो रहा है...',
      'unknown': 'अज्ञात',

      // AI Result Screen (new)
      'ai_result_title': 'AI फसल विश्लेषण',
      'fetching_history': '5 साल का मौसम डेटा लाया जा रहा है...',
      'asking_claude': 'Groq AI से पूछ रहे हैं...',
      'expected_yield': 'अपेक्षित उत्पादन',
      'per_acre': 'प्रति एकड़',
      'total_yield': 'कुल उत्पादन',
      'ai_rating': 'AI रेटिंग',
      'rating_good': '✅ अच्छा',
      'rating_moderate': '🟡 ठीक-ठाक',
      'rating_risk': '🔴 जोखिम',
      'historical_weather': '📊 ऐतिहासिक मौसम (5 साल)',
      'avg_temp_hist': 'औसत तापमान',
      'avg_rain_hist': 'औसत वर्षा',
      'avg_hum_hist': 'औसत आर्द्रता',
      'similar_years': '🕐 समान पिछले वर्ष',
      'ai_suggestions': '🤖 AI स्मार्ट सुझाव',
      'saved_to_advisory': '✅ सलाह में सहेजा गया!',
      'error_fetch': 'डेटा लाने में त्रुटि। कृपया पुनः प्रयास करें।',
      'year_label': 'वर्ष',
      'temp_chart': 'तापमान (°C)',
      'rain_chart': 'वर्षा (mm/दिन)',
      'humidity_chart': 'आर्द्रता (%)',
      'advisory_title': 'मेरी सलाह',
      'no_predictions':
          'अभी तक कोई भविष्यवाणी नहीं।\nPrediction टैब में जाएं और पहला AI विश्लेषण करें!',
      'last_analysis': 'पिछले विश्लेषण',
      'tap_for_details': 'विवरण के लिए टैप करें',
      'analysis_on': 'विश्लेषण तिथि',
      'delete_confirm': 'यह विश्लेषण हटाएं?',
      'delete': 'हटाएं',
      'cancel': 'रद्द करें',

      'predict_appbar': 'फसल और खेत विवरण',
      'predict_subtitle':
          'अपनी फसल और खेत की जानकारी दर्ज करें — मौसम, मिट्टी और पोषक तत्व स्वचालित रूप से प्राप्त होंगे',
      'weather_auto_fetched': 'मौसम स्वतः प्राप्त ✓',
      'weather_fetch_failed': 'मौसम प्राप्त विफल — डिफ़ॉल्ट उपयोग',
      'fetching_live_weather': 'लाइव मौसम प्राप्त हो रहा है...',
      'crop_variety_section': 'फसल और किस्म चयन',
      'select_crop_label': 'फसल चुनें *',
      'select_crop_hint': 'फसल चुनें',
      'select_variety_label': 'किस्म चुनें *',
      'select_variety_hint': 'किस्म चुनें',
      'please_select_variety': 'कृपया किस्म चुनें',
      'season_auto': 'सीज़न (स्वतः पता लगाया)',
      'location_details': 'स्थान विवरण',
      'district_label': 'जिला *',
      'district_hint': 'जिला चुनें',
      'district_helper': 'GPS से स्वतः भरा गया',
      'please_select_district': 'कृपया जिला चुनें',
      'farm_details': 'खेत विवरण',
      'irrigation_label': 'सिंचाई प्रकार *',
      'irrigation_hint': 'सिंचाई चुनें',
      'please_select_irrigation': 'कृपया सिंचाई प्रकार चुनें',
      'fertilizer_major_label': 'उर्वरक (मुख्य)',
      'fertilizer_hint': 'उर्वरक चुनें',
      'soil_auto_label': 'मिट्टी प्रकार',
      'soil_helper': 'जिले से स्वतः — आप बदल सकते हैं',
      'npk_pre_filled':
          'जिले के मृदा स्वास्थ्य डेटा से पहले से भरे मान। आप बदल सकते हैं।',
      'with_balanced_npk': 'संतुलित NPK\nउपयोग के साथ',
      'prediction_results': 'भविष्यवाणी परिणाम',
      'predicted_yield': 'अनुमानित उत्पादन',
      'total_production': 'कुल उत्पादन',
      'confidence': 'विश्वास',
      'range': 'सीमा',
      'profit_potential': 'लाभ क्षमता',
      'nutrient_status': 'पोषक तत्व स्थिति और कमी विश्लेषण',
      'fertilizer_recommendations': 'उर्वरक सिफारिशें',
      'fertilizer_sub': 'मृदा विश्लेषण आधारित सटीक उपयोग दर',
      'yield_scenarios': 'उत्पादन सुधार परिदृश्य',
      'yield_scenarios_sub': 'अनुकूलित पोषक प्रबंधन से संभावित उत्पादन वृद्धि',
      'current_prediction': 'वर्तमान भविष्यवाणी',
      'plus_10kg_n': '+10 किग्रा नाइट्रोजन',
      'balanced_npk': 'संतुलित NPK',
      'increase_label': 'वृद्धि',
      'ai_farming_advice': 'AI-आधारित कृषि सलाह',
      'personalized_recs': 'व्यक्तिगत सिफारिशें',
      'crop_analysis_summary': 'फसल विश्लेषण सारांश',
      'tailored_advice': 'आपके चयन के लिए अनुकूलित सलाह',
      'season_ready': 'सीज़न-तैयार',
      'optimized': 'अनुकूलित',
      'risk_alerts': 'जोखिम अलर्ट',
      'alert_badge': 'अलर्ट',
      'optimal_growth_tab': 'इष्टतम विकास',
      'fertilizer_plan_tab': 'उर्वरक योजना',
      'pest_alerts_tab': 'कीट अलर्ट',
      'water_schedule_tab': 'जल कार्यक्रम',
      'retry': 'पुनः प्रयास',
      'for_acres': 'एकड़ कृषि भूमि',
      'q_acre': 'क्विंटल/एकड़',
      'quintals': 'क्विंटल',
      'per_inr_acre': '/एकड़',
      'recommendations_count': 'सिफारिशें',
      'recommendation_single': 'सिफारिश',
      'deficient': 'कम',
      'excess': 'अधिक',
      'optimal': 'सही',
      'status_label': 'स्थिति',
      'tab_optimal_1': '🌱 {crop} को अधिक पानी की आवश्यकता है',
      'tab_optimal_2': '📅 अपेक्षित विकास अवधि: 120 दिन',
      'tab_optimal_3': '💧 आपकी {irrigation} सिंचाई इस फसल के लिए उपयुक्त है',
      'tab_fertilizer_1': '🧪 यूरिया: {urea} किग्रा/एकड़ टॉप ड्रेसिंग में',
      'tab_fertilizer_2': '🧪 DAP: {dap} किग्रा/एकड़ बेसल उपयोग में',
      'tab_fertilizer_3': '🧪 MOP: {mop} किग्रा/एकड़ आवश्यकतानुसार',
      'tab_pest_1': '🐛 कंसे अवस्था में तना छेदक की निगरानी करें',
      'tab_pest_2': '🍃 आर्द्र परिस्थितियों में ब्लास्ट रोग देखें',
      'tab_pest_3': '⚠️ सीमा पहुंचने पर ही अनुशंसित कीटनाशक लगाएं',
      'tab_water_1': '💧 सक्रिय कंसे अवस्था में 5 सेमी स्थिर पानी रखें',
      'tab_water_2': '🌾 कटाई से 2 सप्ताह पहले सिंचाई कम करें',
      'tab_water_3': '📊 AWD तकनीक से 30% पानी बचाएं',
      'nitrogen_high_warn':
          'नाइट्रोजन स्तर अधिक है ({n} किग्रा/हेक्टेयर)। N उर्वरक कम करें।',
      'potassium_high_warn':
          'पोटेशियम स्तर अधिक है ({k} किग्रा/हेक्टेयर)। K उपयोग कम करने पर विचार करें।',
    },

    // ── TAMIL ────────────────────────────────────────────────
    'ta': {
      'app_name': 'அக்ரி ஹெல்பர்',
      'ai_crop_yield': 'AI பயிர் விளைச்சல் கணிப்பு',
      'sih_2025': 'ஸ்மார்ட் இந்தியா ஹேக்கத்தான் 2025',

      'nav_home': 'முகப்பு',
      'nav_predict': 'கணிப்பு',
      'nav_weather': 'வானிலை',
      'nav_advisory': 'ஆலோசனை',

      'namaskara': 'வணக்கம்! 🌾',
      'season_label': 'பருவம்',
      'rainfall_label': 'மழை',
      'temp_label': 'வெப்பம்',
      'quick_actions': 'விரைவு செயல்கள்',
      'predict_yield': 'விளைச்சல் கணிப்பு',
      'enter_farm_details': 'நிலத் தகவல் உள்ளிடுக',
      'scan_soil': 'மண் ஸ்கேன்',
      'ai_soil_analysis': 'AI மண் பகுப்பாய்வு',
      'analysis': 'பகுப்பாய்வு',
      'view_advisory': 'அனைத்து கணிப்புகளையும் காண்க',
      'recommended_crops': 'பரிந்துரைக்கப்பட்ட பயிர்கள்',
      'recommendations_based': 'தற்போதைய நிலைமைகளின் அடிப்படையில் பரிந்துரைகள்',
      'season_suffix': 'பருவம்',

      'imd_heavy_rain':
          '⚠️ IMD: கனமழை எதிர்பார்க்கப்படுகிறது. வயல் பணி மற்றும் பூச்சிக்கொல்லி தெளிப்பை தவிர்க்கவும்.',
      'imd_moderate_rain':
          '🌧 IMD: மிதமான மழை எதிர்பார்க்கப்படுகிறது. விதைப்புக்கு நல்லது.',
      'imd_high_temp':
          '🔥 IMD: அதிக வெப்பநிலை எச்சரிக்கை. நீர்ப்பாசனம் அதிகரிக்கவும்.',
      'imd_cool': '❄ IMD: குளிர் காலநிலை. ராபி பயிர்களுக்கு ஏற்றது.',
      'imd_stable': '✅ IMD: வானிலை நிலைமைகள் விவசாயத்திற்கு சாதகமாக உள்ளன.',

      'predict': 'விளைச்சல் கணிப்பு',
      'voice_input': 'குரல் உள்ளீடு',
      'voice_snack': 'குரல் உள்ளீடு: speech_to_text தொகுப்பை சேர்க்கவும்',
      'step_farm_info': 'நில தகவல்',
      'step_soil_water': 'மண் & நீர்',
      'step_predict': 'கணிப்பு',
      'crop_selection': 'பயிர் தேர்வு',
      'crop_type_hint': 'பயிர் வகை (தட்டச்சு அல்லது தேர்வு)',
      'select_crop': 'பயிர் தேர்வு செய்க',
      'season_dropdown': 'பருவம்',
      'soil_land': 'மண் மற்றும் நிலம்',
      'soil_type_hint': 'மண் வகை (தட்டச்சு அல்லது தேர்வு)',
      'select_soil': 'மண் தேர்வு செய்க',
      'farm_area': 'பயிர் பரப்பு (ஏக்கர்)',
      'acres_suffix': 'ஏக்கர்',
      'enter_farm_area': 'நில பரப்பை உள்ளிடுக',
      'nutrients': 'உட்டச்சத்துக்கள்',
      'nitrogen': 'நைட்ரஜன் (N)',
      'phosphorus': 'பாஸ்பரஸ் (P)',
      'potassium': 'பொட்டாசியம் (K)',
      'climate_data': 'காலநிலை தரவு',
      'annual_rainfall': 'ஆண்டு மழையளவு',
      'mm_suffix': 'மிமீ',
      'enter_rainfall': 'மழையளவு தரவை உள்ளிடுக',
      'avg_temperature': 'சராசரி வெப்பநிலை',
      'celsius_suffix': '°C',
      'enter_temperature': 'வெப்பநிலையை உள்ளிடுக',
      'predict_btn': 'AI மூலம் விளைச்சல் கணிக்கவும்',
      'sowing_date_label': 'விதைப்பு தேதி (விருப்பத்திற்கு)',
      'sowing_date_hint': 'விதைப்பு தேதி தேர்ந்தெடுக்கவும்',
      'sowing_date_helper': 'இன்னும் விதைக்கவில்லை என்றால் காலியாக விடவும்',

      'agri_result': 'விவசாய பகுப்பாய்வு முடிவு',
      'recommended_crop': 'பரிந்துரைக்கப்பட்ட பயிர்',
      'kg_expected': 'கிலோ எதிர்பார்க்கப்படும் விளைச்சல்',
      'smart_plan': '📋 இன்றைய திட்டம்',
      'risk_level': 'அபாய நிலை',
      'plan_skip_irr':
          '🌧 மழை எதிர்பார்க்கப்படுகிறது → நீர்ப்பாசனம் தவிர்க்கவும்',
      'plan_irrigate': '💧 காலை 6 மணிக்கு நீர்ப்பாசனம் செய்யவும்',
      'plan_add_nitrogen': '🧪 குறைந்த ஈரப்பதம் → நைட்ரஜன் உரம் சேர்க்கவும்',
      'plan_monitor_temp': '🌡 வெப்பநிலையை தொடர்ந்து கண்காணிக்கவும்',
      'risk_high': '🔴 அதிக அபாயம்',
      'risk_medium': '🟡 நடுத்தர அபாயம்',
      'risk_low': '🟢 குறைந்த அபாயம்',
      'summary_crop': '🌱 பயிர்',
      'summary_action': '📅 செயல்: திட்டத்தை பின்பற்றவும்',
      'summary_irrigation': '💧 நீர்ப்பாசனம்: மழையின் அடிப்படையில்',
      'summary_risk': '⚠ அபாயம்',

      'weather_climate': 'வானிலை & காலநிலை',
      'humidity': 'ஈரப்பதம்',
      'wind': 'காற்று',
      'visibility_label': 'தெரிவுநிலை',
      'five_day_forecast': '5 நாள் முன்னறிவிப்பு',
      'agri_weather_impact': 'விவசாய-வானிலை தாக்கம்',
      'loading_insights': 'வானிலை தகவல் ஏற்றப்படுகிறது...',
      'agri_heavy_rain':
          '🌧 கனமழை எதிர்பார்க்கப்படுகிறது. பூச்சிக்கொல்லி தெளிக்காதீர்கள்.',
      'agri_moderate_rain':
          '🌦 மிதமான மழை. விதைப்புக்கு நல்லது ஆனால் உரம் போடாதீர்கள்.',
      'agri_high_temp': '🔥 அதிக வெப்பம். நீர்ப்பாசனம் அதிகரிக்கவும்.',
      'agri_cool': '❄ குளிர் காலநிலை. ராபி பயிர்களுக்கு நல்லது.',
      'agri_strong_wind': '💨 வலுவான காற்று. ரசாயனம் தெளிக்காதீர்கள்.',
      'agri_stable': '✅ வானிலை சாதகமாக உள்ளது. விவசாயத்திற்கு நல்லது.',

      'crop_advisory': 'பயிர் ஆலோசனை',
      'season_alerts': 'பருவ எச்சரிக்கைகள்',
      'kharif_alert':
          '⚠️  காரிஃப் விதைப்பு காலம்: ஜூன் 15 – ஜூலை 10. கடலோர ஒடிசாவில் நெல்லுக்கு சிறந்தது.',
      'best_crops': 'உங்கள் பகுதிக்கான சிறந்த பயிர்கள்',
      'crop_rice': 'நெல் (அரிசி)',
      'tip_rice':
          'MTU-7029 அல்லது ஸ்வர்ணா ரகங்களை விதைக்கவும். SRI முறையில் 30% நீர் சேமிக்கவும்.',
      'crop_maize': 'மக்காச்சோளம்',
      'tip_maize':
          '60×20 செமீ வரிசையில் நடவு செய்யவும். சிறந்த முளைப்பிற்கு 25 கிகி/ஹெ ஜிங்க் சல்ஃபேட் பயன்படுத்தவும்.',
      'crop_groundnut': 'வேர்க்கடலை',
      'tip_groundnut':
          'மணல் கலந்த மண்ணுக்கு ஏற்றது. விதைப்பதற்கு முன் ரைசோபியம் கலாச்சாரத்தில் விதை நேர்த்தி செய்யவும்.',

      'farmer_profile': 'விவசாயி சுயவிவரம்',
      'hello_farmer': 'வணக்கம் விவசாயி 👨‍🌾',
      'manage_location': 'உங்கள் இடத்தை நிர்வகிக்கவும்',
      'current_location': 'தற்போதைய இடம்',
      'enter_location_manual': 'இடத்தை கைமுறையாக உள்ளிடுக',
      'set_location': 'இடத்தை அமைக்கவும்',
      'detect_location': 'இடத்தை கண்டறியவும்',
      'language': 'மொழி',

      'turn_on_location': 'இடம் சேவைகளை இயக்கவும்',
      'permission_denied': 'அனுமதி மறுக்கப்பட்டது',
      'permission_permanently_denied': 'அனுமதி நிரந்தரமாக மறுக்கப்பட்டது',
      'location_updated': '📍 இடம் வெற்றிகரமாக புதுப்பிக்கப்பட்டது',
      'location_set': '📍 இடம் அமைக்கப்பட்டது',
      'location_not_found': '❌ இடம் கண்டுபிடிக்கப்படவில்லை',
      'failed_location': 'இடம் பெற தோல்வி',

      'kharif': 'காரிஃப்',
      'rabi': 'ராபி',
      'zaid': 'ஜாயித்',
      'kharif_season': 'காரிஃப் (ஜூன்–அக்டோபர்)',
      'rabi_season': 'ராபி (நவம்பர்–ஏப்ரல்)',
      'zaid_season': 'ஜாயித் (ஏப்ரல்–ஜூன்)',

      'rice': 'நெல்',
      'wheat': 'கோதுமை',
      'maize': 'மக்காச்சோளம்',
      'groundnut': 'வேர்க்கடலை',
      'mustard': 'கடுகு',
      'sugarcane': 'கரும்பு',
      'cotton': 'பருத்தி',
      'millets': 'சிறுதானியம்',
      'pigeon_pea': 'துவரை பருப்பு',
      'green_gram': 'பச்சை பயறு',
      'black_gram': 'உளுந்து',
      'sesame': 'எள்',
      'ragi': 'கேழ்வரகு',

      'red_soil': 'சிவப்பு மண்',
      'black_soil': 'கருப்பு மண்',
      'alluvial': 'வண்டல் மண்',
      'laterite': 'லேட்டரைட்',
      'sandy_loam': 'மணல் கலந்த மண்',

      'loading': 'ஏற்றுகிறது...',
      'unknown': 'தெரியவில்லை',

      // AI Result Screen (new)
      'ai_result_title': 'AI பயிர் பகுப்பாய்வு',
      'fetching_history': '5 ஆண்டு வானிலை தரவு பெறப்படுகிறது...',
      'asking_claude': 'Groq AI கேட்கப்படுகிறது...',
      'expected_yield': 'எதிர்பார்க்கப்படும் விளைச்சல்',
      'per_acre': 'ஒரு ஏக்கருக்கு',
      'total_yield': 'மொத்த விளைச்சல்',
      'ai_rating': 'AI மதிப்பீடு',
      'rating_good': '✅ நல்லது',
      'rating_moderate': '🟡 மிதமான',
      'rating_risk': '🔴 அபாயம்',
      'historical_weather': '📊 வரலாற்று வானிலை (5 ஆண்டுகள்)',
      'avg_temp_hist': 'சராசரி வெப்பம்',
      'avg_rain_hist': 'சராசரி மழை',
      'avg_hum_hist': 'சராசரி ஈரப்பதம்',
      'similar_years': '🕐 ஒத்த கடந்த ஆண்டுகள்',
      'ai_suggestions': '🤖 AI திட்டங்கள்',
      'saved_to_advisory': '✅ ஆலோசனையில் சேமிக்கப்பட்டது!',
      'error_fetch': 'தரவு பெறுவதில் பிழை. மீண்டும் முயற்சிக்கவும்.',
      'year_label': 'ஆண்டு',
      'temp_chart': 'வெப்பநிலை (°C)',
      'rain_chart': 'மழை (mm/நாள்)',
      'humidity_chart': 'ஈரப்பதம் (%)',
      'advisory_title': 'என் ஆலோசனை',
      'no_predictions':
          'இன்னும் கணிப்புகள் இல்லை.\nகணிப்பு தாவலுக்கு சென்று முதல் AI பகுப்பாய்வை இயக்கவும்!',
      'last_analysis': 'கடைசி பகுப்பாய்வுகள்',
      'tap_for_details': 'விவரங்களுக்கு தட்டவும்',
      'analysis_on': 'பகுப்பாய்வு தேதி',
      'delete_confirm': 'இந்த பகுப்பாய்வை நீக்கவா?',
      'delete': 'நீக்கு',
      'cancel': 'ரத்து செய்',

      'predict_appbar': 'பயிர் & நிலம் விவரங்கள்',
      'predict_subtitle':
          'உங்கள் பயிர் மற்றும் நிலத் தகவலை உள்ளிடுக — வானிலை, மண் & ஊட்டச்சத்து தானாக பெறப்படும்',
      'weather_auto_fetched': 'வானிலை தானாக பெறப்பட்டது ✓',
      'weather_fetch_failed':
          'வானிலை பெற தோல்வி — இயல்புநிலை பயன்படுத்தப்படுகிறது',
      'fetching_live_weather': 'நேரலை வானிலை பெறப்படுகிறது...',
      'crop_variety_section': 'பயிர் & இரகம் தேர்வு',
      'select_crop_label': 'பயிர் தேர்ந்தெடுக்கவும் *',
      'select_crop_hint': 'பயிர் தேர்ந்தெடுக்கவும்',
      'select_variety_label': 'இரகம் தேர்ந்தெடுக்கவும் *',
      'select_variety_hint': 'இரகம் தேர்ந்தெடுக்கவும்',
      'please_select_variety': 'இரகம் தேர்ந்தெடுக்கவும்',
      'season_auto': 'பருவம் (தானாக கண்டறியப்பட்டது)',
      'location_details': 'இட விவரங்கள்',
      'district_label': 'மாவட்டம் *',
      'district_hint': 'மாவட்டம் தேர்ந்தெடுக்கவும்',
      'district_helper': 'GPS மூலம் தானாக நிரப்பப்பட்டது',
      'please_select_district': 'மாவட்டம் தேர்ந்தெடுக்கவும்',
      'farm_details': 'நிலம் விவரங்கள்',
      'irrigation_label': 'பாசன வகை *',
      'irrigation_hint': 'பாசனம் தேர்ந்தெடுக்கவும்',
      'please_select_irrigation': 'பாசன வகை தேர்ந்தெடுக்கவும்',
      'fertilizer_major_label': 'உரம் (முக்கியம்)',
      'fertilizer_hint': 'உரம் தேர்ந்தெடுக்கவும்',
      'soil_auto_label': 'மண் வகை',
      'soil_helper': 'மாவட்டத்திலிருந்து தானாக — நீங்கள் மாற்றலாம்',
      'npk_pre_filled':
          'மாவட்ட மண் தரவிலிருந்து முன்னமே நிரப்பப்பட்டது. நீங்கள் மாற்றலாம்.',
      'with_balanced_npk': 'சமநிலை NPK\nபயன்பாட்டுடன்',
      'prediction_results': 'கணிப்பு முடிவுகள்',
      'predicted_yield': 'கணிக்கப்பட்ட விளைச்சல்',
      'total_production': 'மொத்த உற்பத்தி',
      'confidence': 'நம்பிக்கை',
      'range': 'வரம்பு',
      'profit_potential': 'லாப திறன்',
      'nutrient_status': 'ஊட்டச்சத்து நிலை & குறைபாடு பகுப்பாய்வு',
      'fertilizer_recommendations': 'உர பரிந்துரைகள்',
      'fertilizer_sub': 'மண் பகுப்பாய்வு அடிப்படையில் துல்லியமான விகிதங்கள்',
      'yield_scenarios': 'விளைச்சல் மேம்பாடு காட்சிகள்',
      'yield_scenarios_sub':
          'மேம்படுத்தப்பட்ட ஊட்டச்சத்து மேலாண்மையால் சாத்தியமான விளைச்சல் அதிகரிப்பு',
      'current_prediction': 'தற்போதைய கணிப்பு',
      'plus_10kg_n': '+10kg நைட்ரஜன்',
      'balanced_npk': 'சமநிலை NPK',
      'increase_label': 'அதிகரிப்பு',
      'ai_farming_advice': 'AI-இயங்கும் விவசாய ஆலோசனை',
      'personalized_recs': 'தனிப்பயனாக்கப்பட்ட பரிந்துரைகள்',
      'crop_analysis_summary': 'பயிர் பகுப்பாய்வு சுருக்கம்',
      'tailored_advice': 'உங்கள் தேர்வுக்கு ஏற்ற ஆலோசனை',
      'season_ready': 'பருவம்-தயார்',
      'optimized': 'உகந்தது',
      'risk_alerts': 'அபாய எச்சரிக்கைகள்',
      'alert_badge': 'எச்சரிக்கை',
      'optimal_growth_tab': 'உகந்த வளர்ச்சி',
      'fertilizer_plan_tab': 'உர திட்டம்',
      'pest_alerts_tab': 'பூச்சி எச்சரிக்கை',
      'water_schedule_tab': 'நீர் அட்டவணை',
      'retry': 'மீண்டும் முயற்சி',
      'for_acres': 'ஏக்கர் நிலம்',
      'q_acre': 'குவிண்டால்/ஏக்கர்',
      'quintals': 'குவிண்டால்கள்',
      'per_inr_acre': '/ஏக்கர்',
      'recommendations_count': 'பரிந்துரைகள்',
      'recommendation_single': 'பரிந்துரை',
      'deficient': 'குறைபாடு',
      'excess': 'அதிகம்',
      'optimal': 'சரியானது',
      'status_label': 'நிலை',
      'tab_optimal_1': '🌱 {crop} அதிக நீர் தேவைப்படுகிறது',
      'tab_optimal_2': '📅 எதிர்பார்க்கப்படும் வளர்ச்சி காலம்: 120 நாட்கள்',
      'tab_optimal_3': '💧 உங்கள் {irrigation} பாசனம் இந்த பயிருக்கு ஏற்றது',
      'tab_fertilizer_1': '🧪 யூரியா: {urea} கி/ஏக்கர் மேல் பூச்சில்',
      'tab_fertilizer_2': '🧪 DAP: {dap} கி/ஏக்கர் அடிப்படை பயன்பாட்டில்',
      'tab_fertilizer_3': '🧪 MOP: {mop} கி/ஏக்கர் தேவைப்படும்போது',
      'tab_pest_1': '🐛 துளிர் கட்ட பூச்சியை கவனிக்கவும்',
      'tab_pest_2': '🍃 ஈர சூழலில் ப்ளாஸ்ட் நோய் கவனிக்கவும்',
      'tab_pest_3': '⚠️ வரம்பை எட்டும்போது மட்டும் கொல்லி பயன்படுத்தவும்',
      'tab_water_1': '💧 செயலில் உள்ள கட்டத்தில் 5 செமி நிலையான நீர் வைக்கவும்',
      'tab_water_2': '🌾 அறுவடைக்கு 2 வாரங்கள் முன் பாசனம் குறைக்கவும்',
      'tab_water_3': '📊 AWD முறையில் 30% நீர் சேமிக்கவும்',
      'nitrogen_high_warn':
          'நைட்ரஜன் அளவு அதிகம் ({n} கி/ஹெக்.). N குறைக்கவும்.',
      'potassium_high_warn':
          'பொட்டாசியம் அளவு அதிகம் ({k} கி/ஹெக்.). K குறைப்பதை பரிசீலிக்கவும்.',
    },

    // ── ODIA ─────────────────────────────────────────────────
    'or': {
      // App general
      'app_name': 'ଆଗ୍ରି ହେଲ୍ପର',
      'ai_crop_yield': 'AI ଫସଲ ଅମଳ ପୂର୍ବାନୁମାନ',
      'sih_2025': 'ସ୍ମାର୍ଟ ଇଣ୍ଡିଆ ହ୍ୟାକାଥନ୍ 2025',

      // Nav bar
      'nav_home': 'ହୋମ',
      'nav_predict': 'ପୂର୍ବାନୁମାନ',
      'nav_weather': 'ଆବହାୱା',
      'nav_advisory': 'ପରାମର୍ଶ',

      // Home screen
      'namaskara': 'ନମସ୍କାର! 🌾',
      'season_label': 'ଋତୁ',
      'rainfall_label': 'ବର୍ଷା',
      'temp_label': 'ତାପମାତ୍ରା',
      'quick_actions': 'ଦ୍ରୁତ କାର୍ଯ୍ୟ',
      'predict_yield': 'ଅମଳ ପୂର୍ବାନୁମାନ',
      'enter_farm_details': 'ଜମି ବିବରଣ ଦିଅନ୍ତୁ',
      'scan_soil': 'ମାଟି ସ୍କ୍ୟାନ',
      'ai_soil_analysis': 'AI ମାଟି ବିଶ୍ଳେଷଣ',
      'analysis': 'ବିଶ୍ଳେଷଣ',
      'view_advisory': 'ସମସ୍ତ ଭବିଷ୍ୟବାଣୀ ଦେଖନ୍ତୁ',
      'recommended_crops': 'ପରାମର୍ଶ ଦିଆ ଫସଲ',
      'recommendations_based': 'ବର୍ତ୍ତମାନ ପରିସ୍ଥିତି ଆଧାରରେ ପରାମର୍ଶ',
      'season_suffix': 'ଋତୁ',

      // IMD messages
      'imd_heavy_rain':
          '⚠️ IMD: ଭାରୀ ବର୍ଷା ସମ୍ଭାବନା। ମଡ଼ କାମ ଓ କୀଟନାଶକ ଛିଞ୍ଚିବା ଏଡ଼ାନ୍ତୁ।',
      'imd_moderate_rain': '🌧 IMD: ମଧ୍ୟମ ବର୍ଷା ସମ୍ଭାବନା। ବୁଣିବା ପାଇଁ ଭଲ।',
      'imd_high_temp': '🔥 IMD: ଅଧିକ ତାପମାତ୍ରା ସତର୍କତା। ଜଳସେଚନ ବଢ଼ାନ୍ତୁ।',
      'imd_cool': '❄ IMD: ଥଣ୍ଡା ଆବହାୱା। ରବି ଫସଲ ପାଇଁ ଉପଯୁକ୍ତ।',
      'imd_stable': '✅ IMD: ଚାଷ ପାଇଁ ଆବହାୱା ସ୍ଥିର ଅଛି।',

      // Predict screen
      'predict': 'ଅମଳ ପୂର୍ବାନୁମାନ',
      'voice_input': 'ଭଏସ ଇନପୁଟ',
      'voice_snack': 'ଭଏସ ଇନପୁଟ: speech_to_text ପ୍ୟାକେଜ ଯୋଡ଼ନ୍ତୁ',
      'step_farm_info': 'ଜମି ତଥ୍ୟ',
      'step_soil_water': 'ମାଟି ଓ ଜଳ',
      'step_predict': 'ପୂର୍ବାନୁମାନ',
      'crop_selection': 'ଫସଲ ଚୟନ',
      'crop_type_hint': 'ଫସଲ ପ୍ରକାର (ଟାଇପ ବା ଚୟନ)',
      'select_crop': 'ଫସଲ ଚୟନ କରନ୍ତୁ',
      'season_dropdown': 'ଋତୁ',
      'soil_land': 'ମାଟି ଓ ଜମି',
      'soil_type_hint': 'ମାଟି ପ୍ରକାର (ଟାଇପ ବା ଚୟନ)',
      'select_soil': 'ମାଟି ଚୟନ କରନ୍ତୁ',
      'farm_area': 'ଜମି କ୍ଷେତ୍ରଫଳ (ଏକର)',
      'acres_suffix': 'ଏକର',
      'enter_farm_area': 'ଜମି ଆୟତନ ଦିଅନ୍ତୁ',
      'nutrients': 'ପୋଷକ ତତ୍ୱ',
      'nitrogen': 'ନାଇଟ୍ରୋଜେନ (N)',
      'phosphorus': 'ଫସଫରସ (P)',
      'potassium': 'ପୋଟାସିୟମ (K)',
      'climate_data': 'ଜଳବାୟୁ ତଥ୍ୟ',
      'annual_rainfall': 'ବାର୍ଷିକ ବର୍ଷା',
      'mm_suffix': 'ମିମି',
      'enter_rainfall': 'ବର୍ଷା ତଥ୍ୟ ଦିଅନ୍ତୁ',
      'avg_temperature': 'ହାରାହାରି ତାପମାତ୍ରା',
      'celsius_suffix': '°C',
      'enter_temperature': 'ତାପମାତ୍ରା ଦିଅନ୍ତୁ',
      'predict_btn': 'AI ଦ୍ୱାରା ଅମଳ ପୂର୍ବାନୁମାନ',
      'sowing_date_label': 'ବୁଣା ତାରିଖ (ଐଚ୍ଛିକ)',
      'sowing_date_hint': 'ବୁଣା ତାରିଖ ଚୟନ କରନ୍ତୁ',
      'sowing_date_helper': 'ଯଦି ଏଖନ ବୁଣା ହୋଇନାହିଁ ଖାଲି ଛାଡ଼ନ୍ତୁ',

      // Result screen
      'agri_result': 'କୃଷି ବିଶ୍ଳେଷଣ ଫଳ',
      'recommended_crop': 'ପରାମର୍ଶ ଦିଆ ଫସଲ',
      'kg_expected': 'କିଗ୍ରା ଅପେକ୍ଷିତ ଅମଳ',
      'smart_plan': '📋 ଆଜିର ସ୍ମାର୍ଟ ଯୋଜନା',
      'risk_level': 'ଝୁଙ୍କି ସ୍ତର',
      'plan_skip_irr': '🌧 ବର୍ଷା ସମ୍ଭାବନା → ଜଳସେଚନ ଛାଡ଼ନ୍ତୁ',
      'plan_irrigate': '💧 ସକାଳ ୬ ଟାରେ ଜଳସେଚନ କରନ୍ତୁ',
      'plan_add_nitrogen': '🧪 କମ ଆର୍ଦ୍ରତା → ନାଇଟ୍ରୋଜେନ ଖତ ଦିଅନ୍ତୁ',
      'plan_monitor_temp': '🌡 ନିୟମିତ ତାପମାତ୍ରା ଯାଞ୍ଚ କରନ୍ତୁ',
      'risk_high': '🔴 ଅଧିକ ଝୁଙ୍କି',
      'risk_medium': '🟡 ମଧ୍ୟମ ଝୁଙ୍କି',
      'risk_low': '🟢 କମ ଝୁଙ୍କି',
      'summary_crop': '🌱 ଫସଲ',
      'summary_action': '📅 କାର୍ଯ୍ୟ: ସ୍ମାର୍ଟ ଯୋଜନା ଅନୁସରଣ',
      'summary_irrigation': '💧 ଜଳସେଚନ: ବର୍ଷା ଉପରେ ଆଧାରିତ',
      'summary_risk': '⚠ ଝୁଙ୍କି',

      // Weather screen
      'weather_climate': 'ଆବହାୱା ଓ ଜଳବାୟୁ',
      'humidity': 'ଆର୍ଦ୍ରତା',
      'wind': 'ବାୟୁ',
      'visibility_label': 'ଦୃଶ୍ୟତା',
      'five_day_forecast': '୫ ଦିନର ପୂର୍ବାନୁମାନ',
      'agri_weather_impact': 'କୃଷି-ଆବହାୱା ପ୍ରଭାବ',
      'loading_insights': 'ଆବହାୱା ତଥ୍ୟ ଲୋଡ ହେଉଛି...',
      'agri_heavy_rain':
          '🌧 ଭାରୀ ବର୍ଷା ସମ୍ଭାବନା। କୀଟନାଶକ ଛିଞ୍ଚିବା ଓ ମଡ଼ କାମ ଏଡ଼ାନ୍ତୁ।',
      'agri_moderate_rain':
          '🌦 ମଧ୍ୟମ ବର୍ଷା। ବୁଣିବା ପାଇଁ ଭଲ କିନ୍ତୁ ଖତ ଦେବା ଏଡ଼ାନ୍ତୁ।',
      'agri_high_temp': '🔥 ଅଧିକ ତାପମାତ୍ରା। ଜଳସେଚନ ବଢ଼ାନ୍ତୁ।',
      'agri_cool': '❄ ଥଣ୍ଡା ଆବହାୱା। ରବି ଫସଲ ପାଇଁ ଭଲ।',
      'agri_strong_wind': '💨 ଜୋରଦାର ବାୟୁ। ରାସାୟନିକ ଛିଞ୍ଚିବା ଏଡ଼ାନ୍ତୁ।',
      'agri_stable': '✅ ଆବହାୱା ସ୍ଥିର। ଚାଷ ପାଇଁ ଭଲ।',

      // Advisory screen
      'crop_advisory': 'ଫସଲ ପରାମର୍ଶ',
      'season_alerts': 'ଋତୁ ସତର୍କତା',
      'kharif_alert':
          '⚠️  ଖରିଫ ବୁଣା ସମୟ: ଜୁନ ୧୫ – ଜୁଲାଇ ୧୦। ଉପକୂଳ ଓଡ଼ିଶାରେ ଧାନ ପାଇଁ ଉତ୍ତମ।',
      'best_crops': 'ଆପଣଙ୍କ ଅଞ୍ଚଳ ପାଇଁ ସର୍ବୋତ୍ତମ ଫସଲ',
      'crop_rice': 'ଧାନ (ଚାଉଳ)',
      'tip_rice': 'MTU-7029 ବା ସ୍ୱର୍ଣ ଜାତ ବୁଣନ୍ତୁ। SRI ପଦ୍ଧତିରେ ୩୦% ଜଳ ସଞ୍ଚୟ।',
      'crop_maize': 'ମକା',
      'tip_maize':
          '୬୦×୨୦ ସେମି ଧାଡ଼ିରେ ଲଗାନ୍ତୁ। ଭଲ ଅଙ୍କୁରଣ ପାଇଁ ୨୫ କିଗ୍ରା/ହେ ଜିଙ୍କ ସଲ୍ଫେଟ ଦିଅନ୍ତୁ।',
      'crop_groundnut': 'ଚିନାବାଦାମ',
      'tip_groundnut':
          'ବାଲୁ ଦୋରସା ମାଟି ପାଇଁ ଉପଯୁକ୍ତ। ବୁଣିବା ପୂର୍ବରୁ ରାଇଜୋବିୟମ ଦ୍ୱାରା ବିଜ ଶୋଧନ।',

      // Profile screen
      'farmer_profile': 'ଚାଷୀ ପ୍ରୋଫାଇଲ',
      'hello_farmer': 'ନମସ୍କାର ଚାଷୀ 👨‍🌾',
      'manage_location': 'ଆପଣଙ୍କ ଅବସ୍ଥାନ ପରିଚାଳନା',
      'current_location': 'ବର୍ତ୍ତମାନ ଅବସ୍ଥାନ',
      'enter_location_manual': 'ଅବସ୍ଥାନ ହସ୍ତଚାଳିତ ଭାବେ ଦିଅନ୍ତୁ',
      'set_location': 'ଅବସ୍ଥାନ ଧାର୍ଯ୍ୟ',
      'detect_location': 'ଅବସ୍ଥାନ ଚିହ୍ନଟ',
      'language': 'ଭାଷା',

      // Snackbars / messages
      'turn_on_location': 'ଅବସ୍ଥାନ ସେବା ଚାଲୁ କରନ୍ତୁ',
      'permission_denied': 'ଅନୁମତି ଅସ୍ୱୀକୃତ',
      'permission_permanently_denied': 'ଅନୁମତି ସ୍ଥାୟୀ ଭାବେ ଅସ୍ୱୀକୃତ',
      'location_updated': '📍 ଅବସ୍ଥାନ ସଫଳତାର ସହ ଅଦ୍ୟତନ',
      'location_set': '📍 ଅବସ୍ଥାନ ଧାର୍ଯ୍ୟ ହୋଇଛି',
      'location_not_found': '❌ ଅବସ୍ଥାନ ମିଳିଲାନି',
      'failed_location': 'ଅବସ୍ଥାନ ଗ୍ରହଣ ବିଫଳ',

      // Seasons
      'kharif': 'ଖରିଫ',
      'rabi': 'ରବି',
      'zaid': 'ଜାଇଦ',
      'kharif_season': 'ଖରିଫ (ଜୁନ–ଅକ୍ଟୋ)',
      'rabi_season': 'ରବି (ନଭେ–ଏପ୍ରି)',
      'zaid_season': 'ଜାଇଦ (ଏପ୍ରି–ଜୁନ)',

      // Crop names
      'rice': 'ଧାନ',
      'wheat': 'ଗହମ',
      'maize': 'ମକା',
      'groundnut': 'ଚିନାବାଦାମ',
      'mustard': 'ସୋରିଷ',
      'sugarcane': 'ଆଖୁ',
      'cotton': 'କପା',
      'millets': 'ବାଜରା',
      'pigeon_pea': 'ହରଡ଼ ଡ଼ାଲ',
      'green_gram': 'ମୁଗ ଡ଼ାଲ',
      'black_gram': 'ବିରି ଡ଼ାଲ',
      'sesame': 'ତିଳ',
      'ragi': 'ମଣ୍ଡିଆ',

      // Soil types
      'red_soil': 'ଲାଲ ମାଟି',
      'black_soil': 'କଳା ମାଟି',
      'alluvial': 'ଜଲୋଢ଼ ମାଟି',
      'laterite': 'ଲାଟେରାଇଟ',
      'sandy_loam': 'ବାଲୁ ଦୋରସା',

      // Misc
      'loading': 'ଲୋଡ ହେଉଛି...',
      'unknown': 'ଅଜ୍ଞାତ',

      // AI Result Screen
      'ai_result_title': 'AI ଫସଲ ବିଶ୍ଳେଷଣ',
      'fetching_history': '୫ ବର୍ଷର ଆବହାୱା ତଥ୍ୟ ଆଣୁଛି...',
      'asking_claude': 'Groq AI କୁ ପଚାରୁଛି...',
      'expected_yield': 'ଅପେକ୍ଷିତ ଅମଳ',
      'per_acre': 'ପ୍ରତି ଏକର',
      'total_yield': 'ମୋଟ ଅମଳ',
      'ai_rating': 'AI ମୂଲ୍ୟାଙ୍କ',
      'rating_good': '✅ ଭଲ',
      'rating_moderate': '🟡 ମଧ୍ୟମ',
      'rating_risk': '🔴 ଝୁଙ୍କି',
      'historical_weather': '📊 ଐତିହାସିକ ଆବହାୱା (୫ ବର୍ଷ)',
      'avg_temp_hist': 'ହାରା ତାପ',
      'avg_rain_hist': 'ହାରା ବର୍ଷା',
      'avg_hum_hist': 'ହାରା ଆର୍ଦ୍ରତା',
      'similar_years': '🕐 ମିଳିତ ଅତୀତ ବର୍ଷ',
      'ai_suggestions': '🤖 AI ସ୍ମାର୍ଟ ପରାମର୍ଶ',
      'saved_to_advisory': '✅ ପରାମର୍ଶରେ ସଞ୍ଚୟ ହୋଇଛି!',
      'error_fetch': 'ତଥ୍ୟ ଆଣିବାରେ ତ୍ରୁଟି। ପୁଣି ଚେଷ୍ଟା କରନ୍ତୁ।',
      'year_label': 'ବର୍ଷ',
      'temp_chart': 'ତାପମାତ୍ରା (°C)',
      'rain_chart': 'ବର୍ଷା (mm/ଦିନ)',
      'humidity_chart': 'ଆର୍ଦ୍ରତା (%)',

      // Advisory Screen
      'advisory_title': 'ମୋ ପରାମର୍ଶ',
      'no_predictions':
          'ଏଯାଏ କୌଣସି ପୂର୍ବାନୁମାନ ନାହିଁ।\nPrediction ଟ୍ୟାବକୁ ଯାଆନ୍ତୁ ଓ ପ୍ରଥମ AI ବିଶ୍ଳେଷଣ ଚଳାନ୍ତୁ!',
      'last_analysis': 'ଶେଷ ବିଶ୍ଳେଷଣ',
      'tap_for_details': 'ବିବରଣ ପାଇଁ ଟ୍ୟାପ କରନ୍ତୁ',
      'analysis_on': 'ବିଶ୍ଳେଷଣ ତାରିଖ',
      'delete_confirm': 'ଏହି ବିଶ୍ଳେଷଣ ବିଲୋପ କରିବେ?',
      'delete': 'ବିଲୋପ',
      'cancel': 'ବାତିଲ',

      'predict_appbar': 'ଫସଲ ଓ ଜମି ବିବରଣ',
      'predict_subtitle':
          'ଆପଣଙ୍କ ଫସଲ ଓ ଜମି ତଥ୍ୟ ଦିଅନ୍ତୁ — ଆବହାୱା, ମାଟି ଓ ପୋଷକ ତତ୍ୱ ସ୍ୱୟଂ ଆସିବ',
      'weather_auto_fetched': 'ଆବହାୱା ସ୍ୱୟଂ ପ୍ରାପ୍ତ ✓',
      'weather_fetch_failed': 'ଆବହାୱା ପ୍ରାପ୍ତ ବିଫଳ — ଡିଫଲ୍ଟ ବ୍ୟବହାର',
      'fetching_live_weather': 'ସିଧା ଆବହାୱା ଆଣୁଛି...',
      'crop_variety_section': 'ଫସଲ ଓ ଜାତ ଚୟନ',
      'select_crop_label': 'ଫସଲ ଚୟନ କରନ୍ତୁ *',
      'select_crop_hint': 'ଫସଲ ଚୟନ',
      'select_variety_label': 'ଜାତ ଚୟନ କରନ୍ତୁ *',
      'select_variety_hint': 'ଜାତ ଚୟନ',
      'please_select_variety': 'ଜାତ ଚୟନ କରନ୍ତୁ',
      'season_auto': 'ଋତୁ (ସ୍ୱୟଂ ଚିହ୍ନଟ)',
      'location_details': 'ଅବସ୍ଥାନ ବିବରଣ',
      'district_label': 'ଜିଲ୍ଲା *',
      'district_hint': 'ଜିଲ୍ଲା ଚୟନ',
      'district_helper': 'GPS ରୁ ସ୍ୱୟଂ ଭରା',
      'please_select_district': 'ଜିଲ୍ଲା ଚୟନ କରନ୍ତୁ',
      'farm_details': 'ଜମି ବିବରଣ',
      'irrigation_label': 'ଜଳସେଚନ ପ୍ରକାର *',
      'irrigation_hint': 'ଜଳସେଚନ ଚୟନ',
      'please_select_irrigation': 'ଜଳସେଚନ ପ୍ରକାର ଚୟନ କରନ୍ତୁ',
      'fertilizer_major_label': 'ସାର (ମୁଖ୍ୟ)',
      'fertilizer_hint': 'ସାର ଚୟନ',
      'soil_auto_label': 'ମାଟି ପ୍ରକାର',
      'soil_helper': 'ଜିଲ୍ଲା ଆଧାରରେ ସ୍ୱୟଂ — ଆପଣ ବଦଳାଇ ପାରିବେ',
      'npk_pre_filled':
          'ଜିଲ୍ଲା ମୃତ୍ତିକା ସ୍ୱାସ୍ଥ୍ୟ ଆଧାରରେ ପୂର୍ବ-ଭରା। ଆପଣ ବଦଳାଇ ପାରିବେ।',
      'with_balanced_npk': 'ସନ୍ତୁଳିତ NPK\nପ୍ରୟୋଗ ସହ',
      'prediction_results': 'ପୂର୍ବାନୁମାନ ଫଳ',
      'predicted_yield': 'ଅନୁମାନିତ ଅମଳ',
      'total_production': 'ମୋଟ ଉତ୍ପାଦନ',
      'confidence': 'ଆତ୍ମବିଶ୍ୱାସ',
      'range': 'ସୀମା',
      'profit_potential': 'ଲାଭ ସୁଯୋଗ',
      'nutrient_status': 'ପୋଷକ ତତ୍ୱ ସ୍ଥିତି ଓ ଅଭାବ ବିଶ୍ଳେଷଣ',
      'fertilizer_recommendations': 'ସାର ସୁପାରିଶ',
      'fertilizer_sub': 'ମୃତ୍ତିକା ବିଶ୍ଳେଷଣ ଆଧାରିତ ସଠିକ ପ୍ରୟୋଗ ହାର',
      'yield_scenarios': 'ଅମଳ ଉନ୍ନତି ପରିଦୃଶ୍ୟ',
      'yield_scenarios_sub': 'ଅନୁକୂଳ ପୋଷକ ପ୍ରବନ୍ଧନ ସହ ସମ୍ଭାବ୍ୟ ଅମଳ ବୃଦ୍ଧି',
      'current_prediction': 'ବର୍ତ୍ତମାନ ପୂର୍ବାନୁମାନ',
      'plus_10kg_n': '+10 କିଗ୍ରା ନାଇଟ୍ରୋଜେନ',
      'balanced_npk': 'ସନ୍ତୁଳିତ NPK',
      'increase_label': 'ବୃଦ୍ଧି',
      'ai_farming_advice': 'AI-ଚାଳିତ ଚାଷ ପରାମର୍ଶ',
      'personalized_recs': 'ବ୍ୟକ୍ତିଗତ ସୁପାରିଶ',
      'crop_analysis_summary': 'ଫସଲ ବିଶ୍ଳେଷଣ ସାରାଂଶ',
      'tailored_advice': 'ଆପଣଙ୍କ ଚୟନ ପାଇଁ ଉପଯୁକ୍ତ ପରାମର୍ଶ',
      'season_ready': 'ଋତୁ-ପ୍ରସ୍ତୁତ',
      'optimized': 'ଅନୁକୂଳ',
      'risk_alerts': 'ଝୁଙ୍କି ସଙ୍କେତ',
      'alert_badge': 'ସଙ୍କେତ',
      'optimal_growth_tab': 'ଅନୁକୂଳ ବୃଦ୍ଧି',
      'fertilizer_plan_tab': 'ସାର ଯୋଜନା',
      'pest_alerts_tab': 'କୀଟ ସଙ୍କେତ',
      'water_schedule_tab': 'ଜଳ ଯୋଜନା',
      'retry': 'ପୁଣି ଚେଷ୍ଟା',
      'for_acres': 'ଏକର କୃଷି ଭୂମି',
      'q_acre': 'କ୍ୱିଣ୍ଟାଲ/ଏକର',
      'quintals': 'କ୍ୱିଣ୍ଟାଲ',
      'per_inr_acre': '/ଏକର',
      'recommendations_count': 'ସୁପାରିଶ',
      'recommendation_single': 'ସୁପାରିଶ',
      'deficient': 'ଅଭାବ',
      'excess': 'ଅଧିକ',
      'optimal': 'ଉପଯୁକ୍ତ',
      'status_label': 'ସ୍ଥିତି',
      'tab_optimal_1': '🌱 {crop} ଅଧିକ ଜଳ ଆବଶ୍ୟକ',
      'tab_optimal_2': '📅 ଅପେକ୍ଷିତ ବୃଦ୍ଧି ଅବଧି: ୧୨୦ ଦିନ',
      'tab_optimal_3': '💧 ଆପଣଙ୍କ {irrigation} ଜଳସେଚନ ଏହି ଫସଲ ପାଇଁ ଉପଯୁକ୍ତ',
      'tab_fertilizer_1': '🧪 ୟୁରିଆ: {urea} କିଗ୍ରା/ଏକର ଟପ ଡ୍ରେସିଂରେ',
      'tab_fertilizer_2': '🧪 DAP: {dap} କିଗ୍ରା/ଏକର ବেসল ପ୍ରୟୋଗରେ',
      'tab_fertilizer_3': '🧪 MOP: {mop} କିଗ୍ରା/ଏକର ଆବଶ୍ୟକ ଅନୁଯାୟୀ',
      'tab_pest_1': '🐛 କଣ୍ଠ ଛେଦକ ନଜର ରଖନ୍ତୁ',
      'tab_pest_2': '🍃 ଆର୍ଦ୍ର ପରିବେଶରେ ବ୍ଲାଷ୍ଟ ରୋଗ ଦେଖନ୍ତୁ',
      'tab_pest_3': '⚠️ ସୀମା ପ୍ରାପ୍ତ ହେଲେ ଅନୁମୋଦିତ କୀଟନାଶକ ବ୍ୟବହାର',
      'tab_water_1': '💧 ସକ୍ରିୟ ଅବସ୍ଥାରେ ୫ ସେମି ସ୍ଥାୟୀ ପାଣି ରଖନ୍ତୁ',
      'tab_water_2': '🌾 କଟଣ ୨ ସପ୍ତାହ ପୂର୍ବରୁ ଜଳସେଚନ କମ୍ କରନ୍ତୁ',
      'tab_water_3': '📊 AWD ପଦ୍ଧତିରେ ୩୦% ଜଳ ସଞ୍ଚୟ',
      'nitrogen_high_warn':
          'ନାଇଟ୍ରୋଜେନ ଅଧିକ ({n} କିଗ୍ରା/ହେ)। N ସାର କମ୍ କରନ୍ତୁ।',
      'potassium_high_warn':
          'ପୋଟାସିୟମ ଅଧିକ ({k} କିଗ୍ରା/ହେ)। K ପ୍ରୟୋଗ କମ୍ ବିଚାର କରନ୍ତୁ।',
    },
  };
}

// ─── App entry ───────────────────────────────────────────────
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const AgriHelperApp());
}

class AgriHelperApp extends StatelessWidget {
  const AgriHelperApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ValueListenableBuilder rebuilds the entire app on language change
    return ValueListenableBuilder<String>(
      valueListenable: langNotifier,
      builder: (context, lang, _) {
        return MaterialApp(
          title: AppText.get('app_name'),
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          home: const SplashScreen(),
        );
      },
    );
  }
}

// ─── Theme ───────────────────────────────────────────────────
class AppTheme {
  static const Color primary = Color(0xFF2E7D32);
  static const Color secondary = Color(0xFF558B2F);
  static const Color accent = Color(0xFFF9A825);
  static const Color soil = Color(0xFF795548);
  static const Color sky = Color(0xFF0288D1);
  static const Color surface = Color(0xFFF1F8E9);
  static const Color background = Color(0xFFFAFAFA);
  static const Color cardWhite = Color(0xFFFFFFFF);

  static ThemeData get light => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primary,
      primary: primary,
      secondary: secondary,
      surface: surface,
    ),
    scaffoldBackgroundColor: background,
    fontFamily: 'Roboto',
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      foregroundColor: Color(0xFF1B5E20),
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: Color(0xFF1B5E20),
        fontSize: 20,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.3,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: cardWhite,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primary, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      labelStyle: const TextStyle(color: Colors.grey),
    ),
    cardTheme: CardThemeData(
      color: cardWhite,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      margin: EdgeInsets.zero,
    ),
  );
}

// ═══════════════════════════════════════════════════════════
//  SPLASH SCREEN
// ═══════════════════════════════════════════════════════════
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fade;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeIn);
    _scale = Tween<double>(
      begin: 0.85,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    _ctrl.forward();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const MainNav()),
        );
      }
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primary,
      body: FadeTransition(
        opacity: _fade,
        child: ScaleTransition(
          scale: _scale,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: const Icon(Icons.grass, size: 64, color: Colors.white),
                ),
                const SizedBox(height: 24),
                Text(
                  AppText.get('app_name'),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  AppText.get('ai_crop_yield'),
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(height: 60),
                SizedBox(
                  width: 140,
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.white.withOpacity(0.3),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  AppText.get('sih_2025'),
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
//  BOTTOM NAV — Main shell
// ═══════════════════════════════════════════════════════════
class MainNav extends StatefulWidget {
  const MainNav({super.key});

  @override
  State<MainNav> createState() => _MainNavState();
}

class _MainNavState extends State<MainNav> {
  int _tab = 0;
  final _pages = const [
    HomeScreen(),
    PredictScreen(),
    WeatherScreen(),
    AdvisoryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    // Listen to lang changes to rebuild nav labels
    return ValueListenableBuilder<String>(
      valueListenable: langNotifier,
      builder: (context, _, _) {
        return Scaffold(
          body: _pages[_tab],
          bottomNavigationBar: NavigationBar(
            selectedIndex: _tab,
            onDestinationSelected: (i) => setState(() => _tab = i),
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            shadowColor: Colors.black26,
            destinations: [
              NavigationDestination(
                icon: const Icon(Icons.home_outlined),
                selectedIcon: const Icon(Icons.home),
                label: AppText.get('nav_home'),
              ),
              NavigationDestination(
                icon: const Icon(Icons.bar_chart_outlined),
                selectedIcon: const Icon(Icons.bar_chart),
                label: AppText.get('nav_predict'),
              ),
              NavigationDestination(
                icon: const Icon(Icons.cloud_outlined),
                selectedIcon: const Icon(Icons.cloud),
                label: AppText.get('nav_weather'),
              ),
              NavigationDestination(
                icon: const Icon(Icons.tips_and_updates_outlined),
                selectedIcon: const Icon(Icons.tips_and_updates),
                label: AppText.get('nav_advisory'),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ═══════════════════════════════════════════════════════════
//  HOME SCREEN
// ═══════════════════════════════════════════════════════════
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double temperature = 0;
  double rainfall = 0;
  String season = "Kharif";
  String location = "Loading...";

  // AI crop recommendations
  List<Map<String, dynamic>> _aiCrops = [];
  bool _cropsLoading = false;
  String _cropsLocation = '';

  Future<void> loadWeather() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final newLoc = prefs.getString('location') ?? AppText.get('unknown');
    final newTemp = prefs.getDouble('temp') ?? 0;
    final newRain = prefs.getDouble('rain') ?? 0;
    final newSeason = prefs.getString('season') ?? "Kharif";
    setState(() {
      temperature = newTemp;
      rainfall = newRain;
      season = newSeason;
      location = newLoc;
    });
    // Fetch AI crops only when location changes
    if (newLoc != _cropsLocation &&
        newLoc.isNotEmpty &&
        newLoc != AppText.get('unknown')) {
      _fetchAICrops(newLoc, newTemp, newRain, newSeason);
    }
  }

  Future<void> _fetchAICrops(
    String loc,
    double temp,
    double rain,
    String seas,
  ) async {
    if (_cropsLoading) return;
    setState(() => _cropsLoading = true);
    try {
      final res = await http
          .post(
            AppEnvironment.groqChatUri,
            headers: AppEnvironment.groqHeaders,
            body: json.encode({
              'model': 'openai/gpt-oss-120b',
              'messages': [
                {
                  'role': 'system',
                  'content':
                      'You are an agricultural expert for India. Respond ONLY with valid JSON, no markdown, no explanation.',
                },
                {
                  'role': 'user',
                  'content':
                      '''
Recommend the top 3 crops for a farmer in this region.
Location: $loc
Temperature: ${temp.toStringAsFixed(1)}°C
Rainfall: ${rain.toStringAsFixed(1)} mm
Season: $seas

Respond ONLY with this JSON (no markdown, no extra text):
{"crops":[{"key":"rice","score":92},{"key":"maize","score":78},{"key":"groundnut","score":65}]}

Use only these keys: rice, wheat, maize, groundnut, mustard, sugarcane, cotton, millets, pigeon_pea, green_gram, black_gram, sesame, ragi
Score should be 1-100.
''',
                },
              ],
             'max_tokens': 200,
'temperature': 0.2,
'response_format': {
  'type': 'json_object',
},
            }),
          )
          .timeout(const Duration(seconds: 15));

      if (res.statusCode == 200) {
        final data = json.decode(res.body);
        String text = data['choices'][0]['message']['content'] as String;
        text = text.replaceAll(RegExp(r'```json|```'), '').trim();
        final start = text.indexOf('{');
        final end = text.lastIndexOf('}');
        if (start != -1 && end != -1) {
          final parsed = json.decode(text.substring(start, end + 1));
          final cropList = parsed['crops'] as List;
          final icons = {
            'rice': '🌾',
            'wheat': '🌾',
            'maize': '🌽',
            'groundnut': '🥜',
            'mustard': '🌼',
            'sugarcane': '🌿',
            'cotton': '🌱',
            'millets': '🌾',
            'pigeon_pea': '🫘',
            'green_gram': '🫘',
            'black_gram': '🫘',
            'sesame': '🌻',
            'ragi': '🌾',
          };
          if (mounted) {
            setState(() {
              _aiCrops = cropList.map<Map<String, dynamic>>((c) {
                final key = c['key']?.toString() ?? 'rice';
                return {
                  'name': AppText.get(key),
                  'icon': icons[key] ?? '🌱',
                  'score': (c['score'] as num?)?.toInt() ?? 70,
                };
              }).toList();
              _cropsLocation = loc;
            });
          }
        }
      }
    } catch (_) {
      // Fall back to static on error — don't crash
    } finally {
      if (mounted) setState(() => _cropsLoading = false);
    }
  }

  List<Map<String, dynamic>> getRecommendedCrops() {
    // If AI has returned crops, use those
    if (_aiCrops.isNotEmpty) return _aiCrops;

    // Fallback static scoring while AI loads
    int riceScore = 0,
        maizeScore = 0,
        groundnutScore = 0,
        mustardScore = 0,
        sugarcaneScore = 0;
    if (rainfall > 200) {
      riceScore += 50;
      sugarcaneScore += 40;
    } else if (rainfall > 100) {
      maizeScore += 40;
      groundnutScore += 30;
    } else {
      mustardScore += 40;
      groundnutScore += 20;
    }
    if (temperature > 30) {
      groundnutScore += 30;
      maizeScore += 20;
    } else {
      riceScore += 20;
      mustardScore += 25;
    }
    if (season == "Rabi") {
      mustardScore += 30;
    } else if (season == "Kharif")
      riceScore += 30;
    List<Map<String, dynamic>> crops = [
      {"name": AppText.get('rice'), "icon": "🌾", "score": riceScore},
      {"name": AppText.get('maize'), "icon": "🌽", "score": maizeScore},
      {"name": AppText.get('groundnut'), "icon": "🥜", "score": groundnutScore},
      {"name": AppText.get('mustard'), "icon": "🌼", "score": mustardScore},
      {"name": AppText.get('sugarcane'), "icon": "🌿", "score": sugarcaneScore},
    ];
    crops.sort((a, b) => b["score"].compareTo(a["score"]));
    int maxScore = crops[0]["score"];
    if (maxScore > 0) {
      for (var crop in crops) {
        crop["score"] = ((crop["score"] / maxScore) * 100).round();
      }
    }
    return crops.take(3).toList();
  }

  @override
  void initState() {
    super.initState();
    loadWeather();
    langNotifier.addListener(_onLangChange);
  }

  @override
  void dispose() {
    langNotifier.removeListener(_onLangChange);
    super.dispose();
  }

  void _onLangChange() {
    // Refresh crop names when language changes
    if (_aiCrops.isNotEmpty) {
      // Re-fetch with current location to get translated names
      _fetchAICrops(location, temperature, rainfall, season);
    }
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadWeather();
  }

  String getIMDMessage() {
    if (rainfall > 200) return AppText.get('imd_heavy_rain');
    if (rainfall > 100) return AppText.get('imd_moderate_rain');
    if (temperature > 35) return AppText.get('imd_high_temp');
    if (temperature < 20) return AppText.get('imd_cool');
    return AppText.get('imd_stable');
  }

  String _localSeason() {
    if (season == 'Kharif') return AppText.get('kharif');
    if (season == 'Rabi') return AppText.get('rabi');
    if (season == 'Zaid') return AppText.get('zaid');
    return season;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: AppTheme.primary,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppTheme.primary, AppTheme.secondary],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppText.get('namaskara'),
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.85),
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  AppText.get('app_name'),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 28,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () async {
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProfileScreen(),
                                  ),
                                );
                                if (result == true) loadWeather();
                              },
                              child: CircleAvatar(
                                radius: 24,
                                backgroundColor: Colors.white.withOpacity(0.2),
                                child: const Icon(
                                  Icons.person_outline,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: Colors.white70,
                                size: 16,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                "$location • ${_localSeason()} ${AppText.get('season_suffix')}",
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Row(
                  children: [
                    _StatCard(
                      icon: Icons.eco,
                      label: AppText.get('season_label'),
                      value: _localSeason(),
                      color: AppTheme.secondary,
                    ),
                    const SizedBox(width: 12),
                    _StatCard(
                      icon: Icons.water_drop,
                      label: AppText.get('rainfall_label'),
                      value: '${rainfall.toStringAsFixed(1)} mm',
                      color: AppTheme.sky,
                    ),
                    const SizedBox(width: 12),
                    _StatCard(
                      icon: Icons.thermostat,
                      label: AppText.get('temp_label'),
                      value: '${temperature.toStringAsFixed(1)}°C',
                      color: AppTheme.accent,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _SectionHeader(title: AppText.get('quick_actions')),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _ActionTile(
                        icon: Icons.auto_graph,
                        title: AppText.get('predict_yield'),
                        subtitle: AppText.get('enter_farm_details'),
                        color: AppTheme.primary,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const PredictScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _ActionTile(
                        icon: Icons.analytics_outlined,
                        title: AppText.get('analysis'),
                        subtitle: AppText.get('view_advisory'),
                        color: AppTheme.soil,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const AdvisoryScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: _SectionHeader(
                        title: AppText.get('recommended_crops'),
                      ),
                    ),
                    if (_cropsLoading)
                      const Padding(
                        padding: EdgeInsets.only(right: 4),
                        child: SizedBox(
                          width: 14,
                          height: 14,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppTheme.primary,
                          ),
                        ),
                      ),
                    if (!_cropsLoading && _aiCrops.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.auto_awesome,
                              size: 11,
                              color: AppTheme.primary,
                            ),
                            SizedBox(width: 3),
                            Text(
                              'AI',
                              style: TextStyle(
                                fontSize: 10,
                                color: AppTheme.primary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 110,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: getRecommendedCrops().map<Widget>((crop) {
                      return _CropChip(
                        name: crop["name"],
                        icon: crop["icon"],
                        score: crop["score"],
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 20),
                _SectionHeader(title: AppText.get('recommendations_based')),
                const SizedBox(height: 8),
                _AlertBanner(message: getIMDMessage()),
                const SizedBox(height: 80),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
//  PREDICT SCREEN — Enhanced with variety, location, irrigation, fertilizer
// ═══════════════════════════════════════════════════════════

// Crop variety data
const Map<String, List<String>> _cropVarieties = {
  'rice': [
    'Swarna',
    'MTU-1010',
    'IR-36',
    'Naveen',
    'Lalat',
    'Khandagiri',
    'NDR-359',
    'Ranjit',
  ],
  'wheat': ['HD-2967', 'GW-496', 'PBW-550', 'Lok-1', 'K-307'],
  'maize': ['HQPM-1', 'Vivek-QPM-9', 'Shaktiman-1', 'PEHM-2'],
  'groundnut': ['K-6', 'TAG-24', 'GG-20', 'Kadiri-3', 'ICGS-76'],
  'mustard': ['Pusa Bold', 'Kranti', 'Varuna', 'Rohini', 'Maya'],
  'sugarcane': ['Co-238', 'CoC-671', 'Co-86032', 'CoJ-64'],
  'cotton': ['MCU-5', 'LRA-5166', 'Anjali', 'Suraj', 'H-4'],
  'pigeon_pea': ['ICPL-87119', 'BDN-711', 'Asha', 'Pusa-992'],
  'green_gram': ['Pusa-Vishal', 'SML-668', 'PDM-139', 'Meha'],
  'black_gram': ['Pant U-19', 'IPU-94-1', 'LBG-648', 'VBN-3'],
  'sesame': ['E-8', 'Rama', 'Swetha', 'Prachi'],
  'ragi': ['GPU-28', 'VL-149', 'MR-6', 'PR-202'],
};

// Odisha districts
const List<String> _odishaDistricts = [
  'Angul',
  'Balangir',
  'Balasore',
  'Bargarh',
  'Bhadrak',
  'Boudh',
  'Cuttack',
  'Deogarh',
  'Dhenkanal',
  'Gajapati',
  'Ganjam',
  'Jagatsinghpur',
  'Jajpur',
  'Jharsuguda',
  'Kalahandi',
  'Kandhamal',
  'Kendrapara',
  'Kendujhar',
  'Khordha',
  'Koraput',
  'Malkangiri',
  'Mayurbhanj',
  'Nabarangpur',
  'Nayagarh',
  'Nuapada',
  'Puri',
  'Rayagada',
  'Sambalpur',
  'Subarnapur',
  'Sundargarh',
];

// Irrigation types
const List<String> _irrigationTypes = [
  'Rainfed',
  'Canal Irrigation',
  'Tube Well',
  'Bore Well',
  'Drip Irrigation',
  'Sprinkler',
  'Pond/Tank',
];

// Fertilizer types
const List<String> _fertilizerTypes = [
  'Urea',
  'DAP (Di-Ammonium Phosphate)',
  'MOP (Muriate of Potash)',
  'SSP (Single Super Phosphate)',
  'NPK (Compound Fertilizer)',
  'Compost',
  'Cow Manure',
  'Other',
];

// Extended crop list with keys — labels are resolved at runtime via AppText
const List<Map<String, String>> _extendedCrops = [
  {'key': 'rice', 'label': 'Rice'},
  {'key': 'maize', 'label': 'Maize'},
  {'key': 'pigeon_pea', 'label': 'Pigeon Pea (Arhar)'},
  {'key': 'green_gram', 'label': 'Green Gram (Moong)'},
  {'key': 'black_gram', 'label': 'Black Gram (Urad)'},
  {'key': 'groundnut', 'label': 'Groundnut'},
  {'key': 'sesame', 'label': 'Sesame'},
  {'key': 'ragi', 'label': 'Ragi'},
  {'key': 'wheat', 'label': 'Wheat'},
  {'key': 'mustard', 'label': 'Mustard'},
  {'key': 'sugarcane', 'label': 'Sugarcane'},
  {'key': 'cotton', 'label': 'Cotton'},
];

// Returns the localized crop label for a given key
String _cropLabel(String key) {
  const knownKeys = [
    'rice',
    'maize',
    'pigeon_pea',
    'green_gram',
    'black_gram',
    'groundnut',
    'sesame',
    'ragi',
    'wheat',
    'mustard',
    'sugarcane',
    'cotton',
  ];
  if (knownKeys.contains(key)) return AppText.get(key);
  // Fallback: find in static list
  return _extendedCrops.firstWhere(
    (c) => c['key'] == key,
    orElse: () => {'key': key, 'label': key},
  )['label']!;
}

class PredictScreen extends StatefulWidget {
  const PredictScreen({super.key});

  @override
  State<PredictScreen> createState() => _PredictScreenState();
}

// District → default soil type mapping for Odisha
const Map<String, String> _districtSoilMap = {
  'Angul': 'red_soil',
  'Balangir': 'red_soil',
  'Balasore': 'alluvial',
  'Bargarh': 'alluvial',
  'Bhadrak': 'alluvial',
  'Boudh': 'red_soil',
  'Cuttack': 'alluvial',
  'Deogarh': 'laterite',
  'Dhenkanal': 'red_soil',
  'Gajapati': 'laterite',
  'Ganjam': 'red_soil',
  'Jagatsinghpur': 'alluvial',
  'Jajpur': 'alluvial',
  'Jharsuguda': 'laterite',
  'Kalahandi': 'red_soil',
  'Kandhamal': 'laterite',
  'Kendrapara': 'alluvial',
  'Kendujhar': 'laterite',
  'Khordha': 'alluvial',
  'Koraput': 'laterite',
  'Malkangiri': 'laterite',
  'Mayurbhanj': 'laterite',
  'Nabarangpur': 'red_soil',
  'Nayagarh': 'red_soil',
  'Nuapada': 'red_soil',
  'Puri': 'alluvial',
  'Rayagada': 'laterite',
  'Sambalpur': 'alluvial',
  'Subarnapur': 'alluvial',
  'Sundargarh': 'laterite',
};

// District → typical NPK values (kg/ha) based on regional soil health data
const Map<String, Map<String, int>> _districtNpkMap = {
  'Cuttack': {'n': 80, 'p': 40, 'k': 40},
  'Puri': {'n': 75, 'p': 35, 'k': 35},
  'Khordha': {'n': 80, 'p': 40, 'k': 40},
  'Balasore': {'n': 70, 'p': 35, 'k': 40},
  'Bhadrak': {'n': 70, 'p': 35, 'k': 40},
  'Kendrapara': {'n': 70, 'p': 30, 'k': 35},
  'Jagatsinghpur': {'n': 70, 'p': 30, 'k': 35},
  'Jajpur': {'n': 65, 'p': 30, 'k': 35},
  'Ganjam': {'n': 60, 'p': 25, 'k': 30},
  'Koraput': {'n': 50, 'p': 20, 'k': 25},
  'Malkangiri': {'n': 45, 'p': 18, 'k': 20},
  'Gajapati': {'n': 50, 'p': 20, 'k': 25},
  'Rayagada': {'n': 50, 'p': 20, 'k': 25},
  'Kalahandi': {'n': 55, 'p': 22, 'k': 28},
  'Nuapada': {'n': 50, 'p': 20, 'k': 25},
  'Bolangir': {'n': 55, 'p': 22, 'k': 28},
  'Subarnapur': {'n': 60, 'p': 25, 'k': 30},
  'Bargarh': {'n': 65, 'p': 28, 'k': 32},
  'Sambalpur': {'n': 62, 'p': 25, 'k': 30},
  'Jharsuguda': {'n': 58, 'p': 22, 'k': 28},
  'Deogarh': {'n': 55, 'p': 20, 'k': 25},
  'Sundargarh': {'n': 55, 'p': 22, 'k': 28},
  'Kendujhar': {'n': 55, 'p': 20, 'k': 25},
  'Mayurbhanj': {'n': 60, 'p': 25, 'k': 30},
  'Angul': {'n': 60, 'p': 25, 'k': 30},
  'Dhenkanal': {'n': 60, 'p': 25, 'k': 30},
  'Boudh': {'n': 55, 'p': 22, 'k': 28},
  'Kandhamal': {'n': 50, 'p': 20, 'k': 25},
  'Nayagarh': {'n': 60, 'p': 25, 'k': 30},
  'Nabarangpur': {'n': 50, 'p': 20, 'k': 25},
};

class _PredictScreenState extends State<PredictScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _selectedCrop;
  String? _selectedVariety;
  String? _selectedSoil;
  String? _selectedSeason;
  String? _selectedDistrict;
  String? _selectedIrrigation;
  String? _selectedFertilizer;
  DateTime? _sowingDate;
  // Holds GPS-detected district/city that is NOT in the Odisha list
  String? _gpsDetectedExtraDistrict;

  final _tempCtrl = TextEditingController();
  final _areaCtrl = TextEditingController();
  final _nCtrl = TextEditingController();
  final _pCtrl = TextEditingController();
  final _kCtrl = TextEditingController();

  // Auto-fetched values
  double _autoRainfall = 0;
  double _autoTemp = 28.0;
  bool _weatherFetched = false;
  String _weatherStatus = '';

  bool _loading = false;
  bool _gpsLoading = false;

  final _soilKeys = [
    'red_soil',
    'black_soil',
    'alluvial',
    'laterite',
    'sandy_loam',
  ];
  final _seasonKeys = ['kharif_season', 'rabi_season', 'zaid_season'];

  List<String> get _varietiesForCrop => _cropVarieties[_selectedCrop] ?? [];

  @override
  void initState() {
    super.initState();
    _autoDetectSeason();
    _loadSavedLocation();
    langNotifier.addListener(_onLangChange);
  }

  @override
  void dispose() {
    langNotifier.removeListener(_onLangChange);
    _tempCtrl.dispose();
    _areaCtrl.dispose();
    _nCtrl.dispose();
    _pCtrl.dispose();
    _kCtrl.dispose();
    super.dispose();
  }

  void _onLangChange() => setState(() {});

  void _autoDetectSeason() {
    final month = DateTime.now().month;
    String season;
    if (month >= 6 && month <= 10) {
      season = 'kharif_season';
    } else if (month >= 11 || month <= 4) {
      season = 'rabi_season';
    } else {
      season = 'zaid_season';
    }
    setState(() => _selectedSeason = season);
  }

  Future<void> _loadSavedLocation() async {
    final prefs = await SharedPreferences.getInstance();
    final loc = prefs.getString('location') ?? '';
    String? matchedDistrict;
    for (final d in _odishaDistricts) {
      if (loc.toLowerCase().contains(d.toLowerCase())) {
        matchedDistrict = d;
        break;
      }
    }
    if (matchedDistrict != null) {
      final npk =
          _districtNpkMap[matchedDistrict] ?? {'n': 60, 'p': 25, 'k': 30};
      setState(() {
        _selectedDistrict = matchedDistrict;
        _selectedSoil = _districtSoilMap[matchedDistrict] ?? 'alluvial';
      });
      _nCtrl.text = npk['n'].toString();
      _pCtrl.text = npk['p'].toString();
      _kCtrl.text = npk['k'].toString();
    } else if (loc.isNotEmpty && loc != AppText.get('unknown')) {
      // Location is saved but not an Odisha district (e.g. "Chennai, Tamil Nadu")
      // Extract the city/district portion (before first comma)
      final cityName = loc.split(',').first.trim();
      setState(() {
        _gpsDetectedExtraDistrict = cityName;
        _selectedDistrict = cityName;
        _selectedSoil = 'alluvial';
      });
      _nCtrl.text = '60';
      _pCtrl.text = '25';
      _kCtrl.text = '30';
    } else {
      // Default NPK values when no location at all
      _nCtrl.text = '60';
      _pCtrl.text = '25';
      _kCtrl.text = '30';
    }
    final lat = prefs.getDouble('lat');
    final lon = prefs.getDouble('lon');
    if (lat != null && lon != null) {
      _fetchWeatherFromCoords(lat, lon);
    }
  }

  Future<void> _fetchWeatherFromCoords(double lat, double lon) async {
    setState(() => _weatherStatus = AppText.get('fetching_live_weather'));
    try {
      // Fetch past 30 days of daily precipitation + today's temperature
      final now = DateTime.now();
      final past30 = now.subtract(const Duration(days: 30));
      final startStr =
          '${past30.year}-${past30.month.toString().padLeft(2, '0')}-${past30.day.toString().padLeft(2, '0')}';
      final endStr =
          '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';

      final url = AppEnvironment.meteoForecastUri(
        lat: lat,
        lon: lon,
        startDate: startStr,
        endDate: endStr,
      );
      final res = await http.get(url).timeout(const Duration(seconds: 12));
      if (res.statusCode == 200) {
        final data = json.decode(res.body);
        final current = data['current'];
        final avgTemp = (current['temperature_2m'] as num?)?.toDouble() ?? 28.0;

        // Sum up all daily precipitation over the past 30 days
        final List dailyRain =
            (data['daily']?['precipitation_sum'] as List?) ?? [];
        double totalRain = 0;
        for (final v in dailyRain) {
          if (v != null) totalRain += (v as num).toDouble();
        }

        if (mounted) {
          setState(() {
            _autoTemp = avgTemp;
            _autoRainfall = totalRain;
            _tempCtrl.text = avgTemp.toStringAsFixed(1);
            _weatherFetched = true;
            _weatherStatus = AppText.get('weather_auto_fetched');
          });
        }
      } else {
        if (mounted) {
          setState(() => _weatherStatus = AppText.get('weather_fetch_failed'));
        }
      }
    } catch (_) {
      if (mounted) {
        setState(() => _weatherStatus = AppText.get('weather_fetch_failed'));
      }
    }
  }

  Future<void> _useGPS() async {
    setState(() => _gpsLoading = true);
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(AppText.get('turn_on_location'))),
          );
        }
        if (mounted) setState(() => _gpsLoading = false);
        return;
      }
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          if (mounted) setState(() => _gpsLoading = false);
          return;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        if (mounted) {
          setState(() => _gpsLoading = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppText.get('permission_permanently_denied')),
            ),
          );
        }
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      Placemark place = placemarks[0];

      final prefs = await SharedPreferences.getInstance();
      await prefs.setDouble('lat', position.latitude);
      await prefs.setDouble('lon', position.longitude);

      // Build a combined string from all available placemark fields for matching
      final placeStr = [
        place.locality,
        place.subLocality,
        place.subAdministrativeArea,
        place.administrativeArea,
        place.name,
      ].whereType<String>().join(' ').toLowerCase();

      String? matchedDistrict;
      for (final d in _odishaDistricts) {
        if (placeStr.contains(d.toLowerCase())) {
          matchedDistrict = d;
          break;
        }
      }
      setState(() {
        if (matchedDistrict != null) {
          _selectedDistrict = matchedDistrict;
          _selectedSoil = _districtSoilMap[matchedDistrict] ?? 'alluvial';
          // Auto-fill NPK controllers from district map
          final npk =
              _districtNpkMap[matchedDistrict] ?? {'n': 60, 'p': 25, 'k': 30};
          _nCtrl.text = npk['n'].toString();
          _pCtrl.text = npk['p'].toString();
          _kCtrl.text = npk['k'].toString();
        } else {
          // Not an Odisha district — use actual location name from reverse geocoding
          final cityName =
              (place.subAdministrativeArea?.isNotEmpty == true
                  ? place.subAdministrativeArea
                  : place.locality?.isNotEmpty == true
                  ? place.locality
                  : place.administrativeArea) ??
              'Unknown Location';
          _gpsDetectedExtraDistrict = cityName;
          _selectedDistrict = cityName;
          // Use generic soil defaults for non-Odisha
          _selectedSoil = 'alluvial';
          _nCtrl.text = '60';
          _pCtrl.text = '25';
          _kCtrl.text = '30';
        }
      });
      _fetchWeatherFromCoords(position.latitude, position.longitude);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppText.get('location_updated')),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(AppText.get('failed_location'))));
      }
    } finally {
      if (mounted) setState(() => _gpsLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppText.get('predict_appbar')),
        actions: [
          IconButton(
            icon: const Icon(Icons.mic_outlined),
            tooltip: AppText.get('voice_input'),
            onPressed: () => ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(AppText.get('voice_snack')))),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Header subtitle
            Text(
              AppText.get('predict_subtitle'),
              style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
            ),
            const SizedBox(height: 12),

            // ── Auto-fetch status banner ──────────────────────
            if (_weatherStatus.isNotEmpty)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: _weatherFetched
                      ? const Color(0xFFE8F5E9)
                      : const Color(0xFFFFF8E1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _weatherFetched ? AppTheme.primary : AppTheme.accent,
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      _weatherFetched
                          ? Icons.cloud_done_outlined
                          : Icons.cloud_sync_outlined,
                      color: _weatherFetched
                          ? AppTheme.primary
                          : AppTheme.accent,
                      size: 20,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        _weatherStatus,
                        style: TextStyle(
                          fontSize: 13,
                          color: _weatherFetched
                              ? AppTheme.primary
                              : AppTheme.accent,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    if (_weatherFetched) ...[
                      Text(
                        '${_autoTemp.toStringAsFixed(0)}°C  ${_autoRainfall.toStringAsFixed(0)}mm',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ],
                ),
              ),

            // ── Crop & Variety Selection ──────────────────────
            _FormCard(
              title: AppText.get('crop_variety_section'),
              icon: Icons.eco,
              child: Column(
                children: [
                  DropdownButtonFormField<String>(
                    initialValue: _selectedCrop,
                    isExpanded: true,
                    decoration: InputDecoration(
                      labelText: AppText.get('select_crop_label'),
                      prefixIcon: const Icon(Icons.grass),
                    ),
                    hint: Text(AppText.get('select_crop_hint')),
                    items: _extendedCrops
                        .map(
                          (c) => DropdownMenuItem(
                            value: c['key'],
                            child: Text(_cropLabel(c['key']!)),
                          ),
                        )
                        .toList(),
                    onChanged: (v) => setState(() {
                      _selectedCrop = v;
                      _selectedVariety = null;
                    }),
                    validator: (v) =>
                        v == null ? AppText.get('select_crop') : null,
                  ),
                  const SizedBox(height: 14),
                  DropdownButtonFormField<String>(
                    initialValue: _selectedVariety,
                    isExpanded: true,
                    decoration: InputDecoration(
                      labelText: AppText.get('select_variety_label'),
                      prefixIcon: const Icon(Icons.spa_outlined),
                    ),
                    hint: Text(AppText.get('select_variety_hint')),
                    items: _varietiesForCrop
                        .map((v) => DropdownMenuItem(value: v, child: Text(v)))
                        .toList(),
                    onChanged: _selectedCrop == null
                        ? null
                        : (v) => setState(() => _selectedVariety = v),
                    validator: (v) =>
                        v == null ? AppText.get('please_select_variety') : null,
                  ),
                  const SizedBox(height: 14),
                  _DropdownField(
                    label: AppText.get('season_auto'),
                    value: _selectedSeason,
                    itemKeys: _seasonKeys,
                    onChanged: (v) => setState(() => _selectedSeason = v),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            // ── Location Details ──────────────────────────────
            _FormCard(
              title: AppText.get('location_details'),
              icon: Icons.location_on_outlined,
              iconColor: AppTheme.accent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DropdownButtonFormField<String>(
                    initialValue: _selectedDistrict,
                    isExpanded: true,
                    decoration: InputDecoration(
                      labelText: AppText.get('district_label'),
                      prefixIcon: const Icon(Icons.map_outlined),
                      helperText: AppText.get('district_helper'),
                      helperMaxLines: 2,
                    ),
                    hint: Text(
                      AppText.get('district_hint'),
                      overflow: TextOverflow.ellipsis,
                    ),
                    items: [
                      // Show GPS-detected non-Odisha location first (if any)
                      if (_gpsDetectedExtraDistrict != null &&
                          !_odishaDistricts.contains(_gpsDetectedExtraDistrict))
                        DropdownMenuItem(
                          value: _gpsDetectedExtraDistrict,
                          child: Row(
                            children: [
                              const Icon(
                                Icons.gps_fixed,
                                size: 14,
                                color: AppTheme.primary,
                              ),
                              const SizedBox(width: 6),
                              Flexible(
                                child: Text(
                                  _gpsDetectedExtraDistrict!,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ..._odishaDistricts.map(
                        (d) => DropdownMenuItem(value: d, child: Text(d)),
                      ),
                    ],
                    onChanged: (v) => setState(() {
                      _selectedDistrict = v;
                      if (v != null && _odishaDistricts.contains(v)) {
                        _selectedSoil = _districtSoilMap[v] ?? 'alluvial';
                        final npk =
                            _districtNpkMap[v] ?? {'n': 60, 'p': 25, 'k': 30};
                        _nCtrl.text = npk['n'].toString();
                        _pCtrl.text = npk['p'].toString();
                        _kCtrl.text = npk['k'].toString();
                      }
                    }),
                    validator: (v) => v == null
                        ? AppText.get('please_select_district')
                        : null,
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 48,
                    child: OutlinedButton.icon(
                      onPressed: _gpsLoading ? null : _useGPS,
                      icon: _gpsLoading
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.gps_fixed, size: 16),
                      label: Text(AppText.get('detect_location')),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppTheme.primary,
                        side: const BorderSide(color: AppTheme.primary),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            // ── Farm Details ──────────────────────────────────
            _FormCard(
              title: AppText.get('farm_details'),
              icon: Icons.straighten,
              iconColor: AppTheme.accent,
              child: Column(
                children: [
                  TextFormField(
                    controller: _areaCtrl,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: AppText.get('farm_area'),
                      suffixText: AppText.get('acres_suffix'),
                      prefixIcon: const Icon(Icons.crop_square),
                    ),
                    validator: (v) => v == null || v.isEmpty
                        ? AppText.get('enter_farm_area')
                        : null,
                  ),
                  const SizedBox(height: 14),
                  DropdownButtonFormField<String>(
                    initialValue: _selectedIrrigation,
                    isExpanded: true,
                    decoration: InputDecoration(
                      labelText: AppText.get('irrigation_label'),
                      prefixIcon: const Icon(Icons.water_drop_outlined),
                    ),
                    hint: Text(AppText.get('irrigation_hint')),
                    items: _irrigationTypes
                        .map(
                          (t) => DropdownMenuItem(
                            value: t,
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.water_drop_outlined,
                                  size: 18,
                                  color: AppTheme.sky,
                                ),
                                const SizedBox(width: 8),
                                Text(t),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (v) => setState(() => _selectedIrrigation = v),
                    validator: (v) => v == null
                        ? AppText.get('please_select_irrigation')
                        : null,
                  ),
                  const SizedBox(height: 14),
                  DropdownButtonFormField<String>(
                    initialValue: _selectedFertilizer,
                    isExpanded: true,
                    decoration: InputDecoration(
                      labelText: AppText.get('fertilizer_major_label'),
                      prefixIcon: const Icon(Icons.science_outlined),
                    ),
                    hint: Text(
                      AppText.get('fertilizer_hint'),
                      overflow: TextOverflow.ellipsis,
                    ),
                    items: _fertilizerTypes
                        .map((f) => DropdownMenuItem(value: f, child: Text(f, overflow: TextOverflow.ellipsis)))
                        .toList(),
                    onChanged: (v) => setState(() => _selectedFertilizer = v),
                  ),
                  const SizedBox(height: 14),
                  // ── Sowing Date (Optional) ────────────────────
                  InkWell(
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: _sowingDate ?? DateTime.now(),
                        firstDate: DateTime(DateTime.now().year - 1),
                        lastDate: DateTime(DateTime.now().year + 1),
                        helpText: AppText.get('sowing_date_label'),
                      );
                      if (picked != null) setState(() => _sowingDate = picked);
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: AppText.get('sowing_date_label'),
                        prefixIcon: const Icon(Icons.calendar_today_outlined),
                        helperText: AppText.get('sowing_date_helper'),
                        suffixIcon: _sowingDate != null
                            ? IconButton(
                                icon: const Icon(Icons.clear, size: 18),
                                onPressed: () =>
                                    setState(() => _sowingDate = null),
                              )
                            : const Icon(Icons.arrow_drop_down),
                      ),
                      child: Text(
                        _sowingDate != null
                            ? DateFormat('dd MMM yyyy').format(_sowingDate!)
                            : AppText.get('sowing_date_hint'),
                        style: TextStyle(
                          fontSize: 14,
                          color: _sowingDate != null
                              ? null
                              : Colors.grey.shade500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            // ── Soil & Land — auto-filled from district ───────
            _FormCard(
              title: '${AppText.get('soil_land')} (auto-filled)',
              icon: Icons.landscape,
              child: DropdownButtonFormField<String>(
                initialValue: _selectedSoil,
                decoration: InputDecoration(
                  labelText: AppText.get('soil_auto_label'),
                  prefixIcon: const Icon(Icons.layers_outlined),
                  helperText: AppText.get('soil_helper'),
                ),
                items: _soilKeys
                    .map(
                      (k) => DropdownMenuItem(
                        value: k,
                        child: Text(AppText.get(k)),
                      ),
                    )
                    .toList(),
                onChanged: (v) => setState(() => _selectedSoil = v),
              ),
            ),
            const SizedBox(height: 28),

            // ── NPK Values (auto-filled, editable) ───────────
            _FormCard(
              title: '${AppText.get('nutrients')} (auto-filled from region)',
              icon: Icons.science_outlined,
              iconColor: AppTheme.sky,
              child: Column(
                children: [
                  Text(
                    AppText.get('npk_pre_filled'),
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _nCtrl,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'N (kg/ha)',
                            prefixText: 'N  ',
                          ),
                          validator: (v) =>
                              v == null || v.isEmpty ? 'Required' : null,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextFormField(
                          controller: _pCtrl,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'P (kg/ha)',
                            prefixText: 'P  ',
                          ),
                          validator: (v) =>
                              v == null || v.isEmpty ? 'Required' : null,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextFormField(
                          controller: _kCtrl,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'K (kg/ha)',
                            prefixText: 'K  ',
                          ),
                          validator: (v) =>
                              v == null || v.isEmpty ? 'Required' : null,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ── Predict Button ────────────────────────────────
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _loading ? null : _predict,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: _loading
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2.5,
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.auto_awesome),
                          const SizedBox(width: 10),
                          Text(
                            AppText.get('predict_btn'),
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  void _predict() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    final prefs = await SharedPreferences.getInstance();
    final lat = prefs.getDouble('lat') ?? 20.2961;
    final lon = prefs.getDouble('lon') ?? 85.8245;
    final defaultNpk =
        _districtNpkMap[_selectedDistrict] ?? {'n': 60, 'p': 25, 'k': 30};
    final nVal = int.tryParse(_nCtrl.text) ?? defaultNpk['n']!;
    final pVal = int.tryParse(_pCtrl.text) ?? defaultNpk['p']!;
    final kVal = int.tryParse(_kCtrl.text) ?? defaultNpk['k']!;
    if (!mounted) return;
    setState(() => _loading = false);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AIResultScreen(
          crop: _selectedCrop!,
          variety: _selectedVariety ?? '',
          season: _selectedSeason!,
          soil: _selectedSoil ?? 'alluvial',
          area: double.tryParse(_areaCtrl.text) ?? 1.0,
          rainfall: _autoRainfall,
          temperature: _autoTemp,
          nitrogen: nVal,
          phosphorus: pVal,
          potassium: kVal,
          lat: lat,
          lon: lon,
          district: _selectedDistrict ?? '',
          block: '',
          village: '',
          irrigation: _selectedIrrigation ?? 'Rainfed',
          fertilizer: _selectedFertilizer ?? '',
        ),
      ),
    );
  }
}

// Nutrient slider widget
class _NutrientSlider extends StatelessWidget {
  final String label;
  final double value;
  final Color color;
  final String unit;
  final double max;
  final ValueChanged<double> onChanged;

  const _NutrientSlider({
    required this.label,
    required this.value,
    required this.color,
    required this.unit,
    required this.max,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '${value.round()} $unit',
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        Slider(
          value: value,
          min: 0,
          max: max,
          divisions: max.toInt(),
          activeColor: color,
          inactiveColor: color.withOpacity(0.2),
          onChanged: onChanged,
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════
//  AI RESULT SCREEN — Open-Meteo + Groq AI
// ═══════════════════════════════════════════════════════════
class AIResultScreen extends StatefulWidget {
  final String crop;
  final String variety;
  final String season;
  final String soil;
  final double area;
  final double rainfall;
  final double temperature;
  final int nitrogen;
  final int phosphorus;
  final int potassium;
  final double lat;
  final double lon;
  final String district;
  final String block;
  final String village;
  final String irrigation;
  final String fertilizer;

  const AIResultScreen({
    super.key,
    required this.crop,
    this.variety = '',
    required this.season,
    required this.soil,
    required this.area,
    required this.rainfall,
    required this.temperature,
    required this.nitrogen,
    required this.phosphorus,
    required this.potassium,
    required this.lat,
    required this.lon,
    this.district = '',
    this.block = '',
    this.village = '',
    this.irrigation = 'Rainfed',
    this.fertilizer = '',
  });

  @override
  State<AIResultScreen> createState() => _AIResultScreenState();
}

class _AIResultScreenState extends State<AIResultScreen> {
  bool _loading = true;
  String _statusMsg = '';
  String _error = '';

  // Historical data from Open-Meteo (last 5 years, by year)
  List<Map<String, dynamic>> _yearlyData = [];

  // Future 14-day forecast from Open-Meteo
  String _futureForecastText = '';

  // AI response parsed fields
  double _yieldPerAcre = 0;
  double _totalYield = 0;
  String _rating = '';
  List<String> _similarYears = [];
  List<String> _suggestions = [];
  String _rawClaudeText = '';

  // New structured result fields
  double _confidencePct = 80;
  double _yieldMin = 0;
  double _yieldMax = 0;
  double _profitPerAcre = 0;
  // Nutrient deficits (positive = excess, negative = deficit in kg/ha)
  double _nDeficit = 0;
  double _pDeficit = 0;
  double _kDeficit = 0;
  // Fertilizer recommendations
  double _ureaKgAcre = 0;
  double _dapKgAcre = 0;
  double _mopKgAcre = 0;
  // Yield improvement scenarios
  double _yieldPlusN = 0;
  double _yieldBalancedNpk = 0;
  // Risk alert
  String _riskAlert = '';
  // AI farming advice sections
  List<Map<String, dynamic>> _adviceSections = [];
  // Quick action tabs
  int _activeTab = 0;

  @override
  void initState() {
    super.initState();
    langNotifier.addListener(_onLangChange);
    _runAnalysis();
  }

  @override
  void dispose() {
    langNotifier.removeListener(_onLangChange);
    super.dispose();
  }

  void _onLangChange() => setState(() {});

  // ── Get season month range ────────────────────────────────
  Map<String, int> _seasonMonths() {
    if (widget.season.contains('rabi') || widget.season == 'rabi_season') {
      return {'start': 11, 'end': 3};
    } else if (widget.season.contains('zaid') ||
        widget.season == 'zaid_season') {
      return {'start': 4, 'end': 6};
    } else {
      return {'start': 6, 'end': 10};
    }
  }

  // ── Fetch Open-Meteo historical weather for one year ──────
  Future<Map<String, dynamic>?> _fetchYearWeather(int year) async {
    final sm = _seasonMonths();
    int startMonth = sm['start']!;
    int endMonth = sm['end']!;

    String startDate, endDate;
    if (startMonth > endMonth) {
      startDate = '$year-${startMonth.toString().padLeft(2, '0')}-01';
      endDate = '${year + 1}-${endMonth.toString().padLeft(2, '0')}-28';
    } else {
      startDate = '$year-${startMonth.toString().padLeft(2, '0')}-01';
      endDate = '$year-${endMonth.toString().padLeft(2, '0')}-28';
    }

    final url = AppEnvironment.meteoArchiveUri(
      lat: widget.lat,
      lon: widget.lon,
      startDate: startDate,
      endDate: endDate,
    );

    try {
      final res = await http.get(url).timeout(const Duration(seconds: 15));
      if (res.statusCode == 200) {
        final data = json.decode(res.body);
        final daily = data['daily'];
        final List temps = daily['temperature_2m_mean'] ?? [];
        final List rains = daily['precipitation_sum'] ?? [];
        final List hums = daily['relative_humidity_2m_mean'] ?? [];

        double avgTemp = 0, avgRain = 0, avgHum = 0;
        int countT = 0, countR = 0, countH = 0;
        for (var v in temps) {
          if (v != null) {
            avgTemp += v;
            countT++;
          }
        }
        for (var v in rains) {
          if (v != null) {
            avgRain += v;
            countR++;
          }
        }
        for (var v in hums) {
          if (v != null) {
            avgHum += v;
            countH++;
          }
        }

        return {
          'year': year,
          'avgTemp': countT > 0 ? avgTemp / countT : 0.0,
          'avgRain': countR > 0 ? avgRain / countR : 0.0,
          'avgHum': countH > 0 ? avgHum / countH : 0.0,
          'totalRain': countR > 0 ? avgRain : 0.0,
        };
      }
    } catch (_) {}
    return null;
  }

  // ── Fetch Open-Meteo 14-day future forecast ──────────────
  Future<String> _fetchFutureForecast() async {
    try {
      final url = AppEnvironment.meteoFourteenDayForecastUri(
        lat: widget.lat,
        lon: widget.lon,
      );
      final res = await http.get(url).timeout(const Duration(seconds: 15));
      if (res.statusCode == 200) {
        final data = json.decode(res.body);
        final daily = data['daily'] as Map<String, dynamic>;
        final dates = (daily['time'] as List?)?.cast<String>() ?? [];
        final maxTemps = (daily['temperature_2m_max'] as List?) ?? [];
        final minTemps = (daily['temperature_2m_min'] as List?) ?? [];
        final precip = (daily['precipitation_sum'] as List?) ?? [];
        final precipProb =
            (daily['precipitation_probability_max'] as List?) ?? [];
        final humidity = (daily['relative_humidity_2m_max'] as List?) ?? [];
        final wind = (daily['wind_speed_10m_max'] as List?) ?? [];
        final et0 = (daily['et0_fao_evapotranspiration'] as List?) ?? [];
        final lines = <String>[];
        for (int i = 0; i < dates.length && i < 14; i++) {
          final tMax = maxTemps.length > i && maxTemps[i] != null
              ? '${(maxTemps[i] as num).toStringAsFixed(1)}°C'
              : '—';
          final tMin = minTemps.length > i && minTemps[i] != null
              ? '${(minTemps[i] as num).toStringAsFixed(1)}°C'
              : '—';
          final rain = precip.length > i && precip[i] != null
              ? '${(precip[i] as num).toStringAsFixed(1)}mm'
              : '—';
          final rProb = precipProb.length > i && precipProb[i] != null
              ? '${precipProb[i]}%'
              : '—';
          final hum = humidity.length > i && humidity[i] != null
              ? '${humidity[i]}%'
              : '—';
          final wnd = wind.length > i && wind[i] != null
              ? '${(wind[i] as num).toStringAsFixed(1)}km/h'
              : '—';
          final evap = et0.length > i && et0[i] != null
              ? '${(et0[i] as num).toStringAsFixed(1)}mm'
              : '—';
          lines.add(
            '${dates[i]}: MaxT=$tMax MinT=$tMin Rain=$rain RainProb=$rProb Humidity=$hum Wind=$wnd ET0=$evap',
          );
        }
        return lines.join('\n');
      }
    } catch (_) {}
    return 'Future forecast unavailable';
  }

  // ── Call Groq AI ────────────────────────────────────────
  Future<void> _callClaude(List<Map<String, dynamic>> history) async {
    final histText = history
        .map(
          (y) =>
              'Year ${y['year']}: Avg Temp=${y['avgTemp'].toStringAsFixed(1)}°C, '
              'Avg Daily Rain=${y['avgRain'].toStringAsFixed(1)}mm, '
              'Avg Humidity=${y['avgHum'].toStringAsFixed(0)}%',
        )
        .join('\n');

    final cropLabel = _cropLabel(widget.crop);

    // Pre-compute NPK analysis to inject into prompt
    final cropOptimalN =
        {
          'rice': 120,
          'wheat': 120,
          'maize': 150,
          'sugarcane': 250,
          'cotton': 120,
          'groundnut': 20,
          'pigeon_pea': 20,
          'green_gram': 20,
          'black_gram': 20,
          'mustard': 120,
          'sesame': 40,
          'ragi': 80,
        }[widget.crop] ??
        80;
    final cropOptimalP =
        {
          'rice': 60,
          'wheat': 60,
          'maize': 70,
          'sugarcane': 110,
          'cotton': 60,
          'groundnut': 50,
          'pigeon_pea': 50,
          'green_gram': 40,
          'black_gram': 40,
          'mustard': 40,
          'sesame': 30,
          'ragi': 40,
        }[widget.crop] ??
        40;
    final cropOptimalK =
        {
          'rice': 60,
          'wheat': 40,
          'maize': 70,
          'sugarcane': 120,
          'cotton': 60,
          'groundnut': 40,
          'pigeon_pea': 40,
          'green_gram': 40,
          'black_gram': 40,
          'mustard': 40,
          'sesame': 30,
          'ragi': 40,
        }[widget.crop] ??
        40;

    final nGap = cropOptimalN - widget.nitrogen; // positive = deficit
    final pGap = cropOptimalP - widget.phosphorus;
    final kGap = cropOptimalK - widget.potassium;

    final nStatus = nGap > 0
        ? 'DEFICIT of $nGap kg/ha — needs ${(nGap * 2.17).toStringAsFixed(0)} kg Urea/ha'
        : 'EXCESS by ${(-nGap)} kg/ha — reduce nitrogen';
    final pStatus = pGap > 0
        ? 'DEFICIT of $pGap kg/ha — needs ${(pGap * 5.56).toStringAsFixed(0)} kg DAP/ha'
        : 'EXCESS by ${(-pGap)} kg/ha';
    final kStatus = kGap > 0
        ? 'DEFICIT of $kGap kg/ha — needs ${(kGap * 1.67).toStringAsFixed(0)} kg MOP/ha'
        : 'EXCESS by ${(-kGap)} kg/ha — reduce potassium';

    // ICAR base yield benchmarks per crop/soil combination (kg/acre)
    final baseYieldMap = {
      'rice': {
        'alluvial': 2400,
        'black_soil': 2200,
        'red_soil': 1900,
        'laterite': 1700,
        'sandy_loam': 1800,
      },
      'wheat': {
        'alluvial': 1800,
        'black_soil': 1700,
        'red_soil': 1400,
        'laterite': 1300,
        'sandy_loam': 1500,
      },
      'maize': {
        'alluvial': 2000,
        'black_soil': 2200,
        'red_soil': 1700,
        'laterite': 1500,
        'sandy_loam': 1800,
      },
      'sugarcane': {
        'alluvial': 22000,
        'black_soil': 20000,
        'red_soil': 16000,
        'laterite': 14000,
        'sandy_loam': 15000,
      },
      'cotton': {
        'alluvial': 420,
        'black_soil': 500,
        'red_soil': 350,
        'laterite': 300,
        'sandy_loam': 380,
      },
      'groundnut': {
        'alluvial': 750,
        'black_soil': 700,
        'red_soil': 650,
        'laterite': 550,
        'sandy_loam': 680,
      },
      'pigeon_pea': {
        'alluvial': 550,
        'black_soil': 600,
        'red_soil': 500,
        'laterite': 420,
        'sandy_loam': 480,
      },
      'green_gram': {
        'alluvial': 380,
        'black_soil': 350,
        'red_soil': 320,
        'laterite': 280,
        'sandy_loam': 340,
      },
      'black_gram': {
        'alluvial': 350,
        'black_soil': 330,
        'red_soil': 300,
        'laterite': 260,
        'sandy_loam': 310,
      },
      'mustard': {
        'alluvial': 600,
        'black_soil': 580,
        'red_soil': 500,
        'laterite': 440,
        'sandy_loam': 520,
      },
      'sesame': {
        'alluvial': 300,
        'black_soil': 280,
        'red_soil': 260,
        'laterite': 220,
        'sandy_loam': 260,
      },
      'ragi': {
        'alluvial': 700,
        'black_soil': 650,
        'red_soil': 750,
        'laterite': 800,
        'sandy_loam': 700,
      },
    };
    final baseYield = baseYieldMap[widget.crop]?[widget.soil] ?? 1500;

    // MSP/market price reference 2024-25 (INR per quintal)
    final mspMap = {
      'rice': 2300,
      'wheat': 2275,
      'maize': 2090,
      'sugarcane': 340,
      'cotton': 7121,
      'groundnut': 6783,
      'pigeon_pea': 7550,
      'green_gram': 8682,
      'black_gram': 7400,
      'mustard': 5650,
      'sesame': 8635,
      'ragi': 4290,
    };
    final msp = mspMap[widget.crop] ?? 2000;

    // Input cost estimates (INR/acre) by irrigation
    final irrigCost = {
      'Rainfed': 0,
      'Canal Irrigation': 1200,
      'Tube Well': 2500,
      'Bore Well': 2800,
      'Drip Irrigation': 1800,
      'Sprinkler': 2000,
      'Pond/Tank': 800,
    };
    final waterCost = irrigCost[widget.irrigation] ?? 1500;

    final prompt =
        '''
TASK: You are an expert ICAR-trained agricultural scientist for India. Use ONLY the data below to compute precise yield and profit. Do NOT use generic placeholder values.

═══ FARMER INPUTS ═══
Crop            : $cropLabel${widget.variety.isNotEmpty ? " — Variety: ${widget.variety}" : ""}
Season          : ${AppText.get(widget.season)}
Soil Type       : ${AppText.get(widget.soil)}
Farm Area       : ${widget.area} acres
District        : ${widget.district.isNotEmpty ? widget.district : 'India (general)'}
Irrigation      : ${widget.irrigation}  (estimated water cost: ₹$waterCost/acre)
Fertilizer Used : ${widget.fertilizer.isNotEmpty ? widget.fertilizer : "Standard NPK"}
Live Rainfall (past 30 days) : ${widget.rainfall.toStringAsFixed(1)} mm
Live Temperature             : ${widget.temperature.toStringAsFixed(1)} °C

═══ NPK STATUS (vs $cropLabel ICAR optimal) ═══
Farmer's N: ${widget.nitrogen} kg/ha  | Optimal for $cropLabel: $cropOptimalN kg/ha  → $nStatus
Farmer's P: ${widget.phosphorus} kg/ha | Optimal for $cropLabel: $cropOptimalP kg/ha  → $pStatus
Farmer's K: ${widget.potassium} kg/ha  | Optimal for $cropLabel: $cropOptimalK kg/ha  → $kStatus

═══ HISTORICAL WEATHER — last 5 growing seasons ═══
$histText

═══ FUTURE CLIMATE FORECAST — next 14 days (Open-Meteo live data) ═══
$_futureForecastText
Use this to assess upcoming heat stress, waterlogging risk, or optimal irrigation windows for this crop.

═══ ICAR BASE YIELD REFERENCE ═══
$cropLabel on ${AppText.get(widget.soil)} soil (ICAR benchmark): $baseYield kg/acre
Current MSP/market price for $cropLabel: ₹$msp per quintal (100 kg)
Estimated seed + fertiliser + labour cost for ${widget.irrigation}: ₹${3500 + waterCost}/acre

═══ YOUR CALCULATION STEPS ═══
Step 1 — Start from base yield: $baseYield kg/acre
Step 2 — Rainfall adjustment: use BOTH current rainfall (${widget.rainfall.toStringAsFixed(0)}mm) AND the future 14-day forecast rain totals. If combined outlook is dry (<50mm) for water-hungry crops → -15%, if wet (>100mm total) → +5%, else +0%
Step 3 — Temperature adjustment: use live temp (${widget.temperature.toStringAsFixed(0)}°C) AND max temps from 14-day forecast. If sustained heat >35°C ahead → -12%, if cold <18°C → -10%, if 25-32°C optimal range → +5%  
Step 4 — NPK adjustment: sum of (n_deficit×0.5 + p_deficit×0.3 + k_deficit×0.2) / cropOptimalN × 20% penalty if all deficient
Step 5 — Irrigation bonus: Drip/Sprinkler → +8%, Canal/Tubewell → +5%, Rainfed → +0%
Step 6 — Round to nearest 10
Step 7 — Profit = (final_yield_kg / 100) × msp_per_quintal minus (3500 + $waterCost) input cost

═══ OUTPUT: ONLY valid JSON, no text before or after ═══
{
  "yield_per_acre_kg": <integer from your calculation — NOT $baseYield verbatim, APPLY all adjustments>,
  "yield_min_kg": <yield × 0.83, rounded to nearest 10>,
  "yield_max_kg": <yield × 1.17, rounded to nearest 10>,
  "confidence_pct": <integer: 60 if NPK all deficient + dry, 75 if average, 85 if good conditions, 90 if optimal>,
  "profit_per_acre_inr": <integer from Step 7>,
  "rating": <"Good" if profit>5000, "Moderate" if 2000–5000, "Risk" if <2000>,
  "risk_alert": "<ONE specific risk sentence mentioning $cropLabel, ${widget.district.isNotEmpty ? widget.district : 'this region'}, and actual temp/rainfall numbers>",
  "n_deficit_kg_ha": ${nGap.toStringAsFixed(0)},
  "p_deficit_kg_ha": ${pGap.toStringAsFixed(0)},
  "k_deficit_kg_ha": ${kGap.toStringAsFixed(0)},
  "urea_kg_acre": ${nGap > 0 ? ((nGap * 2.17 / 2.47).toStringAsFixed(1)) : "0"},
  "dap_kg_acre": ${pGap > 0 ? ((pGap * 5.56 / 2.47).toStringAsFixed(1)) : "0"},
  "mop_kg_acre": ${kGap > 0 ? ((kGap * 1.67 / 2.47).toStringAsFixed(1)) : "0"},
  "fertilizer_warnings": [${nGap < -20 ? '"Nitrogen excess (${widget.nitrogen} kg/ha vs optimal $cropOptimalN). Cut urea by ${(-nGap * 0.5).toInt()} kg/ha."' : ''}${kGap < -20 ? '${nGap < -20 ? "," : ""}"Potassium excess (${widget.potassium} kg/ha vs optimal $cropOptimalK). Reduce MOP."' : ''}],
  "yield_plus_10kg_n": <yield_per_acre_kg + ${nGap > 0 ? (baseYield * 0.06).toInt() : 0}>,
  "yield_balanced_npk": <yield_per_acre_kg + ${((nGap.abs() + pGap.abs() + kGap.abs()) * 0.8).toInt()}>,
  "similar_years": ["<year from history with closest rainfall to ${widget.rainfall.toStringAsFixed(0)}mm> — similar rainfall pattern", "<year with closest temp to ${widget.temperature.toStringAsFixed(0)}°C> — similar temperature ${widget.temperature.toStringAsFixed(0)}°C"],
  "advice_sections": [
    {"title": "Crop Summary", "icon": "leaf", "count": 1, "items": ["<specific fact about $cropLabel${widget.variety.isNotEmpty ? " ${widget.variety}" : ""} performance in ${AppText.get(widget.soil)} during ${AppText.get(widget.season)} in ${widget.district.isNotEmpty ? widget.district : 'this region'}>"]},
    {"title": "Optimal Growing Conditions", "icon": "sun", "count": 3, "items": ["<$cropLabel water requirement per growth stage>", "<expected growing days and key stages for $cropLabel>", "<suitability of ${widget.irrigation} irrigation for $cropLabel>"]},
    {"title": "Fertilizer Plan — Basal", "icon": "calendar", "count": 2, "items": ["<basal dose: DAP + MOP at sowing with exact kg/acre based on p_deficit and k_deficit>", "<method and timing of basal application for $cropLabel>"]},
    {"title": "Fertilizer Plan — Top Dressing", "icon": "leaf", "count": 2, "items": ["<first top dressing timing and urea dose based on n_deficit for $cropLabel>", "<second top dressing if applicable>"]},
    {"title": "District Advisory — ${widget.district.isNotEmpty ? widget.district : 'Your Region'}", "icon": "bulb", "count": 3, "items": ["<specific pest/disease risk for $cropLabel in ${widget.district.isNotEmpty ? widget.district : 'this region'} during ${AppText.get(widget.season)}>", "<variety recommendation for $cropLabel in ${widget.district.isNotEmpty ? widget.district : 'this area'}>", "<local agri department tip specific to ${widget.district.isNotEmpty ? widget.district : 'this region'}>"]},
    {"title": "Water Management", "icon": "water", "count": 2, "items": ["<irrigation schedule for $cropLabel with ${widget.irrigation} given ${widget.rainfall.toStringAsFixed(0)}mm rainfall>", "<water stress warning if rainfall < optimal or tip to save water>"]}
  ],
  "suggestions": [
    "<NPK-specific tip: e.g. 'Apply ${nGap > 0 ? '${(nGap * 2.17 / 2.47).toStringAsFixed(0)} kg Urea/acre at tillering' : 'Nitrogen is adequate — avoid over-application'}'>",
    "<weather-specific tip based on ${widget.temperature.toStringAsFixed(0)}°C and ${widget.rainfall.toStringAsFixed(0)}mm rainfall for $cropLabel>",
    "<variety or sowing tip for ${widget.variety.isNotEmpty ? widget.variety : cropLabel} in ${AppText.get(widget.season)}>",
    "<profit maximisation tip: e.g. sell at MSP ₹$msp/quintal, avoid distress sale, or intercrop suggestion>"
  ],
  "analysis_summary": "<Two sentences: mention the computed yield number, the main limiting factor from NPK/weather/irrigation, and the district name.>"
}
''';

    final res = await http.post(
      AppEnvironment.groqChatUri,
      headers: AppEnvironment.groqHeaders,
      body: json.encode({
        'model': 'openai/gpt-oss-120b',
        'messages': [
          {
            'role': 'system',
            'content':
                'You are a precise agricultural data scientist for India. You ALWAYS compute yield and profit from the exact numeric inputs provided. You NEVER use placeholder text, generic advice, or repeat the example schema numbers. Every number in your JSON must be computed from the farmer inputs. Every advice item must reference the specific crop, district, and NPK values given. Respond only with valid JSON.',
          },
          {'role': 'user', 'content': prompt},
        ],
        'max_tokens': 4000,
        'temperature': 0.1,
        'response_format': {'type': 'json_object'},
      }),
    );

    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      final text = data['choices'][0]['message']['content'] as String;
      _rawClaudeText = text;

      // Robustly extract JSON — strip markdown fences, find first { ... }
      String jsonStr = text.replaceAll(RegExp(r'```json|```'), '').trim();
      final startIdx = jsonStr.indexOf('{');
      final endIdx = jsonStr.lastIndexOf('}');
      if (startIdx != -1 && endIdx != -1 && endIdx > startIdx) {
        jsonStr = jsonStr.substring(startIdx, endIdx + 1);
      }

      Map<String, dynamic> parsed;
      try {
        parsed = Map<String, dynamic>.from(json.decode(jsonStr));
      } catch (e) {
        throw Exception(
          'Failed to parse AI response as JSON: $e\nRaw: ${text.substring(0, text.length.clamp(0, 300))}',
        );
      }

      _yieldPerAcre = _toDouble(parsed['yield_per_acre_kg']) ?? 1500;
      _totalYield = _yieldPerAcre * widget.area;
      _yieldMin = _toDouble(parsed['yield_min_kg']) ?? _yieldPerAcre * 0.85;
      _yieldMax = _toDouble(parsed['yield_max_kg']) ?? _yieldPerAcre * 1.15;
      _confidencePct = _toDouble(parsed['confidence_pct']) ?? 75;
      _profitPerAcre =
          _toDouble(parsed['profit_per_acre_inr']) ?? _yieldPerAcre * 2;
      _nDeficit = _toDouble(parsed['n_deficit_kg_ha']) ?? 0;
      _pDeficit = _toDouble(parsed['p_deficit_kg_ha']) ?? 0;
      _kDeficit = _toDouble(parsed['k_deficit_kg_ha']) ?? 0;
      _ureaKgAcre = _toDouble(parsed['urea_kg_acre']) ?? 0;
      _dapKgAcre = _toDouble(parsed['dap_kg_acre']) ?? 0;
      _mopKgAcre = _toDouble(parsed['mop_kg_acre']) ?? 0;
      _yieldPlusN =
          _toDouble(parsed['yield_plus_10kg_n']) ?? _yieldPerAcre * 1.083;
      _yieldBalancedNpk =
          _toDouble(parsed['yield_balanced_npk']) ?? _yieldPerAcre * 1.124;
      _riskAlert = parsed['risk_alert']?.toString() ?? '';

      final ratingRaw = (parsed['rating'] ?? 'moderate')
          .toString()
          .toLowerCase();
      if (ratingRaw.contains('good')) {
        _rating = AppText.get('rating_good');
      } else if (ratingRaw.contains('moderate')) {
        _rating = AppText.get('rating_moderate');
      } else {
        _rating = AppText.get('rating_risk');
      }

      _similarYears = _toStringList(parsed['similar_years']);
      _suggestions = _toStringList(parsed['suggestions']);

      // Parse advice sections safely
      final rawSections = parsed['advice_sections'];
      if (rawSections is List) {
        _adviceSections = rawSections
            .map<Map<String, dynamic>>((s) {
              if (s is! Map) return <String, dynamic>{};
              return {
                'title': s['title']?.toString() ?? '',
                'icon': s['icon']?.toString() ?? 'leaf',
                'count': _toDouble(s['count'])?.toInt() ?? 0,
                'items': _toStringList(s['items']),
                'warnings': _toStringList(
                  s['fertilizer_warnings'] ?? parsed['fertilizer_warnings'],
                ),
              };
            })
            .where((s) => (s['title'] as String).isNotEmpty)
            .toList();
      } else {
        _adviceSections = [];
      }
    } else {
      throw Exception(
        'AI inference service error: ${res.statusCode} — ${res.body.substring(0, res.body.length.clamp(0, 300))}',
      );
    }
  }

  // Safe type helpers
  static double? _toDouble(dynamic v) {
    if (v == null) return null;
    if (v is num) return v.toDouble();
    if (v is String) return double.tryParse(v);
    return null;
  }

  static List<String> _toStringList(dynamic v) {
    if (v == null) return [];
    if (v is List) {
      return v
          .map((e) => e?.toString() ?? '')
          .where((s) => s.isNotEmpty)
          .toList();
    }
    return [];
  }

  // ── Main analysis pipeline ────────────────────────────────
  Future<void> _runAnalysis() async {
    setState(() {
      _loading = true;
      _error = '';
    });
    try {
      setState(() => _statusMsg = AppText.get('fetching_history'));
      final currentYear = DateTime.now().year;
      final histFutures = List.generate(
        5,
        (i) => _fetchYearWeather(currentYear - 5 + i),
      );
      // Fetch 5-year history + 14-day future forecast in parallel
      final results = await Future.wait([
        ...histFutures,
        _fetchFutureForecast(),
      ]);
      _yearlyData = results.whereType<Map<String, dynamic>>().toList();
      _futureForecastText = results.last is String
          ? results.last as String
          : 'Future forecast unavailable';

      setState(() => _statusMsg = AppText.get('asking_claude'));
      await _callClaude(_yearlyData);

      // Save to Advisory (SharedPreferences)
      await _saveToAdvisory();

      setState(() {
        _loading = false;
      });
    } catch (e) {
      print('❌ AGRI ERROR: $e');
      setState(() {
        _loading = false;
        _error = 'Error: $e';
      });
    }
  }

  Future<void> _saveToAdvisory() async {
    final prefs = await SharedPreferences.getInstance();
    final existing = prefs.getString('advisory_history');
    List<dynamic> history = existing != null ? json.decode(existing) : [];

    history.insert(0, {
      'crop': widget.crop,
      'season': widget.season,
      'area': widget.area,
      'yield_per_acre': _yieldPerAcre,
      'total_yield': _totalYield,
      'profit_per_acre': _profitPerAcre,
      'rating': _rating,
      'suggestions': _suggestions,
      'similar_years': _similarYears,
      'date': DateTime.now().toIso8601String(),
      'temperature': widget.temperature,
      'rainfall': widget.rainfall,
    });

    // Keep max 20 entries
    if (history.length > 20) history = history.sublist(0, 20);
    await prefs.setString('advisory_history', json.encode(history));
  }

  Color get _ratingColor {
    if (_rating.contains('✅')) return const Color(0xFF2E7D32);
    if (_rating.contains('🟡')) return const Color(0xFFF9A825);
    return const Color(0xFFD32F2F);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppText.get('ai_result_title'))),
      body: _loading
          ? _buildLoading()
          : _error.isNotEmpty
          ? _buildError()
          : _buildResult(),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(
              color: AppTheme.primary,
              strokeWidth: 3,
            ),
            const SizedBox(height: 24),
            Text(
              _statusMsg,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: AppTheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              '${AppText.get('crop_selection')}: ${AppText.get(widget.crop)}',
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildError() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              _error,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _runAnalysis,
              icon: const Icon(Icons.refresh),
              label: Text(AppText.get('retry')),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResult() {
    final cropLabel = _cropLabel(widget.crop);
    final varietyLabel = widget.variety.isNotEmpty ? widget.variety : '';
    final locationLabel = widget.district.isNotEmpty ? widget.district : '';

    // Bottom tab content helper
    Widget tabContent() {
      switch (_activeTab) {
        case 0:
          return _buildOptimalGrowthTab(cropLabel);
        case 1:
          return _buildFertilizerTab();
        case 2:
          return _buildPestAlertsTab();
        case 3:
          return _buildWaterScheduleTab();
        default:
          return const SizedBox.shrink();
      }
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // ── 1. Prediction Results Hero ──────────────────────
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  AppText.get('prediction_results'),
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 22,
                    color: Color(0xFF1B5E20),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$cropLabel${varietyLabel.isNotEmpty ? " ($varietyLabel)" : ""}${locationLabel.isNotEmpty ? " - $locationLabel" : ""}',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    // Predicted Yield
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.trending_up,
                                  color: AppTheme.primary,
                                  size: 16,
                                ),
                                const SizedBox(width: 6),
                                Flexible(
                                  child: Text(
                                    AppText.get('predicted_yield'),
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              '${(_yieldPerAcre / 100).toStringAsFixed(1)} ${AppText.get('q_acre')}',
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF1B5E20),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                '${AppText.get('confidence')}: ${_confidencePct.toInt()}%',
                                style: const TextStyle(fontSize: 10),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${AppText.get('range')}: ${(_yieldMin / 100).toStringAsFixed(1)} - ${(_yieldMax / 100).toStringAsFixed(1)} ${AppText.get('q_acre')}',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey.shade600,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            const SizedBox(height: 8),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: LinearProgressIndicator(
                                value: _confidencePct / 100,
                                backgroundColor: Colors.grey.shade200,
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                  AppTheme.primary,
                                ),
                                minHeight: 6,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    // Total Production
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.inventory_2_outlined,
                                  color: AppTheme.primary,
                                  size: 16,
                                ),
                                const SizedBox(width: 6),
                                Flexible(
                                  child: Text(
                                    AppText.get('total_production'),
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              '${(_totalYield / 100).toStringAsFixed(1)} ${AppText.get('quintals')}',
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF1B5E20),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              '${widget.area.toStringAsFixed(0)} ${AppText.get('acres_suffix')} ${AppText.get('for_acres')}',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Profit Potential full width
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppTheme.accent.withOpacity(0.12),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.gps_fixed,
                          color: AppTheme.accent,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppText.get('profit_potential'),
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.grey,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            '₹${_profitPerAcre.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}${AppText.get('per_inr_acre')}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              color: AppTheme.accent,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Text(
                        AppText.get('with_balanced_npk'),
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 14),

        // ── 2. Nutrient Status & Deficit Analysis ──────────
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.eco, color: AppTheme.primary, size: 18),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        AppText.get('nutrient_status'),
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: Color(0xFF1B5E20),
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    _NutrientStatusCard(
                      label: 'Nitrogen',
                      value: _nDeficit,
                      unit: 'kg/ha',
                    ),
                    const SizedBox(width: 8),
                    _NutrientStatusCard(
                      label: 'Phosphorus',
                      value: _pDeficit,
                      unit: 'kg/ha',
                    ),
                    const SizedBox(width: 8),
                    _NutrientStatusCard(
                      label: 'Potassium',
                      value: _kDeficit,
                      unit: 'kg/ha',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 14),

        // ── 3. Risk Alert ──────────────────────────────────
        if (_riskAlert.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(bottom: 14),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF3F3),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.red.shade200),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.red.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.red,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            AppText.get('risk_alerts'),
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.red,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              AppText.get('alert_badge'),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Text('• ', style: TextStyle(color: Colors.red)),
                          const Text('⚠️ ', style: TextStyle(fontSize: 12)),
                          Expanded(
                            child: Text(
                              _riskAlert,
                              style: const TextStyle(fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

        // ── 4. Fertilizer Recommendations ─────────────────
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.science_outlined,
                      color: AppTheme.sky,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        AppText.get('fertilizer_recommendations'),
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: Color(0xFF1B5E20),
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
                Text(
                  AppText.get('fertilizer_sub'),
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _FertilizerCard(
                      label: 'Urea',
                      shortLabel: 'U',
                      color: const Color(0xFF1565C0),
                      kgAcre: _ureaKgAcre,
                      area: widget.area,
                    ),
                    const SizedBox(width: 8),
                    _FertilizerCard(
                      label: 'DAP',
                      shortLabel: 'D',
                      color: const Color(0xFF2E7D32),
                      kgAcre: _dapKgAcre,
                      area: widget.area,
                    ),
                    const SizedBox(width: 8),
                    _FertilizerCard(
                      label: 'MOP',
                      shortLabel: 'M',
                      color: const Color(0xFF6D4C41),
                      kgAcre: _mopKgAcre,
                      area: widget.area,
                    ),
                  ],
                ),
                if (_nDeficit > 0 || _kDeficit > 0) ...[
                  const SizedBox(height: 12),
                  if (_nDeficit > 0)
                    _WarningBanner(
                      msg: AppText.get(
                        'nitrogen_high_warn',
                      ).replaceFirst('{n}', widget.nitrogen.toString()),
                    ),
                  if (_kDeficit > 0)
                    _WarningBanner(
                      msg: AppText.get(
                        'potassium_high_warn',
                      ).replaceFirst('{k}', widget.potassium.toString()),
                    ),
                ],
              ],
            ),
          ),
        ),
        const SizedBox(height: 14),

        // ── 5. Yield Improvement Scenarios ────────────────
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppText.get('yield_scenarios'),
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: Color(0xFF1B5E20),
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Text(
                  AppText.get('yield_scenarios_sub'),
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: _YieldScenarioCard(
                        label: AppText.get('current_prediction'),
                        value:
                            '${(_yieldPerAcre / 100).toStringAsFixed(1)} ${AppText.get('q_acre')}',
                        highlight: false,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _YieldScenarioCard(
                        label: AppText.get('plus_10kg_n'),
                        value:
                            '${(_yieldPlusN / 100).toStringAsFixed(1)} ${AppText.get('q_acre')}',
                        badge:
                            '+${((_yieldPlusN - _yieldPerAcre) / _yieldPerAcre * 100).toStringAsFixed(1)}% ${AppText.get('increase_label')}',
                        highlight: true,
                        highlightColor: const Color(0xFFE3F2FD),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _YieldScenarioCard(
                        label: AppText.get('balanced_npk'),
                        value:
                            '${(_yieldBalancedNpk / 100).toStringAsFixed(1)} ${AppText.get('q_acre')}',
                        badge:
                            '+${((_yieldBalancedNpk - _yieldPerAcre) / _yieldPerAcre * 100).toStringAsFixed(1)}% ${AppText.get('increase_label')}',
                        highlight: false,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 14),

        // ── 6. AI-Powered Farming Advice ──────────────────
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppTheme.primary, AppTheme.secondary],
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.auto_awesome,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppText.get('ai_farming_advice'),
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: Color(0xFF1B5E20),
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          Text(
                            AppText.get('personalized_recs'),
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey.shade500,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // Crop Analysis Summary tags
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppTheme.surface,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppText.get('crop_analysis_summary'),
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: Color(0xFF1B5E20),
                        ),
                      ),
                      Text(
                        AppText.get('tailored_advice'),
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 6,
                        children: [
                          _Tag(
                            icon: Icons.grass,
                            label: cropLabel,
                            color: AppTheme.primary,
                          ),
                          if (varietyLabel.isNotEmpty)
                            _Tag(
                              icon: Icons.spa_outlined,
                              label: varietyLabel,
                              color: AppTheme.secondary,
                            ),
                          _Tag(
                            icon: Icons.access_time,
                            label: AppText.get('season_ready'),
                            color: AppTheme.sky,
                          ),
                          _Tag(
                            icon: Icons.water_drop_outlined,
                            label:
                                '${widget.irrigation} ${AppText.get('optimized')}',
                            color: AppTheme.sky,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // Expandable advice sections
                ..._adviceSections.map(
                  (section) => _AdviceSection(section: section),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 14),

        // ── 7. Quick Action Tabs ───────────────────────────
        Card(
          child: Column(
            children: [
              // Tab bar
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    _QuickTabBtn(
                      label: AppText.get('optimal_growth_tab'),
                      icon: Icons.eco,
                      index: 0,
                      active: _activeTab,
                      onTap: (i) => setState(() => _activeTab = i),
                      color: AppTheme.primary,
                    ),
                    const SizedBox(width: 6),
                    _QuickTabBtn(
                      label: AppText.get('fertilizer_plan_tab'),
                      icon: Icons.science_outlined,
                      index: 1,
                      active: _activeTab,
                      onTap: (i) => setState(() => _activeTab = i),
                      color: AppTheme.sky,
                    ),
                    const SizedBox(width: 6),
                    _QuickTabBtn(
                      label: AppText.get('pest_alerts_tab'),
                      icon: Icons.pest_control,
                      index: 2,
                      active: _activeTab,
                      onTap: (i) => setState(() => _activeTab = i),
                      color: AppTheme.accent,
                    ),
                    const SizedBox(width: 6),
                    _QuickTabBtn(
                      label: AppText.get('water_schedule_tab'),
                      icon: Icons.water_drop_outlined,
                      index: 3,
                      active: _activeTab,
                      onTap: (i) => setState(() => _activeTab = i),
                      color: AppTheme.sky,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 16),
                child: tabContent(),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 8. Historical Weather ──────────────────────────
        if (_yearlyData.isNotEmpty) ...[
          _SectionHeader(title: AppText.get('historical_weather')),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _yearlyData
                  .map(
                    (y) => Container(
                      width: 130,
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${y['year']}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 14,
                              color: AppTheme.primary,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const Icon(
                                Icons.thermostat,
                                size: 12,
                                color: Colors.orange,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${(y['avgTemp'] as double).toStringAsFixed(1)}°C',
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              const Icon(
                                Icons.water_drop,
                                size: 12,
                                color: AppTheme.sky,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${(y['avgRain'] as double).toStringAsFixed(1)} mm',
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              const Icon(
                                Icons.water,
                                size: 12,
                                color: Colors.teal,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${(y['avgHum'] as double).toStringAsFixed(0)}% hum',
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],

        const SizedBox(height: 16),
        // Saved to Advisory confirmation
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFE8F5E9),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              const Icon(Icons.check_circle, color: AppTheme.primary),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  AppText.get('saved_to_advisory'),
                  style: const TextStyle(
                    color: AppTheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 80),
      ],
    );
  }

  // Quick tab content builders
  Widget _buildOptimalGrowthTab(String cropLabel) => _tabContent([
    AppText.get('tab_optimal_1').replaceFirst('{crop}', cropLabel),
    AppText.get('tab_optimal_2'),
    AppText.get(
      'tab_optimal_3',
    ).replaceFirst('{irrigation}', widget.irrigation),
  ], AppTheme.primary);

  Widget _buildFertilizerTab() => _tabContent([
    AppText.get(
      'tab_fertilizer_1',
    ).replaceFirst('{urea}', _ureaKgAcre.toStringAsFixed(1)),
    AppText.get(
      'tab_fertilizer_2',
    ).replaceFirst('{dap}', _dapKgAcre.toStringAsFixed(1)),
    AppText.get(
      'tab_fertilizer_3',
    ).replaceFirst('{mop}', _mopKgAcre.toStringAsFixed(1)),
  ], AppTheme.sky);

  Widget _buildPestAlertsTab() => _tabContent([
    AppText.get('tab_pest_1'),
    AppText.get('tab_pest_2'),
    AppText.get('tab_pest_3'),
  ], AppTheme.accent);

  Widget _buildWaterScheduleTab() => _tabContent([
    AppText.get('tab_water_1'),
    AppText.get('tab_water_2'),
    AppText.get('tab_water_3'),
  ], AppTheme.sky);

  Widget _tabContent(List<String> items, Color color) => Column(
    children: items
        .asMap()
        .entries
        .map(
          (e) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.06),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: color.withOpacity(0.15)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${e.key + 1}',
                        style: TextStyle(
                          fontSize: 11,
                          color: color,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(e.value, style: const TextStyle(fontSize: 13)),
                  ),
                ],
              ),
            ),
          ),
        )
        .toList(),
  );
}

// ── Advice Section expandable tile ────────────────────────────
class _AdviceSection extends StatefulWidget {
  final Map<String, dynamic> section;
  const _AdviceSection({required this.section});

  @override
  State<_AdviceSection> createState() => _AdviceSectionState();
}

class _AdviceSectionState extends State<_AdviceSection> {
  bool _expanded = false;

  Color _bgColor(String icon) {
    switch (icon) {
      case 'sun':
        return const Color(0xFFE8F5E9);
      case 'calendar':
        return const Color(0xFFE3F2FD);
      case 'leaf':
        return const Color(0xFFE8F5E9);
      case 'bulb':
        return const Color(0xFFFFF8E1);
      case 'sprout':
        return const Color(0xFFE8F5E9);
      case 'water':
        return const Color(0xFFE1F5FE);
      default:
        return const Color(0xFFE8F5E9);
    }
  }

  Color _iconColor(String icon) {
    switch (icon) {
      case 'sun':
        return AppTheme.primary;
      case 'calendar':
        return AppTheme.sky;
      case 'leaf':
        return AppTheme.secondary;
      case 'bulb':
        return AppTheme.accent;
      case 'sprout':
        return AppTheme.primary;
      case 'water':
        return AppTheme.sky;
      default:
        return AppTheme.primary;
    }
  }

  IconData _iconData(String icon) {
    switch (icon) {
      case 'sun':
        return Icons.wb_sunny_outlined;
      case 'calendar':
        return Icons.calendar_today_outlined;
      case 'leaf':
        return Icons.eco_outlined;
      case 'bulb':
        return Icons.lightbulb_outlined;
      case 'sprout':
        return Icons.grass_outlined;
      case 'water':
        return Icons.water_drop_outlined;
      default:
        return Icons.eco_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final icon = widget.section['icon'] as String? ?? 'leaf';
    final title = widget.section['title'] as String? ?? '';
    final count = widget.section['count'] as int? ?? 0;
    final items = widget.section['items'] as List<String>? ?? [];
    final bg = _bgColor(icon);
    final iconColor = _iconColor(icon);

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: iconColor.withOpacity(0.15)),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () => setState(() => _expanded = !_expanded),
            borderRadius: BorderRadius.circular(14),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: iconColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(_iconData(icon), color: iconColor, size: 18),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Color(0xFF1B5E20),
                          ),
                        ),
                        Text(
                          '$count ${count == 1 ? AppText.get('recommendation_single') : AppText.get('recommendations_count')}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    _expanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),
          if (_expanded) ...[
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 8, 14, 14),
              child: Column(
                children: items
                    .asMap()
                    .entries
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 22,
                                height: 22,
                                decoration: BoxDecoration(
                                  color: iconColor.withOpacity(0.15),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    '${e.key + 1}',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: iconColor,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  e.value,
                                  style: const TextStyle(fontSize: 13),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ── Nutrient Status Card ───────────────────────────────────────
class _NutrientStatusCard extends StatelessWidget {
  final String label;
  final double value;
  final String unit;
  const _NutrientStatusCard({
    required this.label,
    required this.value,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    final isDeficient = value < 0;
    final isExcess = value > 0;
    final statusLabel = isDeficient
        ? AppText.get('deficient')
        : isExcess
        ? AppText.get('excess')
        : AppText.get('optimal');
    final bg = isDeficient
        ? const Color(0xFFFFF0F0)
        : isExcess
        ? const Color(0xFFFFF8E1)
        : const Color(0xFFE8F5E9);
    final textColor = isDeficient
        ? Colors.red.shade700
        : isExcess
        ? AppTheme.accent
        : AppTheme.primary;
    final arrowIcon = isDeficient ? Icons.south_east : Icons.north_east;

    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 12,
                      color: textColor,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                Icon(arrowIcon, size: 14, color: textColor),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              '${value.toStringAsFixed(0)} $unit',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w900,
                color: textColor,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            Text(
              '${AppText.get('status_label')}: $statusLabel',
              style: TextStyle(fontSize: 11, color: textColor),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}

// ── Fertilizer Card ───────────────────────────────────────────
class _FertilizerCard extends StatelessWidget {
  final String label;
  final String shortLabel;
  final Color color;
  final double kgAcre;
  final double area;
  const _FertilizerCard({
    required this.label,
    required this.shortLabel,
    required this.color,
    required this.kgAcre,
    this.area = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: color,
              child: Text(
                shortLabel,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: Color(0xFF1B5E20),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${kgAcre.toStringAsFixed(1)} kg/acre',
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 16,
                color: Color(0xFF1B5E20),
              ),
            ),
            Text(
              '(${(kgAcre * 2.47).toStringAsFixed(1)} kg/ha)',
              style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 4),
            Text(
              'Total: ${(kgAcre * area).toStringAsFixed(1)} kg',
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppTheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Yield Scenario Card ───────────────────────────────────────
class _YieldScenarioCard extends StatelessWidget {
  final String label;
  final String value;
  final String? badge;
  final bool highlight;
  final Color? highlightColor;
  const _YieldScenarioCard({
    required this.label,
    required this.value,
    this.badge,
    this.highlight = false,
    this.highlightColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: highlightColor ?? AppTheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: highlight
              ? AppTheme.sky.withOpacity(0.3)
              : Colors.grey.shade200,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: Color(0xFF1B5E20),
            ),
          ),
          if (badge != null) ...[
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: AppTheme.accent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                badge!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ── Tag chip ─────────────────────────────────────────────────
class _Tag extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _Tag({required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Warning Banner ────────────────────────────────────────────
class _WarningBanner extends StatelessWidget {
  final String msg;
  const _WarningBanner({required this.msg});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8E1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppTheme.accent.withOpacity(0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.warning_amber_outlined,
            size: 16,
            color: AppTheme.accent,
          ),
          const SizedBox(width: 6),
          const Text('⚠️ ', style: TextStyle(fontSize: 12)),
          Expanded(child: Text(msg, style: const TextStyle(fontSize: 12))),
        ],
      ),
    );
  }
}

// ── Quick Tab Button ──────────────────────────────────────────
class _QuickTabBtn extends StatelessWidget {
  final String label;
  final IconData icon;
  final int index;
  final int active;
  final Color color;
  final ValueChanged<int> onTap;
  const _QuickTabBtn({
    required this.label,
    required this.icon,
    required this.index,
    required this.active,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = active == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
          decoration: BoxDecoration(
            color: isActive ? color.withOpacity(0.12) : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isActive ? color.withOpacity(0.3) : Colors.transparent,
            ),
          ),
          child: Column(
            children: [
              Icon(icon, color: isActive ? color : Colors.grey, size: 22),
              const SizedBox(height: 4),
              Text(
                label,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 10,
                  color: isActive ? color : Colors.grey,
                  fontWeight: isActive ? FontWeight.w700 : FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Mini bar chart widget ─────────────────────────────────────
class _ChartBar {
  final String label;
  final double value;
  final Color color;
  const _ChartBar({
    required this.label,
    required this.value,
    required this.color,
  });
}

class _MiniBarChart extends StatelessWidget {
  final String title;
  final List<_ChartBar> data;
  final String unit;
  const _MiniBarChart({
    required this.title,
    required this.data,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) return const SizedBox.shrink();
    final maxVal = data.map((d) => d.value).reduce((a, b) => a > b ? a : b);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: data.map((bar) {
                final ratio = maxVal > 0 ? (bar.value / maxVal) : 0.0;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      bar.value.toStringAsFixed(1),
                      style: TextStyle(
                        fontSize: 9,
                        color: bar.color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 600),
                      width: 28,
                      height: 60 * ratio + 4,
                      decoration: BoxDecoration(
                        color: bar.color.withOpacity(0.85),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      bar.label,
                      style: const TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
//  WEATHER SCREEN
// ═══════════════════════════════════════════════════════════
class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  List forecast = [];
  String location = "Loading...";
  double temperature = 0;
  int humidity = 0;
  double windSpeed = 0;
  double visibility = 0;
  String description = "";

  Future<void> loadWeatherData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? forecastData = prefs.getString('forecast');
    setState(() {
      location = prefs.getString('location') ?? AppText.get('unknown');
      temperature = prefs.getDouble('temp') ?? 0;
      humidity = prefs.getInt('humidity') ?? 0;
      windSpeed = prefs.getDouble('wind') ?? 0;
      description = prefs.getString('desc') ?? "";
      visibility = prefs.getDouble('visibility') ?? 0;
      if (forecastData != null) {
        forecast = json.decode(forecastData);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    loadWeatherData();
    langNotifier.addListener(_onLangChange);
  }

  @override
  void dispose() {
    langNotifier.removeListener(_onLangChange);
    super.dispose();
  }

  void _onLangChange() => setState(() {});

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadWeatherData();
  }

  IconData getWeatherIcon(String condition) {
    condition = condition.toLowerCase();
    if (condition.contains('rain')) return Icons.thunderstorm;
    if (condition.contains('cloud')) return Icons.cloud;
    if (condition.contains('clear')) return Icons.wb_sunny;
    if (condition.contains('drizzle')) return Icons.grain;
    if (condition.contains('snow')) return Icons.ac_unit;
    return Icons.wb_cloudy;
  }

  String getAgriAdvice() {
    if (forecast.isEmpty) return AppText.get('loading_insights');
    double rain = (forecast[0]['pop'] ?? 0).toDouble() * 100;
    double temp = (forecast[0]['main']['temp'] ?? 0).toDouble();
    double wind = (forecast[0]['wind']['speed'] ?? 0).toDouble();

    if (rain > 70) return AppText.get('agri_heavy_rain');
    if (rain > 40) return AppText.get('agri_moderate_rain');
    if (temp > 35) return AppText.get('agri_high_temp');
    if (temp < 20) return AppText.get('agri_cool');
    if (wind > 10) return AppText.get('agri_strong_wind');
    return AppText.get('agri_stable');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppText.get('weather_climate'))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF0288D1), Color(0xFF0097A7)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          location,
                          style: const TextStyle(color: Colors.white70),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "${temperature.toStringAsFixed(1)}°C",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 56,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          description,
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                    Icon(
                      getWeatherIcon(description),
                      color: Colors.white,
                      size: 72,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _weatherPill(
                      icon: Icons.water_drop,
                      label: '$humidity%',
                      sub: AppText.get('humidity'),
                    ),
                    _weatherPill(
                      icon: Icons.air,
                      label: '${windSpeed.toStringAsFixed(1)} km/h',
                      sub: AppText.get('wind'),
                    ),
                    _weatherPill(
                      icon: Icons.visibility,
                      label: '${visibility.toStringAsFixed(1)} km',
                      sub: AppText.get('visibility_label'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          _SectionHeader(title: AppText.get('five_day_forecast')),
          const SizedBox(height: 12),
          Column(
            children: forecast.map<Widget>((dayData) {
              final date = DateTime.parse(dayData['dt_txt']);
              final min = dayData['main']['temp_min'];
              final max = dayData['main']['temp_max'];
              final rain = (dayData['pop'] ?? 0).toDouble() * 100;
              final weatherMain = dayData['weather'][0]['main'];
              final hum = (dayData['main']['humidity'] ?? 0) as int;
              final wind = (dayData['wind']['speed'] ?? 0.0).toDouble();

              return _ForecastRow(
                day: DateFormat('EEEE').format(date),
                icon: getWeatherIcon(weatherMain),
                high: max.round(),
                low: min.round(),
                rain: rain.round(),
                humidity: hum,
                windSpeed: wind,
              );
            }).toList(),
          ),
          const SizedBox(height: 20),

          _SectionHeader(title: AppText.get('agri_weather_impact')),
          const SizedBox(height: 12),
          _AlertBanner(message: getAgriAdvice()),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _weatherPill({
    required IconData icon,
    required String label,
    required String sub,
  }) {
    return Column(
      children: [
        Icon(icon, color: Colors.white70, size: 24),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(sub, style: const TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════
//  ADVISORY SCREEN — Shows saved AI prediction history
// ═══════════════════════════════════════════════════════════
class AdvisoryScreen extends StatefulWidget {
  const AdvisoryScreen({super.key});

  @override
  State<AdvisoryScreen> createState() => _AdvisoryScreenState();
}

class _AdvisoryScreenState extends State<AdvisoryScreen> {
  List<Map<String, dynamic>> _history = [];
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    langNotifier.addListener(_onLangChange);
    _loadHistory();
  }

  @override
  void dispose() {
    langNotifier.removeListener(_onLangChange);
    super.dispose();
  }

  void _onLangChange() => setState(() {});

  Future<void> _loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString('advisory_history');
    setState(() {
      _history = raw != null
          ? List<Map<String, dynamic>>.from(json.decode(raw))
          : [];
      _loaded = true;
    });
  }

  Future<void> _deleteEntry(int index) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(AppText.get('delete_confirm')),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(AppText.get('cancel')),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(
              AppText.get('delete'),
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      _history.removeAt(index);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('advisory_history', json.encode(_history));
      setState(() {});
    }
  }

  Color _ratingColor(String rating) {
    if (rating.contains('✅')) return const Color(0xFF2E7D32);
    if (rating.contains('🟡')) return const Color(0xFFF9A825);
    return const Color(0xFFD32F2F);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppText.get('advisory_title')),
        actions: [
          if (_history.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: _loadHistory,
            ),
        ],
      ),
      body: !_loaded
          ? const Center(
              child: CircularProgressIndicator(color: AppTheme.primary),
            )
          : _history.isEmpty
          ? _buildEmpty()
          : _buildList(),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppTheme.surface,
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Icon(
                Icons.tips_and_updates_outlined,
                size: 48,
                color: AppTheme.primary,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              AppText.get('no_predictions'),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.grey,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildList() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // ── Combined Bar Chart (crop vs market price) ────────
        if (_history.isNotEmpty) ...[
          _SectionHeader(
            title:
                '📊 ${AppText.get("last_analysis")} — ${AppText.get("profit_potential")}',
          ),
          const SizedBox(height: 12),
          _AdvisoryBarChart(history: _history),
          const SizedBox(height: 20),
        ],
        _SectionHeader(title: AppText.get('last_analysis')),
        const SizedBox(height: 12),
        ..._history.asMap().entries.map((e) {
          final i = e.key;
          final entry = e.value;
          final crop = entry['crop'] as String? ?? '';
          final season = entry['season'] as String? ?? '';
          final rating = entry['rating'] as String? ?? '';
          final yieldPerAcre =
              (entry['yield_per_acre'] as num?)?.toDouble() ?? 0;
          final totalYield = (entry['total_yield'] as num?)?.toDouble() ?? 0;
          final area = (entry['area'] as num?)?.toDouble() ?? 0;
          final date = entry['date'] as String? ?? '';
          final suggestions = List<String>.from(entry['suggestions'] ?? []);
          final similarYears = List<String>.from(entry['similar_years'] ?? []);
          final temp = (entry['temperature'] as num?)?.toDouble() ?? 0;
          final rain = (entry['rainfall'] as num?)?.toDouble() ?? 0;

          String displayDate = '';
          try {
            final dt = DateTime.parse(date);
            displayDate = DateFormat('dd MMM yyyy, hh:mm a').format(dt);
          } catch (_) {}

          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: BorderSide(color: Colors.grey.shade200),
              ),
              child: ExpansionTile(
                leading: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: _ratingColor(rating).withOpacity(0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.eco, color: _ratingColor(rating)),
                ),
                title: Row(
                  children: [
                    Expanded(
                      child: Text(
                        AppText.get(crop),
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Rating badge inline with title
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: _ratingColor(rating),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          rating,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ),
                  ],
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Yield + area on same row
                      Row(
                        children: [
                          const Icon(
                            Icons.trending_up,
                            size: 13,
                            color: AppTheme.primary,
                          ),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              '${yieldPerAcre.toStringAsFixed(0)} kg/acre',
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppTheme.primary,
                                fontWeight: FontWeight.w700,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Icon(
                            Icons.crop_square,
                            size: 13,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              '$area ${AppText.get("acres_suffix")}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 3),
                      Text(
                        displayDate,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                    size: 20,
                  ),
                  onPressed: () => _deleteEntry(i),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Divider(),
                        // Stats row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _AdvisoryStatPill(
                              label: AppText.get('total_yield'),
                              value: '${totalYield.toStringAsFixed(0)} kg',
                            ),
                            _AdvisoryStatPill(
                              label: AppText.get('farm_area'),
                              value: '$area ${AppText.get('acres_suffix')}',
                            ),
                            _AdvisoryStatPill(
                              label: AppText.get('avg_temperature'),
                              value: '${temp.toStringAsFixed(1)}°C',
                            ),
                            _AdvisoryStatPill(
                              label: AppText.get('annual_rainfall'),
                              value: '${rain.toStringAsFixed(0)} mm',
                            ),
                          ],
                        ),
                        if (similarYears.isNotEmpty) ...[
                          const SizedBox(height: 12),
                          Text(
                            AppText.get('similar_years'),
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 6),
                          ...similarYears.map(
                            (y) => Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.history,
                                    size: 14,
                                    color: AppTheme.primary,
                                  ),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Text(
                                      y,
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                        if (suggestions.isNotEmpty) ...[
                          const SizedBox(height: 12),
                          Text(
                            AppText.get('ai_suggestions'),
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 6),
                          ...suggestions.asMap().entries.map(
                            (s) => Padding(
                              padding: const EdgeInsets.only(bottom: 6),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: const BoxDecoration(
                                      color: AppTheme.primary,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${s.key + 1}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      s.value,
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
        const SizedBox(height: 80),
      ],
    );
  }
}

class _AdvisoryStatPill extends StatelessWidget {
  final String label;
  final String value;
  const _AdvisoryStatPill({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 13,
            color: AppTheme.primary,
          ),
        ),
        Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey)),
      ],
    );
  }
}

// ── Advisory Combined Bar Chart ───────────────────────────────
class _AdvisoryBarChart extends StatefulWidget {
  final List<Map<String, dynamic>> history;
  const _AdvisoryBarChart({required this.history});

  @override
  State<_AdvisoryBarChart> createState() => _AdvisoryBarChartState();
}

class _AdvisoryBarChartState extends State<_AdvisoryBarChart>
    with SingleTickerProviderStateMixin {
  int? _selectedIndex;
  late AnimationController _animCtrl;
  late Animation<double> _growAnim;

  static const List<Color> _barColors = [
    Color(0xFF2E7D32), // deep green
    Color(0xFF1565C0), // deep blue
    Color(0xFF6A1B9A), // purple
    Color(0xFFE65100), // deep orange
    Color(0xFF00695C), // teal
    Color(0xFFC62828), // red
    Color(0xFF283593), // indigo
    Color(0xFF558B2F), // light green
  ];

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _growAnim = CurvedAnimation(parent: _animCtrl, curve: Curves.easeOutCubic);
    // Start animation after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) => _animCtrl.forward());
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Show newest-first in list but chart oldest→newest (left→right)
    final rawEntries = widget.history.reversed.toList();
    if (rawEntries.length > 8) rawEntries.removeRange(0, rawEntries.length - 8);

    final chartEntries = rawEntries.asMap().entries.map((e) {
      final i = e.key;
      final entry = e.value;
      final crop = entry['crop'] as String? ?? '';
      final profit = (entry['profit_per_acre'] as num?)?.toDouble() ?? 0;
      final yieldKg = (entry['yield_per_acre'] as num?)?.toDouble() ?? 0;
      String dateLabel = '';
      try {
        final dt = DateTime.parse(entry['date'] as String? ?? '');
        dateLabel = DateFormat('dd/MM').format(dt);
      } catch (_) {}
      return _BarEntry(
        cropKey: crop,
        cropLabel: AppText.get(crop),
        profitPerAcre: profit,
        yieldPerAcre: yieldKg,
        date: dateLabel,
        color: _barColors[i % _barColors.length],
      );
    }).toList();

    if (chartEntries.isEmpty) return const SizedBox.shrink();

    final maxProfit = chartEntries
        .map((e) => e.profitPerAcre)
        .reduce((a, b) => a > b ? a : b);
    final maxYield = chartEntries
        .map((e) => e.yieldPerAcre)
        .reduce((a, b) => a > b ? a : b);
    final maxBar = maxProfit > 0 ? maxProfit : 1.0;
    final maxYieldVal = maxYield > 0 ? maxYield : 1.0;

    // Chart layout constants — all carefully sized to avoid overflow
    const double chartHeight = 160.0; // actual bar drawing area
    const double topLabelZone = 32.0; // reserved above bars for value labels
    const double xLabelZone = 44.0; // reserved below baseline for crop+date
    const double yAxisWidth = 42.0; // left column for Y-axis ticks
    const double barGroupWidth = 80.0; // each crop group width
    const int gridLines = 4;

    final totalScrollWidth = (chartEntries.length * barGroupWidth).clamp(
      200.0,
      double.infinity,
    );

    // Round maxBar up to a nice number for Y-axis ticks
    double niceMax(double v) {
      if (v <= 0) return 1000;
      final mag = (v / gridLines).ceilToDouble();
      final step = mag < 500
          ? 500.0
          : mag < 1000
          ? 1000.0
          : mag < 2500
          ? 2500.0
          : 5000.0;
      return (v / step).ceil() * step;
    }

    final yMax = niceMax(maxBar);
    final yStep = yMax / gridLines;

    // Selected entry detail card
    final sel = _selectedIndex != null && _selectedIndex! < chartEntries.length
        ? chartEntries[_selectedIndex!]
        : null;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ──────────────────────────────────────────
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppTheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.bar_chart_rounded,
                    size: 18,
                    color: AppTheme.primary,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppText.get('profit_potential'),
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 14,
                          color: Color(0xFF1B5E20),
                        ),
                      ),
                      Text(
                        '${chartEntries.length} ${AppText.get("last_analysis")} · Tap a bar for details',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // ── Legend ──────────────────────────────────────────
            Row(
              children: [
                _LegendDot(color: AppTheme.primary, label: '₹ Profit/acre'),
                const SizedBox(width: 16),
                _LegendDot(
                  color: AppTheme.primary.withOpacity(0.28),
                  label: 'Yield (q/acre)',
                  isLight: true,
                ),
              ],
            ),
            const SizedBox(height: 12),

            // ── Chart area (Y-axis + scrollable bars) ────────────
            SizedBox(
              // Total height = top label zone + chart bars + baseline (1.5) + x labels
              height: topLabelZone + chartHeight + 2 + xLabelZone,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Y-axis column ──────────────────────────────
                  SizedBox(
                    width: yAxisWidth,
                    height: topLabelZone + chartHeight + 1,
                    child: Column(
                      children: [
                        // Top label zone spacer
                        const SizedBox(height: topLabelZone),
                        // Grid tick labels from top (yMax) to bottom (0)
                        ...List.generate(gridLines + 1, (i) {
                          final tickVal = yMax - i * yStep;
                          final label = tickVal >= 1000
                              ? '₹${(tickVal / 1000).toStringAsFixed(tickVal % 1000 == 0 ? 0 : 1)}k'
                              : '₹${tickVal.toInt()}';
                          return Expanded(
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 6),
                                child: Text(
                                  label,
                                  style: TextStyle(
                                    fontSize: 9,
                                    color: Colors.grey.shade500,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                  const SizedBox(width: 4),
                  // ── Scrollable bars + x-labels ─────────────────
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: AnimatedBuilder(
                        animation: _growAnim,
                        builder: (context, _) {
                          return SizedBox(
                            width: totalScrollWidth,
                            child: Column(
                              children: [
                                // ── Bar drawing area ───────────────
                                SizedBox(
                                  height: topLabelZone + chartHeight,
                                  child: Stack(
                                    children: [
                                      // Grid lines (behind bars)
                                      Positioned(
                                        top: topLabelZone,
                                        left: 0,
                                        right: 0,
                                        height: chartHeight,
                                        child: Column(
                                          children: List.generate(
                                            gridLines + 1,
                                            (i) => Expanded(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  border: Border(
                                                    top: BorderSide(
                                                      color: i == gridLines
                                                          ? Colors.grey.shade400
                                                          : Colors
                                                                .grey
                                                                .shade200,
                                                      width: i == gridLines
                                                          ? 1.5
                                                          : 1,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      // Bars row
                                      Positioned(
                                        top: 0,
                                        left: 0,
                                        right: 0,
                                        bottom: 0,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: chartEntries.asMap().entries.map((
                                            e,
                                          ) {
                                            final idx = e.key;
                                            final entry = e.value;
                                            final isSelected =
                                                _selectedIndex == idx;

                                            final profitRatio =
                                                (entry.profitPerAcre / yMax)
                                                    .clamp(0.0, 1.0);
                                            final yieldRatio =
                                                (entry.yieldPerAcre /
                                                        maxYieldVal)
                                                    .clamp(0.0, 1.0);

                                            // Animate height from 0 → final
                                            final animP =
                                                profitRatio * _growAnim.value;
                                            final animY =
                                                yieldRatio * _growAnim.value;

                                            final profitBarH =
                                                (chartHeight * animP).clamp(
                                                  0.0,
                                                  chartHeight,
                                                );
                                            final yieldBarH =
                                                (chartHeight * animY * 0.7)
                                                    .clamp(0.0, chartHeight);

                                            return GestureDetector(
                                              onTap: () => setState(() {
                                                _selectedIndex = isSelected
                                                    ? null
                                                    : idx;
                                              }),
                                              child: SizedBox(
                                                width: barGroupWidth,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    // Value label zone (fixed 32px)
                                                    SizedBox(
                                                      height: topLabelZone,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          if (entry
                                                                  .profitPerAcre >
                                                              0)
                                                            Text(
                                                              '₹${(entry.profitPerAcre / 1000).toStringAsFixed(1)}k',
                                                              style: TextStyle(
                                                                fontSize: 10,
                                                                color:
                                                                    isSelected
                                                                    ? entry
                                                                          .color
                                                                    : entry
                                                                          .color
                                                                          .withOpacity(
                                                                            0.8,
                                                                          ),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800,
                                                              ),
                                                            ),
                                                          if (entry
                                                                  .yieldPerAcre >
                                                              0)
                                                            Text(
                                                              '${(entry.yieldPerAcre / 100).toStringAsFixed(1)}q',
                                                              style: TextStyle(
                                                                fontSize: 9,
                                                                color: Colors
                                                                    .grey
                                                                    .shade600,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                        ],
                                                      ),
                                                    ),
                                                    // Bars
                                                    Container(
                                                      decoration: isSelected
                                                          ? BoxDecoration(
                                                              color: entry.color
                                                                  .withOpacity(
                                                                    0.06,
                                                                  ),
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    4,
                                                                  ),
                                                            )
                                                          : null,
                                                      padding:
                                                          const EdgeInsets.symmetric(
                                                            horizontal: 2,
                                                          ),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          // Profit bar
                                                          Container(
                                                            width: 24,
                                                            height: profitBarH
                                                                .clamp(
                                                                  2.0,
                                                                  chartHeight,
                                                                ),
                                                            decoration: BoxDecoration(
                                                              gradient: LinearGradient(
                                                                colors: [
                                                                  entry.color
                                                                      .withOpacity(
                                                                        0.7,
                                                                      ),
                                                                  entry.color,
                                                                ],
                                                                begin: Alignment
                                                                    .bottomCenter,
                                                                end: Alignment
                                                                    .topCenter,
                                                              ),
                                                              borderRadius:
                                                                  const BorderRadius.vertical(
                                                                    top:
                                                                        Radius.circular(
                                                                          6,
                                                                        ),
                                                                  ),
                                                              boxShadow:
                                                                  isSelected
                                                                  ? [
                                                                      BoxShadow(
                                                                        color: entry
                                                                            .color
                                                                            .withOpacity(
                                                                              0.4,
                                                                            ),
                                                                        blurRadius:
                                                                            8,
                                                                        offset:
                                                                            const Offset(
                                                                              0,
                                                                              -2,
                                                                            ),
                                                                      ),
                                                                    ]
                                                                  : [],
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 4,
                                                          ),
                                                          // Yield bar
                                                          Container(
                                                            width: 20,
                                                            height: yieldBarH
                                                                .clamp(
                                                                  2.0,
                                                                  chartHeight,
                                                                ),
                                                            decoration: BoxDecoration(
                                                              color: entry.color
                                                                  .withOpacity(
                                                                    0.28,
                                                                  ),
                                                              borderRadius:
                                                                  const BorderRadius.vertical(
                                                                    top:
                                                                        Radius.circular(
                                                                          5,
                                                                        ),
                                                                  ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // ── Baseline ──────────────────────
                                Container(
                                  height: 1.5,
                                  color: Colors.grey.shade400,
                                ),
                                // ── X-axis labels ─────────────────
                                SizedBox(
                                  height: xLabelZone,
                                  child: Row(
                                    children: chartEntries.asMap().entries.map((
                                      e,
                                    ) {
                                      final isSelected =
                                          _selectedIndex == e.key;
                                      return SizedBox(
                                        width: barGroupWidth,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            top: 6,
                                          ),
                                          child: Column(
                                            children: [
                                              Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 4,
                                                    ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 4,
                                                      vertical: 2,
                                                    ),
                                                decoration: isSelected
                                                    ? BoxDecoration(
                                                        color: e.value.color
                                                            .withOpacity(0.12),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              6,
                                                            ),
                                                      )
                                                    : null,
                                                child: Text(
                                                  e.value.cropLabel,
                                                  textAlign: TextAlign.center,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: isSelected
                                                        ? FontWeight.w800
                                                        : FontWeight.w600,
                                                    color: isSelected
                                                        ? e.value.color
                                                        : Colors.black87,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 2),
                                              Text(
                                                e.value.date,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 9,
                                                  color: Colors.grey.shade500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── Tap detail card ──────────────────────────────────
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: sel != null
                  ? Container(
                      key: ValueKey(_selectedIndex),
                      margin: const EdgeInsets.only(top: 14),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: sel.color.withOpacity(0.07),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: sel.color.withOpacity(0.3)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: sel.color,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '${sel.cropLabel}  ·  ${sel.date}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13,
                                  color: sel.color,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: _DetailMetric(
                                  icon: Icons.currency_rupee,
                                  label: 'Profit / acre',
                                  value:
                                      '₹${sel.profitPerAcre.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}',
                                  color: sel.color,
                                ),
                              ),
                              Expanded(
                                child: _DetailMetric(
                                  icon: Icons.grain,
                                  label: 'Yield / acre',
                                  value:
                                      '${(sel.yieldPerAcre / 100).toStringAsFixed(1)} q',
                                  color: Colors.grey.shade700,
                                ),
                              ),
                              Expanded(
                                child: _DetailMetric(
                                  icon: Icons.scale,
                                  label: 'Yield (kg)',
                                  value:
                                      '${sel.yieldPerAcre.toStringAsFixed(0)} kg',
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
            ),

            // ── Summary footer ───────────────────────────────────
            if (chartEntries.length > 1) ...[
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F8E9),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _SummaryMetric(
                      label: 'Best Profit',
                      value:
                          '₹${maxProfit.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}',
                      icon: Icons.emoji_events,
                      color: AppTheme.accent,
                    ),
                    Container(
                      width: 1,
                      height: 32,
                      color: Colors.grey.shade300,
                    ),
                    _SummaryMetric(
                      label: 'Best Yield',
                      value: '${(maxYield / 100).toStringAsFixed(1)} q/acre',
                      icon: Icons.trending_up,
                      color: AppTheme.primary,
                    ),
                    Container(
                      width: 1,
                      height: 32,
                      color: Colors.grey.shade300,
                    ),
                    _SummaryMetric(
                      label: 'Analyses',
                      value: '${chartEntries.length}',
                      icon: Icons.history,
                      color: AppTheme.sky,
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// Helper widgets for the chart
class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;
  final bool isLight;
  const _LegendDot({
    required this.color,
    required this.label,
    this.isLight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
            border: isLight ? Border.all(color: Colors.grey.shade300) : null,
          ),
        ),
        const SizedBox(width: 5),
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: Colors.black54),
        ),
      ],
    );
  }
}

class _DetailMetric extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  const _DetailMetric({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w800,
            color: color,
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 9, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _SummaryMetric extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  const _SummaryMetric({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(height: 3),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w800,
            color: color,
          ),
        ),
        Text(label, style: const TextStyle(fontSize: 9, color: Colors.grey)),
      ],
    );
  }
}

class _BarEntry {
  final String cropKey;
  final String cropLabel;
  final double profitPerAcre;
  final double yieldPerAcre;
  final String date;
  final Color color;
  const _BarEntry({
    required this.cropKey,
    required this.cropLabel,
    required this.profitPerAcre,
    required this.yieldPerAcre,
    required this.date,
    required this.color,
  });
}

// ═══════════════════════════════════════════════════════════
//  PROFILE SCREEN
// ═══════════════════════════════════════════════════════════
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String getSeason() {
    int month = DateTime.now().month;
    if (month >= 6 && month <= 10) return "Kharif";
    if (month >= 11 || month <= 3) return "Rabi";
    return "Zaid";
  }

  Future<void> detectLocation() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppText.get('turn_on_location'))),
        );
        return;
      }

      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppText.get('permission_denied'))),
        );
        return;
      }

      if (permission == LocationPermission.deniedForever) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppText.get('permission_permanently_denied'))),
        );
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      await fetchWeather(position.latitude, position.longitude);

      Placemark place = placemarks[0];
      setState(() {
        location = "${place.locality}, ${place.administrativeArea}";
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('location', location);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppText.get('location_updated')),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),
          ),
        );
        Navigator.pop(context, true);
      }
    } catch (e) {
      print(e);
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(AppText.get('failed_location'))));
      }
    }
  }

  Future<void> getCoordinatesFromLocation(String placeName) async {
    try {
      List<Location> locations = await locationFromAddress(placeName);
      latitude = locations[0].latitude;
      longitude = locations[0].longitude;
      setState(() {
        location = placeName;
      });

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('location', location);
      await fetchWeather(latitude!, longitude!);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("${AppText.get('location_set')}: $placeName"),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context, true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppText.get('location_not_found'))),
      );
    }
  }

  Future<void> fetchWeather(double lat, double lon) async {
    try {
      final response = await http.get(
        AppEnvironment.weatherForecastUri(lat: lat, lon: lon),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List forecastList = data['list'];
        List daily = [
          forecastList[0],
          forecastList[8],
          forecastList[16],
          forecastList[24],
          forecastList[32],
        ];
        var current = data['list'][0];

        setState(() {
          temperature = current['main']['temp'];
          windSpeed = current['wind']['speed'];
          visibility = (current['visibility'] ?? 0) / 1000;
          humidity = current['main']['humidity'];
          weatherDescription = current['weather'][0]['description'];
          rainfall = current['rain'] != null ? (current['rain']['3h'] ?? 0) : 0;
          if (rainfall > 1) {
            season = "Kharif";
          } else if (temperature < 25) {
            season = "Rabi";
          } else {
            season = "Zaid";
          }
        });

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setDouble('temp', temperature);
        await prefs.setDouble('rain', rainfall);
        await prefs.setString('season', season);
        await prefs.setString('forecast', json.encode(daily));
        await prefs.setInt('humidity', humidity);
        await prefs.setDouble('wind', windSpeed);
        await prefs.setString('desc', weatherDescription);
        await prefs.setDouble('visibility', visibility);
        await prefs.setDouble('lat', lat);
        await prefs.setDouble('lon', lon);
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  final locationController = TextEditingController();
  String location = "Bhubaneswar, Odisha";
  double temperature = 0;
  double rainfall = 0;
  int humidity = 0;
  String weatherDescription = "";
  double? latitude;
  double? longitude;
  String season = "Kharif";
  double windSpeed = 0;
  double visibility = 0;

  Future<void> loadLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedLocation = prefs.getString('location');
    if (savedLocation != null) {
      setState(() {
        location = savedLocation;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadLocation();
    loadTemperature();
    langNotifier.addListener(_onLangChange);
  }

  @override
  void dispose() {
    langNotifier.removeListener(_onLangChange);
    super.dispose();
  }

  void _onLangChange() => setState(() {});

  void loadTemperature() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      temperature = prefs.getDouble('temp') ?? 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppText.get('farmer_profile'))),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 👨‍🌾 Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppTheme.primary, AppTheme.secondary],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const Icon(Icons.agriculture, size: 50, color: Colors.white),
                  const SizedBox(height: 10),
                  Text(
                    AppText.get('hello_farmer'),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    AppText.get('manage_location'),
                    style: const TextStyle(color: Colors.white70),
                  ),
                  Text(
                    "${temperature.toStringAsFixed(1)}°C",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Card(
              child: ListTile(
                leading: const Icon(Icons.location_on, color: AppTheme.primary),
                title: Text(AppText.get('current_location')),
                subtitle: Text(location),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: locationController,
              decoration: InputDecoration(
                labelText: AppText.get('enter_location_manual'),
                prefixIcon: const Icon(Icons.edit_location),
              ),
            ),

            const SizedBox(height: 15),

            ElevatedButton.icon(
              onPressed: () {
                getCoordinatesFromLocation(locationController.text);
              },
              icon: const Icon(Icons.check),
              label: Text(AppText.get('set_location')),
            ),

            const SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: detectLocation,
              icon: const Icon(Icons.my_location),
              label: Text(AppText.get('detect_location')),
            ),

            const SizedBox(height: 20),

            // ── Language Switcher ──────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${AppText.get('language')}: ",
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.primary,
                  ),
                ),
                DropdownButton<String>(
                  value: AppText.currentLang,
                  underline: const SizedBox(),
                  borderRadius: BorderRadius.circular(12),
                  onChanged: (value) {
                    if (value != null) {
                      AppText.currentLang = value;
                    }
                  },
                  items: const [
                    DropdownMenuItem(value: "en", child: Text("🇬🇧  English")),
                    DropdownMenuItem(value: "hi", child: Text("🇮🇳  हिंदी")),
                    DropdownMenuItem(value: "ta", child: Text("🇮🇳  தமிழ்")),
                    DropdownMenuItem(value: "or", child: Text("🇮🇳  ଓଡ଼ିଆ")),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
//  REUSABLE WIDGETS
// ═══════════════════════════════════════════════════════════

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) => Text(
    title,
    style: const TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w700,
      color: Color(0xFF1B5E20),
    ),
  );
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 6),
            Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 15,
                color: color,
              ),
            ),
            Text(
              label,
              style: TextStyle(fontSize: 11, color: color.withOpacity(0.8)),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;
  const _ActionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.white, size: 28),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 15,
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CropChip extends StatelessWidget {
  final String name;
  final String icon;
  final int score;
  const _CropChip({
    required this.name,
    required this.icon,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(icon, style: const TextStyle(fontSize: 28)),
          const SizedBox(height: 4),
          Text(
            name,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          Container(
            margin: const EdgeInsets.only(top: 4),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: AppTheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '$score%',
              style: const TextStyle(
                fontSize: 11,
                color: AppTheme.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AlertBanner extends StatelessWidget {
  final String message;
  const _AlertBanner({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppTheme.accent.withOpacity(0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.accent.withOpacity(0.3)),
      ),
      child: Text(
        message,
        style: const TextStyle(fontSize: 13, color: Color(0xFF795548)),
      ),
    );
  }
}

class _FormCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;
  final Color? iconColor;
  const _FormCard({
    required this.title,
    required this.icon,
    required this.child,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final color = iconColor ?? AppTheme.primary;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, size: 16, color: color),
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: Color(0xFF1B5E20),
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
            const Divider(height: 20),
            child,
          ],
        ),
      ),
    );
  }
}

class _DropdownField extends StatelessWidget {
  final String label;
  final String? value;
  final List<String> itemKeys;
  final void Function(String?) onChanged;
  const _DropdownField({
    required this.label,
    required this.value,
    required this.itemKeys,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      onChanged: onChanged,
      validator: (v) => v == null ? 'Please select $label' : null,
      decoration: InputDecoration(labelText: label),
      items: itemKeys
          .map((k) => DropdownMenuItem(value: k, child: Text(AppText.get(k))))
          .toList(),
    );
  }
}

class _StepIndicator extends StatelessWidget {
  final List<String> steps;
  final int current;
  const _StepIndicator({required this.steps, required this.current});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(steps.length, (i) {
        final active = i == current;
        final done = i < current;
        return Expanded(
          child: Row(
            children: [
              Column(
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: done || active
                          ? AppTheme.primary
                          : Colors.grey.shade200,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: done
                          ? const Icon(
                              Icons.check,
                              size: 16,
                              color: Colors.white,
                            )
                          : Text(
                              '${i + 1}',
                              style: TextStyle(
                                fontSize: 12,
                                color: active ? Colors.white : Colors.grey,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    steps[i],
                    style: TextStyle(
                      fontSize: 10,
                      color: active ? AppTheme.primary : Colors.grey,
                      fontWeight: active ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                ],
              ),
              if (i < steps.length - 1)
                Expanded(
                  child: Divider(
                    color: done ? AppTheme.primary : Colors.grey.shade300,
                    thickness: 1.5,
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }
}

class _ResultPill extends StatelessWidget {
  final String label;
  final String value;
  const _ResultPill({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
      ],
    );
  }
}

class _RecommendationTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  const _RecommendationTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.12),
          child: Icon(icon, color: color, size: 20),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(subtitle, style: const TextStyle(fontSize: 13)),
        ),
        isThreeLine: true,
      ),
    );
  }
}

class _WeatherPill extends StatelessWidget {
  final IconData icon;
  final String label;
  final String sub;
  const _WeatherPill({
    required this.icon,
    required this.label,
    required this.sub,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.white70, size: 18),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        Text(sub, style: const TextStyle(color: Colors.white60, fontSize: 11)),
      ],
    );
  }
}

class _ForecastRow extends StatelessWidget {
  final String day;
  final IconData icon;
  final int high;
  final int low;
  final int rain;
  final int humidity;
  final double windSpeed;
  const _ForecastRow({
    required this.day,
    required this.icon,
    required this.high,
    required this.low,
    required this.rain,
    this.humidity = 0,
    this.windSpeed = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0288D1), Color(0xFF0097A7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Day + icon + temp row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                day,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
              Row(
                children: [
                  Icon(icon, color: Colors.white, size: 22),
                  const SizedBox(width: 8),
                  Text(
                    '$low° / $high°',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Humidity | Wind | Rain row — just like current weather pills
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _forecastPill(
                Icons.water_drop,
                '$humidity%',
                AppText.get('humidity'),
              ),
              _forecastPill(
                Icons.air,
                '${windSpeed.toStringAsFixed(1)} km/h',
                AppText.get('wind'),
              ),
              _forecastPill(Icons.beach_access, '$rain%', 'Rain'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _forecastPill(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.white70, size: 18),
        const SizedBox(height: 3),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.white60, fontSize: 11),
        ),
      ],
    );
  }
}

class _AdvisoryCard extends StatelessWidget {
  final String crop;
  final String icon;
  final String tip;
  final int score;
  const _AdvisoryCard({
    required this.crop,
    required this.icon,
    required this.tip,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(icon, style: const TextStyle(fontSize: 32)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        crop,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '$score%',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    tip,
                    style: const TextStyle(fontSize: 13, color: Colors.black54),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
