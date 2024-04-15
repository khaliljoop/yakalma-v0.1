import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart' as path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:yakalma/global/constantes.dart';

import '../global/fonctions.dart';
import '../models/partenaire.dart';
import '../models/partenaireStatistiques.dart';
import '../models/plat.dart';


class FirebaseService{
  Collections collections=Collections();
  Fonctions fonctions=Fonctions();
  FirebaseAuth auth=FirebaseAuth.instance;
  Future<int> saveToCollection(CollectionReference collectionReference,var entity,String documendID)async{
    int res=0;
    await collectionReference.doc(documendID).set(entity.json()).then((v){
      res=1;
    }).onError((error, stackTrace){
      res=0;
    });
    return res;
  }
  Future<int> deleteToCollection(CollectionReference collectionReference,String documendID)async{
    int res=0;

    try {
      await collectionReference.doc(documendID).delete();
      res = 1;
    } catch (e) {
      res = -1;
    }
    return res;
  }

  Future<int> saveObjetList(CollectionReference collectionReference,List<dynamic> objectlist) async {
    int witness=0;
    int res=0;
    if(objectlist.isNotEmpty) {
      for (var object in objectlist) {
        res = await saveToCollection(collectionReference, object,object.key);
        if (res>0) {
          witness++;
        }
      }
    }
    return witness;
  }


  Future<String> upLoadimgFile(File file,String fullUrlimg) async {
    Reference ref = FirebaseStorage.instance.ref().child(fullUrlimg);
    UploadTask uploadTask = ref.putFile(file);
    TaskSnapshot task=await uploadTask;
    return task.ref.getDownloadURL();
  }
  Future<int> deleteFile(String url) async{
    Reference reference = FirebaseStorage.instance.refFromURL(url);
    int result = 0;
    try {
      await reference.delete();
      result = 1;
      print("delete Ok => ");
    } catch (e) {
      print("catch error : $e");
    }
    return result;
  }

  Future<void> deleteImage(String imageFileUrl) async {
    var fileUrl = Uri.decodeFull(path.basename(imageFileUrl)).replaceAll(RegExp(r'(\?alt).*'), '');


    final Reference firebaseStorageRef =
    FirebaseStorage.instance.ref().child(fileUrl);
    try {
      await firebaseStorageRef.delete();
      print("delete Ok => ");
    } catch (e) {
      print("catch error : $e");
    }
  }
  Future<List<String>> upLoadimgListFile(List<File> files,String fullUrlimg) async {
    List<String> list=[];
    int i=0;
    for(File file in files){
      Reference ref = FirebaseStorage.instance.ref().child("$fullUrlimg$i.jpg");
      UploadTask uploadTask = ref.putFile(file);
      TaskSnapshot task=await uploadTask;
      dynamic r = task.ref.getDownloadURL();
      list.add(r);
      i++;
    }
    return list;
  }


  /************ partenaire **********/
  Future<Partenaire?> getLogin(String login,String pwd) async {
    Partenaire partenaire=Partenaire.empty();
    await FirebaseFirestore.instance.collection('partenaires')
        .where("telephone",isEqualTo: login)
        .where("password",isEqualTo: pwd).get().then((value){
        if(value.docs.isNotEmpty){
        var pp=value.docs.map((e) => e.data()).first;
        partenaire.id_partenaire=pp['id_partenaire'];
        partenaire.id_zone=pp['id_zone'];
        partenaire.telephone=pp['telephone'];
        partenaire.password=pp['password'];
        partenaire.type_partenaire=pp['type_partenaire'];
        partenaire.libelle=pp['libelle'];
        Constantes.prefs.setString("partenaire", partenaire.toString());
        Constantes.prefs.setString("idpartenaire", pp['id_partenaire']);
      }
      else{
        print("empty obj:${value.metadata}");
      }
    }).catchError((onError){

    });
    return partenaire;
  }

