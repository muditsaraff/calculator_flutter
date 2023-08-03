  import 'dart:convert';
  import 'package:cached_network_image/cached_network_image.dart';
  import 'package:flutter/material.dart';
  import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_application_1/profile.dart';
  import 'package:http/http.dart' as http;
  import 'package:shared_preferences/shared_preferences.dart';
  import 'model/datamodel.dart';

  class Home extends StatefulWidget {
    const Home({super.key});

    @override
    State<Home> createState() => _HomeState();
  }

  // class imgarr2 {
  //   imgarr2({required this.link, required this.name});

  //   String link;
  //   String name;
  // }

  class _HomeState extends State<Home> {
    var name = "";
    List<DataModel> userList = [];

    @override
    getRequest() async {
      //replace your restFull API here.
      String url = "https://jsonplaceholder.typicode.com/photos";
      final response = await http.get(Uri.parse(url));
      SharedPreferences pref = await SharedPreferences.getInstance();
      name = pref.getString("firstName")!;
      print("name2233 $name");
      var responseData = json.decode(response.body);
      print("code... ${response.statusCode}");
      print("Request Respone... $responseData");
      final data = responseData;
      for (Map<String, dynamic> document in data) {
        setState(() {
          userList.add(DataModel.fromJson(document));
        });
      }
      print("Request Respone... $userList");
    }

    @override
    void initState() {
      // TODO: implement initState
      getRequest();
      super.initState();
    }

    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 250, 251, 251),
          title: const Text('Home Page'),
          leading: IconButton(
            color: Color.fromARGB(255, 117, 80, 186),
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Perform action when the first button is pressed
                      print('First Button pressed!');
                    },
                    child: Text('Flipkart'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Perform action when the second button is pressed
                      print('Grocery pressed');
                    },
                    child: Text('Grocery'),
                  ),
                ],
              ),

              SizedBox(
                height: 18.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 253, 253, 253),
                    border: Border.all(
                      color: const Color.fromARGB(255, 189, 7, 7),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Search',
                          contentPadding: EdgeInsets.only(left: 10.0),
                          border: InputBorder.none,
                          suffixIcon: Icon(
                            Icons.search,
                            color: Colors.red,
                            //size: 10,
                          ),
                        ),
                        obscureText: true,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Column(children: [
                CarouselSlider(
                  items: [
                    // 1st Image of Slider
                    Container(
                    // margin: EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: NetworkImage(
                              "https://cdn.pixabay.com/photo/2015/10/30/20/13/sunrise-1014712_1280.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    // 2nd Image of Slider
                    Container(
                      //margin: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: NetworkImage(
                              "https://cdn.pixabay.com/photo/2017/02/01/22/02/mountain-landscape-2031539_1280.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    // 3rd Image of Slider
                    Container(
                    // margin: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: NetworkImage(
                              "https://cdn.pixabay.com/photo/2017/12/15/13/51/polynesia-3021072_1280.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    // 4th Image of Slider
                    Container(
                  //    margin: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: NetworkImage(
                              "https://cdn.pixabay.com/photo/2015/12/01/20/28/road-1072821_1280.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    // 5th Image of Slider
                    Container(
                  //    margin: EdgeInsets.all(0.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: NetworkImage(
                              "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],

                  // Slider Container properties
                  options: CarouselOptions(
                    height: 180.0,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    aspectRatio: 21 / 9,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    viewportFraction: 0.8,
                  ),
                ),
              ]),
            ],
          ),
        ),
    bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                // Perform action when the first button is pressed
                print('First Button pressed!');
              },
              child: Row(
                children: [
                  Icon(Icons.home),
                  Text('Home'),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                 Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfilePage()
          ),
        );
                // Perform action when the second button is pressed
             //   print('Button 2 pressed');
              },
              child: Row(
                children: [
                  Icon(Icons.person_2),
                  Text(' Account'),

                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Perform action when the third button is pressed
                   
                print('Cart');
              },
              child: Row(
                children: [
                  Icon(Icons.shopping_bag),
                  Text(' Cart'),
                ],
              ),
              
            ),
          ],
        ),
      ),
    );
  }
}