import 'dart:io';

import 'package:flutter/material.dart';
import 'package:instagram_app/features/authication/presentation/view_model/usermodel.dart';

abstract class Addpostrepo {
  Future<void> UploadPost(BuildContext context, String? des, File? image);
  Future<void> addlikepost({required Map<String, dynamic> postmap});
  Future<void> deletepost({required Map<String, dynamic> post});
  Future<void> addcomment(
      {required Map<String, dynamic> post,
      required String comment,
      required UserModel user});
}
