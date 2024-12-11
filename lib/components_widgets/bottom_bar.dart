import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:my_web_app/constants/constants.dart';
import 'bottom_bar_column.dart';
import 'package:my_web_app/screens/about_us_screen.dart';
import 'package:my_web_app/screens/contact_us_screen.dart';
import 'info_text.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0),
        gradient: const LinearGradient(
          colors: [gradientStartColor, gradientEndColor],
          begin: FractionalOffset(0.2, 0.2),
          end: FractionalOffset(1.0, 1.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp,
        ),
      ),
      child: MediaQuery.of(context).size.width <800
          ? Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BottomBarColumn(
                  heading: 'ABOUT',
                s1: 'Contact us',
                s1Link: ContactUsPage.id,
                s2: 'About us',
                s2Link: AboutUsPage.id,
              ),
            ],
          ),
           const Divider(
            color: Colors.white60,
          ),
           const SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InfoText(
                type: 'Email',
                text: 'https://github.com/GargabeloGargabela',
                isEmail: true,
              ),
              SizedBox(height: 10),
              InfoText(
                type: 'Address',
                text:
                'Egypt, Cairo, Cairo University, Faculty of Engineering',
                isAddress: true,
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Divider(
            color: Colors.white60,
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () async {
              var addressUrl = 'https://github.com/GargabeloGargabela';
              try {
                await launchUrl(Uri.parse(addressUrl));
              } catch (e) {
                await Clipboard.setData(ClipboardData(text: addressUrl));
                debugPrint('Address Copied');
              }
            },
            child: Text(
              'Copyright © 2022 | Gargabelo Gargabela',
              style: TextStyle(
                color: Colors.blueGrey[100],
                fontSize: 14,
              ),
            ),
          ),
        ],
      ) :
          Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  BottomBarColumn(
                    heading: 'ABOUT',
                    s1: 'Contact us',
                    s1Link: ContactUsPage.id,
                    s2: 'About us',
                    s2Link: AboutUsPage.id,
                  ),
                  Container(
                    color: Colors.white60,
                    width: 2,
                    height: 150,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InfoText(
                        type: 'Email',
                        text: 'https://github.com/GargabeloGargabela',
                        isEmail: true,
                      ),
                      SizedBox(height: 10),
                      InfoText(
                        type: 'Address',
                        text:
                        'Egypt, Cairo, Cairo University, Faculty of Engineering',
                        isAddress: true,
                      ),
                    ],
                  ),
                ],
              ),
              const Divider(
                color: Colors.white60,
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () async {
                  var addressUrl = 'https://github.com/GargabeloGargabela';
                  try {
                    await launchUrl(Uri.parse(addressUrl));
                  } catch (e) {
                    await Clipboard.setData(ClipboardData(text: addressUrl));
                    debugPrint('Address Copied');
                  }
                },
                child: Text(
                  'Copyright © 2022 | Gargabelo Gargabela',
                  style: TextStyle(
                    color: Colors.blueGrey[100],
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          )
    );
  }
}
