import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:w3b_app/configs/constants/constant.dart';
import 'package:w3b_app/configs/routes/navigator.dart';
import 'package:w3b_app/pages/scan.dart';
import 'package:w3b_app/widgets/input.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 60),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 230,
              child: Column(children: [
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(100)),
                ),
                const Text(
                  'Nom et Prenoms',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: pacifico),
                ),
                const Text(
                  'Profession',
                  style: TextStyle(fontSize: 20, fontFamily: pacifico),
                ),
              ]),
            ),
            Expanded(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(children: [
                    myInput(),
                    const SizedBox(
                      height: 10,
                    ),
                    myInput(),
                    const SizedBox(
                      height: 10,
                    ),
                    myInput(),
                    const SizedBox(
                      height: 10,
                    ),
                    myInput(),
                    const SizedBox(
                      height: 10,
                    ),
                    myInput(),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width:150,
                      child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                      ),
                      onPressed: () {
                        navigatorDelete(context, const ScanPage());
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Text('Ok'), Icon(EvaIcons.checkmark)],
                      ),
                    ),
                    )
                  ]),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
