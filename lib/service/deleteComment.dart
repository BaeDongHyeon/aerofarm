import 'dart:convert';

import 'package:capstone/provider/Controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../main.dart';
import '../model/Comment.dart';
import 'normalFetch.dart';

deleteComment(BuildContext context, ModifySelectController modifySelectController,Comment comment) async {
  final userController = Get.put(UserController());
  final routeController = Get.put(RouteController());

  if (checkTimerController.time.value) {
    checkTimerController.stop(context);
  } else {
    if (modifySelectController.id.value != comment.id) {
      modifySelectController.changeModify();
    }
    if (modifySelectController.modify.value &&
        modifySelectController.id.value == comment.id) {
      modifySelectController.modify.value = false;
    } else {
      var body = json.encode({"id": comment.id});
      await http.post(Uri.http(serverIP, '/deleteComment'),
          headers: {
            "Content-Type": "application/json",
            "Cookie": "JSESSIONID=${userController.user.value.session}",
          },
          body: body);
      readComment(comment.postId,false);
      routeController.setCurrent(routeController.before.value);
      Get.back();
    }
  }
}