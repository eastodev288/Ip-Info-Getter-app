import 'package:flutter/material.dart';
import 'package:ip_info_app/data/ip_info_datasource.dart';
import 'widgets/info_text.dart';
import 'widgets/info_title_text.dart';
import 'widgets/my_button.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController ipInputFieldControler = TextEditingController();
  String ipAdress = "No Ip";
  String city = "None";
  String region = "None";
  String country = "None";
  String latLong = "none";
  String operator = "None";
  String postalCode = "None";
  String timeZone = "None";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xff0F0817),
            image:
                DecorationImage(image: AssetImage("images/bg_highlight.png")),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "images/logo.png",
                height: 120.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: TextField(
                  controller: ipInputFieldControler,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30.0),
                      ),
                    ),
                    fillColor: Color(0xff1E133E),
                    filled: true,
                    hoverColor: Colors.blueAccent,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyButton(
                        text: "My IP",
                        icon: Image.asset(
                          "images/my_ip.png",
                          width: 30.0,
                        ),
                        onPressed: () async {
                          String ipfromDataSource =
                              await IpData.getMyIpAdress();

                          ipInputFieldControler.text = ipfromDataSource;
                          setState(() {
                            ipAdress = ipfromDataSource;
                          });
                        }),
                    const SizedBox(width: 10.0),
                    MyButton(
                      text: "Get Info",
                      icon: Image.asset(
                        "images/get_info.png",
                        width: 30.0,
                      ),
                      onPressed: () async {
                        Map ipInfo = await IpData.getIpInformation(
                            ipInputFieldControler.text);
                        setState(() {
                          // city = ipInfo["city"];
                          if (ipInfo["city"] == null) {
                            city = "Not found";
                          } else {
                            city = ipInfo["city"];
                          }
                          ;
                          if (ipInfo["region"] == null) {
                            region = "Not found";
                          } else {
                            region = ipInfo["region"];
                          }
                          ;
                          //country = ipInfo["country"];
                          if (ipInfo["country"] == null) {
                            country = "Not found";
                          } else {
                            country = ipInfo["country"];
                          }
                          ;

                          //latLong = ipInfo["loc"];
                          if (ipInfo["latLong"] == null) {
                            latLong = "Not found";
                          } else {
                            latLong = ipInfo["latLong"];
                          }
                          ;

                          if (ipInfo["operator"] == null) {
                            operator = "Not found";
                          } else {
                            operator = ipInfo["operator"];
                          }
                          ;
                          //postalCode = ipInfo["postal"];
                          if (ipInfo["postalCode"] == null) {
                            postalCode = "Not found";
                          } else {
                            postalCode = ipInfo["postalCode"];
                          }
                          ;
                          if (ipInfo["timeZone"] == null) {
                            timeZone = "Not found";
                          } else {
                            timeZone = ipInfo["timeZone"];
                          }
                          ;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 24.0),
                child: Column(
                  children: [
                    const Text(
                      "Information about the IP",
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                    Text(
                      "${ipAdress}",
                      style: TextStyle(color: Colors.white, fontSize: 32.0),
                    ),
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        InfoTitleText(text: "City"),
                        InfoTitleText(text: "Region"),
                        InfoTitleText(text: "Country"),
                        InfoTitleText(text: "Latitude "),
                        InfoTitleText(text: "Operator"),
                        InfoTitleText(text: "Poatal Code"),
                        InfoTitleText(text: "Time Zone"),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InfoText(text: "$city"),
                          InfoText(text: "$region"),
                          InfoText(text: "$country"),
                          InfoText(text: "$latLong"),
                          InfoText(text: "$operator"),
                          InfoText(text: "$postalCode"),
                          InfoText(text: "$timeZone")
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
