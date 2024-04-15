class PartenaireStatistique {
 
  String id_partenaireStatistique='';
  int total = 0;
  int recupere =0;
  PartenaireStatistique.empty();
  PartenaireStatistique(
      this.id_partenaireStatistique,this.total,this.recupere);

  json(){
    return {
      "id_partenaireStatistique":id_partenaireStatistique,
      "total":total,
      "recupere":recupere
    };
  }

  PartenaireStatistique.fromMap(dynamic json){
    id_partenaireStatistique=json["id_partenaireStatistique"];
    total=json["total"];
    recupere=json["recupere"];
  }
  Map<String, dynamic> toFirestore() {
    return json();
  }

  @override
  String toString() {
    return '{"id_partenaireStatistiquee":"$id_partenaireStatistique","total":$total,"recupere":$recupere}';
  }

}