import 'dart:async';

import 'package:flutter/services.dart';

final clipboardContentStream = StreamController<String>.broadcast();

final clipboardTriggerTime = Timer.periodic(
//  you can specify any duration you want, roughly every 20 read from the system
  const Duration(seconds: 5),
  (timer) {
    Clipboard.getData('text/plain').then((clipboarContent) {
      print('Clipboard content ${clipboarContent.text}');

      // post to a Stream you're subscribed to
      clipboardContentStream.add(clipboarContent.text);
    });
  },
);

//  subscribe your view with
Stream get clipboardText => clipboardContentStream.stream;

//  and don't forget to clean up on your widget
@override
void dispose() {
  clipboardContentStream.close();

  clipboardTriggerTime.cancel();
}
