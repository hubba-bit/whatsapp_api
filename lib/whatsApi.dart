import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_appavailability/flutter_appavailability.dart';
import 'package:flutter_sim_country_code/flutter_sim_country_code.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whats_api/sharedPref.dart';

class WhatsApiPage extends StatelessWidget {
  final numberContainer = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool validNumber = false;
    PhoneNumber _number;
    return FutureBuilder(
        future: initialize(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return CircularProgressIndicator();
          }

          _number = PhoneNumber(isoCode: snapshot.data);
          return Scaffold(
            backgroundColor: Color(0xFFECE5DD),
            appBar: AppBar(
              title: Text("Whats API"),
            ),
            body: Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(
                children: [
                  SizedBox(
                    child: Center(
                      child: Text(
                        "Using this you can directly send WhatsApp messages to numbers which are not saved in your contact list.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    height: MediaQuery.of(context).size.height * 0.15,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  InternationalPhoneNumberInput(
                    onInputChanged: (PhoneNumber number) {
                      if (number.isoCode != _number.isoCode) {
                        setStoreValue(number.isoCode);
                      }
                      _number = number;
                    },
                    onInputValidated: (bool value) {
                      validNumber = value;
                    },
                    onSubmit: () async {
                      if (validNumber) {
                        String uri;
                        try {
                          await AppAvailability.checkAvailability(
                              "com.whatsapp");
                          uri =
                              'https://api.whatsapp.com/send?phone=${_number.phoneNumber.substring(1)}';
                        } on PlatformException catch (_) {
                          uri =
                              "https://play.google.com/store/apps/details?id=com.whatsapp";
                        }

                        if (await canLaunch(uri)) {
                          await launch(uri);
                        }
                      } else {
                        showDialog(
                          context: context,
                          builder: (_) {
                            return new AlertDialog(
                              backgroundColor: Color(0xFFECE5DD),
                              title: Text(
                                "Invalid Number",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 22,
                                ),
                              ),
                              content: Text(
                                "It seems number is not valid please enter correct number.",
                                style: TextStyle(
                                  color: Theme.of(context).primaryColorDark,
                                  fontSize: 16,
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                    ignoreBlank: false,
                    autoValidate: false,
                    selectorTextStyle: TextStyle(color: Colors.grey),
                    initialValue: _number,
                    textFieldController: numberContainer,
                    selectorType: PhoneInputSelectorType.DIALOG,
                    inputBorder: OutlineInputBorder(),
                    autoFocus: false,
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<String> initialize() async =>
      await getStoreValue('Country') ??
      await FlutterSimCountryCode.simCountryCode ??
      'PK';
}
