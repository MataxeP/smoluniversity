// ignore_for_file: constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({super.key});

  @override
  State<MapsPage> createState() => _MapsPageState();
}

const SmolGU = LatLng(54.784302, 32.046221);

class _MapsPageState extends State<MapsPage> {
  GoogleMapController? mapController;
  final Set<Marker> _markers = {};
  late BitmapDescriptor sourceIcon;
  int? categorySelected = 1;
  double pinPillPosition = -220;
  String markerTitle = "СмолГУ";
  String markerDescription = "СмолГУ";
  String markerAdress = "улица Пржевальского, 4";
  String markerPicture = "assets/images/Spline.png";

  void showPinsOnMap() {
    setState(() {
      pinPillPosition = -220;
    });
    _markers.clear();
    if (categorySelected == 1) {
      mapController?.animateCamera(CameraUpdate.newCameraPosition(
          const CameraPosition(target: SmolGU, zoom: 16, tilt: 20)));
      _markers.add(Marker(
          markerId: const MarkerId('1corpus'),
          position: SmolGU,
          onTap: () {
            setState(() {
              pinPillPosition = 10;
              markerTitle = "1 корпус";
              markerDescription = "ФИД, ФИП, ЕГФ";
              markerAdress = "";
              markerPicture = "assets/images/1corpus.jpg";
            });
          }));
      _markers.add(Marker(
          markerId: const MarkerId('2corpus'),
          position: const LatLng(54.78530438527553, 32.04567006384271),
          onTap: () {
            setState(() {
              pinPillPosition = 10;
              markerTitle = "2 корпус";
              markerDescription = "ФМФ, ФФ, ФЭУ";
              markerAdress = "";
              markerPicture = "assets/images/2corpus.jpg";
            });
          }));
      _markers.add(Marker(
          markerId: const MarkerId('3corpus'),
          position: const LatLng(54.785905835157344, 32.04640498911278),
          onTap: () {
            setState(() {
              pinPillPosition = 10;
              markerTitle = "3 корпус";
              markerDescription = "ППФ, СФ";
              markerAdress = "";
              markerPicture = "assets/images/3corpus.jpg";
            });
          }));
      _markers.add(Marker(
          markerId: const MarkerId('hall'),
          position: const LatLng(54.784670, 32.044847),
          onTap: () {
            setState(() {
              pinPillPosition = 10;
              markerTitle = "Холл";
              markerDescription = "Место силы";
              markerAdress = "";
              markerPicture = "assets/images/hall.jpg";
            });
          }));
      _markers.add(Marker(
          markerId: const MarkerId('foc'),
          position: const LatLng(54.785298, 32.047376),
          onTap: () {
            setState(() {
              pinPillPosition = 10;
              markerTitle = "ФОК";
              markerDescription = "Место сильных";
              markerAdress = "";
              markerPicture = "assets/images/foc.jpg";
            });
          }));
      _markers.add(Marker(
          markerId: const MarkerId('library'),
          position: const LatLng(54.78497885452995, 32.04781583105461),
          onTap: () {
            setState(() {
              pinPillPosition = 10;
              markerTitle = "Библиотека";
              markerDescription = "Место умных";
              markerAdress = "";
              markerPicture = "assets/images/biblioteka.jpg";
            });
          }));
    } else if (categorySelected == 2) {
      mapController?.animateCamera(CameraUpdate.newCameraPosition(
          const CameraPosition(
              target: LatLng(54.77680166960749, 32.04194511471416),
              zoom: 14,
              tilt: 20)));
      _markers.add(Marker(
          markerId: const MarkerId('obsh1'),
          position: const LatLng(54.780849, 32.036932),
          onTap: () {
            setState(() {
              pinPillPosition = 10;
              markerTitle = "Общежитие №1";
              markerDescription = "";
              markerAdress = "улица Дзержинского, 23/1";
              markerPicture = "assets/images/obsh1.jpg";
            });
          }));
      _markers.add(Marker(
          markerId: const MarkerId('obsh2'),
          position: const LatLng(54.774602, 32.051710),
          onTap: () {
            setState(() {
              pinPillPosition = 10;
              markerTitle = "Общежитие №2";
              markerDescription = "";
              markerAdress = "улица Урицкого, 13";
              markerPicture = "assets/images/obsh3.jpg";
            });
          }));
      _markers.add(Marker(
          markerId: const MarkerId('obsh3'),
          position: const LatLng(54.769549, 32.035019),
          onTap: () {
            setState(() {
              pinPillPosition = 10;
              markerTitle = "Общежитие №3";
              markerDescription = "";
              markerAdress = "улица Кирова, 27";
              markerPicture = "assets/images/obsh3.jpg";
            });
          }));
      _markers.add(Marker(
          markerId: const MarkerId('obsh4'),
          position: const LatLng(54.78551830404657, 32.04823962007898),
          onTap: () {
            setState(() {
              pinPillPosition = 10;
              markerTitle = "Общежитие №4";
              markerDescription = "";
              markerAdress = "ул. Пржевальского, 2А";
              markerPicture = "assets/images/obsh4.jpg";
            });
          }));
    } else if (categorySelected == 3) {
      mapController?.animateCamera(CameraUpdate.newCameraPosition(
          const CameraPosition(
              target: LatLng(54.78161403319646, 32.04632247982647),
              zoom: 15,
              tilt: 20)));
      _markers.add(Marker(
          markerId: const MarkerId('hlmn'),
          position: const LatLng(54.784175042225314, 32.04369258030188),
          onTap: () {
            setState(() {
              pinPillPosition = 10;
              markerTitle = "Хлебная мануфактура";
              markerDescription = "и Andersøn";
              markerAdress = "улица Пржевальского, 6/25";
              markerPicture = "assets/images/hlmn.jpg";
            });
          }));
      _markers.add(Marker(
          markerId: const MarkerId('kvartal'),
          position: const LatLng(54.78447711692806, 32.04374397823586),
          onTap: () {
            setState(() {
              pinPillPosition = 10;
              markerTitle = "Квартал";
              markerDescription = "Магазин";
              markerAdress = "улица Пржевальского, 6/25";
              markerPicture = "assets/images/hlmn.jpg";
            });
          }));
      _markers.add(Marker(
          markerId: const MarkerId('stolovaya'),
          position: const LatLng(54.784762347564424, 32.04532111713661),
          onTap: () {
            setState(() {
              pinPillPosition = 10;
              markerTitle = "Столовая СмолГУ";
              markerDescription = "Самая вкусная еда в городе";
              markerAdress = "";
              markerPicture = "assets/images/stolovaya.jpg";
            });
          }));
      _markers.add(Marker(
          markerId: const MarkerId('smolka'),
          position: const LatLng(54.78554052087124, 32.04363668987528),
          onTap: () {
            setState(() {
              pinPillPosition = 10;
              markerTitle = "Смолка";
              markerDescription = "Кафе";
              markerAdress = "ул. Ногина, 32Б";
              markerPicture = "assets/images/smolka.jpg";
            });
          }));
      _markers.add(Marker(
          markerId: const MarkerId('marusya'),
          position: const LatLng(54.78430048883029, 32.047657340919166),
          onTap: () {
            setState(() {
              pinPillPosition = 10;
              markerTitle = "Маруся";
              markerDescription = "Кафе";
              markerAdress = "ул. Пржевальского, 2";
              markerPicture = "assets/images/marusya.jpg";
            });
          }));
      _markers.add(Marker(
          markerId: const MarkerId('russkiy_dvor'),
          position: const LatLng(54.781396035565145, 32.04506306296856),
          onTap: () {
            setState(() {
              pinPillPosition = 10;
              markerTitle = "Русский двор";
              markerDescription = "Кафе";
              markerAdress = "ул. Октябрьской Революции, 1Б";
              markerPicture = "assets/images/russkiy.jpg";
            });
          }));
      _markers.add(Marker(
          markerId: const MarkerId('diksi'),
          position: const LatLng(54.77840571694671, 32.04377157196967),
          onTap: () {
            setState(() {
              pinPillPosition = 10;
              markerTitle = "Дикси";
              markerDescription = "Магазин";
              markerAdress = "ул. Октябрьской Революции, 12";
              markerPicture = "assets/images/diksi.jpg";
            });
          }));
      _markers.add(Marker(
          markerId: const MarkerId('surf'),
          position: const LatLng(54.78231999817476, 32.0492687667039),
          onTap: () {
            setState(() {
              pinPillPosition = 10;
              markerTitle = "Surf Coffee";
              markerDescription = "Кофейня";
              markerAdress = "ул. Ленина, 6";
              markerPicture = "assets/images/surf.jpg";
            });
          }));
    } else if (categorySelected == 4) {
      mapController?.animateCamera(CameraUpdate.newCameraPosition(
          const CameraPosition(
              target: LatLng(54.783861873036116, 32.04778284522215),
              zoom: 17,
              tilt: 20)));
      _markers.add(Marker(
          markerId: const MarkerId('kvc'),
          position: const LatLng(54.783861873036116, 32.04778284522215),
          onTap: () {
            setState(() {
              pinPillPosition = 10;
              markerTitle = "КВЦ им Тенишевых";
              markerDescription = "";
              markerAdress = "ул. Пржевальского, 3";
              markerPicture = "assets/images/kvc.jpg";
            });
          }));
      _markers.add(Marker(
          markerId: const MarkerId('teatr'),
          position: const LatLng(54.783243, 32.046706),
          onTap: () {
            setState(() {
              pinPillPosition = 10;
              markerTitle = "Театр им Грибоедова";
              markerDescription = "";
              markerAdress = "площадь Ленина, 4";
              markerPicture = "assets/images/teatr.jpg";
            });
          }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      GoogleMap(
          compassEnabled: false,
          mapToolbarEnabled: false,
          myLocationButtonEnabled: false,
          onMapCreated: (GoogleMapController controller) {
            DefaultAssetBundle.of(context)
                .loadString("assets/map_style.json")
                .then((value) => {controller.setMapStyle(value)});
            mapController = controller;
            showPinsOnMap();
          },
          onTap: (LatLng loc) {
            setState(() {
              pinPillPosition = -220;
            });
          },
          markers: _markers,
          initialCameraPosition:
              const CameraPosition(target: SmolGU, zoom: 17, tilt: 20)),
      Positioned(
        bottom: 0,
        right: 0,
        left: 0,
        height: MediaQuery.of(context).size.height * 0.14,
        child: Container(
          color: Theme.of(context).colorScheme.background,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 30.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          categorySelected = 1;
                          showPinsOnMap();
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                            color: categorySelected == 1
                                ? Theme.of(context).colorScheme.secondary
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(CupertinoIcons.building_2_fill,
                                color: Theme.of(context).colorScheme.primary,
                                size: 32),
                            const SizedBox(height: 5),
                            const Text("Корпуса",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500))
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 30.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          categorySelected = 2;
                          showPinsOnMap();
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                            color: categorySelected == 2
                                ? Theme.of(context).colorScheme.secondary
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(CupertinoIcons.house_fill,
                                color: Theme.of(context).colorScheme.primary,
                                size: 32),
                            const SizedBox(height: 5),
                            const Text("Общежития",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500))
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 30.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          categorySelected = 3;
                          showPinsOnMap();
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        decoration: BoxDecoration(
                            color: categorySelected == 3
                                ? Theme.of(context).colorScheme.secondary
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.restaurant,
                                color: Theme.of(context).colorScheme.primary,
                                size: 32),
                            const SizedBox(height: 5),
                            const Text("Еда",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500))
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        categorySelected = 4;
                        showPinsOnMap();
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                          color: categorySelected == 4
                              ? Theme.of(context).colorScheme.secondary
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(CupertinoIcons.music_note,
                              color: Theme.of(context).colorScheme.primary,
                              size: 32),
                          const SizedBox(height: 5),
                          const Text("Развлечения",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      AnimatedPositioned(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        top: pinPillPosition,
        left: 0,
        right: 0,
        child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background ==
                      Colors.black.withOpacity(0.65)
                  ? Colors.grey.shade800
                  : Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.2),
                    blurRadius: 10,
                    offset: Offset.zero)
              ]),
          child: Column(
            children: [
              Container(
                color: Theme.of(context).colorScheme.background ==
                        Colors.black.withOpacity(0.65)
                    ? Colors.grey.shade800
                    : Theme.of(context).colorScheme.background,
                child: Row(
                  children: [
                    Stack(
                      children: [
                        ClipOval(
                          child: Image.asset(markerPicture,
                              width: 60, height: 60, fit: BoxFit.cover),
                        )
                      ],
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(markerTitle,
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold, fontSize: 15)),
                          Text(markerDescription),
                          Text(markerAdress,
                              style: GoogleFonts.montserrat(fontSize: 12)),
                        ],
                      ),
                    ),
                    const Icon(Icons.location_pin, color: Colors.red, size: 50)
                  ],
                ),
              )
            ],
          ),
        ),
      )
    ]));
  }
}
