import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:Ads/Classes/SaveUser.dart';
import 'package:Ads/Widgets/ToastMessage.dart';

class AuthorisationMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  SaveUser returnFirebaseUser(User user) {

    return user != null
        ? SaveUser(
            userID: user.uid,
            displayName: user.displayName,
            email: user.email,
            phoneNumber: user.phoneNumber)
        : null;
  }

  // auth change user stream

  Stream<SaveUser> get user {
    return _auth
        .authStateChanges()
        .map((User user) => returnFirebaseUser(user));
    // return _auth.onAuthStateChanged.map(returnFirebaseUser);
  }

  Future signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential authResult =
          await _auth.signInWithCredential(credential);

      return returnFirebaseUser(authResult.user);
    } catch (error) {
      print(error.code);
      print(error.toString());

      String errorMessage;

      switch (error.code) {
        case "INVALID_ACCOUNT":
          errorMessage = "this user-account is invalid";
          break;
        case "INTERNAL_ERROR":
          errorMessage = "An internal error occurred, please try again";
          break;
        case "user-disabled":
          errorMessage = "User with this email has been disabled.";
          break;
        case "too-many-requests":
          errorMessage = "Too many requests. Try again later.";
          break;
        case "operation-not-allowed":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        case "network-request-failed":
        case "network_error":
          errorMessage = "Check internet connection";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
      // print(0);
      toastMessage(errorMessage);
    }
  }

  Future<void> signOutGoogle() async {
    try {
      await googleSignIn.signOut();
      // print("signout from google");
    } catch (e) {
      print(e.toString());
    }
  }

  Future signOut() async {
    try {
      signOutGoogle();
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      String errorMessage;
      switch (error.code) {
        case "network-request-failed":
        case "network_error":
          errorMessage = "Check internet connection";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
      toastMessage(errorMessage);
    }
  }

  // Future signInWithGmailAndPassword(String _email, String _password) async {
  //   try {
  //     User _firebaseUser = (await _auth.signInWithEmailAndPassword(
  //             email: _email, password: _password))
  //         .user;
  //     return returnFirebaseUser(_firebaseUser);
  //   } catch (error) {
  //     print(error.toString());
  //     String errorMessage;
  //     switch (error.code) {
  //       case "invalid-email":
  //         errorMessage = "Your email address appears to be malformed.";
  //         break;
  //       case "wrong-password":
  //         errorMessage =
  //             "Your password is wrong OR\nThis account use Google SignIn.";
  //         break;
  //       case "email-already-in-use":
  //         errorMessage =
  //             "The email address is already in use by another account.";
  //         break;
  //       case "user-not-found":
  //         errorMessage = "User with this email doesn't exist.";
  //         break;
  //       case "user-disabled":
  //         errorMessage = "User with this email has been disabled.";
  //         break;
  //       case "too-many-requests":
  //         errorMessage = "Too many requests. Try again later.";
  //         break;
  //       case "operation-not-allowed":
  //         errorMessage = "Signing in with Email and Password is not enabled.";
  //         break;
  //       case "network-request-failed":
  //       case "network_error":
  //         errorMessage = "Check internet connection";
  //         break;
  //       default:
  //         errorMessage = "An undefined Error happened.";
  //     }

  //     toastMessage(errorMessage);
  //   }
  // }

  // Future signUpWithGmailAndPassword(String _email, String _password) async {
  //   try {
  //     User _firebaseUser = (await _auth.createUserWithEmailAndPassword(
  //             email: _email, password: _password))
  //         .user;
  //     return returnFirebaseUser(_firebaseUser);
  //   } catch (error) {
  //     print(error.toString());
  //     String errorMessage;
  //     print(error.code);

  //     switch (error.code) {
  //       case "invalid-email":
  //         errorMessage = "Your email address appears to be malformed.";
  //         break;
  //       case "email-already-in-use":
  //         errorMessage =
  //             "The email address is already in use by another account.";
  //         break;
  //       case "wrong-password":
  //         errorMessage = "Your password is wrong.";
  //         break;
  //       case "user-not-found":
  //         errorMessage = "User with this email doesn't exist.";
  //         break;
  //       case "user-disabled":
  //         errorMessage = "User with this email has been disabled.";
  //         break;
  //       case "too-many-requests":
  //         errorMessage = "Too many requests. Try again later.";
  //         break;
  //       case "operation-not-allowed":
  //         errorMessage = "Signing in with Email and Password is not enabled.";
  //         break;
  //       case "network-request-failed":
  //         errorMessage = "Check internet connection";
  //         break;
  //       default:
  //         errorMessage = "An undefined Error happened.";
  //     }

  //     toastMessage(errorMessage);
  //   }
  // }

  // Future resetPassword(String _email) async {
  //   try {
  //     return await _auth.sendPasswordResetEmail(email: _email);
  //   } catch (error) {
  //     print(error.toString());
  //     String errorMessage;
  //     switch (error.code) {
  //       case "invalid-email":
  //         errorMessage = "Your email address appears to be malformed.";
  //         break;
  //       case "wrong-password":
  //         errorMessage = "Your password is wrong.";
  //         break;
  //       case "email-already-in-use":
  //         errorMessage =
  //             "The email address is already in use by another account.";
  //         break;
  //       case "user-not-found":
  //         errorMessage = "User with this email doesn't exist.";
  //         break;
  //       case "user-disabled":
  //         errorMessage = "User with this email has been disabled.";
  //         break;
  //       case "too-many-requests":
  //         errorMessage = "Too many requests. Try again later.";
  //         break;
  //       case "operation-not-allowed":
  //         errorMessage = "Signing in with Email and Password is not enabled.";
  //         break;
  //       case "network-request-failed":
  //       case "network_error":
  //         errorMessage = "Check internet connection";
  //         break;
  //       default:
  //         errorMessage = "An undefined Error happened.";
  //     }

  //     toastMessage(errorMessage);
  //   }
  // }

  // Future<void> sendResetPasswordEmail(String email) async {
  //   try {
  //     await _auth.sendPasswordResetEmail(email: email);
  //     toastMessage("A password reset link has been sent to $email");
  //   } catch (error) {
  //     print(error.toString());
  //     String errorMessage;
  //     switch (error.code) {
  //       case "invalid-email":
  //         errorMessage = "Your email address appears to be malformed.";
  //         break;
  //       case "email-already-in-use":
  //         errorMessage =
  //             "The email address is already in use by another account.";
  //         break;
  //       case "user-not-found":
  //         errorMessage =
  //             "There is no user record corresponding to this identifier. The user may have been deleted.";
  //         break;
  //       case "user-disabled":
  //         errorMessage = "User with this email has been disabled.";
  //         break;
  //       case "too-many-requests":
  //         errorMessage = "Too many requests. Try again later.";
  //         break;
  //       case "operation-not-allowed":
  //         errorMessage = "Signing in with Email and Password is not enabled.";
  //         break;
  //       case "network-request-failed":
  //       case "network_error":
  //         errorMessage = "Check internet connection";
  //         break;
  //       default:
  //         errorMessage = "An undefined Error happened.";
  //     }

  //     toastMessage(errorMessage);
  //   }
  // }

}
