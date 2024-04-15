
class Partenaire{

  String id_partenaire='';
  String id_zone='';
  String libelle='';
  String telephone='';
  String type_partenaire='';
  String password='';
  Partenaire.empty();

  Partenaire(this.id_partenaire,this.id_zone,this.libelle,this.telephone,this.type_partenaire,this.password);

  json(){
    return {
      "id_partenaire":this.id_partenaire,
      "id_zone":this.id_zone,
      "libelle":this.libelle,
      "telephone":this.telephone,
      "type_partenaire":this.type_partenaire,
      "password":this.password,
    };
  }

  Partenaire.fromMap(dynamic json) {
    id_partenaire=json["id_partenaire"];
    id_zone=json["id_zone"];
    libelle=json["libelle"];
    telephone=json["telephone"];
    type_partenaire=json["type_partenaire"];
    password=json["password"];
  }

  @override
  String toString() {
    return '{"id_partenaire":"$id_partenaire","id_zone":"$id_zone","libelle":"$libelle","telephone":"$telephone","type_partenaire":"$type_partenaire","password":"$password"}';
  }
}