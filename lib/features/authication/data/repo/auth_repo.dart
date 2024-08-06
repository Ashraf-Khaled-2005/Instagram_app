import 'dart:io';

abstract class Auth_Repo {
  Future<File?> PickImageGallery();
  Future<File?> PickVidopGallery();

  follow_user({required String uuid});

  Future<void> SignUp(
      {required String Email,
      pass,
      username,
      required List followers,
      following,
      required String image,
      required List stories});
  Future<String> Getimgaeurl(String uuid, File image, String child);
}
