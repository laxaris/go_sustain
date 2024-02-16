import 'dart:ui' as ui;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProjectPage extends StatefulWidget {
  final String projectID;
  ProjectPage({required this.projectID, super.key});

  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  @override
  Widget build(BuildContext context) {
    int donationAmount = 5;

    double h = MediaQuery.of(context).size.height / 932;
    double w = MediaQuery.of(context).size.width / 430;
    void _changeDonationAmount(double value) {
      donationAmount = value.round();
    }

    void _makeDonate() {
      Navigator.pushNamed(context, '/payment', arguments: {
        'projectID': widget.projectID,
        'donationAmount': donationAmount
      });
    }

    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('projects')
            .doc(widget.projectID)
            .get(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              backgroundColor: Theme.of(context).primaryColor,
              body: Padding(
                padding: EdgeInsets.only(top: 40.0 * h, bottom: 24.0 * h),
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              ),
            );
          }
          final data = snapshot.data!.data() as Map<String, dynamic>;
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
                                    width: 280 * w,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Text(
                                        data['projectName'],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 36 * w,
                                            fontFamily: "google_sans_display"),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.more_horiz,
                                        color: Colors.white,
                                        size: 50 * w,
                                      )),
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
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: 39 * h,
                                          left: 18.0 * w,
                                          right: 14.0 * w),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      width: 2.0 * w),
                                                ),
                                                child: CircleAvatar(
                                                  radius: 101 * w,
                                                  backgroundImage: NetworkImage(
                                                      data['imageUrl']),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 12 * w,
                                              ),
                                              Container(
                                                  width: 180 * w,
                                                  height: 202 * h,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                          width: 2 * w),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30)),
                                                  child: Center(
                                                      child: Container(
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          'Explanation',
                                                          style:
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 10 * w),
                                                          child:
                                                              SingleChildScrollView(
                                                                  child: Text(
                                                            data['explanation'],
                                                          )),
                                                        )
                                                      ],
                                                    ),
                                                  ))),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 41 * h,
                                          ),
                                          BubbleText(
                                            title: 'Project Goal',
                                            data: data['projectGoal'],
                                          ),
                                          SizedBox(
                                            height: 15 * h,
                                          ),
                                          BubbleText(
                                            title: 'Project Category',
                                            data: data['projectCategory'],
                                          ),
                                          SizedBox(
                                            height: 20 * h,
                                          ),
                                          Text('Degree of Sustainability',
                                              style: TextStyle(
                                                color: Color.fromRGBO(
                                                    0, 0, 0, 0.5),
                                                fontSize: 27 * w,
                                                fontWeight: FontWeight.w400,
                                              )),
                                          SizedBox(
                                            height: 7 * h,
                                          ),
                                          Container(
                                            child: Center(
                                              child: Text(
                                                data['degreeOfSustainability'],
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16 * w,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                            width: 27 * w,
                                            height: 27 * w,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 14 * h,
                                          ),
                                          Text('Choose donation amount',
                                              style: TextStyle(
                                                color: Color.fromRGBO(
                                                    0, 0, 0, 0.5),
                                                fontSize: 27 * w,
                                                fontWeight: FontWeight.w400,
                                              )),
                                          SizedBox(
                                            width: 244 * w,
                                            child: Column(
                                              children: [
                                                CustomSlider(
                                                    changeDonationAmount:
                                                        _changeDonationAmount,
                                                    goalAmount: double.parse(
                                                        data['goalMoney'])),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "\$ 5",
                                                      style: TextStyle(
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                        fontSize: 16 * w,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    Text(
                                                      "\$ ${data['goalMoney']}",
                                                      style: TextStyle(
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                        fontSize: 16 * w,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                ElevatedButton(
                                                    style: ButtonStyle(
                                                        minimumSize:
                                                            MaterialStateProperty.all(Size(
                                                                158 * w,
                                                                40 * h)),
                                                        maximumSize: MaterialStateProperty.all(Size(
                                                            158 * w,
                                                            40 *
                                                                h)), // Text color
                                                        backgroundColor:
                                                            MaterialStateProperty.all(
                                                                Theme.of(context)
                                                                    .primaryColor), // Background color
                                                        shape: MaterialStateProperty.all(
                                                            RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                        30.0))), // Button shape
                                                        padding: MaterialStateProperty.all(
                                                            EdgeInsets.symmetric(horizontal: 25 * w))), // Button padding

                                                    onPressed: _makeDonate,
                                                    child: Text('Donate', style: TextStyle(color: Colors.white, fontSize: 22 * w, fontWeight: FontWeight.w400, fontFamily: "google_sans_display"))),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ))),
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
        });
  }
}

class CustomSlider extends StatefulWidget {
  double goalAmount;
  final Function(double) changeDonationAmount;
  CustomSlider(
      {required this.changeDonationAmount,
      required this.goalAmount,
      super.key});

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  double donationAmount = 5;
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height / 932;
    double w = MediaQuery.of(context).size.width / 430;
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        trackHeight: 10.0 * h,
        activeTrackColor: Theme.of(context).primaryColor,
        inactiveTrackColor: Color.fromRGBO(0, 0, 0, 0.5),
        thumbColor: Theme.of(context).primaryColor,
        overlayColor: Color.fromRGBO(30, 124, 64, 1),
        valueIndicatorColor: Theme.of(context).primaryColor,
        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 13.0 * w),
        overlayShape: RoundSliderOverlayShape(overlayRadius: 15.0 * w),
      ),
      child: Slider(
        divisions: ((widget.goalAmount.round() - 5) / 5).round(),
        min: 5,
        max: widget.goalAmount,
        value: donationAmount,
        label: donationAmount.round().toString(),
        onChanged: (value) {
          setState(() {
            donationAmount = value;
            widget.changeDonationAmount(value);
          });
        },
      ),
    );
  }
}

class BubbleText extends StatelessWidget {
  final String title;
  final String data;
  const BubbleText({required this.title, required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height / 932;
    double w = MediaQuery.of(context).size.width / 430;

    return Container(
        width: 388 * w,
        height: 67 * h,
        decoration: BoxDecoration(
            border:
                Border.all(color: Theme.of(context).primaryColor, width: 2 * w),
            borderRadius: BorderRadius.circular(30)),
        child: Center(
            child: Container(
          child: Column(
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10 * w),
                child: SizedBox(
                  height: 43 * h,
                  child: SingleChildScrollView(child: Text(data)),
                ),
              )
            ],
          ),
        )));
  }
}

class ImageThumbShape extends SliderComponentShape {
  final double thumbRadius;
  final ui.Image image;

  const ImageThumbShape({required this.thumbRadius, required this.image});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Paint paint = Paint()
      ..filterQuality = FilterQuality.high
      ..isAntiAlias = true;

    final imageWidth = image.width.toDouble();
    final imageHeight = image.height.toDouble();
    final scale = thumbRadius / imageWidth;
    final rect = Rect.fromCenter(
        center: center, width: imageWidth * scale, height: imageHeight * scale);
    context.canvas.drawImageRect(
        image, Rect.fromLTWH(0, 0, imageWidth, imageHeight), rect, paint);
  }
}
