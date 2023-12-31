import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../data/model/universal_data.dart';
import '../data/network/api_service.dart';

class AddressCallProvider with ChangeNotifier {
  AddressCallProvider({required this.apiService});

  final ApiService apiService;


  TextEditingController textController = TextEditingController();
  String scrolledAddressText = '';
  String kind = "house";
  String lang = "uz_UZ";

  getAddressByLatLong({required LatLng latLng}) async {
    UniversalData universalData = await apiService.getAddress(
      latLng: latLng,
      kind: kind,
      lang: lang,
    );

    if (universalData.error.isEmpty) {
      scrolledAddressText = universalData.data as String;
    } else {
      debugPrint("ERROR:${universalData.error}");
    }
    notifyListeners();
  }

  void updateKind(String newKind) {
    kind = newKind;
  }

  void updateLang(String newLang) {
    lang = newLang;
  }

  bool canSaveAddress() {
    if (scrolledAddressText.isEmpty) return false;
    if (scrolledAddressText == 'Aniqlanmagan Hudud') return false;
    if (scrolledAddressText == 'Undefined Area') return false;
    if (scrolledAddressText == 'Неопределенная область') return false;
    if (scrolledAddressText == 'Tanımsız Alan') return false;

    return true;
  }
}
