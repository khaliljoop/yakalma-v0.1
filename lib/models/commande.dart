import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Commande{
  String id_commande='';
  String id_plat='';
  String id_partenaire='';
  int etat =0;
  String date_commande=DateFormat("yyyy-MM-dd").format(DateTime.parse(DateTime.now().toString()));
  Commande.empty();

  Commande(this.id_commande,this.id_plat,this.id_partenaire,this.etat,this.date_commande);

  json(){
    return {
      "id_commande":this.id_commande,
      "id_plat":this.id_plat,
      "id_partenaire":this.id_partenaire,
      "etat":this.etat,
      "date_commande":this.date_commande
    };
  }

  Commande.fromMap(dynamic json){
    id_commande=json["id_commande"];
    id_plat=json["id_plat"];
    id_partenaire=json["id_partenaire"];
    etat=json["etat"];
    date_commande=json["date_commande"];
  }

factory Commande.fromFirestore(
DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
) {
final data = snapshot.data();
return Commande(
     data?["id_commande"],
     data?["id_plat"],
     data?["id_partenaire"],
     data?["id_partenaire"],
     data?["date_commande"],
);
}

Map<String, dynamic> toFirestore() {
  return json();
}

}