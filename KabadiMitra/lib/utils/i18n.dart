import '../models/types.dart';

class I18n {
  static const Map<String, Map<Lang, String>> _t = {
    "appName": {
      Lang.hi: "कबाड़ी मित्र",
      Lang.mr: "कबाडी मित्र",
      Lang.en: "Kabadi Mitra"
    },
    "ramRam": {Lang.hi: "राम राम", Lang.mr: "राम राम", Lang.en: "Hello"},
    "sampleName": {Lang.hi: "रमेश", Lang.mr: "रमेश", Lang.en: "Ramesh"},
    "chainSub": {
      Lang.hi: "संग्रह–पहचान–मूल्य श्रृंखला",
      Lang.mr: "गोळा–ओळख–किंमत साखळी",
      Lang.en: "collect–identify–value chain"
    },
    "todayEarned": {Lang.hi: "आज की कमाई", Lang.mr: "आजची कमाई", Lang.en: "Today earned"},
    "openCamera": {Lang.hi: "कैमरा खोलें", Lang.mr: "कॅमेरा उघडा", Lang.en: "Open camera"},
    "addScrap": {Lang.hi: "कबाड़ जोड़ें", Lang.mr: "कबाड जोडा", Lang.en: "Add scrap"},
    "priceBoard": {Lang.hi: "भाव सूची", Lang.mr: "भाव यादी", Lang.en: "Price board"},
    "earnings": {Lang.hi: "कमाई", Lang.mr: "कमाई", Lang.en: "Earnings"},
    "recyclers": {Lang.hi: "रीसाइक्लर", Lang.mr: "रीसायक्लर", Lang.en: "Recyclers"},
    "safety": {Lang.hi: "सुरक्षा", Lang.mr: "सुरक्षा", Lang.en: "Safety"},
    "userPage": {Lang.hi: "उपयोगकर्ता", Lang.mr: "वापरकर्ता", Lang.en: "User"},
    "recentLots": {Lang.hi: "हाल के लॉट", Lang.mr: "अलीकडील लॉट", Lang.en: "Recent lots"},
    "noLots": {Lang.hi: "अभी कोई लॉट नहीं", Lang.mr: "अजून कोणताही लॉट नाही", Lang.en: "No lots yet"},
    "login": {Lang.hi: "लॉगिन", Lang.mr: "लॉगिन", Lang.en: "Login"},
    "loginSub": {
      Lang.hi: "स्क्रैप कलेक्टर साथी ऐप",
      Lang.mr: "स्क्रॅप कलेक्टर साथी अॅप",
      Lang.en: "Scrap collector companion app"
    },
    "email": {Lang.hi: "ईमेल", Lang.mr: "ईमेल", Lang.en: "Email"},
    "password": {Lang.hi: "पासवर्ड", Lang.mr: "पासवर्ड", Lang.en: "Password"},
    "loginGo": {Lang.hi: "लॉगिन करें", Lang.mr: "लॉगिन करा", Lang.en: "Log in"},
    "newAccount": {Lang.hi: "नया खाता बनाएं", Lang.mr: "नवीन खाते तयार करा", Lang.en: "Create account"},
    "register": {Lang.hi: "नया खाता", Lang.mr: "नवीन खाते", Lang.en: "Register"},
    "name": {Lang.hi: "नाम", Lang.mr: "नाव", Lang.en: "Name"},
    "next": {Lang.hi: "आगे बढ़ें", Lang.mr: "पुढे जा", Lang.en: "Next"},
    "pickRole": {Lang.hi: "अपनी भूमिका चुनें", Lang.mr: "तुमची भूमिका निवडा", Lang.en: "Pick your role"},
    "roleCollector": {Lang.hi: "कलेक्टर", Lang.mr: "कलेक्टर", Lang.en: "Collector"},
    "roleRecycler": {Lang.hi: "रीसाइक्लर", Lang.mr: "रीसायक्लर", Lang.en: "Recycler"},
    "roleAdmin": {Lang.hi: "एडमिन", Lang.mr: "अॅडमिन", Lang.en: "Admin"},
    "cameraTitle": {Lang.hi: "कैमरा", Lang.mr: "कॅमेरा", Lang.en: "Camera"},
    "cameraSub": {Lang.hi: "कबाड़ की फोटो लें", Lang.mr: "कबाडाचा फोटो काढा", Lang.en: "Take scrap photo"},
    "noPhoto": {Lang.hi: "कोई फोटो नहीं", Lang.mr: "फोटो नाही", Lang.en: "No photo"},
    "takePhoto": {Lang.hi: "फोटो लें", Lang.mr: "फोटो काढा", Lang.en: "Take photo"},
    "fromGallery": {Lang.hi: "गैलरी से", Lang.mr: "गॅलरीतून", Lang.en: "From gallery"},
    "aiGuess": {Lang.hi: "AI अनुमान", Lang.mr: "AI अंदाज", Lang.en: "AI Guess"},
    "pickType": {Lang.hi: "प्रकार चुनें", Lang.mr: "प्रकार निवडा", Lang.en: "Pick type"},
    "weight": {Lang.hi: "वजन (किलो)", Lang.mr: "वजन (किलो)", Lang.en: "Weight (kg)"},
    "weightEnter": {Lang.hi: "वजन लिखें", Lang.mr: "वजन लिहा", Lang.en: "Enter weight"},
    "estimate": {Lang.hi: "अनुमान", Lang.mr: "अंदाज", Lang.en: "Estimate"},
    "matchRecycler": {Lang.hi: "रीसाइक्लर से मिलाएं", Lang.mr: "रीसायक्लरशी जुळवा", Lang.en: "Match recycler"},
    "save": {Lang.hi: "सेव करें", Lang.mr: "जतन करा", Lang.en: "Save"},
    "handover": {Lang.hi: "हस्तांतरण", Lang.mr: "हस्तांतरण", Lang.en: "Handover"},
    "payHow": {Lang.hi: "भुगतान कैसे?", Lang.mr: "पेमेंट कसे?", Lang.en: "Pay how?"},
    "cash": {Lang.hi: "नकद", Lang.mr: "रोख", Lang.en: "Cash"},
    "upi": {Lang.hi: "UPI", Lang.mr: "UPI", Lang.en: "UPI"},
    "confirmHandover": {Lang.hi: "हस्तांतरण पुष्टि", Lang.mr: "हस्तांतरण पुष्टी", Lang.en: "Confirm handover"},
    "settings": {Lang.hi: "सेटिंग्स", Lang.mr: "सेटिंग्ज", Lang.en: "Settings"},
    "language": {Lang.hi: "भाषा", Lang.mr: "भाषा", Lang.en: "Language"},
    "themeTitle": {Lang.hi: "थीम", Lang.mr: "थीम", Lang.en: "Theme"},
    "defaultTheme": {Lang.hi: "डिफ़ॉल्ट", Lang.mr: "डिफॉल्ट", Lang.en: "Default"},
    "darkTheme": {Lang.hi: "डार्क", Lang.mr: "डार्क", Lang.en: "Dark"},
    "voice": {Lang.hi: "आवाज", Lang.mr: "आवाज", Lang.en: "Voice"},
    "on": {Lang.hi: "चालू", Lang.mr: "चालू", Lang.en: "On"},
    "off": {Lang.hi: "बंद", Lang.mr: "बंद", Lang.en: "Off"},
    "adminDesk": {Lang.hi: "एडमिन डेस्क", Lang.mr: "अॅडमिन डेस्क", Lang.en: "Admin desk"},
    "lots": {Lang.hi: "लॉट", Lang.mr: "लॉट", Lang.en: "Lots"},
    "paidDone": {Lang.hi: "भुगतान हुआ", Lang.mr: "पेमेंट झाले", Lang.en: "Paid"},
    "pendingPay": {Lang.hi: "बाकी", Lang.mr: "बाकी", Lang.en: "Pending"},
    "history": {Lang.hi: "इतिहास", Lang.mr: "इतिहास", Lang.en: "History"},
    "trace": {Lang.hi: "ट्रेस", Lang.mr: "ट्रेस", Lang.en: "Trace"},
    "perKg": {Lang.hi: "/ किलो", Lang.mr: "/ किलो", Lang.en: "/ kg"},
    "rupees": {Lang.hi: "रुपये", Lang.mr: "रुपये", Lang.en: "rupees"},
    "home": {Lang.hi: "होम", Lang.mr: "होम", Lang.en: "Home"},
    "working": {Lang.hi: "काम हो रहा…", Lang.mr: "काम सुरू आहे…", Lang.en: "Working…"},
    "authorized": {Lang.hi: "अधिकृत", Lang.mr: "अधिकृत", Lang.en: "Authorized"},
    "streetRate": {Lang.hi: "सड़क भाव", Lang.mr: "रस्त्यावरील भाव", Lang.en: "Street rate"},
    "betterBy": {Lang.hi: "बेहतर", Lang.mr: "इतके अधिक", Lang.en: "Better by"},
    "skipDemo": {Lang.hi: "छोड़ें (डेमो)", Lang.mr: "वगळा (डेमो)", Lang.en: "Skip (demo)"},
    "validEmail": {Lang.hi: "मान्य ईमेल चाहिए", Lang.mr: "वैध ईमेल आवश्यक", Lang.en: "Valid email required"},
    "passwordShort": {
      Lang.hi: "पासवर्ड बहुत छोटा है",
      Lang.mr: "पासवर्ड खूप छोटा आहे",
      Lang.en: "Password too short"
    },
    "materialFlow": {Lang.hi: "सामग्री प्रवाह", Lang.mr: "साहित्य प्रवाह", Lang.en: "Material flow"},
    "statusCollected": {Lang.hi: "एकत्रित", Lang.mr: "गोळा केले", Lang.en: "Collected"},
    "statusIdentified": {Lang.hi: "पहचाना", Lang.mr: "ओळखले", Lang.en: "Identified"},
    "statusValued": {Lang.hi: "मूल्यांकित", Lang.mr: "मूल्यांकित", Lang.en: "Valued"},
    "statusOffered": {Lang.hi: "ऑफर किया", Lang.mr: "ऑफर केले", Lang.en: "Offered"},
    "statusAccepted": {Lang.hi: "स्वीकृत", Lang.mr: "स्वीकारले", Lang.en: "Accepted"},
    "statusHandover": {Lang.hi: "हस्तांतरण", Lang.mr: "हस्तांतरण", Lang.en: "Handover"},
    "statusPaid": {Lang.hi: "भुगतान हुआ", Lang.mr: "पेमेंट झाले", Lang.en: "Paid"},
    "statusTrace": {Lang.hi: "ट्रेस", Lang.mr: "ट्रेस", Lang.en: "Trace"},
    "staySafe": {
      Lang.hi: "संग्रह करते समय सुरक्षित रहें",
      Lang.mr: "गोळा करताना सुरक्षित रहा",
      Lang.en: "Stay safe while collecting"
    },
    "tipBurn": {Lang.hi: "तारें न जलाएं", Lang.mr: "तार जाळू नका", Lang.en: "Don't burn wires"},
    "tipBurnB": {
      Lang.hi: "जलाने से जहरीला धुआं निकलता है। इंसुलेटेड तांबा बेचें।",
      Lang.mr: "जाळल्याने विषारी धूर निघतो. इन्सुलेटेड तांबे विका.",
      Lang.en: "Burning releases toxic fumes. Sell insulated copper instead."
    },
    "tipBat": {Lang.hi: "बैटरी सावधानी से", Lang.mr: "बॅटरी काळजीपूर्वक", Lang.en: "Handle batteries carefully"},
    "tipBatB": {
      Lang.hi: "गर्मी से दूर रखें और लिथियम सेल न फोड़ें।",
      Lang.mr: "उष्णतेपासून दूर ठेवा आणि लिथियम सेल फोडू नका.",
      Lang.en: "Keep away from heat and never puncture lithium cells."
    },
    "tipCrt": {Lang.hi: "CRT / कांच सावधानी", Lang.mr: "CRT / काच काळजी", Lang.en: "CRT / glass care"},
    "tipCrtB": {
      Lang.hi: "CRT मॉनिटर में लेड वाला कांच होता है — तोड़ें नहीं।",
      Lang.mr: "CRT मॉनिटरमध्ये शिसे असलेला काच असतो — फोडू नका.",
      Lang.en: "CRT monitors contain leaded glass — do not smash."
    },
    "tipPcb": {Lang.hi: "PCB संभालना", Lang.mr: "PCB हाताळणी", Lang.en: "PCB handling"},
    "tipPcbB": {
      Lang.hi: "दस्ताने पहनें; सर्किट बोर्ड की धूल न सांस में लें।",
      Lang.mr: "हातमोजे घाला; सर्किट बोर्डची धूळ श्वासात घेऊ नका.",
      Lang.en: "Wear gloves; avoid inhaling dust from circuit boards."
    },
    "step1": {Lang.hi: "कबाड़ इकट्ठा करें", Lang.mr: "कबाड गोळा करा", Lang.en: "Collect scrap"},
    "step2": {Lang.hi: "सामग्री पहचानें", Lang.mr: "साहित्य ओळखा", Lang.en: "Identify material"},
    "step3": {Lang.hi: "मूल्य अनुमान", Lang.mr: "किंमत अंदाज", Lang.en: "Get value estimate"},
    "step4": {Lang.hi: "रीसाइक्लर मिलाएं", Lang.mr: "रीसायक्लर जुळवा", Lang.en: "Match recycler"},
    "step5": {Lang.hi: "पिकअप तय करें", Lang.mr: "पिकअप ठरवा", Lang.en: "Schedule pickup"},
    "step6": {Lang.hi: "हस्तांतरण पुष्टि", Lang.mr: "हस्तांतरण पुष्टी", Lang.en: "Handover and confirm"},
    "step7": {Lang.hi: "भुगतान लें", Lang.mr: "पेमेंट घ्या", Lang.en: "Get paid"},
    "step8": {Lang.hi: "इतिहास ट्रेस करें", Lang.mr: "इतिहास ट्रेस करा", Lang.en: "Trace history"},
    "pipeCollect": {Lang.hi: "संग्रह", Lang.mr: "गोळा", Lang.en: "COLLECT"},
    "pipeIdentify": {Lang.hi: "पहचान", Lang.mr: "ओळख", Lang.en: "IDENTIFY"},
    "pipeValue": {Lang.hi: "मूल्य", Lang.mr: "किंमत", Lang.en: "VALUE"},
    "pipeMatch": {Lang.hi: "मैच", Lang.mr: "जुळव", Lang.en: "MATCH"},
    "pipeHandover": {Lang.hi: "सौंपें", Lang.mr: "सोपवा", Lang.en: "HANDOVER"},
    "kgUnit": {Lang.hi: "किलो", Lang.mr: "किलो", Lang.en: "kg"},
    "kmUnit": {Lang.hi: "किमी", Lang.mr: "किमी", Lang.en: "km"},
    "nagpur": {Lang.hi: "नागपुर", Lang.mr: "नागपूर", Lang.en: "Nagpur"},
    "local": {Lang.hi: "स्थानीय", Lang.mr: "स्थानिक", Lang.en: "Local"},
    "demoNote": {
      Lang.hi: "डेमो ऐप — असली लॉगिन सर्वर नहीं",
      Lang.mr: "डेमो अॅप — खरा लॉगिन सर्व्हर नाही",
      Lang.en: "Demo app — no live login server"
    },
  };

