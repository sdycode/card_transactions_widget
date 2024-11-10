import 'package:firebase_database/firebase_database.dart';
import 'package:transcation_history/folders/folders.dart';
import 'package:transcation_history/lib.dart';

Future<bool> loadData() async {
  print("allYearsData[year] ${DataService.instance.allYearsData.isEmpty} : $kIsWeb");
  if (DataService.instance.allYearsData.length<2) {
    if (kIsWeb) {
      await getDataFromFirebase();
    } else {
      await DataService.instance.loadCompleteData();
    }
    return true;
  }
  return true;
}

Future<bool> getDataFromFirebase() async {
  final DatabaseReference db =
      FirebaseDatabase.instance.ref(); // Root reference
  DataSnapshot snap = await db.get();
  snap.children.forEach((e) {
    try {
      Map? map = e.value as Map?;
      if (map != null) {
        YearData data = YearData.fromMap(map);
        DataService.instance.allYearsData[data.year] = data;
      }
    } catch (e) {}
  });
  return true;
}
