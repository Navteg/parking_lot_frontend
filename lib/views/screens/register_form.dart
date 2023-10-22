// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:parking_lot_system/data/api/registeration/registeration_api_impl.dart';
import 'package:parking_lot_system/utils/responsive_utils.dart';
import 'package:parking_lot_system/utils/theme.dart';
import 'package:parking_lot_system/views/common/error_snack_bar.dart';
import 'package:parking_lot_system/views/common/text_field_widget.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class RegisterResponse {
  final String id;
  final bool registered;

  RegisterResponse({
    required this.id,
    required this.registered,
  });
}

class _RegisterFormState extends State<RegisterForm> {
  final ScrollController _scrollController = ScrollController();
  String floors = "",
      // slotsPerFloor = 0,
      smallVehicle = "",
      mediumVehicle = "",
      largeVehicle = "",
      xLargeVehicle = "";
  String pass = "";
  bool isPasswordVisible = false;
  bool isLoading = false;
  final registerResponse = <RegisterResponse>{};

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Get Started",
            style: TextStyle(
              fontSize: ResponsiveUtils.textScaleFactor(context) * 35,
              fontWeight: FontTheme.headingWeight,
            ),
          ),
          SizedBox(height: ResponsiveUtils.screenHeight(context) * 0.04),
          TextFieldWidget(
            key: const Key("floors_text_field"),
            hintText: "Enter Floors",
            prefixIcon: Icons.layers,
            onChanged: (value) => setState(() {
              floors = value;
            }),
            numberKeyboard: true,
          ),
          SizedBox(height: ResponsiveUtils.screenHeight(context) * 0.02),
          TextFieldWidget(
            key: const Key("small_slots_text_field"),
            hintText: "Enter Small Slots Per Floor",
            prefixIcon: Icons.local_parking_outlined,
            onChanged: (value) => setState(() {
              smallVehicle = value;
            }),
            numberKeyboard: true,
          ),
          SizedBox(height: ResponsiveUtils.screenHeight(context) * 0.02),
          TextFieldWidget(
            key: const Key("medium_slots_text_field"),
            hintText: "Enter Medium Slots Per Floor",
            prefixIcon: Icons.local_parking_outlined,
            onChanged: (value) => setState(() {
              mediumVehicle = value;
            }),
            numberKeyboard: true,
          ),
          SizedBox(height: ResponsiveUtils.screenHeight(context) * 0.02),
          TextFieldWidget(
            key: const Key("large_slots_text_field"),
            hintText: "Enter Large Slots Per Floor",
            prefixIcon: Icons.local_parking_outlined,
            onChanged: (value) => setState(() {
              largeVehicle = value;
            }),
            numberKeyboard: true,
          ),
          SizedBox(height: ResponsiveUtils.screenHeight(context) * 0.02),
          TextFieldWidget(
            key: const Key("xlarge_slots_text_field"),
            hintText: "Enter Extra Large Slots Per Floor",
            prefixIcon: Icons.local_parking_outlined,
            onChanged: (value) => setState(() {
              xLargeVehicle = value;
            }),
            numberKeyboard: true,
          ),
          SizedBox(
            height: ResponsiveUtils.screenHeight(context) * 0.02,
          ),
          TextFieldWidget(
            key: const Key("register_password_text_field"),
            onChanged: (value) => setState(() {
              pass = value;
            }),
            obscureText: !isPasswordVisible,
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
            hintText: 'Enter Password',
          ),
          SizedBox(height: ResponsiveUtils.screenHeight(context) * 0.02),
          SizedBox(
            height: ResponsiveUtils.screenHeight(context) * 0.06,
            width: ResponsiveUtils.screenWidth(context) * 0.4,
            child: ElevatedButton(
              key: const Key("register_button"),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    !isLoading ? ColorTheme.primary : ColorTheme.whiteTheme,
                foregroundColor:
                    !isLoading ? ColorTheme.whiteTheme : ColorTheme.primary,
              ),
              onPressed: () {
                !isLoading && register();
              },
              child: !isLoading
                  ? const Text(
                      "REGISTER",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontTheme.subheadingWeight,
                        fontSize: FontTheme.buttonFontSize,
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
                "Already have account? ",
                style: TextStyle(
                    fontSize: ResponsiveUtils.textScaleFactor(context) * 13.5,
                    color: const Color.fromARGB(255, 126, 126, 126)),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushReplacementNamed(context, "/login");
                },
                child: Text(
                  "Login",
                  style: TextStyle(
                    fontSize: ResponsiveUtils.textScaleFactor(context) * 15,
                    color: ColorTheme.primary,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  register() async {
    setState(() {
      isLoading = true;
    });
    if (pass.isEmpty || floors.isEmpty) {
      final snackBar = SnackBarWidget().errorSnackBar(
        "Please fill all the fields",
        context,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      final res = await RegisterationApiImpl().register(
        floor: floors,
        smallSlot: smallVehicle,
        mediumSlot: mediumVehicle,
        largeSlot: largeVehicle,
        xLargeSlot: xLargeVehicle,
        password: pass,
      );
      if (res.id!.isNotEmpty) {
        setState(() {
          registerResponse.add(RegisterResponse(
            id: res.id ?? "",
            registered: true,
          ));
        });
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text("You have successfully registered."),
                  content: Row(
                    children: [
                      Text(
                        "Your Parking Id",
                        style: TextStyle(
                          fontSize:
                              ResponsiveUtils.textScaleFactor(context) * 18,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        res.id ?? "",
                        style: TextStyle(
                          fontSize:
                              ResponsiveUtils.textScaleFactor(context) * 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, "/login");
                      },
                      child: const Text("OK"),
                    ),
                  ],
                ));
      } else {
        setState(() {
          registerResponse.add(RegisterResponse(
            id: res.id ?? "",
            registered: false,
          ));
        });
      }
    }
    setState(() {
      isLoading = false;
    });
    return;
  }
}