  static String t(Lang lang, String key) {
    final m = _t[key];
    if (m == null) return key;
    return m[lang] ?? m[Lang.en] ?? key;
  }

  static String materialLabel(Lang lang, MaterialId id) {
    const labels = {
      MaterialId.pcb: {Lang.hi: "PCB", Lang.mr: "PCB", Lang.en: "PCB"},
      MaterialId.copper: {Lang.hi: "तांबा", Lang.mr: "तांबे", Lang.en: "Copper"},
      MaterialId.aluminium: {Lang.hi: "एल्युमिनियम", Lang.mr: "अॅल्युमिनियम", Lang.en: "Aluminium"},
      MaterialId.plastic: {Lang.hi: "प्लास्टिक", Lang.mr: "प्लास्टिक", Lang.en: "Plastic"},
      MaterialId.iron: {Lang.hi: "लोहा", Lang.mr: "लोखंड", Lang.en: "Iron"},
      MaterialId.mixed: {Lang.hi: "मिश्र", Lang.mr: "मिश्र", Lang.en: "Mixed"},
    };
    return labels[id]?[lang] ?? labels[id]?[Lang.en] ?? id.name;
  }

  static String statusLabel(Lang lang, LotStatus status) {
    switch (status) {
      case LotStatus.collected:
        return t(lang, "statusCollected");
      case LotStatus.identified:
        return t(lang, "statusIdentified");
      case LotStatus.valued:
        return t(lang, "statusValued");
      case LotStatus.offered:
        return t(lang, "statusOffered");
      case LotStatus.accepted:
        return t(lang, "statusAccepted");
      case LotStatus.handover:
        return t(lang, "statusHandover");
      case LotStatus.paid:
        return t(lang, "statusPaid");
      case LotStatus.trace:
        return t(lang, "statusTrace");
    }
  }
}
