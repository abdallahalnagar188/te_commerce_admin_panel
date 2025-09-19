import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:te_commerce_admin_panel/data/repos/auth/auth_repo.dart';

import '../../../../features/shop/models/address_model.dart';

class AddressRepository extends GetxController {
  // Get instance of AddressRepository using GetX
  static AddressRepository get instance => Get.find();

  // Firebase Firestore instance
  final _db = FirebaseFirestore.instance;

  /// Fetch user addresses from Firestore based on userId
  Future<List<AddressModel>> fetchUserAddresses(String userId) async {
    try {
      // Query Firestore collection to get user addresses
      final result = await _db
          .collection('Users')
          .doc(userId)
          .collection('Addresses')
          .get();

      // Convert Firestore document snapshots to AddressModel objects
      return result.docs
          .map((documentSnapshot) =>
          AddressModel.fromDocumentSnapshot(documentSnapshot))
          .toList();
    } catch (e) {
      // Throw an error if fetching addresses fails
      throw "Something went wrong while fetching Address Information. Try again later";
    }
  }

  /// Update the "SelectedAddress" field for a specific address
  Future<void> updateSelectedField(String addressId, bool selected) async {
    try {
      // Get the current user's ID
      final userId = AuthRepo.instance.authUser!.uid;

      // Update the selected field for the specified address in Firestore
      await _db
          .collection('Users')
          .doc(userId)
          .collection('Addresses')
          .doc(addressId)
          .update({'SelectedAddress': selected});
    } catch (e) {
      // Throw an error if updating address selection fails
      throw "Unable to update your address selection. Try again later";
    }
  }

  /// Add a new address to Firestore
  Future<String> addAddress(AddressModel address) async {
    try {
      // Get the current user's ID
      final userId = AuthRepo.instance.authUser!.uid;

      // Add the address to the user's collection in Firestore
      final currentAddress = await _db
          .collection('Users')
          .doc(userId)
          .collection('Addresses')
          .add(address.toJson());

      // Return the ID of the newly added address
      return currentAddress.id;
    } catch (e) {
      // Throw an error if adding the address fails
      throw "Something went wrong while saving Address Information. Try again later";
    }
  }
}
