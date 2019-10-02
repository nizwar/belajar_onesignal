import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

main() {
  return runApp(MaterialApp(
    home: Main(),
  ));
}

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

//Jangan lupa buat check android > build.gradle
class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Onesignal"),
      ),
      body: Center(
          child: SizedBox(
        width: 100,
        height: 100,
        child: FlatButton(
          color: Colors.blue,
          shape: CircleBorder(),
          child: Icon(
            Icons.notifications,
            color: Colors.white,
            size: 60,
          ),
          onPressed: () => buatNotif(),
        ),
      )),
    );
  }

  @override
  void initState() {
    super.initState();
    initEverything();
  }

  void initEverything() async {
    //7f808cc5-00b6-4c78-8586-7b08d5e8964b < Ini app id saya
    await OneSignal.shared.init("APP ID");
    OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);
    buatNotif();
    setState(() {});
  }

  String idButton;
  void buatNotif() async {
    var status = await OneSignal.shared.getPermissionSubscriptionState();

    var playerId = status.subscriptionStatus.userId;

    var imgUrlString =
        "https://1.bp.blogspot.com/-d1icZJkgBo0/XPAHAoiSG3I/AAAAAAAAFEU/zKodaq_A5W0CCO-n-7zSkBGBrV03LZdcwCLcBGAs/s1024/mochamad_nizwar_syafuan.jpg";

    var notification = OSCreateNotification(
      playerIds: [playerId],
      content: "Ini adalah contoh notifikasi Onesignal menggunakan flutter",
      heading: "You're Awesome",
      iosAttachments: {"id1": imgUrlString},
      bigPicture: imgUrlString,
    );

    var response = await OneSignal.shared.postNotification(notification);
    setState(() {
      idButton = response.toString();
    });
  }
}
