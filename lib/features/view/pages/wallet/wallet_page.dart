import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ride_app/core/config/service_locator.dart';
import 'package:ride_app/core/res/app_color.dart';
import 'package:ride_app/core/res/app_images.dart';
import 'package:ride_app/core/res/app_string.dart';
import 'package:ride_app/core/res/app_style.dart';
import 'package:ride_app/features/view/pages/wallet/add_money_page.dart';
import 'package:ride_app/features/view/provider/immutable_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WalletPage extends ConsumerWidget {
  WalletPage({super.key});

  final int userId = core.get<SharedPreferences>().getInt('userId')!;

  final AppString appString = AppString();
  num totalpriceExpend = 0.0;

  bool executed = false;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final balance = ref.watch(walletProvider(userId));
    final rentals = ref.watch(allRentalsProvider(userId));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Wallet',
          style: titleStyle,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddMoneyPage()),
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 150,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      width: 1,
                      color: primaryColor,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Add Money',
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(boxImage),
                  Column(
                    children: [
                      Consumer(builder: (context, ref, _) {
                        return balance.when(
                          data: (data) {
                            return Text(
                              '${data[0]['Balance']}',
                              style: nameStyle,
                            );
                          },
                          error: (error, stackTrace) {
                            return Icon(
                              Icons.signal_wifi_connected_no_internet_4,
                              color: grayColor,
                            );
                          },
                          loading: () {
                            return Center(
                                child: SizedBox(
                              width: 50,
                              child: LinearProgressIndicator(
                                minHeight: 2,
                                color: primaryColor,
                              ),
                            ));
                          },
                        );
                      }),
                      Text(appString.AVAIABLEBALANCE),
                    ],
                  ),
                ],
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(boxImage),
                  Column(
                    children: [
                      Consumer(builder: (context, ref, _) {
                        return rentals.when(
                          data: (data) {
                            if (!executed) {
                              for (var i = 0; i < data.length; i++) {
                                if (!executed) {
                                  totalpriceExpend += data[i]['totalprice'];
                                }
                              }
                            }
                            executed = true;
                            return Text(
                              totalpriceExpend.toString(),
                              style: nameStyle,
                            );
                          },
                          error: (error, stackTrace) {
                            return Icon(
                              Icons.signal_wifi_connected_no_internet_4,
                              color: grayColor,
                            );
                          },
                          loading: () {
                            return Center(
                                child: SizedBox(
                              width: 30,
                              child: LinearProgressIndicator(
                                minHeight: 2,
                                color: primaryColor,
                              ),
                            ));
                          },
                        );
                      }),
                      Text(appString.TOTALEXPEND),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 15, left: 15, bottom: 10),
              child: Text(
                appString.TRANSECTINOS,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: titleColor,
                ),
              ),
            ),
          ),
          Expanded(
            child: Consumer(builder: (context, ref, _) {
              return rentals.when(
                data: (data) {
                  if (data.isEmpty) {
                    return Center(
                      child: Text(
                        'There is no rentals',
                        style: titleFavoStyle,
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Container(
                          alignment: Alignment.topCenter,
                          margin: const EdgeInsets.only(
                              bottom: 10, left: 10, right: 10),
                          width: double.infinity,
                          height: 64,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border:
                                  Border.all(color: primaryColor, width: 1)),
                          child: ListTile(
                            leading: Image.asset(upImage),
                            title: Text(
                              data[index]['bike_name'],
                              style: TextStyle(
                                color: blackColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                            subtitle: Text(
                              "${data[index]['startTime']}".substring(0, 10),
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: grayColor,
                              ),
                            ),
                            trailing: Text(
                              "-${data[index]['totalprice']}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  color: blackColor),
                            ),
                          ),
                        );
                      },
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
          )
        ],
      ),
    );
  }
}
