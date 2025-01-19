import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:login_page/newstab/moneytab.dart';

class MoneyTitle extends StatelessWidget {
  final String moneyTitle;
  final String moneyDate;
  final moneyColor;
  final String imageName;
  final String moneygold;
  final String updown;

  final double borderRadius = 12;

  const MoneyTitle({
    super.key,
    required this.moneyTitle,
    required this.moneyDate,
    required this.moneyColor,
    required this.imageName,
    required this.moneygold,
    required this.updown,
  });

  @override
  Widget build(BuildContext) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(
          color: moneyColor[50],
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Column(
          children: [
            // price
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        padding: EdgeInsets.only(top: 4, left: 4),
                        child: Icon(
                          Icons.monetization_on,
                          color: Color.fromARGB(255, 35, 173, 40),
                        )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          color: moneyColor[100],
                          /*borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(borderRadius),
                                    topRight: Radius.circular(borderRadius)),*/
                        ),
                        //: EdgeInsets.all(12),
                        child: Text(
                          moneyDate,
                          style: TextStyle(
                              color: moneyColor[800],
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        )),
                  ],
                ),
              ],
            ),

            // donut picture
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 36.0, vertical: 16),
              child: Image.asset(
                imageName,
                height: 80,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            // donut flavor
            Text(
              moneyTitle,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '$moneygold\B \$',
              style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                  decoration: TextDecoration.underline),
            ),

            // love icon + add button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // plus button
                  Container(
                      margin: EdgeInsets.only(
                        top: 8,
                        left: 18,
                      ),
                      child: InkWell(
                        child: Text(
                          'Details',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[600],
                              fontSize: 15,
                              decoration: TextDecoration.underline),
                        ),
                        onTap: () {},
                      )),
                  updown == "up"
                      ? Icon(
                          FontAwesomeIcons.levelUpAlt,
                          color: Colors.green,
                          size: 18,
                        )
                      : Icon(
                          FontAwesomeIcons.levelDownAlt,
                          color: Colors.red,
                          size: 18,
                        ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
