import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class PaymentPage extends StatefulWidget {
  int donationAmount;
  final String projectID;
  PaymentPage(
      {required this.donationAmount, required this.projectID, super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width / 430;
    final double h = MediaQuery.of(context).size.height / 932;
    TextEditingController _nameController = TextEditingController();
    TextEditingController _cardNumberController = TextEditingController();
    TextEditingController _expiryDateController = TextEditingController();
    TextEditingController _cvvController = TextEditingController();
    TextEditingController _amountController = TextEditingController();
    _amountController.text = widget.donationAmount.toString();
    Future<void> _selectDate(BuildContext context) async {
      // Initial date is set to current date for the picker
      final DateTime? picked = await showMonthPicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2035),
      );

      if (picked != null) {
        // Formatting the picked DateTime to "Month/Year" format
        String formattedDate = "${picked.month}/${picked.year}";
        // Setting the formatted date to the TextField controller
        _expiryDateController.text = formattedDate;
      }
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
                                    width: 63 * w,
                                  ),
                                  Text(
                                    'Payment',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 36 * w,
                                        fontFamily: "google_sans_display"),
                                  ),
                                  SizedBox(
                                    width: 63 * w,
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
                                    height: 700 * h,
                                    width: 430 * w,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        top: 32 * h,
                                      ),
                                      child: Column(children: [
                                        Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                width: 2 * w,
                                              ),
                                            ),
                                            child: CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                data['imageUrl'],
                                              ),
                                              radius: 64 * w,
                                            )),
                                        SizedBox(height: 19 * h),
                                        Text(
                                          "Contribute to the Project",
                                          style: TextStyle(
                                            fontSize: 32 * w,
                                            fontFamily: "google_sans_display",
                                            color: Color.fromRGBO(0, 0, 0, 0.5),
                                          ),
                                        ),
                                        SizedBox(height: 19 * h),
                                        Container(
                                          width: 326 * w,
                                          height: 60 * h,
                                          child: SingleChildScrollView(
                                            child: Text(
                                              data['explanation'],
                                              style: TextStyle(
                                                fontSize: 14 * w,
                                                fontFamily:
                                                    "google_sans_display",
                                                color: Color.fromRGBO(
                                                    0, 0, 0, 0.5),
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 21 * h),
                                        SizedBox(
                                          width: 350 * w,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: List.generate(
                                              6,
                                              (_) => Container(
                                                width: 45 * w,
                                                height: 2 * h,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 26 * h),
                                        SizedBox(
                                          width: 350 * w,
                                          child: Column(
                                            children: [
                                              CustomTextField(
                                                  hintText: 'Name surname',
                                                  controller: _nameController),
                                              SizedBox(height: 18 * h),
                                              CustomTextField(
                                                  hintText: 'Card number',
                                                  controller:
                                                      _cardNumberController),
                                              SizedBox(
                                                height: 18,
                                              ),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: 147 * w,
                                                    height: 50 * h,
                                                    child: Center(
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          _selectDate(context);
                                                        },
                                                        child: AbsorbPointer(
                                                          child: TextField(
                                                            controller:
                                                                _expiryDateController,
                                                            decoration:
                                                                InputDecoration(
                                                              contentPadding:
                                                                  EdgeInsets.symmetric(
                                                                      vertical:
                                                                          9 * h,
                                                                      horizontal:
                                                                          16 *
                                                                              w), // Adjust vertical padding to control height
                                                              filled: true,
                                                              fillColor:
                                                                  Colors.white,
                                                              hintText:
                                                                  'Month/Year',
                                                              hintStyle:
                                                                  TextStyle(
                                                                      color: const Color
                                                                          .fromRGBO(
                                                                        0,
                                                                        0,
                                                                        0,
                                                                        0.50,
                                                                      ),
                                                                      fontSize:
                                                                          16 *
                                                                              w,
                                                                      fontFamily:
                                                                          "google_sans_display"),
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            30.0),
                                                                borderSide:
                                                                    BorderSide(
                                                                        width: 3.0 *
                                                                            w, // Ensure 'w' scales the border width as intended
                                                                        color: Theme.of(context)
                                                                            .primaryColor),
                                                              ),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            30.0),
                                                                borderSide:
                                                                    BorderSide(
                                                                        width: 4.0 *
                                                                            w, // Ensure 'w' scales the border width as intended
                                                                        color: Theme.of(context)
                                                                            .primaryColor),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 54 * w,
                                                  ),
                                                  SizedBox(
                                                    height: 50 * h,
                                                    width: 147 * w,
                                                    child: Center(
                                                      child: TextField(
                                                        maxLength: 4,
                                                        keyboardType: TextInputType
                                                            .numberWithOptions(
                                                                decimal: false,
                                                                signed: false),
                                                        obscureText: true,
                                                        controller:
                                                            _cvvController,
                                                        decoration:
                                                            InputDecoration(
                                                          counterText: "",
                                                          contentPadding:
                                                              EdgeInsets.symmetric(
                                                                  vertical:
                                                                      9 * h,
                                                                  horizontal: 16 *
                                                                      w), // Adjust vertical padding to control height
                                                          filled: true,
                                                          fillColor:
                                                              Colors.white,
                                                          hintText: 'CVV',
                                                          hintStyle: TextStyle(
                                                              color: const Color
                                                                  .fromRGBO(
                                                                0,
                                                                0,
                                                                0,
                                                                0.50,
                                                              ),
                                                              fontSize: 16 * w,
                                                              fontFamily:
                                                                  "google_sans_display"),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30.0),
                                                            borderSide:
                                                                BorderSide(
                                                                    width: 3.0 *
                                                                        w, // Ensure 'w' scales the border width as intended
                                                                    color: Theme.of(
                                                                            context)
                                                                        .primaryColor),
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30.0),
                                                            borderSide:
                                                                BorderSide(
                                                                    width: 4.0 *
                                                                        w, // Ensure 'w' scales the border width as intended
                                                                    color: Theme.of(
                                                                            context)
                                                                        .primaryColor),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 20 * h),
                                              SizedBox(
                                                height: 50 * h,
                                                width: 147 * w,
                                                child: Center(
                                                  child: TextField(
                                                    // Adjust vertical padding to control height
                                                    controller:
                                                        _amountController,
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 9 * h,
                                                              horizontal:
                                                                  16 * w),
                                                      suffixText: 'USD',
                                                      // Adjust vertical padding to control height
                                                      filled: true,
                                                      fillColor: Colors.white,

                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30.0),
                                                        borderSide: BorderSide(
                                                            width: 3.0 *
                                                                w, // Ensure 'w' scales the border width as intended
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30.0),
                                                        borderSide: BorderSide(
                                                            width: 4.0 *
                                                                w, // Ensure 'w' scales the border width as intended
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 20 * h),
                                        ElevatedButton(
                                            style: ButtonStyle(
                                                minimumSize: MaterialStateProperty.all(
                                                    Size(195 * w, 49 * h)),
                                                maximumSize:
                                                    MaterialStateProperty.all(Size(
                                                        195 * w,
                                                        49 * h)), // Text color
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Theme.of(context)
                                                            .primaryColor), // Background color
                                                shape: MaterialStateProperty.all(
                                                    RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(
                                                            30.0))), // Button shape
                                                padding: MaterialStateProperty.all(
                                                    EdgeInsets.symmetric(horizontal: 25 * w))), // Button padding

                                            onPressed: () {},
                                            child: Text('Pay', style: TextStyle(color: Colors.white, fontSize: 36 * w, fontWeight: FontWeight.w400, fontFamily: "google_sans_display"))),
                                      ]),
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

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  const CustomTextField(
      {required this.hintText, required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height / 932;
    double w = MediaQuery.of(context).size.width / 430;
    return SizedBox(
      height: 50 * h,
      child: Center(
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: 9 * h,
                horizontal:
                    16 * w), // Adjust vertical padding to control height
            filled: true,
            fillColor: Colors.white,
            hintText: hintText,
            hintStyle: TextStyle(
                color: const Color.fromRGBO(
                  0,
                  0,
                  0,
                  0.50,
                ),
                fontSize: 16 * w,
                fontFamily: "google_sans_display"),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide(
                  width:
                      3.0 * w, // Ensure 'w' scales the border width as intended
                  color: Theme.of(context).primaryColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide(
                  width:
                      4.0 * w, // Ensure 'w' scales the border width as intended
                  color: Theme.of(context).primaryColor),
            ),
          ),
        ),
      ),
    );
  }
}
