
class Plat{
  String id_plat='';
  String categorie='';
  String id_partenaire='';
  int etat = 0;
  String date_plat=DateTime.now().toString();
  String heureDebut='';
  String heureFin='';
  String description='';
  String photoUrl='';
  double lat =0;
  double lng =0;
  Plat.empty();

  Plat(
      this.id_plat,this.categorie,this.id_partenaire,
      this.etat,this.date_plat,this.heureDebut,this.heureFin,
      this.description,this.photoUrl,{this.lat=0,this.lng=0});

  json(){
    return {
      "id_plat":id_plat,
      "categorie":categorie,
      "id_partenaire":id_partenaire,
      "etat":etat,
      "date_plat":date_plat,
      "heureDebut":heureDebut,
      "heureFin":heureFin,
      "description":description,
      "photoUrl":photoUrl,
      "lat":lat,
      "lng":lng,
    };
  }

  Plat.fromMap(dynamic json){
    id_plat=json["id_plat"];
    categorie=json["categorie"];
    id_partenaire=json["id_partenaire"];
    etat=json["etat"];
    date_plat=json["date_plat"];
    heureDebut=json["heureDebut"];
    heureFin=json["heureFin"];
    description=json["description"];
    photoUrl=json["photoUrl"];
    lat=json["lat"];
    lng=json["lng"];
  }

/**factory Plat.fromFirestore(
DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
) {
final data = snapshot.data();
return Plat(
     data?["id_plat"],
     data?["categorie"],
     data?["id_partenaire"],
     data?["etat"],
     data?["date_plat"],
     data?["heureDebut"],
     data?["heureFin"],
     data?["description"],
     data?["photoUrl"],
    {data["lat"], data?["lng"]});
}*/

Map<String, dynamic> toFirestore() {
  return json();
}

  @override
  String toString() {
    return '{"id_plate":"$id_plat","id_partenaire":"$id_partenaire","categorie":"$categorie","etat":$etat,"date_plat":"$date_plat","heureDebut":"$heureDebut","heureFin":"$heureFin","description":"$description","photoUrl":"$photoUrl","lat":$lat,"lng":$lng}';
  }

}

class Categorie{
  String id_categorie="";
  String libelle="";

}