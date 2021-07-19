import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final titleEditctl = TextEditingController();
  final CollectionReference todoReference =
      FirebaseFirestore.instance.collection('todo');
}
