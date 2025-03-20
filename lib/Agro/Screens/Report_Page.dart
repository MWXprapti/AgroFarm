import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:new_app/theme/theme.dart';

class ReportPage extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  DateTime? startDate;
  DateTime? endDate;
  bool showList = false; // State variable to control visibility

  Future<void> pickDate(bool isStartDate) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        if (isStartDate) {
          startDate = pickedDate;
        } else {
          endDate = pickedDate;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgcolor,
      appBar: AppBar(
        title: Text("Generate Report"),
        backgroundColor: AppColors.lightgreen,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Select Date:", style: TextStyle(fontSize: 20)),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => pickDate(true),
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.olive,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10,
                              offset: Offset(4, 4),
                            ),
                          ],
                        ),
                        child: Text(
                          startDate == null
                              ? "Start Date"
                              : DateFormat('dd/MM/yyyy').format(startDate!),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => pickDate(false),
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.lightgreen,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10,
                              offset: Offset(4, 4),
                            ),
                          ],
                        ),
                        child: Text(
                          endDate == null
                              ? "End Date"
                              : DateFormat('dd/MM/yyyy').format(endDate!),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  setState(() {
                    showList = true;
                  });
                  Get.snackbar("Action", "Generating Report...");
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.yellow,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        offset: Offset(4, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      "Get List",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              if (showList)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: PurchasesListPage(),
                ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Get.snackbar("Action", "Sending Email...");
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        offset: Offset(4, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      "Send to Mail",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}

class PurchasesListPage extends StatelessWidget {
  final RxInt currentPage = 1.obs;
  final int itemsPerPage = 5;
  final List<Map<String, String>> purchases = List.generate(
    20,
        (index) => {
      "billDate": "12/02/2025",
      "cashCredit": "Cash",
      "name": "Customer $index",
      "gstNo": "GST1234$index",
      "address": "123 Street, City",
      "invoiceNumber": "INV00$index",
      "mobileNumber": "987654321$index",
      "productName": "Product $index",
      "hsnCode": "HSN1234",
      "quantityUnit": "10 KG",
      "amount": "₹5000",
    },
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.bgcolor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Obx(
            () {
          int startIndex = (currentPage.value - 1) * itemsPerPage;
          int endIndex = startIndex + itemsPerPage;
          var paginatedList = purchases.sublist(
              startIndex, endIndex > purchases.length ? purchases.length : endIndex);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Purchases List", style: AppTextStyles.headingStyle),
              SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true, // Ensure list takes only necessary space
                physics: NeverScrollableScrollPhysics(), // Disable inner scrolling
                itemCount: paginatedList.length,
                itemBuilder: (context, index) {
                  var item = paginatedList[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 10),
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.cream),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Invoice No: ${item['invoiceNumber']}",
                                style: AppTextStyles.bodyStyle),
                            Text("Bill Date: ${item['billDate']}",
                                style: AppTextStyles.bodyStyle),
                          ],
                        ),
                        SizedBox(height: 5),
                        Text("Name: ${item['name']}",
                            style: AppTextStyles.bodyStyle),
                        SizedBox(height: 5),
                        Text("HSN Code: ${item['hsnCode']}",
                            style: AppTextStyles.bodyStyle),
                        SizedBox(height: 5),
                        Text("Quantity: ${item['quantityUnit']}",
                            style: AppTextStyles.bodyStyle),
                      ],
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
