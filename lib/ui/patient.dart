import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:ui/controllers/recipent_controller.dart';
import 'package:ui/controllers/book_appoinement.dart';
import 'package:ui/ui/blood_request_ui.dart';

class PatientInfoScreen extends StatelessWidget {
  final PatientInfoController controller = Get.put(PatientInfoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Recipient Information'),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Obx(
          () => Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (controller.user.value != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Recipient Name: ${controller.user.value!.username}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                            'Blood Group: ${controller.user.value!.bloodGroup}'),
                        Text('Contact Number: ${controller.user.value!.phone}'),
                        SizedBox(height: 16),
                        SizedBox(height: 16),
                        Text(
                          'Blood Requests:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // Display blood requests
                        if (controller.bloodRequests.isNotEmpty)
                          Column(
                            children: controller.bloodRequests
                                .map(
                                  (request) => Card(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    elevation: 4,
                                    child: ListTile(
                                      leading: Icon(Icons
                                          .bloodtype), // Icon representing blood request
                                      title: Text(
                                        'Blood Group: ${request.bloodGroup}',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      subtitle: Text(
                                        'Quantity: ${request.quantity.toString()} units',
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          )
                        else
                          Text(
                              'No blood requests yet'), // Display if no blood requests
                      ],
                    )
                  else
                    CircularProgressIndicator(), // Show loading indicator while user data is loading
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.red,
        
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        currentIndex: 0,
        onTap: (int index) async {
          if (index == 0) {
            await FlutterSecureStorage().deleteAll();
            Get.offAndToNamed("/auth");
          } else if (index == 1) {
            Get.to((BloodRequestScreen()));
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Logout',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_hospital_outlined),
            label: 'Request Blood',
          ),
        ],
      ),
    );
  }
}
