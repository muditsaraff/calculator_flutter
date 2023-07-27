import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
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
  List<DataModel> userList = [];
  var name = "";

  @override
  getRequest() async {
    //replace your restFull API here.
    String url = "https://jsonplaceholder.typicode.com/photos";
    final response = await http.get(Uri.parse(url));
    SharedPreferences pref = await SharedPreferences.getInstance();
    name = pref.getString("firstName")!;
    print("name... $name");
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

    //Creating a list to store input data;
    // List<Datamodel> users = [];
    // for (var singleUser in responseData) {
    //   Datamodel user = Datamodel(
    //       id: singleUser["id"],
    //       userId: singleUser["userId"],
    //       title: singleUser["title"],
    //       body: singleUser["body"]);

    //   //Adding user to the list.
    //   users.add(user);
    // }
    // return users;
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
                    margin: EdgeInsets.all(6.0),
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
                    margin: EdgeInsets.all(6.0),
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
                    margin: EdgeInsets.all(6.0),
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
                    margin: EdgeInsets.all(6.0),
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
                    margin: EdgeInsets.all(0.0),
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
            //  SizedBox(height: 16.0),
            /*  List View
          Container(
              height: 159,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(8),
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Container(
                    height: 50,
                    color: Colors.amber[600],
                    child: const Center(child: Text('Entry A')),
                  ),
                  Container(
                    height: 50,
                    color: Colors.amber[500],
                    child: const Center(child: Text('Entry B')),
                  ),
                  Container(
                    height: 50,
                    color: Colors.amber[100],
                    child: const Center(child: Text('Entry C')),
                  ),
                ],
              ),
            )
            */
            // SingleChildScrollView(
            //   scrollDirection: Axis.horizontal,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: List.generate(8, (index) {
            //       return Padding(
            //         padding: EdgeInsets.all(8.0),
            //         child: ElevatedButton(
            //           onPressed: () {
            //             // Perform action when button is pressed
            //             print('Button $index pressed!');
            //           },
            //           child: Text('Button $index'),
            //         ),
            //       );
            //     }),
            //   ),
            // ),
            // SizedBox(height: 16.0),
            // Container(
            //   height: 150,
            //   child: GridView.count(
            //     padding: const EdgeInsets.all(20),
            //     crossAxisSpacing: 10,
            //     mainAxisSpacing: 10,
            //     crossAxisCount: 2,
            //     children: <Widget>[
            //       Container(
            //         padding: const EdgeInsets.all(8),
            //         color: Colors.teal[100],
            //         child: const Text("He'd have you all unravel at the"),
            //       ),
            //       Container(
            //         padding: const EdgeInsets.all(8),
            //         color: Colors.teal[200],
            //         child: const Text('Heed not the rabble'),
            //       ),
            //       Container(
            //         padding: const EdgeInsets.all(8),
            //         color: Colors.teal[300],
            //         child: const Text('Sound of screams but the'),
            //       ),
            //       Container(
            //         padding: const EdgeInsets.all(8),
            //         color: Colors.teal[400],
            //         child: const Text('Who scream'),
            //       ),
            //       Container(
            //         padding: const EdgeInsets.all(8),
            //         color: Colors.teal[500],
            //         child: const Text('Revolution is coming...'),
            //       ),
            //       Container(
            //         padding: const EdgeInsets.all(8),
            //         color: Colors.teal[600],
            //         child: const Text('Revolution, they...'),
            //       ),
            //     ],
            //   ),
            // ),

            userList.isEmpty
                ? Center(child: CircularProgressIndicator())
                : Container(
                    height: 400,
                    width: MediaQuery.of(context).size.width,

                    //color: Colors.amber,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: userList.length,
                        // scrollDirection: Axis.horizontal,x
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(3),
                            child: Container(
                                //  padding: 10 ,
                                // height: 100,
                                width: 200,
                                color: Color.fromARGB(255, 206, 209, 210),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 0),
                                  child: Container(
                                    //height: 20,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      //shape: BoxShape.circle,
                                      borderRadius: BorderRadius.circular(50),

                                      // image: DecorationImage(
                                      //   image: NetworkImage(info[index].link),
                                      // ),
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl: userList[index].url,
                                      placeholder: (context, url) =>
                                          CachedNetworkImage(
                                              imageUrl:
                                                  userList[index].thumbnailUrl),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                  ),
                                )),
                          );
                        }),
                  ),
          ],
        ),
      ),
    );
  }
}
