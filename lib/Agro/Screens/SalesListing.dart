import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_app/Agro/Screens/Sales_Details.dart';
import 'package:new_app/theme/theme.dart';

class SalesListPage extends StatefulWidget {
  @override
  _SalesListPageState createState() => _SalesListPageState();
}

class _SalesListPageState extends State<SalesListPage> {
  final RxInt currentPage = 1.obs;
  final int itemsPerPage = 5;
  final List<Map<String, String>> purchases = List.generate(
    20,
        (index) => {
      "invoiceDate": "12/02/2025",
      "cashCredit": "Cash",
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
    return Scaffold(
      backgroundColor: AppColors.bgcolor,
      appBar: AppBar(
        backgroundColor: AppColors.lightgreen,
        title: Text(
          "Items for sale",
          style: AppTextStyles.headingStyle.copyWith(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Obx(
                    () {
                  int startIndex = (currentPage.value - 1) * itemsPerPage;
                  int endIndex = startIndex + itemsPerPage;
                  var paginatedList = purchases.sublist(
                      startIndex, endIndex > purchases.length ? purchases.length : endIndex);

                  return ListView.builder(
                    itemCount: paginatedList.length,
                    itemBuilder: (context, index) {
                      var item = paginatedList[index];
                      return GestureDetector(
                        onTap: () {
                          Get.to(() => SalesDetailsPage(details: item));
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 10),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.cream),
                          ),
                          child: Stack(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text("Invoice No: ",
                                              style: AppTextStyles.bodyStyle.copyWith(
                                                  fontWeight: FontWeight.bold)),
                                          Text("${item['invoiceNumber']}",
                                              style: AppTextStyles.bodyStyle),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text("Invoice Date: ",
                                              style: AppTextStyles.bodyStyle.copyWith(
                                                  fontWeight: FontWeight.bold)),
                                          Text("${item['invoiceDate']}",
                                              style: AppTextStyles.bodyStyle),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Text("Name: ",
                                          style: AppTextStyles.bodyStyle.copyWith(
                                              fontWeight: FontWeight.bold)),
                                      Text("${item['name'] ?? ''}",
                                          style: AppTextStyles.bodyStyle),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Text("HSN Code: ",
                                          style: AppTextStyles.bodyStyle.copyWith(
                                              fontWeight: FontWeight.bold)),
                                      Text("${item['hsnCode']}",
                                          style: AppTextStyles.bodyStyle),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Text("Quantity: ",
                                          style: AppTextStyles.bodyStyle.copyWith(
                                              fontWeight: FontWeight.bold)),
                                      Text("${item['quantityUnit']}",
                                          style: AppTextStyles.bodyStyle),
                                    ],
                                  ),
                                ],
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.edit, color: AppColors.yellow),
                                      onPressed: () {},
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.delete, color: Colors.red),
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 60),
        child: FloatingActionButton(
          backgroundColor: AppColors.lightgreen,
          onPressed: () {
            Get.toNamed("/sales_form");

          },
          child: Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}