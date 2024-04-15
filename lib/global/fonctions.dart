import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:ndialog/ndialog.dart';
import 'package:yakalma/global/constantes.dart';
import 'package:yakalma/models/partenaire.dart';
import 'package:yakalma/models/plat.dart';
import 'package:yakalma/services/firebaseService.dart';
import '../models/partenaireStatistiques.dart';

/**
    import '../screens/userPostes.dart';
    import 'package:yakalma/screens/background.dart';
    import 'package:yakalma/screens/login_screen/login_screen.dart';
    import 'package:yakalma/screens/userCommande.dart';

    */


class Fonctions {
  late ProgressDialog progressDialog;
  Constantes constantes = Constantes();
  FirebaseService firebaseService=FirebaseService();
  Collections collections=Collections();
  //CustomBackgroundColor bg=CustomBackgroundColor();
  ValueNotifier<bool> textChange = ValueNotifier(false);
  ValueNotifier<String> typeChange = ValueNotifier("restaurant");
  final spaceBetweenTextFormField = const SizedBox(height: 30);
  static final ValueNotifier<bool> _isPasswordVisible = ValueNotifier(true);
  static final ValueNotifier<bool> _isPasswordVisible2 = ValueNotifier(true);
  dateFormat(String date) => DateFormat('yyyy-MM-dd').format(DateTime.parse(date));
  //dateFormat(String date)=>DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.parse(date));
  dateFormatFR(String date) =>DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.parse(date));
  //String s="";
  //TimeOfDay _startTime = TimeOfDay(hour:int.parse(s.split(":")[0]),minute: int.parse(s.split(":")[1]));
  final ValueNotifier<bool> profil = ValueNotifier(false);
  final ValueNotifier<bool> refresh = ValueNotifier(false);
  final ImagePicker _picker = ImagePicker();
  File imageFile = File("");
  XFile? pickedFile;
  String url = "";
  final GlobalKey<FormState> _formSignInKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Location localisation=Location();
  static PartenaireStatistique partenaireStatistique=PartenaireStatistique.empty();
  decoContainer({required Widget child}){
    return Container(
      margin:const EdgeInsets.only(left: 10,right: 10),
      decoration:  const BoxDecoration(
        color: Colors.white38,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(40.0),
            bottomRight: Radius.circular(40.0),
            topLeft: Radius.circular(40.0),
            bottomLeft: Radius.circular(40.0)),
      ),
      child: child,
    );
  }

  signIn() {
    Partenaire p = Partenaire.empty();
    return Builder(builder: (context) {
      return Form(
        key: _formSignInKey,
          child: SingleChildScrollView(
        child: decoContainer(
            child: Column(
              children: [
                const Text("Type",
                  style: TextStyle(
                    fontSize: 15
                  ),
                ),
                const SizedBox(height: 5,),
                ValueListenableBuilder(
                    valueListenable: typeChange,
                    builder: (BuildContext context, value, Widget? child) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 36, vertical: 0),
                        child: SizedBox(
                          height: 120,
                          child: Material(
                            elevation: 8,
                            shadowColor: Colors.black87,
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(30),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.white,
                              ),
                              child: Column(
                                children: [
                                  RadioListTile<String>(
                                    title: const Text('Restaurant'),
                                    value: 'restaurant',
                                    groupValue: typeChange.value,
                                    onChanged: (value) {
                                      typeChange.value = value.toString();
                                    },
                                  ),
                                  RadioListTile<String>(
                                    title: const Text('Particulier'),
                                    value: 'personne',
                                    groupValue: typeChange.value,
                                    onChanged: (value) {
                                      typeChange.value = value.toString();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                ValueListenableBuilder(
                    valueListenable: textChange,
                    builder: (BuildContext context, value, Widget? child) {
                      return Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 36, vertical: 8),
                        child: SizedBox(
                          height: 50,
                          child: Material(
                            elevation: 8,
                            shadowColor: Colors.black87,
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(30),
                            child: TextFormField(
                              textAlignVertical: TextAlignVertical.bottom,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                labelText: 'Votre nom',
                                hintText: 'Votre nom',
                                prefixIcon: const Icon(Icons.person),
                              ),
                              keyboardType: TextInputType.text,
                              onChanged: (v) {
                                p.libelle = v;
                                textChange.value = !textChange.value;
                              },
                              validator: (value){
                                if((value==null) || (value.isEmpty)){
                                  return "Veuillez saisir un nom complet";
                                }
                                  return null;
                              },
                            ),
                          ),
                        ),
                      );
                    }),
                ValueListenableBuilder(
                    valueListenable: textChange,
                    builder: (BuildContext context, value, Widget? child) {
                      return Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 36, vertical: 8),
                        child: SizedBox(
                          height: 50,
                          child: Material(
                            elevation: 8,
                            shadowColor: Colors.black87,
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(30),
                            child: TextFormField(
                              textAlignVertical: TextAlignVertical.bottom,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                labelText: 'Votre numero de telephone',
                                hintText: 'Votre numero de telephone',
                                prefixIcon: const Icon(Icons.phone),
                              ),
                              keyboardType: TextInputType.phone,
                              onChanged: (v) {
                                p.telephone = v;
                                textChange.value = !textChange.value;
                              },
                              validator: (value){
                                if((value==null) || (value.isEmpty)){
                                  return "Veuillez saisir un numéro de telephone";
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      );
                    }),
                ValueListenableBuilder(
                  valueListenable: _isPasswordVisible,
                  builder: (BuildContext context, value, Widget? child) {
                    return Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 36, vertical: 8),
                      child: SizedBox(
                        height: 50,
                        child: Material(
                          elevation: 8,
                          shadowColor: Colors.black87,
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(30),
                          child: TextFormField(
                            textAlignVertical: TextAlignVertical.bottom,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                hintText: "password",
                                labelText: "Password",
                                prefixIcon: const Icon(Icons.lock),
                                suffixIcon: IconButton(
                                  icon: Icon(_isPasswordVisible.value
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                  onPressed: () {
                                    _isPasswordVisible.value =
                                    !_isPasswordVisible.value;
                                  },
                                )),
                            obscureText: !_isPasswordVisible.value,
                            keyboardType: TextInputType.text,
                            onChanged: (v) {
                              p.password = v;
                            },
                            validator: (value){
                              if((value==null) || (value.isEmpty)){
                                return "Veuillez saisir un mot de passe";
                              }
                              else if(value.length<6){
                                return "Le mot de passe doit comporter au moins 6 caracteres";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
                ValueListenableBuilder(
                  valueListenable: _isPasswordVisible2,
                  builder: (BuildContext context, value, Widget? child) {
                    ValueNotifier<String>confirmPass=ValueNotifier("");
                    return Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 36, vertical: 8),
                      child: SizedBox(
                        height: 50,
                        child: Material(
                          elevation: 8,
                          shadowColor: Colors.black87,
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(30),
                          child: ValueListenableBuilder(
                            valueListenable: confirmPass,
                            builder: (BuildContext context, String value, Widget? child) {
                              return TextFormField(
                                textAlignVertical: TextAlignVertical.bottom,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide.none,
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: "confirmation password",
                                    label: const Text("Confirmation Password"),
                                    prefixIcon: const Icon(Icons.lock),
                                    suffixIcon: IconButton(
                                      icon: Icon(_isPasswordVisible2.value
                                          ? Icons.visibility_off
                                          : Icons.visibility),
                                      onPressed: () {
                                        _isPasswordVisible2.value =
                                        !_isPasswordVisible2.value;
                                      },
                                    )),
                                obscureText: !_isPasswordVisible2.value,
                                keyboardType: TextInputType.text,
                                onChanged: (v) {
                                  print("pwd:${p.password}=>confirm:${confirmPass.value}");
                                  confirmPass.value=v;
                                },
                                validator: (value){
                                  if((value==null) || (value.isEmpty)){
                                    return "Veuillez confirmer votre mot de passe";
                                  }
                                  else if(p.password !=confirmPass.value){
                                    return "Les deux mots de passe ne correspondent pas";
                                  }

                                  return null;
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
                spaceBetweenTextFormField,
                SizedBox(
                  height: 45,
                  width: MediaQuery.of(context).size.width*0.6,
                  child: FloatingActionButton.extended(
                    heroTag: "signIn",
                    onPressed: () async {
                      if(_formSignInKey.currentState!.validate()){
                      p.id_partenaire = constantes.genKey();
                      p.id_zone = constantes.genKey();
                      p.type_partenaire = typeChange.value;
                      int v=await firebaseService.saveToCollection(collections.PLATS,p,p.id_partenaire);
                      //int v=await ps.saveToCollection(ps.partenaires,p,p.id_partenaire);
                      if(v==1){
                        if(context.mounted) {
                          ShowDialogs.notifier(context, 2, "Inscription reussie",backgroundColor: Colors.green);
                          //Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>const LoginScreen()));
                        }
                      }
                      else
                      {
                        if(context.mounted) {
                          ShowDialogs.notifier(context, 3, "Une erreur est survenue ",backgroundColor: Colors.redAccent);
                        }

                      }}
                    },
                    label: const Text("S'inscrire"),
                    //backgroundColor: Colors.grey,
                    icon: const Icon(Icons.person_add_alt_1),
                    //extendedIconLabelSpacing: 100,
                    //isExtended: false,
                  ),
                ),
                spaceBetweenTextFormField
              ],
            ),
        ),
      ));
    });
  }
  myDrawer(GlobalKey<ScaffoldState>scaffoldKey ){

    return Builder(
      builder: (context) {
        return Drawer(
          key: scaffoldKey,
          backgroundColor:const Color.fromRGBO(241, 246, 249,4),
          width: MediaQuery.of(context).size.width,
          child:SingleChildScrollView(
            child:ValueListenableBuilder(
              valueListenable:constantes.isconnected,
              builder: (BuildContext context, value, Widget? child) {
                String value=Constantes.prefs.getString("partenaire")??"";
                Partenaire partenaire =value==""?Partenaire.empty():Partenaire.fromMap(jsonDecode(value));
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DrawerHeader(
                        decoration:const BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                                  Colors.white,Colors.greenAccent,Colors.blueAccent
                                ]
                            )
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(
                              height: 100,
                              width: 100,
                              child: ClipOval(
                                child: Icon(Icons.face,size: 120,),
                              ),
                            ),
                            Text(partenaire.libelle),
                            IconButton(
                                onPressed: (){

                                  //scaffoldKey.currentState?.closeDrawer();
                                  //Scaffold.of(context).closeDrawer();
                                  Navigator.of(context).pop();

                                },
                                icon: const  Icon(Icons.cancel_outlined,color: Colors.white,)),
                          ],
                        )
                    ),
                    Container(
                        margin:const EdgeInsets.only(left: 25),
                        child: const Text("mon compte")
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      margin:const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            width: 5,
                            color: Colors.white70,
                          ),
                          // Make rounded corners
                          borderRadius: BorderRadius.circular(30)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          spaceBetweenTextFormField,
                          ListTile(
                            //leading: const Icon(Icons.featured_play_list_outlined),
                            leading: const Icon(Icons.person_outline_outlined),
                            title:const Text("Mon Profil"),
                            trailing:const Icon(Icons.navigate_next_rounded),
                            onTap:() async{
                            },
                          ),
                          spaceBetweenTextFormField,
                          ListTile(
                            //leading: const Icon(Icons.featured_play_list_outlined),
                            leading: const Icon(Icons.kitchen),
                            title:const Text("Mes postes"),
                            trailing:const Icon(Icons.navigate_next_rounded),
                            onTap:() async{
                              if(constantes.isLogin()) {
                                partenaireStatistique = await firebaseService.getStatistiqueByPartenaire(Constantes.prefs.getString("idpartenaire") ?? "", DateTime.now().year);
                                if(context.mounted)
                                {
                                  // Navigator.push(context,MaterialPageRoute(builder: (BuildContext context)=>const UserPostes()));

                                }
                              }
                              else
                                {
                                  goToLogin(context);
                                }


                            },
                          ),
                          spaceBetweenTextFormField,
                          ListTile(
                            //leading: const Icon(Icons.featured_play_list_outlined),
                            leading: const Icon(Icons.outdoor_grill),
                            title:const Text("Mes Commandes"),
                            trailing:const Icon(Icons.navigate_next_rounded),
                            onTap:() async{
                              if(context.mounted) {
                                //constantes.isLogin()? Navigator.push(context,MaterialPageRoute(builder: (BuildContext context)=>const UserCommande())):goToLogin(context);
                              }
                            },
                          ),
                          spaceBetweenTextFormField,
                          ListTile(
                            //leading: const Icon(Icons.featured_play_list_outlined),
                            leading: const Icon(Icons.power_settings_new_sharp),
                            title: Text(constantes.isLogin()? "Se déconnecter":"Se connecter"),
                            trailing:const Icon(Icons.navigate_next_rounded),
                            onTap: ()async {
                              if(constantes.isLogin()){
                                signOut(context);
                              }
                              else{
                                goToLogin(context);
                              }

                            },
                          ),
                          /**spaceBetweenTextFormField,
                          ListTile(
                            //leading: const Icon(Icons.featured_play_list_outlined),
                            leading: const Icon(Icons.location_on_outlined),
                            title: const Text("Maps"),
                            trailing:const Icon(Icons.navigate_next_rounded),
                            onTap: ()async {
                              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>const MapLocation()));

                            },
                          ),*/
                        ],
                      ),
                    ),
                  ],
                );
              },

            ),

          ),

        );
      }
    );
  }
  formAddPlat(BuildContext context,Plat p) {
    int initHour = DateTime.now().hour;
    ValueNotifier<TimeOfDay> heureDebut =
        ValueNotifier( p.heureDebut != "" ? getTimeOfDay(p.heureDebut) :TimeOfDay(hour: initHour, minute: 00));
    ValueNotifier<TimeOfDay> heureFin =
        ValueNotifier(p.heureFin != "" ? getTimeOfDay(p.heureFin) : TimeOfDay(hour: initHour + 1, minute: 00));
    String categorie = p.categorie =="" ? "mafe" : p.categorie;
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Wrap(
            //spacing: 15,
            alignment: WrapAlignment.center,
            children: [
              ValueListenableBuilder(
                valueListenable: profil,
                builder: (BuildContext context, value, Widget? child) {
                  return SizedBox(
                      //height: MediaQuery.of(context).size.height * 0.2,
                      child: imageFile.path == "" && p.photoUrl ==""
                          ? Row(
                              children: <Widget>[
                                TextButton.icon(
                                    onPressed: () async {
                                      getGallery();
                                    },
                                    icon: const Icon(Icons.image),
                                    label: const Text("gallerie")),
                                TextButton.icon(
                                    onPressed: () async {
                                      getCam();
                                    },
                                    icon: const Icon(Icons.camera_alt),
                                    label: const Text("camera")),
                              ],
                            )
                          : Column(
                              children: [
                                if(p.photoUrl=="")...[
                                  CircleAvatar(
                                    child: Image.file(
                                      imageFile,
                                      fit: BoxFit.fill,
                                      width: 140,
                                    ),
                                  ),
                                ]else...[
                                  ClipOval(
                                    //clipper: MyClip(),
                                    child: Image.network(
                                      p.photoUrl,
                                      fit: BoxFit.fill,
                                      width: 130,
                                      height: 130,
                                    ),
                                  ),
                                ],
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                        onPressed: () async {
                                          getGallery();
                                        },
                                        icon: const Icon(Icons.image)),
                                    IconButton(
                                      onPressed: () async {
                                        getCam();
                                      },
                                      icon: const Icon(Icons.camera_alt),
                                    ),
                                  ],
                                )
                              ],
                            ));
                },
              ),
              ValueListenableBuilder(
                valueListenable: heureDebut,
                builder: (BuildContext context, value, Widget? child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.timer_sharp),
                      const Text("Début"),
                      Text(heureDebut.value.format(context)),
                      IconButton(
                        icon: const Icon(Icons.edit_location_alt_outlined),
                        onPressed: () async {
                          final TimeOfDay? newTime = await showTimePicker(
                              context: context,
                              initialTime: heureDebut.value,
                              initialEntryMode: TimePickerEntryMode.dial);
                          heureDebut.value = newTime!;
                          heureFin.value=TimeOfDay(hour: newTime.hour+1,minute: DateTime.now().minute) ;
                        },
                      ),
                    ],
                  );
                },
              ),
              ValueListenableBuilder(
                valueListenable: heureFin,
                builder: (BuildContext context, value, Widget? child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.timer_sharp),
                      const Text("Début"),
                      Text(heureFin.value.format(context)),
                      IconButton(
                        icon: const Icon(Icons.edit_location_alt_outlined),
                        onPressed: () async {
                          final TimeOfDay? newTime = await showTimePicker(
                              context: context,
                              initialTime: heureFin.value,
                              initialEntryMode: TimePickerEntryMode.dial);
                          heureFin.value = newTime!;
                        },
                      ),
                    ],
                  );
                },
              ),
              spaceBetweenTextFormField,
              ListTile(
                leading: const Text("Catégorie"),
                title: ValueListenableBuilder(
                  valueListenable: textChange,
                  builder: (BuildContext context, value, Widget? child) {
                    return DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                      value: categorie,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: const [
                        DropdownMenuItem<String>(
                          value: 'pizza',
                          child: SizedBox(
                            child: Text("Pizza"),
                          ),
                        ),
                        DropdownMenuItem<String>(
                          value: 'mafe',
                          child: SizedBox(
                            child: Text("Mafe"),
                          ),
                        ),
                      ],
                      /**items: malistMenus.map((MenuEntity m) {
                                return DropdownMenuItem<String>(
                                  value: m.mid,
                                  child: SizedBox(
                                    child: Marquee(child: Text(m.mlibelle)),
                                  ),
                                );
                              }).toList(),*/
                      onChanged: (value) {
                        categorie = value!;
                        textChange.value = !textChange.value;
                      },
                    ));
                  },
                ),
              ),
              spaceBetweenTextFormField,
              ValueListenableBuilder(
                  valueListenable: textChange,
                  builder: (BuildContext context, value, Widget? child) {
                    return TextFormField(
                      maxLines: 5,
                      onChanged: (v) {
                        p.description = v;
                        textChange.value = !textChange.value;
                      },
                      validator: (value) {
                        // add email validation
                        if (value == null || value.isEmpty) {
                          return 'Veuillez saisir un texte';
                        }
                        return null;
                      },
                      initialValue: p.description,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        hintText: 'Description',
                        //prefixIcon: Icon(Icons.text_fields_rounded),
                        border: OutlineInputBorder(),
                      ),
                    );
                  }),
              spaceBetweenTextFormField,
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width*0.4,
                  child: FloatingActionButton.extended(
                    heroTag: "enregistrement",
                    onPressed: () async {

                      if ((heureFin.value.hour < heureDebut.value.hour) ||
                          ((heureFin.value.hour == heureDebut.value.hour) &&
                              (heureFin.value.minute <= heureDebut.value.hour))) {
                        showSnackBar(context, "L'heure de fin doit etre supérieure à l'heure de début");
                        //ScaffoldMessenger.of(context).showSnackBar(snackBar("L'heure de fin doit etre supérieure à l'heure de début"));
                      }else{
                          var indicator= ProgressDialog(
                            context,
                            dismissable:false,
                            title: const Text("En cours d'nregistrement"),
                            message: const Text("Veuillez patienter ..."),
                          );
                          if(imageFile.path == "" && p.photoUrl == ""){
                            await ShowDialogs.notifier(
                                context, 3, "Veuillez choisir une image",
                                backgroundColor: Colors.redAccent);
                          }
                          else{
                            indicator.show();
                            if(imageFile.path !=""){
                              p.photoUrl = await firebaseService.upLoadimgFile(imageFile,collections.STORAGE_CHILD);
                            }
                              p.id_partenaire = Constantes.prefs.getString("idpartenaire") ?? "";
                              p.id_plat = p.id_plat == "" ? constantes.genKey() :p.id_plat;
                              p.date_plat =DateFormat('yyyy-MM-dd').format(DateTime.parse(DateTime.now().toString()));// dateFormat(DateTime.now().toString());
                              p.etat = 0;
                              p.categorie = categorie;
                             if(context.mounted){
                               p.heureDebut = heureDebut.value.format(context);
                               p.heureFin = heureFin.value.format(context);
                             }
                              p.photoUrl = p.photoUrl;
                              LocationData latLng = await localisation.getLocation();
                              p.lat = latLng.latitude!;
                              p.lng = latLng.longitude!;
                              await firebaseService.saveToCollection(collections.PLATS, p, p.id_partenaire).then((result) async {
                                indicator.dismiss();
                                if (result == 1) {
                                  await ShowDialogs.notifier(
                                      context, 3, "Vous avez ajouter un plat",
                                      backgroundColor: Colors.green);
                                  if(context.mounted){
                                    Navigator.of(context).pop();
                                  }
                                } else {
                                  await ShowDialogs.notifier(context, 3, "Erreur ",
                                      backgroundColor: Colors.redAccent);
                                }
                              });
                          }
                      }
                    },
                    label: const Text("Enregistrer"),
                    //backgroundColor: Colors.grey,
                    icon: const Icon(Icons.save_outlined),
                    //extendedIconLabelSpacing: 100,
                    //isExtended: false,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  showSnackBar(BuildContext context,String title){
    var snackbar = SnackBar(
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.redAccent,
        content: Text(title)
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
  dialogShow(BuildContext context,{Widget? title,required Widget content,Widget ? function})async {
        return await showDialog<String>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return content;
          },
    );

  }
  goToLogin(BuildContext context){
      print("go to login");
      return dialogShow(context,
          content: AlertDialog(
            title: Marquee(
              child: const Text('Veuillez vous connecter'),),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                //icon: const Icon(Icons.cancel_outlined),
                child: const Text("fermer"),),
              TextButton.icon(
                onPressed: () async {
                  Navigator.of(context).pop();
                  // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>const LoginScreen()));

                  //@@ Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>const MyHomePage(title: "title")));
                },
                icon: const Icon(Icons.arrow_forward),
                label: const Text("Se connecter"),),
            ],
          ),
      );
  }
  waitingFor(BuildContext context,bool isShow,String title){
    var indicator= ProgressDialog(
        context,
        dismissable:false,

        title: Text(title),
        message: const Text("Veuillez patienter ..."),
    );
     if(isShow) {
      indicator.show();
    }
    else{
      indicator.dismiss();
    }
    /**Future.delayed(const Duration(seconds: 10)).then((value){
      indicator.dismiss();
    });*/
    return Container();
  }
  signOut(BuildContext context){
    var indicator= ProgressDialog(
        context,
        dismissable:false,

        //title: Text("D"),
        message: const Text("Déconnexion ..."),
    );
    indicator.show();
    Future.delayed(const Duration(seconds: 4)).then((value)async{
      await Constantes.prefs.remove("partenaire");
      await Constantes.prefs.remove("idpartenaire");
      constantes.isconnected.value=!constantes.isconnected.value;
      indicator.dismiss();
    });
    return Container();
  }
  getGallery() async {
    pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile = File(pickedFile!.path);
      profil.value = !profil.value;
    }
  }
  getCam() async {
    pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      imageFile = File(pickedFile!.path);
      profil.value = !profil.value;
    }
  }
  Widget wait() {
    return const Center(
      child: SpinKitFadingCircle(
        color: Colors.blue,
        size: 60,
      ),
    );
  }
  Future<String> urlFromFirebase(String endpoint) async {
    var ref = FirebaseStorage.instance.ref().child("plats/PF5R1TJB.png");
    String urlImg = "";
    ref.getDownloadURL().then((loc) {
      urlImg = loc;
      print("test path :$loc");
    }).catchError((onError) {
      urlImg = "";
    });
    print("urlImg:$urlImg");
    return urlImg;
  }
  TimeOfDay getTimeOfDay(String s) {
    //s="10:20";
    TimeOfDay startTime = TimeOfDay(
        hour: int.parse(s.split(":")[0]), minute: int.parse(s.split(":")[1])
    );
    return startTime;
  }



    int stayTime(int start, int end){
     int res = end-start;
     Timer.run( () {
       res = end-start;
     });
     return res;
    }
   deleteArchived() {
     Timer.periodic(const Duration(minutes: 4), (timer) async{
       if(DateTime.now().hour == 23 && DateTime.now().minute >= 55)
      {
        print(" timer ticker :${timer.tick}");
        //final CollectionReference PLATS = FirebaseFirestore.instance.collection.dart('plats');
        QuerySnapshot querySnapshot = await constantes.PLATS.where("date_plat",isEqualTo: dateFormat(DateTime.now().toString())).get();
        if(querySnapshot.docs.isNotEmpty)
        {
          for(QueryDocumentSnapshot d in querySnapshot.docs){
            try{
              Plat plat=Plat.fromMap(d.data());
              d.reference.delete();
              deleteFile(plat.photoUrl).then((res){
                if(res==1){
                  print("delete plat.photoUrl ");
                }
                else{
                  print("else delete plat.photoUrl ");
                }
              });

            }catch(e){
              print("catch error :$e");
            }
          }
        }
      }
      /**counter--;
      if (counter == 0) {
        print('Cancel timer');
        timer.cancel();
      }*/
    });
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

  getItemsFromDb(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data?.docs
        .map((doc){
        return Builder(
          builder: (context) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.2,
              margin:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
              decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFE0E0E0)),
                  borderRadius: BorderRadius.circular(8.0)),
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(doc["photoUrl"]),
                          ))),
                  const SizedBox(
                    width: 30,
                  ),
                  Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            doc["categorie"],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Text("Disponible \n de ${doc["heureDebut"]} à ${doc["heureFin"]}",
                              style: Theme.of(context).textTheme.bodySmall),
                          const SizedBox(height: 8),
                          Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  icon:const Icon(Icons.check_circle_outline,size: 30,color: Colors.lightBlueAccent,),
                                  onPressed: () {},
                                ),
                                //Icons.share,
                                //Icons.more_vert
                                const SizedBox(width: 30,),
                                SizedBox(
                                  height: 20,
                                  width: 70,
                                  child: FloatingActionButton.extended(
                                    heroTag: "validation",
                                    onPressed: ()async{
                                      await dialogShow(context,
                                          content: NDialog(
                                            dialogStyle: DialogStyle(
                                                titleDivider: true
                                            ),
                                            title: const Center(child: Text("Confirmation",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold
                                              ),
                                            )),
                                            content: Wrap(
                                              alignment: WrapAlignment.center,
                                              spacing: 20,
                                              children: [
                                                Container(
                                                    width: 130,
                                                    height: 130,
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey,
                                                        borderRadius: BorderRadius.circular(8.0),
                                                        image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: NetworkImage(doc["photoUrl"]),
                                                        ))),
                                                const Text("Veuillez confirmer votre commande"),
                                              ],
                                            ),
                                            actions: [
                                              TextButton.icon(
                                                  onPressed: (){
                                                    Navigator.of(context).pop();
                                                  },
                                                  icon: const Icon(Icons.cancel_outlined,color: Colors.redAccent,),
                                                  label: const Text("annuler")
                                              ),
                                              TextButton.icon(
                                                  onPressed: ()async{
                                                  },
                                                  icon: const Icon(Icons.check_circle_sharp,color: Colors.green,),
                                                  label: const Text("valier")
                                              ),
                                            ],
                                          )
                                      );

                                    },
                                    backgroundColor: Colors.greenAccent ,
                                    icon: const Icon(Icons.remove_red_eye),
                                    label: const Text("Plus"),
                                  ),
                                )
                              ]
                          )
                        ],
                      )),
                ],
              ),
            );
          }
        );
    }
      /**Column(
          children: [
          //fonctions.urlFromFirebase(doc["photoUrl"])==""?fonctions.wait():Image.network(fonctions.urlFromFirebase(doc["photoUrl"])),
          doc["photoUrl"]==null?fonctions.wait():Image.network(doc["photoUrl"]),
          ListTile(title:  Text(doc["photoUrl"].toString()), subtitle:  Text(doc["categorie"].toString())),
          ],
          )*/
    )
        .toList();
  }
}