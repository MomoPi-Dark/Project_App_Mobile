
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menejemen_waktu/src/core/models/tasks_item_builder.dart';

class ItemInfoScreen extends StatefulWidget {
  const ItemInfoScreen({super.key});

  @override
  State<ItemInfoScreen> createState() => _ItemInfoScreenState();
}

class _ItemInfoScreenState extends State<ItemInfoScreen> {
  @override
  Widget build(BuildContext context) {
    var data = Get.arguments as Map<String, dynamic>;
    var dataFromJson = TaskItemBuilder.fromJson(data);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Item Info",
        ),
      ),
      body: Center(
        child: Text(
            "Item Info Screen ${dataFromJson.userId} ${dataFromJson.isTimeExceeded == 1 ? "Completed" : "Not Completed"}"),
      ),
    );
  }
}
