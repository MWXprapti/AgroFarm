import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchBarController extends GetxController {
  var isExpanded = false.obs;

  void toggleSearchBar() {
    isExpanded.value = !isExpanded.value;
  }
}

class FarmerProductDash extends StatelessWidget {
  final SearchBarController controller = Get.put(SearchBarController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 150.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Farmer Product Dashboard'),
              background: Container(color: Colors.green[300]),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Obx(() => AnimatedContainer(
                duration: Duration(milliseconds: 300),
                width: controller.isExpanded.value
                    ? MediaQuery.of(context).size.width * 0.9
                    : 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(controller.isExpanded.value
                          ? Icons.close
                          : Icons.search,
                          color: Colors.green),
                      onPressed: controller.toggleSearchBar,
                    ),
                    if (controller.isExpanded.value)
                      Flexible(
                        child: TextField(
                          style: TextStyle(color: Colors.black87),
                          cursorColor: Colors.green,
                          decoration: InputDecoration(
                            hintText: 'Search products...',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                            contentPadding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                          ),
                        ),
                      ),
                  ],
                ),
              )),
            ),
          )
        ],
      ),
    );
  }
}
