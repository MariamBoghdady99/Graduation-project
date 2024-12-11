import 'package:flutter/material.dart';
import 'package:my_web_app/components_widgets/main_Button.dart';
import 'package:my_web_app/screens/sign_in_screen.dart';
import 'package:my_web_app/screens/home_screen.dart';
import 'package:my_web_app/screens/contact_us_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:auto_size_text/auto_size_text.dart';
// import 'package:my_web_app/screens/about_description.dart';
class AboutUsPage extends StatefulWidget {

  static String id = 'about_us_screen';

  const AboutUsPage({Key? key}) : super(key: key);

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
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
                onPressed: () {
                  Navigator.pushNamed(context, HomePage.id);
                },
                child: Text(
                  'Home',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'About us',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
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
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(
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
                    child: Text(
                      'SignUP',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 16,
                      ),
                    )),
                Container(width: .05*width,),
              ],
            )
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

                  Container(
                    width: .5 * (width),
                    height: .6 * height,
                    child: Image.asset('images/Dementia-pana.png'),
                  ),
                  Container(
                    width: .4*(width),
                    height: .6*height,
                    child: Column(
                      children: [
                        SizedBox(height: 50,),
                        Text('Who We Are',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 28,color: Colors.grey[600]),),
                        const Divider(
                          height: 40,
                          thickness: 5,
                          indent: 10,
                          endIndent: 0,
                          color: Colors.green,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:20.0),
                          child: Text('We are a team of Systems and Biomedical Engineering Student who are passionate about creating wearable technology that can help you monitor your health.',style: TextStyle(fontWeight: FontWeight.normal,fontStyle: FontStyle.italic,fontSize: 22,color: Colors.grey[600])),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:20.0),
                          child: Text('We started CURA because we wanted to provide a convenient, comfortable, and accurate way to measure your needed data anytime and anywhere',style: TextStyle(fontWeight: FontWeight.normal,fontStyle: FontStyle.italic,fontSize: 22,color: Colors.grey[600]),),
                        ),

                      ],
                    ),
                  ),
                  SizedBox(
                    width: width*.1,
                  ),

                ],
              ),
                SizedBox(height:height*.1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // SizedBox(width: width*.1,),
                    SizedBox(
                      width: width*.6,
                      child: Column(
                        children: [
                          //mission circle
                          Text('Our Mission',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 28,color: Colors.grey[600]),),
                          const Divider(
                            height: 40,
                            thickness: 5,
                            indent: 10,
                            endIndent: 0,
                            color: Colors.green,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:20.0),
                            child: Text('Providing a convenient, comfortable, and accurate way to monitor your vital signs using a vest or smart watch. We believe that data and insights can help you improve your well-being and achieve your goals.',
                                style: TextStyle(fontWeight: FontWeight.normal,fontStyle: FontStyle.italic,fontSize: 22,color: Colors.grey[600])),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(left:20),
                            child: Text('We are committed to delivering high-quality products, features, and services that meet your needs and expectations. We are also dedicated to creating a positive impact on the world by promoting health awareness and innovation.',
                                style: TextStyle(fontWeight: FontWeight.normal,fontStyle: FontStyle.italic,fontSize: 22,color: Colors.grey[600])),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: width*.2,
                    child: Image.asset('images/mission.png'),),
                  ],
                ),
                SizedBox(height:height*.1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: width*.2,
                      child: Image.asset('images/vision.png'),),
                    SizedBox(
                      width: width*.6,
                      child: Column(
                        children: [
                          //mission circle
                          Text('Our vision',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 28,color: Colors.grey[600]),),
                          const Divider(
                            height: 40,
                            thickness: 5,
                            indent: 10,
                            endIndent: 0,
                            color: Colors.green,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:20.0),
                            child: Text('Becoming the leading provider of wearable technology for vital signs monitoring. We aspire to empower people with data and insights that can help them live healthier, happier, and longer lives.',style: TextStyle(fontWeight: FontWeight.normal,fontStyle: FontStyle.italic,fontSize: 22,color: Colors.grey[600])),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:20.0),
                            child: Text('We also aim to contribute to the advancement of health research and science by providing rich and reliable data. We envision a future where everyone can access and benefit from our products and services.',style: TextStyle(fontWeight: FontWeight.normal,fontStyle: FontStyle.italic,fontSize: 22,color: Colors.grey[600])),
                          ),
                        ],
                      ),
                    ),
                    // SizedBox(width: width*.1,),
                  ],
                ),
                SizedBox(height:height*.1),
                Column(
                  children: [
                    Text('Our Values',
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.grey[600]),),
                    SizedBox(
                      width:width*.3,
                      child: const Divider(
                        height: 40,
                        thickness: 5,
                        indent: 10,
                        endIndent: 0,
                        color: Colors.green,
                      ),
                    ),
                    SizedBox(
                      width: width*.8,
                      child: Padding(
                        padding: const EdgeInsets.only(left:40.0),
                        child: Text('At CURA, we are guided by our core values that shape our culture and our service. Our values are:',
                            style: TextStyle(fontWeight: FontWeight.normal,fontStyle: FontStyle.italic,fontSize: 25,color: Colors.grey[600])
                        ),
                      ),
                    ),
                    SizedBox(height:20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: width*.2,
                          child: Column(
                            children: [
                              Text(
                                  'Empathy',
                                style: TextStyle(fontSize: 20,color: Colors.grey.shade600,fontWeight: FontWeight.bold,),
                              ),
                              const SizedBox(height:10,),
                              Text(
                                'We care about our customers and their well-being. We listen to their feedback and provide them with data and insights that can help them improve their health and happiness.',
                                style: TextStyle(fontSize: 18,color: Colors.grey.shade600,),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width:width*.03),
                        SizedBox(
                          width: width*.2,
                          child: Column(
                            children: [
                              Text(
                                'Integrity',
                                style: TextStyle(fontSize: 20,color: Colors.grey.shade600,fontWeight: FontWeight.bold,),
                              ),
                              const SizedBox(height:10,),
                              Text(
                          'We are honest, transparent, and ethical in everything we do. We respect our customers\' privacy and security and follow the best practices in data protection and management.',
                                style: TextStyle(fontSize: 18,color: Colors.grey.shade600,),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width:width*.03),
                        SizedBox(
                          width: width*.2,
                          child: Column(
                            children: [
                              Text(
                                'Impact',
                                style: TextStyle(fontSize: 20,color: Colors.grey.shade600,fontWeight: FontWeight.bold,),
                              ),
                              const SizedBox(height:10,),
                              Text(
                                'We aim to create a positive impact on the world by promoting health awareness and innovation. We also contribute to the advancement of health research and science by providing rich and reliable data.',
                                style: TextStyle(fontSize: 18,color: Colors.grey.shade600,),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height:20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: width*.2,
                          child: Column(
                            children: [
                              Text(
                                'Innovation',
                                style: TextStyle(fontSize: 20,color: Colors.grey.shade600,fontWeight: FontWeight.bold,),
                              ),
                              const SizedBox(height:10,),
                              Text(
                                'We are always looking for new and better ways to create wearable technology that can monitor vital signs with ease and accuracy.',
                                style: TextStyle(fontSize: 18,color: Colors.grey.shade600,),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width:width*.03),
                        SizedBox(
                          width: width*.2,
                          child: Column(
                            children: [
                              Text(
                                'Quality',
                                style: TextStyle(fontSize: 20,color: Colors.grey.shade600,fontWeight: FontWeight.bold,),
                              ),
                              const SizedBox(height:10,),
                              Text(
                                'We are committed to delivering high-quality products, features, and services that meet or exceed our customers\' needs and expectations.',
                                style: TextStyle(fontSize: 18,color: Colors.grey.shade600,),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height:20,),
                    SizedBox(
                      width: width*.8,
                      child: Padding(
                        padding: const EdgeInsets.only(left:40.0),
                        child: Text(
                          'These values are not just words on a page. They are the principles that drive our actions and decisions every day. They are what make us CURA.',
                            style: TextStyle(fontWeight: FontWeight.normal,fontStyle: FontStyle.italic,fontSize: 25,color: Colors.grey[600])
                        ),
                      ),
                    )

                  ],
                ),
                SizedBox(height:height*.1),
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
                      SizedBox(width: 50,),
                      SizedBox(
                        width:40,
                        child: Image.asset('images/whatsapp.png'),
                      ),
                      SizedBox(width: 50,),
                      SizedBox(
                        width:40,
                        child: Image.asset('images/gmail.png'),
                      ),
                      SizedBox(width: 50,),
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
    );
  }
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
    ovalPath.quadraticBezierTo(width*.05, height*.25, width*.1, height*.6);
    //paint a curve from current position to bottom left of screen at width*.1
    ovalPath.quadraticBezierTo(width*.12, height*.7, width*.05, height);
    //draw remaining line to bottom left side
    ovalPath.lineTo(0, height);
    //close line to reset it back
    ovalPath.close();
    paint.color = Colors.green.shade100;
    canvas.drawPath(ovalPath, paint);

    //start point from 20% width to the left
    ovalPath.moveTo(width*.93, 0);
    //paint a curve from current position to middle of the screen
    ovalPath.quadraticBezierTo(width*.95, height*.1, width, height*.1);
    //draw remaining line to bottom left side
    ovalPath.lineTo(width, 0);
    //close line to reset it back
    ovalPath.close();
    paint.color = Colors.green.shade100;
    canvas.drawPath(ovalPath, paint);

    ovalPath.moveTo(width*.83, height);
    //paint a curve from current position to middle of the screen
    ovalPath.quadraticBezierTo(width*.85, height*.8, width, height*.8);
    //draw remaining line to bottom left side
    ovalPath.lineTo(width, height);
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