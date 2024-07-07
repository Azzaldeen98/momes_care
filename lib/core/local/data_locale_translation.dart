import 'package:get/route_manager.dart';

import 'ar.dart';
import 'en.dart';

class DataLoacleTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {"ar": ar, "en": en};
}
