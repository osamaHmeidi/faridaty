import 'package:flutter/material.dart';

class PrayerTimeCard extends StatelessWidget {
  final String prayerName;
  final String prayerTime;
  final Color backgroundColor;
  final IconData iconData;

  PrayerTimeCard(
      this.prayerName, this.prayerTime, this.backgroundColor, this.iconData);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(iconData, size: 40),
            SizedBox(width: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  prayerName,
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width / 20,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  prayerTime,
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width / 25),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
