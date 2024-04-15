import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/plat.dart';

class Constantes{

  final CollectionReference PLATS = FirebaseFirestore.instance.collection('plats');
  final CollectionReference PARTENAIRE = FirebaseFirestore.instance.collection('partenaires');
  final CollectionReference STATISTIQUES = FirebaseFirestore.instance.collection('statistiques');

  final String STORAGE_CHILD="plats/";

  String genCode(String char){
    String key=char;
    Random r = Random();
    String allKeyBoardChars="ABCDEFGH456IJKLMNOPUfghijklmnVWXYZ01289abcdeopqrQRSTstuv37wxyz";
    for(int i=0;i<7;i++) {
      key+=allKeyBoardChars[r.nextInt(62)];
    }
    return key.toUpperCase();
  }

  String genKey(){
    String key='';
    Random r = Random();
    String allKeyBoardChars="01234mnopqrs56789abcdefghijklmnopqrstuvwxyz";
    for(int i=0;i<32;i++) {
      key+=allKeyBoardChars[r.nextInt(36)];
    }
    return key;
  }

  Future<List<T>> getDocuments<T>() async {
    QuerySnapshot<Map<String, dynamic>> docs=await FirebaseFirestore.instance.collection('plats').get();
    List<T> list=docs.docs.isNotEmpty ? docs.docs.map((d) => Plat.fromMap(d.data())).toList() as List<T>:[];

    print("liste dcommandes:$list");
    return list;
  }

  bool isLogin(){
    return prefs.getString("partenaire")!=null;
  }


  static late SharedPreferences prefs;
  static Future<void> getSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Location localisation = Location();
  static LocationData ? latLng;
  static Future<void> getLocalisation() async{
    latLng = await localisation.getLocation();
  }

  final ValueNotifier<bool> isconnected = ValueNotifier(false);
  final ValueNotifier<bool> formContentChange=ValueNotifier(false);
  int elementAt=0;

  /**************** Map ****************/

 double getDistanceBetWeen2Points(Point p1, Point p2){
     var p = 0.017453292519943295;
     var c = cos;
     var a = 0.5 - c((p2.latitude - p1.latitude) * p)/2 +
         c(p1.latitude * p) * c(p2.latitude * p) *
             (1 - c((p2.longitude - p2.longitude) * p))/2;
     return 12742 * asin(sqrt(a));
 }

}

class MyClip extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return const Rect.fromLTRB(0, 100, 100, 100);
  }

  @override
  bool shouldReclip(oldClipper) {
    return false;
  }
}
class Point{
  double latitude = 0;
  double longitude = 0;
  Point(this.latitude,this.longitude);
}
class ShowDialogs {
  static Future<void> notifier(
      BuildContext context, int nbSecondes, String message,
      {Color backgroundColor = Colors.orangeAccent,
        Color textColor = Colors.black,
        double borderRadiusAll = 5,
        double contentPaddingTopAndBottom = 2}) async {
    bool? exitAfterNbSecondes =true;
    Timer(Duration(seconds: nbSecondes), () {
      if (exitAfterNbSecondes == true) {
        Navigator.of(context, rootNavigator: true).pop();
      }
    });

    return showDialog(
      context: context,
      builder: (context) {
        return WillPopScope(
            onWillPop: () async {
              exitAfterNbSecondes = false;
              Navigator.of(context, rootNavigator: true)
                  .pop(); //Pour faire disparaitre l'alerte dialog

              return exitAfterNbSecondes!;
            },
            child: AlertDialog(
              backgroundColor: backgroundColor,
              content: Center(
                heightFactor:1,
                child: Text(message, style: TextStyle(color: textColor)), //Le height du widget Center =heightFactor*heightDuChild
              ),
              contentPadding: EdgeInsets.only(
                  top: contentPaddingTopAndBottom,
                  bottom: contentPaddingTopAndBottom),
              shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.all(Radius.circular(borderRadiusAll)),
              ),
            ));
      },
    );
  }
}
class ChartData {
  ChartData(this.x, this.y, {this.color=Colors.greenAccent});
  final String x;
  final double y;
  final Color color;
}


//import 'package:cloud_firestore/cloud_firestore.dart';

class Collections{

  final CollectionReference PLATS = FirebaseFirestore.instance.collection('plats');
  final CollectionReference PARTENAIRE = FirebaseFirestore.instance.collection('partenaires');
  final CollectionReference STATISTIQUES = FirebaseFirestore.instance.collection('statistiques');

  final String STORAGE_CHILD="plats/";

  final  CollectionReference COTISATIONS = FirebaseFirestore.instance.collection('cotisations');
  final CollectionReference DEMANDES = FirebaseFirestore.instance.collection('demandes');
  final CollectionReference EVENEMENT = FirebaseFirestore.instance.collection('evenement');
  final CollectionReference IMAGES = FirebaseFirestore.instance.collection('images');
  final CollectionReference MEMEBRES_COTISATION = FirebaseFirestore.instance.collection('mcotisation');
  //final CollectionReference MEMEBRES = FirebaseFirestore.instance.collection('membres');
  final CollectionReference SERVICES = FirebaseFirestore.instance.collection('services');

  final String MEMEBRES = "membres";
  final String SERVICEPARAMCOTISATION = "spcotisation";
  final String CATEGORIEMCOTISATION = "categoriecotisation";
  final String MEMBREDANSCATEGORIE = "mdanscategoriecotisation";
  final String MONTANTCATEGORIEMCOTISATION = "montantcategoriecotisation";
  final String MEMBRECOTISATION = "membrecotisation";

  final String userprofile="userprofile/";
  final String imagesdescription="imagesdescription/";
  final String serviceprofile="serviceprofile/";

  // gestion des menus

  final CollectionReference SYSMENUS = FirebaseFirestore.instance.collection('menus');
  final CollectionReference SYSSMENUS = FirebaseFirestore.instance.collection('Smenus');
  final CollectionReference SYSACTIONS = FirebaseFirestore.instance.collection('actions');
  final CollectionReference SYSPROFILS = FirebaseFirestore.instance.collection('profils');

  /**
   *  function to create subCollection
   */

  createSubCollection(CollectionReference reference,String scode,String collectionsName)async{
    return reference.doc(scode).collection(collectionsName);

  }


/************************************************/
//final AggregateQuerySnapshot querySnapshot= await COTISATIONS.count().get();
}