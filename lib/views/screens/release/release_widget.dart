import 'package:flutter/material.dart';
import 'package:parking_lot_system/data/api/slot-release/slot-release-api-impl.dart';
import 'package:parking_lot_system/utils/responsive_utils.dart';
import 'package:parking_lot_system/utils/theme.dart';
import 'package:parking_lot_system/views/common/error_snack_bar.dart';
import 'package:parking_lot_system/views/common/text_field_widget.dart';

class ReleaseSlotInfo {
  final String totalAmount;
  final String totalHours;
  final bool isReleased;
  final String entryTime;
  final String exitTime;

  const ReleaseSlotInfo({
    required this.totalAmount,
    required this.totalHours,
    required this.isReleased,
    required this.entryTime,
    required this.exitTime,
  });
}

class ReleaseWidget extends StatefulWidget {
  const ReleaseWidget({
    super.key,
  });

  @override
  State<ReleaseWidget> createState() => _ReleaseWidgetState();
}

class _ReleaseWidgetState extends State<ReleaseWidget> {
  String vehicleNumber = '';
  var releaseInfo = <ReleaseSlotInfo>{};
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              color: ColorTheme.whiteTheme,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            width: double.infinity,
            child: _buildForm(),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            height: ResponsiveUtils.screenHeight(context) * 0.47,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              color: ColorTheme.whiteTheme,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            width: double.infinity,
            child: _paymentInfo(),
          ),
        ],
      ),
    );
  }

  releaseSlot() async {
    setState(() {
      isLoading = true;
    });
    if (vehicleNumber.isEmpty) {
      final snackBar = SnackBarWidget().errorSnackBar(
        'Please enter vehicle number',
        context,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      setState(() {
        isLoading = false;
      });
      return;
    }

    final res = await SlotReleaseApiImpl().getSlotRelease(
      vehicleNumber: vehicleNumber,
    );

    if (res.totalAmount != null && res.totalHrs != null) {
      setState(() {
        releaseInfo.clear();
        releaseInfo.add(
          ReleaseSlotInfo(
            totalAmount: res.totalAmount.toString(),
            totalHours: res.totalHrs.toString(),
            isReleased: true,
            entryTime: res.entryTime ?? '',
            exitTime: res.exitTime ?? '',
          ),
        );
        isLoading = false;
      });
      return;
    }

    setState(() {
      releaseInfo.clear();
      releaseInfo.add(
        const ReleaseSlotInfo(
          totalAmount: '',
          totalHours: '',
          isReleased: false,
          entryTime: '',
          exitTime: '',
        ),
      );
      isLoading = false;
    });
    return;
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: ResponsiveUtils.screenHeight(context) * 0.01,
        ),
        const Align(
          alignment: Alignment.center,
          child: Text(
            "Enter Vehicle Information",
            style: TextStyle(
              fontSize: FontTheme.headingSize,
              fontWeight: FontTheme.headingWeight,
            ),
          ),
        ),
        SizedBox(
          height: ResponsiveUtils.screenHeight(context) * 0.02,
        ),
        TextFieldWidget(
          key: const Key("release_vehicle_text_field"),
          hintText: 'Enter Vehicle Number',
          onChanged: (value) => vehicleNumber = value,
          prefixIcon: Icons.numbers,
          textCapitalization: true,
        ),
        SizedBox(
          height: ResponsiveUtils.screenHeight(context) * 0.04,
        ),
        SizedBox(
          height: ResponsiveUtils.screenHeight(context) * 0.06,
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorTheme.primary,
              foregroundColor: ColorTheme.whiteTheme,
            ),
            onPressed: () {
              !isLoading && releaseSlot();
            },
            child: Text(
              !isLoading ? "RELEASE SLOT" : "releasing ...",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: ResponsiveUtils.screenWidth(context) > 600 ? 18 : 16,
              ),
            ),
          ),
        ),
        SizedBox(
          height: ResponsiveUtils.screenHeight(context) * 0.02,
        ),
      ],
    );
  }

  Widget _paymentInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text(
          'Payment Information',
          style: TextStyle(
            fontWeight: FontTheme.headingWeight,
            fontSize: FontTheme.headingSize,
            color: ColorTheme.blackTheme,
          ),
        ),
        SizedBox(
          height: releaseInfo.isEmpty
              ? (ResponsiveUtils.screenHeight(context) / 2) * 0.2
              : (ResponsiveUtils.screenHeight(context) / 2) * 0.1,
        ),
        releaseInfo.isEmpty
            ? Column(
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    size: ResponsiveUtils.screenWidth(context) > 600 ? 80 : 60,
                    color: ColorTheme.blackTheme,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'No information available',
                    style: TextStyle(
                      fontSize: 22,
                      color: ColorTheme.blackTheme,
                    ),
                  ),
                ],
              )
            : Column(
                children: [
                  // const Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Text(
                  //       'Thanks for using our service',
                  //       style: TextStyle(
                  //         fontSize: 22,
                  //         color: ColorTheme.blackTheme,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        releaseInfo.first.isReleased
                            ? 'Slot Released successfully'
                            : 'oops! no information found',
                        style: const TextStyle(
                          fontSize: 21,
                          fontWeight: FontTheme.subheadingWeight,
                          color: ColorTheme.blackTheme,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Icon(
                        releaseInfo.first.isReleased
                            ? Icons.check_circle_outline
                            : Icons.cancel_outlined,
                        color: releaseInfo.first.isReleased
                            ? Colors.green
                            : ColorTheme.errorTextColor,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: ResponsiveUtils.screenHeight(context) * 0.04,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Expanded(
                        child: Text(
                          'Entry Time: ',
                          style: TextStyle(
                            fontWeight: FontTheme.headingWeight,
                            fontSize: 20,
                            color: ColorTheme.blackTheme,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          releaseInfo.isNotEmpty && releaseInfo.first.isReleased
                              ? DateTime.parse(releaseInfo.first.entryTime)
                                  .toLocal()
                                  .toString()
                                  .substring(0, 19)
                              : "",
                          style: const TextStyle(
                            fontWeight: FontTheme.headingWeight,
                            fontSize: FontTheme.subheadingSize,
                            color: ColorTheme.grayTheme,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: ResponsiveUtils.screenHeight(context) * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Expanded(
                        child: Text(
                          'Exit Time: ',
                          style: TextStyle(
                            fontWeight: FontTheme.headingWeight,
                            fontSize: 20,
                            color: ColorTheme.blackTheme,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          releaseInfo.isNotEmpty && releaseInfo.first.isReleased
                              ? DateTime.parse(releaseInfo.first.exitTime)
                                  .toLocal()
                                  .toString()
                                  .substring(0, 19)
                              : "",
                          style: const TextStyle(
                            fontWeight: FontTheme.headingWeight,
                            fontSize: FontTheme.subheadingSize,
                            color: ColorTheme.grayTheme,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: ResponsiveUtils.screenHeight(context) * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Expanded(
                        child: Text(
                          'Total Hours: ',
                          style: TextStyle(
                            fontWeight: FontTheme.headingWeight,
                            fontSize: 20,
                            color: ColorTheme.blackTheme,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          releaseInfo.first.totalHours,
                          style: const TextStyle(
                            fontWeight: FontTheme.headingWeight,
                            fontSize: FontTheme.subheadingSize,
                            color: ColorTheme.grayTheme,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: ResponsiveUtils.screenHeight(context) * 0.02,
                  ),
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Total Amount: ',
                          style: TextStyle(
                            fontWeight: FontTheme.headingWeight,
                            fontSize: 20,
                            color: ColorTheme.blackTheme,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          releaseInfo.first.totalAmount,
                          style: const TextStyle(
                            fontWeight: FontTheme.headingWeight,
                            fontSize: FontTheme.subheadingSize,
                            color: ColorTheme.grayTheme,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: ResponsiveUtils.screenHeight(context) * 0.02,
                  ),
                  releaseInfo.isNotEmpty && releaseInfo.first.isReleased
                      ? SizedBox(
                          height: ResponsiveUtils.screenHeight(context) * 0.06,
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorTheme.primary,
                              foregroundColor: ColorTheme.whiteTheme,
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Payment Successful'),
                                    content: Icon(
                                      Icons.check_circle_outline,
                                      color: Colors.green,
                                      size:
                                          ResponsiveUtils.screenWidth(context) >
                                                  600
                                              ? 80
                                              : 60,
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          setState(() {
                                            releaseInfo.clear();
                                            vehicleNumber = '';
                                          });
                                        },
                                        child: const Text('OK'),
                                      )
                                    ],
                                  );
                                },
                              );
                            },
                            child: Text(
                              "PAY NOW",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    ResponsiveUtils.screenWidth(context) > 600
                                        ? 18
                                        : 16,
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
      ],
    );
  }
}
