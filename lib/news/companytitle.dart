import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:login_page/newstab/moneytab.dart';

class CompanyTitle extends StatelessWidget {
  final String companyTitle;
  final String companyDate;
  //final companyColor;
  final String imageName;

  final double borderRadius = 12;

  const CompanyTitle({
    super.key,
    required this.companyTitle,
    //required this.companyColor,
    required this.imageName,
    required this.companyDate,
  });

  @override
  Widget build(BuildContext) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 240, 238, 238),
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
                          Icons.download,
                          color: Colors.black,
                        )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                        padding: EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 240, 238, 238),
                          /*borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(borderRadius),
                                    topRight: Radius.circular(borderRadius)),*/
                        ),
                        //: EdgeInsets.all(12),
                        child: Text(
                          companyDate,
                          style: TextStyle(
                              //color: Color.fromARGB(255, 240, 238, 238),
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
                  const EdgeInsets.symmetric(horizontal: 36.0, vertical: 14),
              child: Image.asset(
                imageName,
                height: 80,
              ),
            ),

            // donut flavor
            Text(
              companyTitle,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),

            // love icon + add button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // plus button
                  Container(
                      margin: EdgeInsets.only(
                        left: 18,
                      ),
                      child: InkWell(
                        child: Text(
                          'Dowload',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[600],
                              fontSize: 15,
                              decoration: TextDecoration.underline),
                        ),
                        onTap: () {
                          print("downloaded");
                        },
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
