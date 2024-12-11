import 'package:flutter/material.dart';
import 'package:my_web_app/responsive.dart';
import 'package:my_web_app/screens/about_us_screen.dart';
import 'package:my_web_app/screens/contact_us_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_web_app/screens/log_in_screen.dart';
import 'package:my_web_app/screens/sign_in_screen.dart';
//import 'package:carousel_pro/carousel_pro.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:my_web_app/used_components/main_Button.dart';

class MyItem {
  String itemName;
  String path;

  MyItem({required this.itemName, required this.path});
}

class HomePage extends StatefulWidget {
  static String id = 'home_screen';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int activeIndex = 0;

  List<MyItem> items = [
    MyItem(
        itemName: 'Helping you to take care of your beloved family',
        path: 'images/home1.png'),
    MyItem(
        itemName: 'we are your children and supporters',
        path: 'images/home2.png'),
    MyItem(itemName: 'Never feel alone', path: 'images/home3.png'),
    // MyItem(itemName: 'We all here for you', path: 'images/HM4.jpg'),
    // MyItem(itemName: 'We all love you', path: 'images/HM5.jpg')
  ];
  //fade
  /*var _controller=ScrollController(initialScrollOffset: 2.0);
   late AnimationController animation;*/
  //fade
  /*void initState() {
    super.initState();
    // animation=AnimationController(vsync:this);
    animation=AnimationController(duration: Duration(milliseconds: 100),vsync:this);
    _controller.addListener(() {
      animation.value=1-_controller.offset/_controller.position.maxScrollExtent;
    });
  }*/
  @override
  // late final AnimationController _controller = AnimationController(
  //   duration: const Duration(seconds: 2),
  //   vsync: this,
  // )..repeat(reverse: true);
  // late final Animation<Offset> _offsetAnimation = Tween<Offset>(
  //   begin: Offset.zero,
  //   end: const Offset(1.5, 0.0),
  // ).animate(CurvedAnimation(
  //   parent: _controller,
  //   curve: Curves.elasticIn,
  // ));

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }
  //
  // @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    //slide transition
    /*return SlideTransition(
      position: _offsetAnimation,
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: FlutterLogo(size: 150.0),
      ),
    );*/
    //fade transition
    /*return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Image.asset('images/logo.png'),
          /*Builder(
          builder: (BuildContext context) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 4,
                  // width: 40,
                  // height: 40,
                  child: Image.asset('images/logo.png'),
                ),
                Text('CURA'),
              ],
            );
          },
        ),*/
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Text('CURA'),
              // SizedBox(
              //   width: double.,
              // ),

              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                  primary: Colors.black87,
                  minimumSize: Size(88, 36),
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  'Home',
                  style: TextStyle(color: Colors.blueGrey.shade50),
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, AboutUsPage.id);
                },
                child: Text(
                  'About us',
                  style: TextStyle(color: Colors.brown),
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, ContactUsPage.id);
                },
                child: Text(
                  'Contact Us',
                  style: TextStyle(color: Colors.brown),
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
            ],
          ),
        ),
        body:Center(
          child:Container(
            width: width,
            height: height,
            child: SingleChildScrollView(
                controller: _controller,
                child:Column(
                  children: [
                    FadeTransition(
                        opacity: (animation),
                        alwaysIncludeSemantics: true,
                        child:Column(
                          children: [
                            Container(
                              width: 300,
                              height: 600,
                              child: Image.asset('images/home1.png'),
                            ),
                          ],
                        )
                    ),
                    FadeTransition(
                        opacity: animation,
                        child:Column(
                          children: [
                            Container(
                              width: 300,
                              height: 600,
                              child: Image.asset('images/home2.png'),
                            ),
                          ],
                        )
                    ),
                  ],
                )
            ),
          ),
        )
    );*/
    //original code
    return Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          // backgroundColor: Colors.blueGrey,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leadingWidth: 200,
          leading: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Row(
                  children: [
                    SizedBox(
                      child: Image.asset('images/OIG.png'),
                    ),
                    Text(
                      'CURA',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              )),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Home',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    // decoration: TextDecoration.underline,
                    // decorationThickness: 20.0,
                  ),
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, AboutUsPage.id);
                },
                child: const Text(
                  'About us',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, ContactUsPage.id);
                },
                child: const Text(
                  'Contact Us',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
            ],
          ),
          actions: [
            Row(
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, SignUpPage.id);
                    },
                    child: const Text(
                      'SignUP',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 16,
                      ),
                    )),
                Container(width: .05*width,),
              ],
            ),
          ],
        ),
        body:CustomPaint(
          painter: BluePainter(),
          child: Center(
            child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: width*.1,
                      ),
                      SizedBox(
                        width: .4*(width),
                        height: .6*height,
                        child: Column(
                          children: [
                            const SizedBox(height: 100,),
                            Text('WHY CURA',
                              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.grey[600]),),
                            const Divider(
                              height: 40,
                              thickness: 5,
                              indent: 10,
                              endIndent: 0,
                              color: Colors.green,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left:40.0),
                              child: Text('The smart way to monitor your vital signs With CURA, you can track any data you need using a vest or smart watch.',
                                  style: TextStyle(fontWeight: FontWeight.normal,fontStyle: FontStyle.italic,fontSize: 25,color: Colors.grey[600])
                              ),
                            ),
                            const SizedBox(height: 15,),
                            Padding(
                              padding: const EdgeInsets.only(left:40.0),
                              child: Text(
                                  'CURA uses wearable smart sensors that are comfortable, convenient and accurate.',
                                  style: TextStyle(fontWeight: FontWeight.normal,fontStyle: FontStyle.italic,fontSize: 25,color: Colors.grey[600])
                              ),
                            ),

                          ],
                        ),
                      ),
                      Center(
                        child: SizedBox(
                          width: .5 * (width),
                          height: .6 * height,
                          child: Image.asset('images/home-bro.png'),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height:height*.2,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'The wearable technology that tracks your vital signs anytime and anywhere',
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.grey[600]),
                      ),
                      SizedBox(
                        width: width*.8,
                        child: const Divider(
                          height: 40,
                          thickness: 5,
                          indent: 10,
                          endIndent: 0,
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(
                        width: width*.7,
                        child: Text('In CURA, We propose a real-time remote health monitoring system for vital signs and activity level by accessing different systems that monitor signs like smart watch, Google Fit or our monitoring vest',
                            style: TextStyle(fontWeight: FontWeight.normal,fontStyle: FontStyle.italic,fontSize: 25,color: Colors.grey[600])
                        ),
                      ),
                      SizedBox(height:height*.1),
                      SizedBox(
                        width:width*.7,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                SizedBox(width:width*.7*.1,child: Image.asset('images/3.gif')),
                                Text(
                                  'Temperature',
                                  style: TextStyle(fontSize: 20,color: Colors.grey.shade600,),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                SizedBox(width:width*.7*.1,child: Image.asset('images/2.gif')),
                                Text(
                                  'Heart Rate',
                                  style: TextStyle(fontSize: 20,color: Colors.grey.shade600,),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                SizedBox(width:width*.7*.1,child: Image.asset('images/4.gif')),
                                Text(
                                  'Non-Invasive Blood Pressure',
                                  style: TextStyle(fontSize: 20,color: Colors.grey.shade600,),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                SizedBox(width:width*.7*.1,child: Image.asset('images/steps.gif')),
                                Text(
                                  'Steps',
                                  style: TextStyle(fontSize: 20,color: Colors.grey.shade600,),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height:height*.1,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: SizedBox(
                          width: .6 * (width),
                          height: .6 * height,
                          child: Image.asset('images/home-bro.png'),
                        ),
                      ),
                      SizedBox(
                        width: .3*(width),
                        height: .8*height,
                        child: Column(
                          children: [
                            const SizedBox(height: 50,),
                            Text('Our Monitoring Vest',
                              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.grey[600]),),
                            const Divider(
                              height: 40,
                              thickness: 5,
                              indent: 10,
                              endIndent: 0,
                              color: Colors.green,
                            ),
                            Text(
                                'The vest syncs your data with the VitalTrack website, where you can view, manage, and analyze your vital signs in real-time. You can also access historical reports and trends, set alerts, and share your data with your doctor. It helps you track your health with ease and accuracy.',
                                style: TextStyle(fontWeight: FontWeight.normal,fontStyle: FontStyle.italic,fontSize: 25,color: Colors.grey[600])
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: width*.1,
                      ),
                    ],
                  ),
                  SizedBox(height:height*.1,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'The Benefits',
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.grey[600]),
                      ),
                      SizedBox(
                        width: width*.3,
                        child: const Divider(
                          height: 40,
                          thickness: 5,
                          indent: 10,
                          endIndent: 0,
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(
                        width: width*.7,
                        child: Text('Vital signs monitoring is crucial for living a long and healthy life. Vital signs give us a glimpse into our overall well-being and signal early signs of any health issues',
                            style: TextStyle(fontWeight: FontWeight.normal,fontStyle: FontStyle.italic,fontSize: 25,color: Colors.grey[600])
                        ),
                      ),
                      SizedBox(height:height*.1),
                      SizedBox(
                        width:width*.9,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width:width*.2,
                              child: Column(
                                children: [
                                  Text(
                                    'Convenience',
                                    style: TextStyle(fontSize: 20,color: Colors.grey.shade600,fontWeight: FontWeight.bold,),
                                  ),
                                  const SizedBox(height:10,),
                                  Text(
                                    'You can monitor your vital signs anytime and anywhere using a vest or smart watch. No need to visit a clinic or use bulky equipment.',
                                    style: TextStyle(fontSize: 18,color: Colors.grey.shade600,),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width:width*.2,
                              child: Column(
                                children: [
                                  Text(
                                    'Accuracy',
                                    style: TextStyle(fontSize: 20,color: Colors.grey.shade600,fontWeight: FontWeight.bold,),
                                  ),
                                  const SizedBox(height:10,),
                                  Text(
                                    'Our products use smart sensors that measure your vital signs with precision and reliability. You can trust our data and insights to reflect your true health condition.',
                                    style: TextStyle(fontSize: 18,color: Colors.grey.shade600,),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width:width*.2,
                              child: Column(
                                children: [
                                  Text(
                                    'Prevention',
                                    style: TextStyle(fontSize: 20,color: Colors.grey.shade600,fontWeight: FontWeight.bold,),
                                  ),
                                  const SizedBox(height:10,),
                                  Text(
                                    'Our service can help you detect symptom-less medical problems, such as high blood pressure, low oxygen saturation, or irregular heart rhythm. You can also prevent a misdiagnosis by having accurate and consistent data to share with your doctor.',
                                    style: TextStyle(fontSize: 18,color: Colors.grey.shade600,),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width:width*.2,
                              child: Column(
                                children: [
                                  Text(
                                    'Improvement',
                                    style: TextStyle(fontSize: 20,color: Colors.grey.shade600,fontWeight: FontWeight.bold,),
                                  ),
                                  const SizedBox(height:10,),
                                  Text(
                                    'Our service can help you improve your performance, manage your stress, and track your sleep. You can also set alerts and goals, and view historical reports and trends to see your progress over time.',
                                    style: TextStyle(fontSize: 18,color: Colors.grey.shade600,),
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height:height*.1,),
                  Container(
                    width: width,
                    height: height*.2,
                    color: Colors.green.shade100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width:40,
                          child: Image.asset('images/facebook.png'),
                        ),
                        const SizedBox(width: 50,),
                        SizedBox(
                          width:40,
                          child: Image.asset('images/whatsapp.png'),
                        ),
                        const SizedBox(width: 50,),
                        SizedBox(
                          width:40,
                          child: Image.asset('images/gmail.png'),
                        ),
                        const SizedBox(width: 50,),
                        SizedBox(
                          width:40,
                          child: Image.asset('images/telephone.png'),
                        ),
                      ],
                    ),
                  ),
                ]
            ),
          ),
        )

      ///////////////////////warning
      //preferred appbar
      /*appBar: PreferredSize(
        child: ClipPath(
          clipper: WaveClipper(),
          child: Container(
            height: 200,
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 50,
                          // width: 600,
                          child: Image.asset('images/logo.png'),

                        ),
                        Text('CURA',style: TextStyle(color: Colors.blueGrey),),


                      ],
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {},
                          // style: ButtonStyle(
                          //   backgroundColor: Color(0xFFd9e5ff),
                          // ),
                          child: Text(
                            'Home',
                            style: TextStyle(color: Colors.blueGrey),
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, AboutUsPage.id);
                          },
                          child: Text(
                            'About us',
                            style: TextStyle(color: Colors.blueGrey),
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, ContactUsPage.id);
                          },
                          child: Text(
                            'Contact Us',
                            style: TextStyle(color: Colors.blueGrey),
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        preferredSize: Size.fromHeight(100),
      ),*/
      //body single child scroll view
      /*body: SingleChildScrollView(
        child: Column(
          children: [
            ClipPath(
              clipper: WaveClipper(),
              child: Container(
                height: 150,
                color: Colors.white,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 30,
                ),
                Text('data'),
                Container(
                  width: .6 * width,
                  height: .7* height,
                  child: Image.asset('images/home1.png'),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: .6 * width,
                  height: .7* height,
                  child: Image.asset('images/home2.png'),
                ),
                Text('data'),
                SizedBox(
                  width: 30,
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 30,
                ),
                Text('data'),
                Container(
                  width: .6 * width,
                  height: .7* height,
                  child: Image.asset('images/home3.png'),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            MainButton(
                text: 'Get Started',
                colors: [
                  Colors.blueGrey.shade100,
                  Colors.blueGrey,

                  // Colors.deepOrange.shade400,
                ],
                isOnlight: false,
                onPressed: () {
                  Navigator.pushNamed(context, SignUpPage.id);
                },
                ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),*/

      /*body: Container(
        child: Stack(
          children: [
            Opacity(
              opacity: 0.5,
              child: ClipPath(
                clipper: WaveClipper(),
                child: Container(
                  color: Colors.blueGrey,
                  height: 200,
                ),
              ),
            ),
          ],
        ),
      ),*/
      /*body: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Column(
                children: [

                  CarouselSlider.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index, realIndex) {
                      final imgList = items[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(child: buildImage(imgList.path, index)),
                          const SizedBox(
                            height: 15,
                          ),
                          buildText(imgList.itemName, index),
                        ],
                      );
                    },
                    options: CarouselOptions(
                      height: MediaQuery.of(context).size.height - 150,
                      viewportFraction: 1,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                      autoPlayInterval: const Duration(seconds: 7),
                      onPageChanged: (index, reason) {
                        setState(() {
                          activeIndex = index;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            MainButton(
                text: 'Get Started',

                colors: [
                  Colors.redAccent,
                  Colors.brown,
                  // Colors.deepOrange.shade400,
                ],
                isOnlight: false,
                onPressed: () {
                  Navigator.pushNamed(context, SignUpPage.id);
                }),
            SizedBox(
              height: 10.0,
            ),
            // MainButton(
            //     text: 'Log in',
            //     colors: [
            //       Colors.white,
            //       Color(0xFFE1F5FE),
            //     ],
            //     isOnlight: false,
            //     onPressed: () {
            //       Navigator.pushNamed(context, LogInPage.id);
            //     })
          ],
        ),
      ),*/
    );
  }

  Widget buildImage(String imgList, int index) => Container(
    margin: const EdgeInsets.symmetric(horizontal: 12),
    color: Colors.transparent,
    child: Align(
      alignment: Alignment.center,
      child: Image.asset(
        imgList,
        fit: BoxFit.cover,
      ),
    ),
  );

  buildIndicator() => AnimatedSmoothIndicator(
    activeIndex: activeIndex,
    count: items.length,
    effect: const JumpingDotEffect(
        dotColor: Colors.black,
        dotHeight: 15,
        dotWidth: 15,
        activeDotColor: Color(0xFF00E5FF)),
  );

  buildText(String itemName, int index) => Align(
      alignment: FractionalOffset.bottomCenter,
      child: Text(
        itemName,
        style: const TextStyle(
            fontWeight: FontWeight.w700, fontSize: 23, color: Colors.brown),
      ));
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    debugPrint(size.width.toString());
    var path = new Path();
    path.lineTo(0, size.height);
    var firstStart = Offset(size.width / 5, size.height);
    //first point of quadratic bezier curve
    var firstEnd = Offset(size.width / 2.25, size.height - 50.0);
    //second point of quadratic bezier curve
    path.quadraticBezierTo(
        firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);
    var secondStart =
    Offset(size.width - (size.width / 3.24), size.height - 105);
    //third point of quadratic bezier curve
    var secondEnd = Offset(size.width, size.height - 10);
    //fourth point of quadratic bezier curve
    path.quadraticBezierTo(
        secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
// @override
// dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class BluePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size){
    final height = size.height;
    final width = size. width;
    Paint paint = Paint();

    Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, width, height));
    paint.color = Colors.white;
    canvas.drawPath(mainBackground, paint);

    Path ovalPath = Path();
    //start point from 20% height to the left
    ovalPath.moveTo(0, height*.2);
    //paint a curve from current position to middle of the screen
    ovalPath.quadraticBezierTo(width*.15, height*.25, width*.21, height*.5);
    //paint a curve from current position to bottom left of screen at width*.1
    ovalPath.quadraticBezierTo(width*.28, height*.8, width*.1, height);
    //draw remaining line to bottom left side
    ovalPath.lineTo(0, height);
    //close line to reset it back
    ovalPath.close();
    paint.color = Colors.green.shade100;
    canvas.drawPath(ovalPath, paint);

    //start point from 20% width to the left
    ovalPath.moveTo(width*.93, 0);
    //paint a curve from current position to middle of the screen
    ovalPath.quadraticBezierTo(width*.95, height*.15, width, height*.18);
    //draw remaining line to bottom left side
    ovalPath.lineTo(width, 0);
    //close line to reset it back
    ovalPath.close();
    paint.color = Colors.green.shade100;
    canvas.drawPath(ovalPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate){
    return oldDelegate != this;
  }
}
class addPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    Paint paint = Paint();

    Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, width, height));
    paint.color = Colors.white;
    canvas.drawPath(mainBackground, paint);

    Path ovalPath = Path();


    //bottom left
    ovalPath.moveTo(width * .83, height);
    //paint a curve from current position to middle of the screen
    ovalPath.quadraticBezierTo(width * .85, height * .8, width, height * .8);
    //draw remaining line to bottom left side
    ovalPath.lineTo(width, height);
    //close line to reset it back
    ovalPath.close();
    paint.color = Colors.green.shade100;
    canvas.drawPath(ovalPath, paint);
  }


  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
class TablePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    Paint paint = Paint();

    Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, width, height));
    paint.color = Colors.grey.shade200;
    canvas.drawPath(mainBackground, paint);

    Path ovalPath = Path();


    //start point from 20% height to the left
    ovalPath.moveTo(0, height*.2);
    //paint a curve from current position to middle of the screen
    ovalPath.quadraticBezierTo(width*.05, height*.25, width*.1, height*.6);
    //paint a curve from current position to bottom left of screen at width*.1
    ovalPath.quadraticBezierTo(width*.12, height*.7, width*.05, height);
    //draw remaining line to bottom left side
    ovalPath.lineTo(0, height);
    //close line to reset it back
    ovalPath.close();
    paint.color = Colors.green.shade100;
    canvas.drawPath(ovalPath, paint);


    //bottom right
    ovalPath.moveTo(width * .83, height);
    //paint a curve from current position to middle of the screen
    ovalPath.quadraticBezierTo(width * .85, height * .8, width, height * .8);
    //draw remaining line to bottom left side
    ovalPath.lineTo(width, height);
    //close line to reset it back
    ovalPath.close();
    paint.color = Colors.green.shade100;
    canvas.drawPath(ovalPath, paint);
    //bottom left
    /*ovalPath.moveTo(width * .25, height);
    //paint a curve from current position to middle of the screen
    ovalPath.quadraticBezierTo(width * .23, height * .9, 0, height * .85);
    //draw remaining line to bottom left side
    ovalPath.lineTo(0, height);
    //close line to reset it back
    ovalPath.close();
    paint.color = Colors.green.shade100;
    canvas.drawPath(ovalPath, paint);*/
  }


  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}