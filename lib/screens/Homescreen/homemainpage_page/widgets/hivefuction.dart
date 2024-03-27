import 'package:hive/hive.dart';

class HiveBox {
  static const String cardDataBoxName = 'card_data';

  static Future<Box> getCardDataBox() async {
    return await Hive.openBox(cardDataBoxName);
  }
}
