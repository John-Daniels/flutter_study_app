import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:study_app/configs/logger/app_logger.dart';
import 'package:study_app/firebase_ref/references.dart';
import 'package:study_app/screens/auth/login_screen.dart';
import 'package:study_app/screens/home/home_screen.dart';
import 'package:study_app/widgets/dialogs/dialog_widget.dart';

class AuthController extends GetxController {
  @override
  void onReady() {
    initAuth();
    super.onReady();
  }

  late FirebaseAuth _auth;
  // final _user = Rxn(User)
  final _user = Rxn<User>();
  late Stream<User?> _authStateChanges;

  void initAuth() async {
    await Future.delayed(const Duration(seconds: 2));
    _auth = FirebaseAuth.instance;
    _authStateChanges = _auth.authStateChanges();
    _authStateChanges.listen((User? user) {
      _user.value = user;
    });
    navigateToOnboarding();
  }

  signinWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      GoogleSignInAccount? account = await googleSignIn.signIn();
      if (account != null) {
        final authAccount = await account.authentication;
        final credential = GoogleAuthProvider.credential(
          idToken: authAccount.idToken,
          accessToken: authAccount.accessToken,
        );

        await _auth.signInWithCredential(credential);
        await saveUser(account);
        navigateToHomePage();
      }
    } on Exception catch (e) {
      AppLogger.e(e);
    }
  }

  User? getUser() {
    _user.value = _auth.currentUser;
    return _user.value;
  }

  saveUser(GoogleSignInAccount account) {
    userRF.doc(account.email).set({
      "email": account.email,
      "name": account.displayName,
      "profilepic": account.photoUrl,
    });
  }

  void navigateToOnboarding() {
    Get.offAllNamed('/onboarding');
  }

  Future<void> signOut() async {
    AppLogger.d('Sign out!');

    try {
      await _auth.signOut();
      navigateToHomePage();
    } on FirebaseAuthException catch (e) {
      AppLogger.e(e);
    }
  }

  navigateToHomePage() {
    Get.offAllNamed(HomeScreen.routeName);
  }

  void showLoginAlertDialog() {
    Get.dialog(
      Dialogs.questionStartDialogue(
        onTap: () {
          Get.back();
          // navigate to login page
          navigateToLoginPage();
        },
      ),
      barrierDismissible: false,
    );
  }

  void navigateToLoginPage() {
    Get.toNamed(LoginScreen.routeName);
  }

  bool isLoggedIn() => _auth.currentUser != null;
}
