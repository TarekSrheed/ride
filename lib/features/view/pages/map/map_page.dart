import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ride_app/core/config/secrets.dart';
import 'package:ride_app/core/res/app_string.dart';
import 'package:ride_app/core/res/app_style.dart';
import 'package:ride_app/features/view/pages/transport/avalible_cicle_list_page.dart';
import 'package:ride_app/features/view/provider/immutable_data.dart';
import 'package:ride_app/features/view/widget/button_widget.dart';
import 'package:ride_app/features/view/widget/container/show_snack_bar.dart';
import '../../../../core/res/app_color.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController mapController = MapController();
  final List<Marker> markers = [];
  Map<String, dynamic>? selectedLocation;
  Map<String, dynamic>? secondLocation;
  List<LatLng> routePoints = [];
  bool isBottomSheetVisible = false;
  bool isSelectingSecondLocation = false;
  late TextEditingController fromController;
  late TextEditingController toController;
  @override
  void initState() {
    super.initState();
    fromController = TextEditingController();
    toController = TextEditingController();
  }

  double calculateDistance(LatLng start, LatLng end) {
    final Distance distance = Distance();

    double meters = distance.as(LengthUnit.Meter, start, end);
    return meters / 1000;
  }

  double calculatePrice(double distanceInKm) {
    const double pricePerKm = 4000;
    return distanceInKm * pricePerKm;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Consumer(builder: (context, ref, _) {
            return ref.watch(hupsProvider).when(
              data: (data) {
                if (data.isEmpty) {
                  return const Center(child: Text('There is no hups'));
                } else {
                  markers.clear();
                  for (var i = 0; i < data.length; i++) {
                    markers.add(
                      Marker(
                        width: 70.0,
                        height: 70.0,
                        point:
                            LatLng(data[i]['latitude'], data[i]['longitude']),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              toController.clear();
                              if (selectedLocation == null) {
                                selectedLocation = data[i];
                                fromController.text =
                                    selectedLocation?['location_name'] ??
                                        'From';
                                isBottomSheetVisible = true;
                              } else {
                                secondLocation = data[i];
                                toController.text =
                                    secondLocation?['location_name'] ?? 'To';
                                isBottomSheetVisible = true;
                              }
                            });
                          },
                          child: const Icon(Icons.location_on,
                              color: Colors.red, size: 40.0),
                        ),
                      ),
                    );
                  }
                  return FlutterMap(
                    mapController: mapController,
                    options: MapOptions(
                      onTap: (tapPosition, point) {
                        setState(() {
                          secondLocation = null;
                          selectedLocation = null;
                          isBottomSheetVisible = false;
                        });
                      },
                      initialCenter: const LatLng(33.5093553, 36.2939167),
                      initialZoom: 15.0,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            "https://api.maptiler.com/maps/streets/{z}/{x}/{y}.png?key=${Secrets.mapKey}",
                        userAgentPackageName: 'com.example.app',
                      ),

                      // TileLayer(
                      //   urlTemplate:
                      //       "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                      // ),
                      MarkerLayer(
                        markers: markers,
                      ),
                      PolylineLayer(
                        polylines: [
                          Polyline(
                            points: routePoints,
                            strokeWidth: 4.0,
                            color: Colors.blue,
                          ),
                        ],
                      ),
                    ],
                  );
                }
              },
              error: (error, stackTrace) {
                return Center(
                  child: Text(
                    AppString().NOCONNECTON,
                    style: titleFavoStyle,
                  ),
                );
              },
              loading: () {
                return Center(
                    child: CircularProgressIndicator(
                  color: primaryColor,
                ));
              },
            );
          }),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            bottom: isBottomSheetVisible ? 25 : -300,
            left: 10,
            right: 10,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: iconDisplayColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: primaryColor),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10.0,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 50,
                      height: 5,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  newMethod(
                      controller: fromController,
                      onTap: () {},
                      icon: Icon(
                        Icons.my_location_outlined,
                        size: 20,
                        color: grayColor,
                      ),
                      hintText: 'From'),
                  const SizedBox(height: 15.0),
                  newMethod(
                      controller: toController,
                      onTap: () {
                        setState(() {
                          isBottomSheetVisible = false;
                          showTopSnackBar(
                              context,
                              'Please select the location you want to go',
                              primaryColor);
                        });
                      },
                      icon: Icon(
                        Icons.place_outlined,
                        size: 20,
                        color: grayColor,
                      ),
                      hintText: 'To'),
                  const SizedBox(height: 5),
                  ButtonWidget1(
                      title: "Go",
                      ontap: () {
                        if (selectedLocation != null &&
                            secondLocation != null) {
                          if (selectedLocation == secondLocation) {
                            showTopSnackBar(context,
                                'Choose a different location', Colors.red);
                          } else {
                            LatLng startPoint = LatLng(
                              selectedLocation!['latitude'],
                              selectedLocation!['longitude'],
                            );

                            LatLng endPoint = LatLng(
                              secondLocation!['latitude'],
                              secondLocation!['longitude'],
                            );
                            double distanceInKm =
                                calculateDistance(startPoint, endPoint);

                            double price = calculatePrice(distanceInKm);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AvalibleCicleListPage(
                                  price: price,
                                  startLocationName:
                                      selectedLocation!['location_name'],
                                  endLocationName:
                                      secondLocation!['location_name'],
                                  startlocationId: selectedLocation!['id'],
                                  endlocationId: secondLocation!['id'],
                                ),
                              ),
                            );
                          }
                        } else {
                          showTopSnackBar(
                              context,
                              'Please select location you want to go',
                              Colors.red);
                        }
                        setState(() {
                          isBottomSheetVisible = false;
                        });
                      },
                      color: primaryColor,
                      textColor: Colors.white,
                      borderColor: borderColor,
                      width: double.infinity,
                      height: 40,
                      titleSize: 20),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: (isBottomSheetVisible = false)
          ? FloatingActionButton(
              onPressed: () async {
                setState(() {});
                mapController.move(
                  LatLng(33.5093553, 36.2939167),
                  15.0,
                );
              },
              child: const Icon(Icons.my_location),
            )
          : Container(),
    );
  }

  TextFormField newMethod(
      {required Widget? icon,
      required String hintText,
      required void Function()? onTap,
      required TextEditingController? controller}) {
    return TextFormField(
      controller: controller,
      onTap: onTap,
      readOnly: true,
      // initialValue: initial,
      decoration: InputDecoration(
        filled: true,
        fillColor: backColor,
        prefixIcon: icon,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor, width: 1.0),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: primaryColor,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        hintText: hintText,
        hintStyle: subtitleStyle,
      ),
    );
  }
}
