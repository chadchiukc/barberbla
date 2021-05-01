import 'package:barberbla/controllers/auth_controller.dart';
// import 'package:barberbla/controllers/booking_controller.dart';
import 'package:barberbla/controllers/service_controll.dart';
import 'package:barberbla/controllers/shops_controller.dart';
import 'package:barberbla/pages/success.dart';
import 'package:barberbla/utils/database.dart';
import 'package:barberbla/widgets/background.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmPage extends StatelessWidget {
  final _args = Get.arguments;
  final ShopController _shop = Get.find<ShopController>();
  final ServiceController _service = Get.find<ServiceController>();
  final AuthController _user = Get.find<AuthController>();
  // final BookingController _booking = Get.find<BookingController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[400],
          centerTitle: true,
          title: Text('Confirm Order'),
        ),
        body: Container(
          decoration: background,
          child: SafeArea(
              child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(
                    'Service',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  subtitle: Text(
                    '${_service.selectedService.value.service}',
                    style: Theme.of(context).textTheme.headline5,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(
                    'Branch',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  subtitle: Text(
                    _shop.selectedShop.value.name,
                    style: Theme.of(context).textTheme.headline5,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(
                    'Reserved Time',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  subtitle: Text(
                    '${_args.hour}:${_args.minute.toString().length == 1 ? '00' : _args.minute}',
                    style: Theme.of(context).textTheme.headline5,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Divider(
                thickness: 2,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'TOTAL: ',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Spacer(),
                    Text(
                      '\$${_service.selectedService.value.fee}',
                      style: Theme.of(context).textTheme.headline5,
                    )
                  ],
                ),
              ),
              Divider(
                thickness: 2,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () async {
                          if (await Database().addBooking(
                              _service.selectedService.value.service,
                              _shop.selectedShop.value.id,
                              _args,
                              _user.user,
                              _shop.selectedShop.value.name)) {
                            // _booking.fetchBooking();
                            Get.offAll(() => SuccessPage(), arguments: [
                              _args,
                              _shop.selectedShop.value.name
                            ]);
                          }
                        },
                        child: Text('Confirm Order'))),
              )
            ],
          )),
        ));
  }
}
