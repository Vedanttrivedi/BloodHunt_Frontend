import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui/controllers/blood_request.dart';

class BloodRequestScreen extends StatelessWidget {
  final BloodRequestController bloodRequestController =
      Get.put(BloodRequestController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request Blood'),
        backgroundColor: Colors.red,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                child: Text(
                  "Recipient Blood Request",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                padding: EdgeInsets.all(20),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                _showLocationSelection(context);
              },
              child: Text('Select Location'),
            ),
            SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: TextFormField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  bloodRequestController.quantity.value =
                      int.tryParse(value) ?? 0;
                },
                decoration: InputDecoration(
                  hintText: 'Quantity',
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                _showBloodGroupSelection(context);
              },
              child: Text('Select Blood Group'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: bloodRequestController.receiveBlood,
              child: Text('Request Blood'),
            ),
            SizedBox(height: 16),
            Obx(() {
              return Text(
                'Selected Blood Group: ${bloodRequestController.selectedBloodGroup.value}',
              );
            }),
            Obx(() {
              return Text(
                'Selected Location: ${bloodRequestController.selectedLocation.value}',
              );
            }),
          ],
        ),
      ),
    );
  }

  void _showLocationSelection(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text('Gandhinagar'),
                onTap: () {
                  bloodRequestController.selectedLocation.value = 'Gandhinagar';
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Ahmedabad'),
                onTap: () {
                  bloodRequestController.selectedLocation.value = 'Ahmedabad';
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Mumbai'),
                onTap: () {
                  bloodRequestController.selectedLocation.value = 'Mumbai';
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showBloodGroupSelection(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: bloodRequestController.bloodGroups.map((String value) {
              return ListTile(
                title: Text(value),
                onTap: () {
                  bloodRequestController.selectedBloodGroup.value = value;
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
