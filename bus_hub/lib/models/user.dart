// create a user with UID

class UserModel {
  final String uid;
  final String nic;
  final String email;
  final String profilePictureUrl;

  UserModel(
      {required this.uid,
      required this.nic,
      required this.email,
      required this.profilePictureUrl});
}
