import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ride_app/core/config/service_locator.dart';
import 'package:ride_app/core/res/app_color.dart';
import 'package:ride_app/core/res/app_string.dart';
import 'package:ride_app/core/res/app_style.dart';
import 'package:ride_app/features/view/provider/immutable_data.dart';
import 'package:ride_app/features/view/widget/active_widgets/list_view_for_rentals.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RentalsPage extends ConsumerWidget {
  RentalsPage({super.key});
  final int userId = core.get<SharedPreferences>().getInt('userId')!;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rentals = ref.watch(rentalsProvider(userId));

    return Scaffold(
      body: Consumer(builder: (context, ref, _) {
        return rentals.when(
          data: (data) {
            if (data.isEmpty) {
              return Center(
                child: Text(
                  'There is no rentals completed',
                  style: titleFavoStyle,
                ),
              );
            } else {
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return ContainerForRentals(
                      trailing: "${data[index]['startTime']}".substring(0, 10),
                      subtitle: "You go to ${data[index]['end_location_name']}",
                      title: data[index]['bike_name'],
                      ontap: () {
                        // showDialog2(context);
                      },
                      isCurrent: false,
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
