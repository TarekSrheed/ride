import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ride_app/core/config/service_locator.dart';
import 'package:ride_app/core/res/app_color.dart';
import 'package:ride_app/core/res/app_string.dart';
import 'package:ride_app/core/res/app_style.dart';
import 'package:ride_app/features/data/remote/rent_bike_service.dart';
import 'package:ride_app/features/view/provider/immutable_data.dart';
import 'package:ride_app/features/view/widget/active_widgets/list_view_for_rentals.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrentRentPage extends StatefulWidget {
  CurrentRentPage({super.key});

  @override
  State<CurrentRentPage> createState() => _CurrentRentPageState();
}

class _CurrentRentPageState extends State<CurrentRentPage> {
  final int userId = core.get<SharedPreferences>().getInt('userId')!;

  Future<void> _showLoadingDialog(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(
            color: primaryColor,
          ),
        );
      },
    );
  }

  Future<void> _finishRent(int bikeId, int endLocationId, WidgetRef ref) async {
    // إظهار شاشة التحميل
    await _showLoadingDialog(context);

    // إنهاء الإيجار
    await RentBikeService().finishTheRent(
      userId: userId,
      bikeId: bikeId,
      endLocationId: endLocationId,
    );

    // تحديث البيانات
    ref.refresh(currentRentalsProvider(userId));

    // إغلاق شاشة التحميل
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  bool showCircle = false;

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      body: Consumer(builder: (context, ref, _) {
        final rentals = ref.watch(currentRentalsProvider(userId));
        return rentals.when(
          data: (data) {
            if (data.isEmpty) {
              return Center(
                child: Text(
                  'There are no running rents',
                  style: titleFavoStyle,
                ),
              );
            } else {
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return ContainerForRentals(
                      title: data[index]['end_location_name'],
                      subtitle: data[index]['bike_name'],
                      trailing: "End Ride",
                      ontap: () {},
                      ontap1: () async {
                        await _finishRent(
                          data[index]['bikeId'],
                          data[index]['endLocationID'],
                          ref,
                        );
                      },
                      isCurrent: true,
                    );
                  });
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
    );
  }
}
