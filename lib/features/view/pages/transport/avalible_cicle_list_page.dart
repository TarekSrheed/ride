// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ride_app/core/res/app_color.dart';

import 'package:ride_app/core/res/app_string.dart';
import 'package:ride_app/core/res/app_style.dart';
import 'package:ride_app/features/view/pages/navigation_pages.dart';
import 'package:ride_app/features/view/pages/transport/bike_details_page.dart';
import 'package:ride_app/features/view/provider/immutable_data.dart';
import 'package:ride_app/features/view/widget/avaiable_cycle_list.dart';

class AvalibleCicleListPage extends ConsumerWidget {
  final int startlocationId;
  final int endlocationId;
  final String startLocationName;
  final String endLocationName;
  final double price;

  AvalibleCicleListPage({
    Key? key,
    required this.startlocationId,
    required this.price,
    required this.startLocationName,
    required this.endLocationName,
    required this.endlocationId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final avalibleBikes = ref.watch(availableBikeProvider(startlocationId));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppString().AVAIABLECYCLE,
          style: titleStyle,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => NavigationPage()),
              (route) => false,
            );
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Consumer(
        builder: (context, ref, _) {
          return avalibleBikes.when(
            data: (data) {
              if (data.isEmpty) {
                return Center(
                    child: Text(
                  'There is no bikes now',
                  style: titleFavoStyle,
                ));
              } else {
                return Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: Text(
                          '${data.length} bike found',
                          style: titleFavoStyle,
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: AvaiableCycleList(
                                  nameCycle: data[index]['type'],
                                  feature1: '${data[index]['size']}',
                                  feature2: '2 seats',
                                  price: price.toString(),
                                  ontap1: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => BikeDetailsPage(
                                          startLocationName: startLocationName,
                                          endLocationName: endLocationName,
                                          startlocationId: startlocationId,
                                          endlocationId: endlocationId,
                                          numOfPhoto: data[index]
                                              ['num_of_photo'],
                                          bikeId: data[index]['id'],
                                          price: price,
                                          nameCycle: data[index]['type'],
                                          size: '${data[index]['size']}',
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
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
        },
      ),
    );
  }
}
