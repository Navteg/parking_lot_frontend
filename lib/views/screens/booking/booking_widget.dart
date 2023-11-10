import 'package:flutter/material.dart';
import 'package:parking_lot_system/domain/usecase/booking_usecase.dart';
import 'package:parking_lot_system/utils/responsive_utils.dart';
import 'package:parking_lot_system/utils/theme.dart';
import 'package:parking_lot_system/views/common/error_snack_bar.dart';
import 'package:parking_lot_system/views/common/text_field_widget.dart';

class BookingWidget extends StatefulWidget {
  const BookingWidget({
    super.key,
  });

  @override
  State<BookingWidget> createState() => _BookingWidgetState();
}

class SlotInformation {
  final String bayId;
  final String bookingId;
  final String floor;
  final String? message;
  final bool isSlotAvailable;

  SlotInformation({
    required this.bayId,
    required this.bookingId,
    required this.floor,
    this.message = 'Slot booked successfully',
    required this.isSlotAvailable,
  });
}

class _BookingWidgetState extends State<BookingWidget> {
  String selectedVehicleType = '';
  String vehicleNumber = '';
  var slotDetails = <SlotInformation>{};
  List<String> vehicleTypes = ['Small', 'Medium', 'Large', 'x - large'];
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
            height: ResponsiveUtils.screenHeight(context) * 0.3,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              color: ColorTheme.whiteTheme,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            width: double.infinity,
            child: _slotInfo(),
          ),
        ],
      ),
    );
  }

  getSlot() async {
    setState(() {
      isLoading = true;
    });
    if (selectedVehicleType.isEmpty || vehicleNumber.isEmpty) {
      final snackBar = SnackBarWidget().errorSnackBar(
        'Please enter all the details',
        context,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      setState(() {
        isLoading = false;
      });
      return;
    } else {
      final res = await BookingUseCase().execute(
        vehicleNumber: vehicleNumber,
        vehicleType: selectedVehicleType,
      );
      if (res != null && res.bookingId.isNotEmpty) {
        setState(() {
          slotDetails = {
            SlotInformation(
              bayId: res.bayId,
              bookingId: res.bookingId,
              floor: res.floor,
              isSlotAvailable: true,
            )
          };
          isLoading = false;
        });
      } else {
        setState(() {
          slotDetails = {
            SlotInformation(
              bayId: '',
              bookingId: '',
              floor: '',
              isSlotAvailable: false,
            )
          };
          isLoading = false;
        });
      }
      setState(() {
        isLoading = false;
      });
      return;
    }
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
            "Enter Booking Details",
            style: TextStyle(
              fontSize: FontTheme.headingSize,
              fontWeight: FontTheme.headingWeight,
            ),
          ),
        ),
        SizedBox(
          height: ResponsiveUtils.screenHeight(context) * 0.06,
        ),
        Text(
          'Select Vehicle Type',
          style: TextStyle(
            fontWeight: FontTheme.headingWeight,
            fontSize: ResponsiveUtils.textScaleFactor(context) * 18,
            color: ColorTheme.blackTheme,
          ),
        ),
        SizedBox(
          height: ResponsiveUtils.screenHeight(context) * 0.02,
        ),
        SizedBox(
          key: const Key('vehicle_type_list'),
          height: 50,
          width: double.infinity,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: vehicleTypes.length,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        selectedVehicleType = vehicleTypes[index];
                      });
                    },
                    child: Container(
                      width: 100,
                      height: 50,
                      padding: const EdgeInsets.all(12),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: ColorTheme.grayTheme,
                          width: 1,
                        ),
                        color: selectedVehicleType == vehicleTypes[index]
                            ? ColorTheme.primary
                            : Colors.transparent,
                      ),
                      child: Text(
                        vehicleTypes[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: selectedVehicleType == vehicleTypes[index]
                              ? ColorTheme.whiteTheme
                              : ColorTheme.nearBlack,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: ResponsiveUtils.screenHeight(context) * 0.02,
                  ),
                ],
              );
            },
          ),
        ),
        SizedBox(
          height: ResponsiveUtils.screenHeight(context) * 0.02,
        ),
        TextFieldWidget(
          key: const Key('vehicle_text_field'),
          hintText: 'Enter Vehicle Number',
          onChanged: (value) {
            vehicleNumber = value;
          },
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
              !isLoading && getSlot();
            },
            child: Text(
              isLoading ? "checking ..." : "BOOK SLOT",
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

  Widget _slotInfo() {
    return Column(
      children: [
        const Text(
          'Slot Information',
          style: TextStyle(
            fontWeight: FontTheme.headingWeight,
            fontSize: FontTheme.headingSize,
            color: ColorTheme.blackTheme,
          ),
        ),
        SizedBox(
          height: ResponsiveUtils.screenHeight(context) * 0.03,
        ),
        slotDetails.isEmpty
            ? const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 50,
                    color: ColorTheme.blackTheme,
                  ),
                  Text(
                    'Book a slot to view details',
                    style: TextStyle(
                      fontWeight: FontTheme.subheadingWeight,
                      fontSize: FontTheme.subheadingSize,
                      color: ColorTheme.blackTheme,
                    ),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        slotDetails.first.isSlotAvailable
                            ? 'Slot booked successfully'
                            : 'No slots available',
                        style: const TextStyle(
                          fontSize: 22,
                          color: ColorTheme.blackTheme,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Icon(
                        slotDetails.first.isSlotAvailable
                            ? Icons.check_circle_outline
                            : Icons.cancel_outlined,
                        color: slotDetails.first.isSlotAvailable
                            ? Colors.green
                            : ColorTheme.errorTextColor,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Booking  Id:',
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
                        flex: 2,
                        child: Text(
                          slotDetails.first.bookingId,
                          style: const TextStyle(
                            fontWeight: FontTheme.headingWeight,
                            fontSize: FontTheme.subheadingSize,
                            color: ColorTheme.grayTheme,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Bay Id:',
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
                        flex: 2,
                        child: Text(
                          '${slotDetails.first.floor} - ${slotDetails.first.bayId}',
                          style: const TextStyle(
                            fontWeight: FontTheme.headingWeight,
                            fontSize: FontTheme.subheadingSize,
                            color: ColorTheme.grayTheme,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
      ],
    );
  }
}
