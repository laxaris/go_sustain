import 'package:flutter/material.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width / 430;
    final double h = MediaQuery.of(context).size.height / 932;
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Padding(
            padding: EdgeInsets.only(top: 40.0 * h, bottom: 24.0 * h),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 24.0 * w),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back_ios_new_rounded,
                                size: 40 * w,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 75 * w,
                            ),
                            Text(
                              'Privacy',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 36 * w,
                                  fontFamily: "google_sans_display"),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 25 * h,
                      ),
                      ClipRRect(
                          borderRadius: BorderRadius.circular(50.0),
                          child: Container(
                            color: Colors.white,
                            height: 688 * h,
                            width: 430 * w,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 87 * h,
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 28 * w,
                                      ),
                                      Text(
                                        "Secret Account",
                                        style: TextStyle(
                                            fontSize: 24 * w,
                                            color:
                                                Color.fromRGBO(0, 0, 0, 0.5)),
                                      ),
                                      Spacer(),
                                      ToggleButton(),
                                      SizedBox(
                                        width: 28 * w,
                                      ),
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30.0),
                                    border: Border.all(
                                      color: Theme.of(context).primaryColor,
                                      width: 2 * w,
                                    ),
                                  ),
                                  height: 67 * h,
                                  width: 388 * w,
                                ),
                                SizedBox(
                                  height: 10 * h,
                                ),
                                ElevatedButton(
                                  onPressed: () {},
                                  child: Text(
                                    "Blocked Accounts",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 24 * w,
                                        color: Color.fromRGBO(0, 0, 0, 0.5)),
                                  ),
                                  style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(0),
                                    alignment: Alignment.centerLeft,
                                    minimumSize: MaterialStateProperty.all(
                                        Size(388 * w, 67 * h)),
                                    maximumSize: MaterialStateProperty.all(
                                        Size(388 * w, 67 * h)),
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Theme.of(context).primaryColor,
                                          width: 2 * w),
                                      borderRadius: BorderRadius.circular(30.0),
                                    )),
                                    padding: MaterialStateProperty.all(
                                        EdgeInsets.symmetric(
                                            horizontal: 31 * w)),
                                  ),
                                ),
                                SizedBox(
                                  height: 10 * h,
                                ),
                                ElevatedButton(
                                  onPressed: () {},
                                  child: Text(
                                    "Our Policy",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 24 * w,
                                        color: Color.fromRGBO(0, 0, 0, 0.5)),
                                  ),
                                  style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(0),
                                    alignment: Alignment.centerLeft,
                                    minimumSize: MaterialStateProperty.all(
                                        Size(388 * w, 67 * h)),
                                    maximumSize: MaterialStateProperty.all(
                                        Size(388 * w, 67 * h)),
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Theme.of(context).primaryColor,
                                          width: 2 * w),
                                      borderRadius: BorderRadius.circular(30.0),
                                    )),
                                    padding: MaterialStateProperty.all(
                                        EdgeInsets.symmetric(
                                            horizontal: 31 * w)),
                                  ),
                                ),
                              ],
                            ),
                          )),
                      SizedBox(
                        height: 10 * h,
                      ),
                      Center(
                        child: Image.asset(
                          'lib/images/image_2-removebg-preview.png',
                          height: 65 * h,
                          width: 65 * w,
                        ),
                      ),
                    ]),
              ),
            )));
  }
}

class ToggleButton extends StatefulWidget {
  @override
  _ToggleButtonState createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.5, // Increase the size of the switch
      child: Switch(
        value: isSwitched,
        onChanged: (value) {
          setState(() {
            isSwitched = value;
          });
        },
        activeTrackColor: Theme.of(context).primaryColor,
        activeColor: Colors.green,
        inactiveThumbColor: Colors.white,
        inactiveTrackColor: Colors.grey,
      ),
    );
  }
}
