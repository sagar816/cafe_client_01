import 'dart:math';

import 'package:cafe_client_01/model/user/user.dart';
import 'package:cafe_client_01/pages/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:otp_text_field_v2/otp_field_v2.dart';

class LoginController extends GetxController {
  GetStorage box = GetStorage();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference userCollection;

  TextEditingController registerNameCtrl = TextEditingController();
  TextEditingController registerNumberCtrl = TextEditingController();

  TextEditingController loginNumberCtrl = TextEditingController();

  OtpFieldControllerV2 otpController = OtpFieldControllerV2();
  bool OtpFieldShowm = false;
  int? otpSend;
  int? otpEntered;

  User? loginUser;

  @override
  void onInit() {
    userCollection = firestore.collection('users');
    super.onInit();
  }

  @override
  void onReady() {
    Map<String, dynamic>? user = box.read('loginUser');
    if (user != null) {
      loginUser = User.fromJson(user);
      Get.to(const HomePage());
    }
    super.onReady();
  }

  addUser() {
    try {
      if (otpSend == otpEntered) {
        DocumentReference doc = userCollection.doc();
        User user = User(
          id: doc.id,
          name: registerNameCtrl.text,
          number: int.parse(registerNumberCtrl.text),
        );
        final userJson = user.toJson();
        doc.set(userJson);
        Get.snackbar('Success', 'User Added Successfully',
            colorText: Colors.green);
        registerNameCtrl.clear();
        registerNumberCtrl.clear();
        otpController.clear();
      } else {
        Get.snackbar('Error', 'OTP is Incorrect', colorText: Colors.red);
      }
      // if (registerNameCtrl.text.isEmpty || registerNameCtrl.text.isEmpty) {
      //   Get.snackbar('Error', 'Please fill the fields', colorText: Colors.red);
      //   //? to stop the code
      //   return;
      // }
    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
      print(e);
    }
  }

  sendOtp() {
    try {
      if (registerNameCtrl.text.isEmpty || registerNameCtrl.text.isEmpty) {
        Get.snackbar('Error', 'Please fill the fields', colorText: Colors.red);
        //? to stop the code
        return;
      }
      final random = Random();
      int otp = 1000 + random.nextInt(9000);
      print(otp);
      //will send otp and check its send successfully or not
      if (otp != null) {
        OtpFieldShowm = true;
        otpSend = otp;
        Get.snackbar('Success', 'Otp Sent Successfully',
            colorText: Colors.green);
      } else {
        Get.snackbar('Error', 'Otp Not Found', colorText: Colors.red);
      }
    } catch (e) {
      print(e);
    } finally {
      update();
    }
  }

  Future<void> loginWithPhone() async {
    try {
      String phoneNumber = loginNumberCtrl.text;
      if (phoneNumber.isNotEmpty) {
        var querySnapshot = await userCollection
            .where('number', isEqualTo: int.tryParse(phoneNumber))
            .limit(1)
            .get();
        if (querySnapshot.docs.isNotEmpty) {
          var userDoc = querySnapshot.docs.first;
          var userData = userDoc.data() as Map<String, dynamic>;
          box.write('loginUser', userData);
          loginNumberCtrl.clear();
          Get.to(HomePage());
          Get.snackbar('Success', 'Login Successful', colorText: Colors.green);
        } else {
          Get.snackbar('Error', 'User Not Found, please register',
              colorText: Colors.red);
        }
      } else {
        Get.snackbar('Error', 'Please Enter a Phone Number',
            colorText: Colors.red);
      }
    } catch (error) {
      print("Failed to Login: $error");
      Get.snackbar('Error', 'Failed to Login', colorText: Colors.red);
    }
  }
}
