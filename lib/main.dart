import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MyWidget();
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  void initState() {
    myprocess1();
    super.initState();
  }

  var name = '';
  var dob = '';
  var phone = '';
  var city = '';
  var state = '';
  var country = '';
  var image = 'https://randomuser.me/api/portraits/men/41.jpg';
  bool isLoading = false;

  void myprocess1() async {
    setState(() {
      isLoading = true;
    });
    var url = Uri.parse('https://randomuser.me/api/');
    var response = await http.get(url);
    var details = jsonDecode(response.body)['results'][0];
    if (details['gender'] != 'female') {
      myprocess1();
    } else {
      print('Response status: ${response.statusCode}');
      print('Response body: ${details}');
      setState(() {
        name = details['name']['first'] + ' ' + details['name']['last'];
        dob = details['dob']['age'].toString();
        phone = details['phone'];
        city = details['location']['city'];
        state = details['location']['state'];
        country = details['location']['country'];
        image = details['picture']['large'];
      });
      changeLoading();
    }
  }

  void changeLoading() {
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return MaterialApp(
          title:
              'RandomUsers', //app name shown from package name and for main title this is.
          theme: ThemeData(primarySwatch: Colors.cyan), //theme of app
          home: Scaffold(
            //scaffold
            appBar: AppBar(
              //appbar for show scaffold title
              title: const Text(
                'RandomUsers',
                style: TextStyle(
                  color: Color.fromARGB(255, 17, 2, 177),
                  letterSpacing: 1.5,
                  fontSize: 21,
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.italic,
                  fontFamily: 'Times New Roman',
                ),
              ), //title of scaffold
              centerTitle: true,
              toolbarHeight: 50,
            ),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ));
    } else {
      return MaterialApp(
        title:
            'RandomUsers', //app name shown from package name and for main title this is.
        theme: ThemeData(primarySwatch: Colors.cyan), //theme of app
        home: Scaffold(
          //scaffold
          appBar: AppBar(
            //appbar for show scaffold title
            title: const Text(
              'RandomUsers',
              style: TextStyle(
                color: Color.fromARGB(255, 17, 2, 177),
                letterSpacing: 1.5,
                fontSize: 21,
                fontWeight: FontWeight.w900,
                fontStyle: FontStyle.italic,
                fontFamily: 'Times New Roman',
              ),
            ), //title of scaffold
            centerTitle: true,
            toolbarHeight: 50,
          ),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Container(
                  padding:
                      EdgeInsets.all(16), // Add padding to the whole container
                  decoration: BoxDecoration(
                    color: Colors.grey[200], // Optional background color
                    borderRadius: BorderRadius.circular(
                        10), // Add rounded corners to the container
                  ),
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          CircleAvatar(
                            radius: 100,
                            // The background image will be null if the image is not loaded yet.
                            backgroundImage:
                                isLoading ? null : NetworkImage(image),
                          ),
                          if (isLoading) CircularProgressIndicator(),
                        ],
                      ),
                      SizedBox(
                          height:
                              10), // Add some space between the avatar and the text
                      Text(
                        'Name: ${name}',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        'Age: ${dob}',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        'Phone No.: ${phone}',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        'City: ${city}',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        'State: ${state}',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        'Country: ${country}',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(
                          height:
                              20), // Add some space between the text and the button
                      ElevatedButton(
                        onPressed: () {
                          myprocess1();
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10), // Adjust button padding
                          primary: Color.fromARGB(
                              255, 11, 3, 129), // Set button color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                5), // Add rounded corners to the button
                          ),
                        ),
                        child: Text(
                          "Find Another One",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
