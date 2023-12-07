// UI File - DonorAppointmentScreen

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui/controllers/appoinment_controller.dart';

class DonorAppointmentScreen extends StatelessWidget {
  final AppointmentController appointmentController =
      Get.put(AppointmentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Appointment'),
        backgroundColor: Colors.red,
      ),
      body: Obx(
        () => Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  child: Text(
                    "Donor Appointment",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  padding: EdgeInsets.all(20),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: DropdownButton<String>(
                  hint: Text('Select Location'),
                  value: appointmentController.selectedLocation.value,
                  items: <String>['Gandhinagar', 'Ahmedabad', 'Mumbai']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    appointmentController.selectedLocation.value = newValue!;
                  },
                ),
              ),
              SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: InkWell(
                  onTap: () {
                    appointmentController.selectDate(context);
                  },
                  child: IgnorePointer(
                    child: TextFormField(
                      controller: appointmentController.dateController.value,
                      decoration: InputDecoration(
                        hintText: 'Select Date',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: InkWell(
                  onTap: () {
                    appointmentController.selectTime(context);
                  },
                  child: IgnorePointer(
                    child: TextFormField(
                      controller: appointmentController.timeController.value,
                      decoration: InputDecoration(
                        hintText: 'Select Time',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: appointmentController.bookAppointment,
                child: Text('Book Appointment'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
