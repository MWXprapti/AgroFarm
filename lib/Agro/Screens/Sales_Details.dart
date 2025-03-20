import 'package:flutter/material.dart';
import 'package:new_app/theme/theme.dart';

class SalesDetailsPage extends StatelessWidget {
  final Map<String, String> details;

  SalesDetailsPage({required this.details});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Purchase Details"),
        backgroundColor: AppColors.lightgreen,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Container(
          height: MediaQuery.of(context).size.height*0.32,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: AppColors.bgcolor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.black),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(details['invoiceNumber'] ?? "", style: AppTextStyles.bodyStyle.copyWith(fontWeight: FontWeight.bold)),
                  Text(details['invoiceDate'] ?? "", style: AppTextStyles.bodyStyle.copyWith(fontWeight: FontWeight.bold)),
                ],
              ),
              Divider(color: Colors.black),
              buildDetail("Name", details['name'] ?? ""),
              buildDetail("GST No", details['gstNo'] ?? ""),
              Divider(color: Colors.black),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildBoldDetail("Product Name", details['productName'] ?? ""),
                  buildBoldDetail("HSN Code", details['hsnCode'] ?? ""),
                ],
              ),
              Divider(color: Colors.black),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildBoldDetail("Quantity", details['quantityUnit'] ?? ""),
                  buildBoldDetail("Amount", details['amount'] ?? ""),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDetail(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.bodyStyle.copyWith(fontWeight: FontWeight.bold,fontSize: 16)),
          Text(value, style: AppTextStyles.bodyStyle.copyWith(fontSize: 15)),
        ],
      ),
    );
  }

  Widget buildBoldDetail(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.bodyStyle.copyWith(fontWeight: FontWeight.bold,fontSize: 16)),
        Text(value, style: AppTextStyles.bodyStyle.copyWith(fontSize: 15)),
      ],
    );
  }
}