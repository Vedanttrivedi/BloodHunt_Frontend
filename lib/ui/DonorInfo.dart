import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui/controllers/donor_info_controller.dart';

class DonorInfoScreen extends StatelessWidget {
  final DonorInfoController controller = Get.put(DonorInfoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Donor Information'),
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
                  (controller.user.value != null)
                      ? Column(
                          children: [
                            Text(
                              'Donor Name: ${controller.user.value!.username}',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            Text(
                                'Blood Group: ${controller.user.value!.bloodGroup}'),
                            Text(
                                'Contact Number: ${controller.user.value!.phone}'),
                            SizedBox(height: 16),
                            Text(
                              'Upcoming Appointments:',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      : CircularProgressIndicator(),
                  // Displaying upcoming appointments or a CircularProgressIndicator
                  controller.appointments.isEmpty
                      ? Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "No Appoinments Booked!",
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 16),
                            ),
                          ],
                        )
                      : Column(
                          children: controller.appointments.map((appointment) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 4,
                                child: ListTile(
                                  leading: Icon(Icons.location_on,
                                      color: Colors.red),
                                  title: Text(
                                    'Date: ${appointment.appointmentDate!.toLocal().toString().split(' ')[0]}',
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Time: ${appointment.appointmentDate!.toLocal().toString().split(' ')[1].substring(0, 5)}',
                                      ),
                                      Text(
                                        'Location: ${appointment.location}',
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                  SizedBox(height: 16),
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
            controller.navigateToNewScreen();
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Logout',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_hospital_outlined),
            label: 'Book Appoinment',
          ),
        ],
      ),
    );
  }
}
