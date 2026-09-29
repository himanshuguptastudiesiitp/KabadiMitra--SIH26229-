import '../models/types.dart';

class I18n {
  static const Map<String, Map<Lang, String>> _t = {
    "appName": {Lang.hi: "कबड़ी मित्र", Lang.en: "KabadiMitra"},
    "ramRam": {Lang.hi: "राम राम", Lang.en: "Hello"},
    "sampleName": {Lang.hi: "रमेश", Lang.en: "Ramesh"},
    "chainSub": {Lang.hi: "collect–identify–value chain", Lang.en: "collect–identify–value chain"},
    "todayEarned": {Lang.hi: "आज की कमाई", Lang.en: "Today earned"},
    "openCamera": {Lang.hi: "कैमरा खोलें", Lang.en: "Open camera"},
    "addScrap": {Lang.hi: "कबाड़ी जोड़ें", Lang.en: "Add scrap"},
    "priceBoard": {Lang.hi: "भाव सूची", Lang.en: "Price board"},
    "earnings": {Lang.hi: "कमाई", Lang.en: "Earnings"},
    "recyclers": {Lang.hi: "रीसाइक्लर", Lang.en: "Recyclers"},
    "safety": {Lang.hi: "सुरक्षा", Lang.en: "Safety"},
    "userPage": {Lang.hi: "उपयोगकर्ता", Lang.en: "User"},
    "recentLots": {Lang.hi: "हाल के लॉट", Lang.en: "Recent lots"},
    "noLots": {Lang.hi: "अभी कोई लॉट नहीं", Lang.en: "No lots yet"},
    "login": {Lang.hi: "लॉगिन", Lang.en: "Login"},
    "loginSub": {Lang.hi: "स्क्रैप कलेक्टर साथी ऐप", Lang.en: "Scrap collector companion app"},
    "email": {Lang.hi: "ईमेल", Lang.en: "Email"},
    "password": {Lang.hi: "पासवर्ड", Lang.en: "Password"},
    "loginGo": {Lang.hi: "लॉगिन करें", Lang.en: "Log in"},
    "newAccount": {Lang.hi: "नया खाता बनाएं", Lang.en: "Create account"},
    "register": {Lang.hi: "नया खाता", Lang.en: "Register"},
    "name": {Lang.hi: "नाम", Lang.en: "Name"},
    "next": {Lang.hi: "आगे बढ़ें", Lang.en: "Next"},
    "pickRole": {Lang.hi: "अपनी भूमिका चुनें", Lang.en: "Pick your role"},
    "roleCollector": {Lang.hi: "कलेक्टर", Lang.en: "Collector"},
    "roleRecycler": {Lang.hi: "रीसाइक्लर", Lang.en: "Recycler"},
    "roleAdmin": {Lang.hi: "एडमिन", Lang.en: "Admin"},
    "cameraTitle": {Lang.hi: "कैमरा", Lang.en: "Camera"},
    "cameraSub": {Lang.hi: "कबाड़ी की फोटो लें", Lang.en: "Take scrap photo"},
    "noPhoto": {Lang.hi: "कोई फोटो नहीं", Lang.en: "No photo"},
    "takePhoto": {Lang.hi: "फोटो लें", Lang.en: "Take photo"},
    "fromGallery": {Lang.hi: "गैलरी से", Lang.en: "From gallery"},
    "aiGuess": {Lang.hi: "AI अनुमान", Lang.en: "AI Guess"},
    "pickType": {Lang.hi: "प्रकार चुनें", Lang.en: "Pick type"},
    "weight": {Lang.hi: "वजन (किलो)", Lang.en: "Weight (kg)"},
    "estimate": {Lang.hi: "अनुमान", Lang.en: "Estimate"},
    "matchRecycler": {Lang.hi: "रीसाइक्लर से मिलाएं", Lang.en: "Match recycler"},
    "save": {Lang.hi: "सेव करें", Lang.en: "Save"},
    "handover": {Lang.hi: "हस्तांतरण", Lang.en: "Handover"},
    "payHow": {Lang.hi: "भुगतान कैसे?", Lang.en: "Pay how?"},
    "cash": {Lang.hi: "नकद", Lang.en: "Cash"},
    "upi": {Lang.hi: "UPI", Lang.en: "UPI"},
    "confirmHandover": {Lang.hi: "हस्तांतरण पुष्टि", Lang.en: "Confirm handover"},
    "settings": {Lang.hi: "सेटिंग्स", Lang.en: "Settings"},
    "language": {Lang.hi: "भाषा", Lang.en: "Language"},
    "themeTitle": {Lang.hi: "थीम", Lang.en: "Theme"},
    "voice": {Lang.hi: "आवाज", Lang.en: "Voice"},
    "on": {Lang.hi: "चालू", Lang.en: "On"},
    "off": {Lang.hi: "बंद", Lang.en: "Off"},
    "adminDesk": {Lang.hi: "एडमिन डेस्क", Lang.en: "Admin desk"},
    "lots": {Lang.hi: "लॉट", Lang.en: "Lots"},
    "paidDone": {Lang.hi: "भुगतान हुआ", Lang.en: "Paid"},
    "pendingPay": {Lang.hi: "बाकी", Lang.en: "Pending"},
    "history": {Lang.hi: "इतिहास", Lang.en: "History"},
    "trace": {Lang.hi: "ट्रेस", Lang.en: "Trace"},
    "perKg": {Lang.hi: "/ किलो", Lang.en: "/ kg"},
    "rupees": {Lang.hi: "रुपये", Lang.en: "rupees"},
    "home": {Lang.hi: "होम", Lang.en: "Home"},
    "working": {Lang.hi: "काम हो रहा…", Lang.en: "Working…"},
  };

  static String t(Lang lang, String key) {
    final m = _t[key];
    if (m == null) return key;
    return m[lang] ?? m[Lang.en] ?? key;
  }

  static String materialLabel(Lang lang, MaterialId id) {
    const labels = {
      MaterialId.pcb: {Lang.hi: "PCB", Lang.en: "PCB"},
      MaterialId.copper: {Lang.hi: "तांबा", Lang.en: "Copper"},
      MaterialId.aluminium: {Lang.hi: "एल्युमिनियम", Lang.en: "Aluminium"},
      MaterialId.plastic: {Lang.hi: "प्लास्टिक", Lang.en: "Plastic"},
      MaterialId.iron: {Lang.hi: "लोहा", Lang.en: "Iron"},
      MaterialId.mixed: {Lang.hi: "मिश्र", Lang.en: "Mixed"},
    };
    return labels[id]?[lang] ?? id.name;
  }
}
