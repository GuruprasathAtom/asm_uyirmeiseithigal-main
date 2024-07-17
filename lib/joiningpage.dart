// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_import, sized_box_for_whitespace, prefer_const_declarations, prefer_typing_uninitialized_variables, must_be_immutable, deprecated_member_use

import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:uyirmeiseithigal/categorynews.dart';
import 'package:uyirmeiseithigal/gallery.dart';
import 'package:uyirmeiseithigal/main.dart';

class JoiningPage extends StatefulWidget {
  var jsonList;
  var categoryjsonList;
  var relatednewsjsonList;
  var galleryresponselist;
  JoiningPage(
      {super.key,
      required this.jsonList,
      required this.categoryjsonList,
      required this.relatednewsjsonList,
      required this.galleryresponselist});

  @override
  State<JoiningPage> createState() => _JoiningPageState();
}

class _JoiningPageState extends State<JoiningPage> {
  int? _selectedValue;
  bool isChecked = false;
  bool isOpen = true;
  String gender = 'not disclosed';
  final firstnamecontroller = TextEditingController();
  final lastnamecontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final qualificationcontroller = TextEditingController();
  final agecontroller = TextEditingController();
  final whatsappcontroller = TextEditingController();
  final religioncontroller = TextEditingController();
  final occupationcontroller = TextEditingController();
  final address1controller = TextEditingController();
  final address2controller = TextEditingController();
  final citycontroller = TextEditingController();
  final statecontroller = TextEditingController();
  final pincodecontroller = TextEditingController();
  final countrycontroller = TextEditingController();
  final zipcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        shape: Border(bottom: BorderSide(color: Colors.blue)),
        title: Container(
          width: 240,
          height: 100,
          child: CachedNetworkImage(
            imageUrl:
                "https://uyirmeiseithigal.com/assets/img/logo/uyirmei-logo.png",
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            Container(
              height: 200,
              child: Image.asset('assets/images/advertisement.jpg'),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  border: Border.all(
                    color: Colors.blue,
                    width: 2.0,
                  ),
                ),
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'நீங்களும் நிருபர் ஆகலாம்',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Container(height: 0, child: Divider(color: Colors.blue)),
            SizedBox(
              height: 10,
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'First name',
              ),
              controller: firstnamecontroller,
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email address',
              ),
              controller: emailcontroller,
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Qualification',
              ),
              controller: qualificationcontroller,
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Age',
              ),
              controller: agecontroller,
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Whatsapp No',
              ),
              controller: whatsappcontroller,
            ),
            SizedBox(
              height: 10,
            ),
            Align(alignment: Alignment.centerLeft, child: Text('Gender')),
            Row(
              children: [
                SizedBox(
                  width: 25,
                  child: Radio(
                    value: 1,
                    groupValue: _selectedValue,
                    onChanged: (value) {
                      setState(() {
                        _selectedValue = value;
                        gender = 'Male';
                      });
                    },
                  ),
                ),
                Text('Male'),
                SizedBox(
                  width: 25,
                  child: Radio(
                    value: 2,
                    groupValue: _selectedValue,
                    onChanged: (value) {
                      setState(() {
                        _selectedValue = value;
                        gender = 'Female';
                      });
                    },
                  ),
                ),
                Text('Female'),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Religion',
              ),
              controller: religioncontroller,
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Occupation',
              ),
              controller: occupationcontroller,
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Street address1',
              ),
              controller: address1controller,
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Street address2',
              ),
              controller: address2controller,
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'City',
              ),
              controller: citycontroller,
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'State / Province',
              ),
              controller: statecontroller,
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Country',
              ),
              controller: countrycontroller,
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'ZIP / Postal',
              ),
              controller: zipcontroller,
            ),
            SizedBox(
              height: 10,
            ),
            CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                title: Text(
                    "I hereby declare that the details and information given above are complete and true to the best of my knowledge."),
                value: isChecked,
                onChanged: (value) {
                  setState(() {
                    isChecked = value!;
                  });
                }),
            SizedBox(height: 10),
            Visibility(
              visible: true,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                onPressed: () {
                  if (firstnamecontroller.text.isNotEmpty &&
                      emailcontroller.text.isNotEmpty &&
                      qualificationcontroller.text.isNotEmpty &&
                      agecontroller.text.isNotEmpty &&
                      whatsappcontroller.text.isNotEmpty &&
                      religioncontroller.text.isNotEmpty &&
                      occupationcontroller.text.isNotEmpty &&
                      address1controller.text.isNotEmpty &&
                      address2controller.text.isNotEmpty &&
                      citycontroller.text.isNotEmpty &&
                      statecontroller.text.isNotEmpty &&
                      countrycontroller.text.isNotEmpty &&
                      zipcontroller.text.isNotEmpty &&
                      isChecked == true) {
                    sendemail(
                      name: "uyirmei",
                      email: 'asminfoindia@gmail.com',
                      subject: "Neengalum nirubar agalam",
                      message:
                          "First name-${firstnamecontroller.text},\nemail-${emailcontroller.text},\nqualification-${qualificationcontroller.text},\nage-${agecontroller.text},\nGender-$gender,\nwhatsapp-${whatsappcontroller.text},\nreligion-${religioncontroller.text},\noccupation-${occupationcontroller.text},\naddress1-${address1controller.text},\naddress1-${address2controller.text},\nCity-${citycontroller.text},\nState / Province-${statecontroller.text},\nCountry-${countrycontroller.text},\nZIP / Postal-${zipcontroller.text}.",
                      toemail: 'asminfoindia@gmail.com',
                    );
                    sendemail(
                      name: "uyirmei",
                      email: 'asminfoindia@gmail.com',
                      subject: "Neengalum nirubar agalam",
                      message: "Thank for joining us",
                      toemail: emailcontroller.text,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.green,
                      content: Text("Thank you for joining us."),
                    ));
                    firstnamecontroller.text = '';
                    emailcontroller.text = '';
                    qualificationcontroller.text = '';
                    agecontroller.text = '';
                    whatsappcontroller.text = '';
                    religioncontroller.text = '';
                    occupationcontroller.text = '';
                    address1controller.text = '';
                    address2controller.text = '';
                    citycontroller.text = '';
                    statecontroller.text = '';
                    countrycontroller.text = '';
                    zipcontroller.text = '';
                    isChecked = false;
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyHomePage()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Please fill all the fields"),
                    ));
                    // if (isChecked == false) {
                    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    //     content: Text("Agree to terms and conditions"),
                    //   ));
                    // }
                  }
                },
                child: Text(
                  "Submit",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ]),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color.fromRGBO(75, 5, 5, 1.0),
        child: Container(
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Gallery(
                          index: 0,
                          id: 0,
                          jsonList: widget.jsonList,
                          relatednewsjsonList: widget.relatednewsjsonList,
                          categoryjsonList: widget.categoryjsonList,
                          galleryresponselist: widget.galleryresponselist,
                        ),
                      ));
                },
                child: Container(
                  width: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SvgPicture.asset(
                        'assets/images/movie.svg',
                        height: 20,
                        width: 20,
                        color: Colors.white,
                      ),
                      Text(
                        'வெப் ஸ்டோரீஸ்',
                        style: TextStyle(fontSize: 6, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryPage(
                        categorylength: 1,
                        subcategorylength: 0,
                        categoryjsonList: widget.categoryjsonList,
                        jsonList: widget.jsonList,
                        relatednewsjsonList: widget.relatednewsjsonList,
                        galleryresponselist: widget.galleryresponselist,
                      ),
                    ),
                  );
                },
                child: Container(
                  width: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SvgPicture.asset(
                        'assets/images/cinema.svg',
                        height: 20,
                        width: 20,
                        color: Colors.white,
                      ),
                      Text(
                        'சினிமா',
                        style: TextStyle(fontSize: 6, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              //   Container(
              //     width: 50,
              //     decoration: BoxDecoration(
              //       color: Colors.red,
              //       shape: BoxShape.circle,
              //     ),
              //     child: IconButton(
              //       icon: SvgPicture.asset(
              //         'assets/images/ninedots.svg',
              //         height: 50,
              //         width: 50,
              //         color: Colors.white,
              //       ),
              //       onPressed: () {
              //         // Handle tap
              //       },
              //     ),
              //   ),
              Container(
                width: 60,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: isOpen
                      ? SvgPicture.asset(
                          'assets/images/ninedots.svg',
                          height: 30,
                          width: 30,
                          color: Colors.white,
                        )
                      : Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                  onPressed: () {
                    setState(() {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => ImageTest(),
                      //     ));
                    });
                  },
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  width: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SvgPicture.asset(
                        'assets/images/books.svg',
                        height: 20,
                        width: 20,
                        color: Colors.white,
                      ),
                      Text(
                        'புத்தங்கள்',
                        style: TextStyle(fontSize: 6, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  width: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Icon(Icons.info, color: Colors.white),
                      Text(
                        'எங்களைப்பற்றி',
                        style: TextStyle(fontSize: 6, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future sendemail({
    required String name,
    required String email,
    required String subject,
    required String message,
    required String toemail,
  }) async {
    final serviceId = 'service_tb6s9d8';
    final templateId = 'template_2itx2bg';
    final userId = 'OKJ2OZPsps3WoEmWl';
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response = await http.post(url,
        body: json.encode({
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': userId,
          'template_params': {
            'user_name': name,
            'user_email': email,
            'to_email': toemail,
            'user_subject': subject,
            'user_message': message,
          }
        }),
        headers: {
          'origin': 'http://localhost',
          'Content-Type': 'application/json',
        });
    print(response.body);
  }
}
