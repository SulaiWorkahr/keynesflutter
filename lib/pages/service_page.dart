import 'package:flutter/material.dart';
import '../constants/app_assets.dart';
import '../constants/app_colors.dart';
import '../models/service_list_model.dart';
import '../services/comFuncService.dart';
import '../services/keynes_api_service.dart';
import '../widgets/button_widget.dart';
import 'enquiry/add_enquiry_page.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({super.key});

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  final KeynesApiService apiService = KeynesApiService();

  @override
  void initState() {
    getAllServices();
    super.initState();
  }

  List<ServicesListData>? servicesList = [];
  List<ServicesListData>? servicesListAll = [];

  Future getAllServices() async {
    var result = await apiService.getAllServices();
    print('hi $result');
    ServiceListModel response = serviceListModelFromJson(result);
    if (response.status.toString() == 'SUCCESS') {
      setState(() {
        servicesList = response.list;
        servicesListAll = servicesList;
        print('hello $servicesList');
      });
    } else {
      setState(() {
        servicesList = [];
        servicesListAll = [];
      });
      showInSnackBar(context, response.status);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: screenHeight * 0.10,
        title: Text(
          'Services',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color(0xFF0151AF),
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: servicesList == null || servicesList!.isEmpty
          ? Center(child: CircularProgressIndicator()) // Loading indicator
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: servicesList!.map((service) {
                    return Container(
                      //height: screenHeight / 4.8,
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      decoration: BoxDecoration(
                        color: Color(0xFF0151AF), // Background color of the container
                        borderRadius: BorderRadius.circular(18),
                      ),
                      padding: EdgeInsets.all(16.0),
                      child: Stack(
                        children: [
                          // Main content (icon + service name) in a row
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start, // Align content to the top
                            children: [
                              // Icon with a white background (left)
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white, // White background for the icon
                                  borderRadius: BorderRadius.circular(12), // Rounded edges
                                ),
                                height: screenHeight / 8.3, // Set the height appropriately
                                width: screenWidth * 0.23, // Adjust width for the icon
                                child: Image.asset(
                                  AppAssets.keynesServiceIcon,
                                  // height: 10.0, // Set the height you want for the image
                                  // width: 10.0,  // Set the width you want for the image
                                  //fit: BoxFit.contain, // Ensures image stays within bounds
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.03), // Space between icon and text

                              // Service name (top-aligned)
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8.0), // Add some space from the top
                                  child: Text(
                                    service.name.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          
                          // Enquiry button at the bottom-right
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: ButtonWidget(
                              title: 'Enquiry',
                              width: screenWidth * 0.25, // Adjust width for the button
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddEnquiryPage(
                                      serviceName: service.name.toString(),
                                    ),
                                  ),
                                );
                              },
                              borderRadius: 12.0,
                              color: AppColors.light,
                              titleColor: AppColors.blue,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
    );
  }
}
