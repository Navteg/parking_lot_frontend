// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:parking_lot_system/const/storage_keys.dart';
import 'package:parking_lot_system/data/api/login/login_api_impl.dart';
import 'package:parking_lot_system/data/storage/key_value_storage_impl.dart';
import 'package:parking_lot_system/utils/responsive_utils.dart';
import 'package:parking_lot_system/utils/theme.dart';
import 'package:parking_lot_system/views/common/error_snack_bar.dart';
import 'package:parking_lot_system/views/common/text_field_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String parkingId = "", pass = "";
  bool isPasswordVisible = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        color: ColorTheme.whiteTheme,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              child: SizedBox(
                height: ResponsiveUtils.screenHeight(context) * 0.4,
                child: Image(
                  width: ResponsiveUtils.screenWidth(context) * 1.3,
                  fit: BoxFit.contain,
                  image: const AssetImage("assets/images/login.avif"),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: _buildBottom(),
            ),
          ],
        ),
      ),
    );
  }

  login() async {
    setState(() {
      isLoading = true;
    });
    if (parkingId.isEmpty || pass.isEmpty) {
      final snackBar = SnackBarWidget().errorSnackBar(
        "Please fill all the fields",
        context,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      setState(() {
        isLoading = false;
      });
      return;
    }

    final res = await LoginApiImpl().login(
      parkingId: parkingId,
      password: pass,
    );

    if (res.token.isEmpty) {
      final snackBar = SnackBarWidget().errorSnackBar(
        "Invalid Credentials",
        context,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      setState(() {
        isLoading = false;
      });
      return;
    }

    KeyValueStorageImpl().write(
      StorageKeys.token,
      res.token,
    );
    setState(() {
      isLoading = false;
    });
    return true;
  }

  Widget _buildBottom() {
    return SizedBox(
      width: ResponsiveUtils.screenWidth(context),
      height: ResponsiveUtils.screenHeight(context) * 0.60,
      child: Card(
        margin: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight:
                Radius.circular(ResponsiveUtils.textScaleFactor(context) * 30),
            topLeft:
                Radius.circular(ResponsiveUtils.textScaleFactor(context) * 30),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveUtils.textScaleFactor(context) * 16,
            vertical: ResponsiveUtils.textScaleFactor(context) * 16,
          ),
          child: _buildForm(),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Greeting Text
        SizedBox(
          height: ResponsiveUtils.screenHeight(context) * 0.01,
        ),
        Text(
          "Welcome,back!",
          style: TextStyle(
            fontSize: ResponsiveUtils.textScaleFactor(context) * 35,
            fontWeight: FontTheme.headingWeight,
          ),
        ),
        Text(
          "Please login with your information",
          style: TextStyle(
            fontWeight: FontTheme.subheadingWeight,
            fontSize: ResponsiveUtils.textScaleFactor(context) * 14,
            color: ColorTheme.grayTheme,
          ),
        ),

        // Login Form
        SizedBox(
          height: ResponsiveUtils.screenHeight(context) * 0.06,
        ),
        TextFieldWidget(
          key: const Key("parking_id_text_field"),
          hintText: "Enter Parking ID",
          prefixIcon: Icons.person,
          onChanged: (value) => parkingId = value,
          textCapitalization: true,
        ),
        SizedBox(
          height: ResponsiveUtils.screenHeight(context) * 0.02,
        ),
        TextFieldWidget(
          key: const Key("password_text_field"),
          hintText: 'Enter Password',
          onChanged: (value) => pass = value,
          prefixIcon: Icons.password_rounded,
          suffixIcon: IconButton(
            icon: Icon(
              isPasswordVisible
                  ? Icons.remove_red_eye_outlined
                  : Icons.visibility_off,
            ),
            onPressed: () {
              setState(() {
                isPasswordVisible = !isPasswordVisible;
              });
            },
          ),
          obscureText: !isPasswordVisible,
        ),
        SizedBox(
          height: ResponsiveUtils.screenHeight(context) * 0.06,
        ),
        SizedBox(
          height: ResponsiveUtils.screenHeight(context) * 0.06,
          width: double.infinity,
          child: ElevatedButton(
            key: const Key("login_button"),
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  !isLoading ? ColorTheme.primary : ColorTheme.whiteTheme,
              foregroundColor:
                  !isLoading ? ColorTheme.whiteTheme : ColorTheme.primary,
            ),
            onPressed: () async {
              await login() == true
                  ? Navigator.pushReplacementNamed(context, "/booking")
                  : null;
            },
            child: !isLoading
                ? Text(
                    "LOGIN",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: ResponsiveUtils.textScaleFactor(context) * 18,
                    ),
                  )
                : const CircularProgressIndicator(),
          ),
        ),
        SizedBox(
          height: ResponsiveUtils.screenHeight(context) * 0.02,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Don't have account? ",
              style: TextStyle(
                fontSize: ResponsiveUtils.textScaleFactor(context) * 16,
                color: ColorTheme.grayTheme,
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(context, "/register");
              },
              child: Text(
                "Register",
                style: TextStyle(
                  fontSize: ResponsiveUtils.textScaleFactor(context) * 16,
                  color: ColorTheme.primary,
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
