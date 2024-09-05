import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/pages/login_page.dart';
import 'package:todo_app/pages/main_page.dart';

import '../helpers/route.dart';

class LoginController extends GetxController {
  // Observable variables
  final isLoggedIn= RxBool(false);
  final token= RxString('');
  

  // Simulated login function
  Future<void> login(String email, String password) async {
    // Simulating a successful login with any email/password
    if (email.isNotEmpty && password.isNotEmpty) {
      // Generate a fake token
      String generatedToken = 'sample_token';

      // Save token using SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('login_token', generatedToken);

      // Update state
      token.value = generatedToken;
      isLoggedIn.value = true;

      // Navigate to the main app or dashboard
      offAll(MainPage());
    }
  }

  // // Check if the user is already logged in
  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedToken = prefs.getString('login_token');
    if (savedToken != null) {
      token.value = savedToken;
      isLoggedIn.value = true;

      // Navigate to the main app or dashboard
     offAll(MainPage());
    }else{
      offAll(LoginPage());
    }
  }

  // Logout function to clear token
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('login_token');
    isLoggedIn.value = false;
    token.value = '';

    // Navigate back to login page
    offAll(LoginPage());
  }
}
