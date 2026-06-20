import 'package:googleapis_auth/auth.dart';

void main() async {
  final credentials = ServiceAccountCredentials.fromJson({});
  final client = await clientViaServiceAccount(credentials, []);
}