  // sign out
  Future signOut() async {
    try {
      return await auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  /**
     * Les plats
     */

  Future<List<Plat>> getPlats() async {
    List<Plat> lsites=[];
    QuerySnapshot<Object?> plats;
    try{
      plats=await collections.PLATS.get();
      print("liste de plats : $plats");
      lsites = plats.docs.isNotEmpty ? plats.docs.map((d) => Plat.fromMap(d.data())).toList():[];
    }
    catch(e){
      print("catch error :$e");
      lsites=[];
    }

    return lsites;
  }

  Future<Plat> getPlatBycode(String scode) async {
    var service=await collections.PLATS.doc(scode).get();
    return service.exists ? Plat.fromMap(service.data()) :Plat.empty();
  }

  /********************* Commandes ***********************/

  Future<Plat> getPlatCommande(String id_plat) async {

    var plat=await collections.PLATS.where("id_plat",isEqualTo: id_plat)
        .where("date_plat",isEqualTo: fonctions.dateFormat(DateTime.now().toString())).get();
    return plat.docs.isNotEmpty ? plat.docs.map((e){
      return Plat.fromMap(e.data());
    }).first:Plat.empty();
  }


  /*********** Statistiques ******/
  Future<PartenaireStatistique> getStatistiqueByPartenaire(String id_partenaire,int annee) async {
    DocumentSnapshot<Map<String, dynamic>> qShot = await collections.STATISTIQUES.doc(id_partenaire).collection(id_partenaire).doc(annee.toString()).get();
    return qShot.exists ? PartenaireStatistique.fromMap(qShot.data()) : PartenaireStatistique.empty();
  }

  Future<int> updateUserProfile(String userprofile,String scode,String documendID)async{
    int res=0;
    await collections.SERVICES.doc(scode).collection(collections.MEMEBRES).doc(documendID).set({
      "userProfile":userprofile
    }).then((v){
      res=1;
    }).onError((error, stackTrace){
      res=0;
    });
    return res;
  }

  /**
  Future<MembreEntity> getMembreById(String mid,String scode) async {
    var membre=await collections.SERVICES.doc(scode).collection(collections.MEMEBRES).doc(mid).get();
    return membre.exists ? MembreEntity.fromMap(membre.data()) :MembreEntity.empty();//service.ge.map((d) => Plat.fromMap(d.data())).toList():[];
  }

  ************ param cotiosation *****************

  Future<List<ServiceParamCotisation>> getServiceParamCotisation(String scode) async {
    List<ServiceParamCotisation> spcotisations=[];
    QuerySnapshot<Object?> mbres;
    try{
      mbres=await collections.SERVICES.doc(scode).collection(collections.SERVICEPARAMCOTISATION).get();
      spcotisations = mbres.docs.isNotEmpty ? mbres.docs.map((d) => ServiceParamCotisation.fromMap(d.data())).toList():[];
    }
    catch(e){
      print("res catch $e");
      spcotisations=[];
    }

    return spcotisations;
  }
  Future<ServiceParamCotisation> getServiceParamCotisationById(String mid,String scode) async {
    var membre=await collections.SERVICES.doc(scode).collection(collections.SERVICEPARAMCOTISATION).doc(mid).get();
    return membre.exists ? ServiceParamCotisation.fromMap(membre.data()) :ServiceParamCotisation.empty();//service.ge.map((d) => Plat.fromMap(d.data())).toList():[];
  }
  Future<List<ServiceMontantCotisationParCategorie>> getMontantCategorieCotisation(String scode,
      {int annee = 0, String where = ''}) async {
    List<ServiceMontantCotisationParCategorie> spcotisations=[];
    QuerySnapshot<Object?> mbres;
    try{
      if(where !=""){
        mbres=await collections.SERVICES.doc(scode).collection(collections.MONTANTCATEGORIEMCOTISATION).where("annee",isEqualTo: annee==0?DateTime.now().year:annee)
            .where("paramtypecotisation",isEqualTo: where).get();
      }
      else{
        mbres=await collections.SERVICES.doc(scode).collection(collections.MONTANTCATEGORIEMCOTISATION).where("annee",isEqualTo: annee==0?DateTime.now().year:annee)
            .get();
      }
      print("try spcotisation : $mbres");
      spcotisations = mbres.docs.isNotEmpty ? mbres.docs.map((d) => ServiceMontantCotisationParCategorie.fromMap(d.data())).toList():[];
    }
    catch(e){
      print("catch message : $e");
      spcotisations=[];
    }


    return spcotisations;
  }
  Future<CategorieMembreCotisation> getCategorieMCotisationByMid(String mid,String scode) async {
    var membre=await collections.SERVICES.doc(scode).collection(collections.CATEGORIEMCOTISATION).doc(mid).get();
    return membre.exists ? CategorieMembreCotisation.fromMap(membre.data()) :CategorieMembreCotisation.empty();//service.ge.map((d) => Plat.fromMap(d.data())).toList():[];
  }
  Future<List<CategorieMembreCotisation>> getCategorieMCotisation(String scode) async {
    List<CategorieMembreCotisation> spcotisations=[];
    QuerySnapshot<Object?> mbres;
    try{
      mbres=await collections.SERVICES.doc(scode).collection(collections.CATEGORIEMCOTISATION).get();
      spcotisations = mbres.docs.isNotEmpty ? mbres.docs.map((d) => CategorieMembreCotisation.fromMap(d.data())).toList():[];
    }
    catch(e){
      spcotisations=[];
    }

    return spcotisations;
  }

  Future<CategorieMembreCotisation> getCategorieMCotisationById(String id,String scode) async {
    var membre=await collections.SERVICES.doc(scode).collection(collections.CATEGORIEMCOTISATION).doc(id).get();
    return membre.exists ? CategorieMembreCotisation.fromMap(membre.data()) :CategorieMembreCotisation.empty();//service.ge.map((d) => Plat.fromMap(d.data())).toList():[];
  }

  ************************* cotisation membre ***************************

  Future<List<MembreServiceCotisationEntity>> getMembreServiceCotisation(String scode,String mid,String codeparam) async {
    List<MembreServiceCotisationEntity> spcotisations=[];
    QuerySnapshot<Object?> mbres;
    try{
      mbres=await collections.SERVICES.doc(scode).collection(collections.MEMEBRES).doc(mid).collection(codeparam).get();
      spcotisations = mbres.docs.isNotEmpty ? mbres.docs.map((d) => MembreServiceCotisationEntity.fromMap(d.data())).toList():[];
    }
    catch(e){
      spcotisations=[];
    }

    return spcotisations;
  }
  */







}