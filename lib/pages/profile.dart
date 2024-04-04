import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:w3b_app/configs/constants/constants.dart';
import 'package:w3b_app/configs/routes/navigator.dart';
import 'package:w3b_app/pages/scan.dart';
import 'package:w3b_app/widgets/input.dart';

class Profile extends StatefulWidget {
  final dynamic data;

  const Profile({Key? key, required this.data}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late TextEditingController _city;
  late TextEditingController _gender;
  late TextEditingController _dateNaissance;
  late TextEditingController _dateMade;
  late TextEditingController _dateExpire;
  @override
  void initState() {
    super.initState();
    _city = TextEditingController(text: widget.data['city']);
    _gender = TextEditingController(text: widget.data['gender']);

    final dateBirthStr = widget.data['birthDate'];
    final dateBirth = DateTime.parse(dateBirthStr);
    final formattedBirthDate = DateFormat('dd-MM-yyyy').format(dateBirth);
    _dateNaissance = TextEditingController(text: formattedBirthDate);

    final dateMadeStr = widget.data['madeDate'];
    final dateMade = DateTime.parse(dateMadeStr);
    final formattedMadeDate = DateFormat('dd-MM-yyyy').format(dateMade);
    _dateMade = TextEditingController(text: formattedMadeDate);

    final dateExpireStr = widget.data['expireDate'];
    final dateExpire = DateTime.parse(dateExpireStr);
    final formattedExpireDate = DateFormat('dd-MM-yyyy').format(dateExpire);
    _dateExpire = TextEditingController(text: formattedExpireDate);
  }

  @override
  void dispose() {
    _city.dispose();
    _gender.dispose();
    _dateNaissance.dispose();
    super.dispose();
  }

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
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://fuchsia-definite-fowl-804.mypinata.cloud/ipfs/${widget.data['image']}'),
                          fit: BoxFit.fill),
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(100)),
                ),
                Text(
                  '${widget.data['firstname']} ${widget.data['lastname']}',
                  style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: pacifico),
                ),
                Text(
                  '${widget.data['profession']}',
                  style: const TextStyle(fontSize: 20, fontFamily: pacifico),
                ),
              ]),
            ),
            Expanded(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(children: [
                    myInput(
                      controller: _city,
                      prefixText: 'Ville: ',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    myInput(controller: _gender, prefixText: "Genre: "),
                    const SizedBox(
                      height: 10,
                    ),
                    myInput(
                        controller: _dateNaissance,
                        prefixText: "Date Naissance: "),
                    const SizedBox(
                      height: 10,
                    ),
                    myInput(controller: _dateMade, prefixText: "Fait le: "),
                    const SizedBox(
                      height: 10,
                    ),
                    myInput(controller: _dateExpire, prefixText: "Expire le: "),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 150,
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
