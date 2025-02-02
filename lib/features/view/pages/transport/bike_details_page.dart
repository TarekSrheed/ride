// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:ride_app/core/config/service_locator.dart';
import 'package:ride_app/core/res/app_color.dart';
import 'package:ride_app/core/res/app_images.dart';
import 'package:ride_app/core/res/app_string.dart';
import 'package:ride_app/core/res/app_style.dart';
import 'package:ride_app/features/data/remote/auth_service.dart';
import 'package:ride_app/features/data/remote/rent_bike_service.dart';
import 'package:ride_app/features/view/pages/transport/thank_you_page.dart';
import 'package:ride_app/features/view/widget/active_widgets/show_dialog_widgets/show_dialog_widget.dart';
import 'package:ride_app/features/view/widget/button_widget.dart';
import 'package:ride_app/features/view/widget/container/container_specigications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BikeDetailsPage extends StatefulWidget {
  final String nameCycle;
  final int startlocationId;
  final int endlocationId;
  final int bikeId;
  final String startLocationName;
  final String endLocationName;
  final String size;
  final double price;
  final int numOfPhoto;

  const BikeDetailsPage({
    super.key,
    required this.nameCycle,
    required this.size,
    required this.numOfPhoto,
    required this.startlocationId,
    required this.endlocationId,
    required this.bikeId,
    required this.price,
    required this.startLocationName,
    required this.endLocationName,
  });

  @override
  State<BikeDetailsPage> createState() => _BikeDetailsPageState();
}

class _BikeDetailsPageState extends State<BikeDetailsPage> {
  final AppString appString = AppString();

  bool showCircle = false;
  bool showCircle2 = false;
  int userId = core.get<SharedPreferences>().getInt('userId')!;

  void showDialog2(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Confirm Ride", style: titleDialogStyle),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Column(
                        children: [
                          Image.asset(fromImage),
                          Image.asset(
                            lineImage,
                          ),
                          Image.asset(toImage),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          children: [
                            Text(
                              widget.startLocationName,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 15),
                            ),
                            const SizedBox(height: 45),
                            Text(
                              widget.endLocationName,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 15),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Price: ${widget.price}",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: grayColor,
                        ),
                      ),
                      Text(
                        widget.nameCycle,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: grayColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            actionsPadding:
                const EdgeInsets.only(left: 40, right: 40, bottom: 20),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ButtonWidget1(
                    titleSize: 14,
                    height: 40,
                    title: 'cancel',
                    ontap: () {
                      Navigator.pop(context);
                    },
                    color: Colors.white,
                    textColor: primaryColor,
                    borderColor: primaryColor,
                    width: 70,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ButtonWidget1(
                    titleSize: 14,
                    height: 40,
                    showCircle: showCircle2,
                    title: 'Confirm',
                    ontap: () {
                      setState(() {
                        showCircle2 = true;
                      });
                      RentBikeService().rentBike(
                          userId: userId,
                          bikeId: widget.bikeId,
                          endLocationId: widget.endlocationId,
                          rentalCost: widget.price,
                          startLocationName: widget.startLocationName,
                          endLocationName: widget.endLocationName,
                          bikeName: widget.nameCycle,
                          startLocationId: widget.startlocationId);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ThankYouPage(),
                        ),
                      );
                      setState(() {
                        showCircle2 = false;
                      });
                    },
                    color: primaryColor,
                    textColor: Colors.white,
                    borderColor: primaryColor,
                    width: 70,
                  ),
                ],
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.nameCycle,
                style: titleStyle,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Row(children: [
                  Icon(
                    Icons.star,
                    color: Colors.yellow[700],
                  ),
                  Text(
                    '4.9',
                    style: subtitleStyle,
                  ),
                ]),
              ),
              Center(
                child: Image.asset(
                  'assets/bikes/bike${widget.numOfPhoto}.jpg',
                  width: MediaQuery.of(context).size.width / 2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0, top: 15),
                child: Text(
                  appString.SPECIFICATIONS,
                  style: titleStyle,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ContainerSpecifications(
                    icon: Icons.format_size,
                    title: 'Size',
                    subtitle: widget.size,
                  ),
                  const ContainerSpecifications(
                    icon: Icons.bike_scooter_outlined,
                    title: 'Seats',
                    subtitle: '2',
                  ),
                  ContainerSpecifications(
                    icon: Icons.price_change_outlined,
                    title: 'Price',
                    subtitle: widget.price.toString(),
                  ),
                  const ContainerSpecifications(
                    icon: Icons.speed_outlined,
                    title: 'Max Speed',
                    subtitle: '25 Km',
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ButtonWidget(
                  topHeight: MediaQuery.sizeOf(context).height / 5,
                  showCircle: showCircle,
                  title: appString.RIDENOW,
                  ontap: () async {
                    setState(() {
                      showCircle = true;
                    });

                    final chackBalanse =
                        await RentBikeService().checkBalance(userId: userId);
                    final balance = await chackBalanse[0]['Balance'];

                    final checkUserStatus =
                        await CheckUserStatus().checkUserStatus(userId: userId);

                    final currentStatus = checkUserStatus[0]['AccountStatus'];
                    if (currentStatus == 'Verified') {
                      if (balance < 5000) {
                        setState(() {
                          showCircle = false;
                        });
                        showDialog1(
                          context,
                          "warning",
                          "You don't have enough money to reserve a bike!",
                        );
                      } else {
                        setState(() {
                          showCircle = false;
                        });
                        showDialog2(context);
                      }
                    } else {
                      setState(() {
                        showCircle = false;
                      });
                      showDialog1(
                        context,
                        "warning",
                        "Your account is not Verified please wait form 6 to 12 hours to revu it and verified",
                      );
                    }
                  },
                  color: primaryColor,
                  textColor: white,
                  borderColor: primaryColor,
                  width: double.infinity,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
