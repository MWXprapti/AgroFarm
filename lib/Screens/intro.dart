import 'package:flutter/material.dart';

import 'Login.dart';

class intro extends StatefulWidget {
  const intro({super.key});

  @override
  State<intro> createState() => _introState();
}

class _introState extends State<intro> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          bottomNavigationBar: BottomAppBar(
            shape: CircularNotchedRectangle(),
            color: Colors.transparent,
            elevation: 0,
            child: InkWell(
              child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                  color: Colors.purple[300],
                  borderRadius: BorderRadius.circular(10)
                ),

                child: Center(child: Text('Login',style: TextStyle(fontSize: 20,color: Colors.white),))
              ),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
              },
            ),
          ),
          body: PageView(
            children: [
              Container(
                height: 200,
                  color: Colors.white,
                  child: Center(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 50),
                            child: Container(
                              height: 300,
                              width: 300,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    image: AssetImage(
                                      "assets/1.jpeg",
                                    ),
                                    fit: BoxFit.contain
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0,left: 8,top: 30),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Text('Transfrom Speech into',
                                        style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Text Effortlessly',
                                      style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20,),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      style: TextStyle(fontSize: 20),
                                      textAlign: TextAlign.center,
                                      "App is an abbreviated form of the word application. An application is a software program that's designed to perform a specific function directly for the user or, in some cases, for another software program."),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 90,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 13,width: 13,
                                decoration: BoxDecoration(
                                    color: Colors.purple[300],
                                    shape: BoxShape.circle
                                ),
                              ),
                              SizedBox(width: 5,),
                              Container(
                                height: 13,width: 13,
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    shape: BoxShape.circle
                                ),
                              ),
                              SizedBox(width: 5,),
                              Container(
                                height: 13,width: 13,
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    shape: BoxShape.circle
                                ),
                              ),
                              SizedBox(width: 5,),
                              Container(
                                height: 13,width: 13,
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    shape: BoxShape.circle
                                ),
                              ),


                            ],
                          )
                        ],
                      )
                  )
              ),

              Container(
                  color: Colors.white,
                  height: 200,
                  child: Center(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 50),
                            child: Container(
                              height: 300,
                              width: 300,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    image: AssetImage(
                                      "assets/2.jpeg",
                                    ),
                                    fit: BoxFit.contain
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0,left: 8,top: 30),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Transfrom Speech into',
                                      style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Text Effortlessly',
                                      style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20,),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      style: TextStyle(fontSize: 20),
                                      textAlign: TextAlign.center,
                                      "App is an abbreviated form of the word application. An application is a software program that's designed to perform a specific function directly for the user or, in some cases, for another software program."),
                                ),
                                SizedBox(height: 90,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 13,width: 13,
                                      decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          shape: BoxShape.circle
                                      ),
                                    ),
                                    SizedBox(width: 5,),
                                    Container(
                                      height: 13,width: 13,
                                      decoration: BoxDecoration(
                                          color: Colors.purple[300],
                                          shape: BoxShape.circle
                                      ),
                                    ),
                                    SizedBox(width: 5,),
                                    Container(
                                      height: 13,width: 13,
                                      decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          shape: BoxShape.circle
                                      ),
                                    ),
                                    SizedBox(width: 5,),
                                    Container(
                                      height: 13,width: 13,
                                      decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          shape: BoxShape.circle
                                      ),
                                    ),


                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      )
                  )
              ),

              Container(
                  color: Colors.white,
                  height: 200,
                  child: Center(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 50),
                            child: Container(
                              height: 300,
                              width: 300,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    image: AssetImage(
                                      "assets/3.jpeg",
                                    ),
                                    fit: BoxFit.contain
                                ),
                              ),
                            ),
                          ),


                          Padding(
                            padding: const EdgeInsets.only(right: 8.0,left: 8,top: 30),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Transfrom Speech into',
                                      style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Text Effortlessly',
                                      style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20,),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      style: TextStyle(fontSize: 20),
                                      textAlign: TextAlign.center,
                                      "App is an abbreviated form of the word application. An application is a software program that's designed to perform a specific function directly for the user or, in some cases, for another software program."),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 90,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 13,width: 13,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  shape: BoxShape.circle
                                ),
                              ),
                              SizedBox(width: 5,),
                              Container(
                                height: 13,width: 13,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  shape: BoxShape.circle
                                ),
                              ),
                              SizedBox(width: 5,),
                              Container(
                                height: 13,width: 13,
                                decoration: BoxDecoration(
                                  color: Colors.purple[300],
                                  shape: BoxShape.circle
                                ),
                              ),
                              SizedBox(width: 5,),
                              Container(
                                height: 13,width: 13,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  shape: BoxShape.circle
                                ),
                              ),

                            ],
                          )
                        ],
                      )
                  )
              ),
              Container(
                  color: Colors.white,
                  height: 200,
                  child: Center(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 50),
                            child: Container(
                              height: 300,
                              width: 300,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    image: AssetImage(
                                      "assets/4.jpeg",
                                    ),
                                    fit: BoxFit.contain
                                ),
                              ),
                            ),
                          ),


                          Padding(
                            padding: const EdgeInsets.only(right: 8.0,left: 8,top: 30),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Transfrom Speech into',
                                      style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Text Effortlessly',
                                      style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20,),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      style: TextStyle(fontSize: 20),
                                      textAlign: TextAlign.center,
                                      "App is an abbreviated form of the word application. An application is a software program that's designed to perform a specific function directly for the user or, in some cases, for another software program."),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 90,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 13,width: 13,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  shape: BoxShape.circle
                                ),
                              ),
                              SizedBox(width: 5,),
                              Container(
                                height: 13,width: 13,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  shape: BoxShape.circle
                                ),
                              ),
                              SizedBox(width: 5,),
                              Container(
                                height: 13,width: 13,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  shape: BoxShape.circle
                                ),
                              ),
                              SizedBox(width: 5,),
                              Container(
                                height: 13,width: 13,
                                decoration: BoxDecoration(
                                  color: Colors.purple[300],
                                  shape: BoxShape.circle
                                ),
                              ),

                            ],
                          )
                        ],
                      )
                  )
              ),


            ],
          ),

    ));
  }
}
