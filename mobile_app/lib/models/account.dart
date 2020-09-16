import 'package:firebase_auth/firebase_auth.dart';

///Check if the format of the [phoneNumber] is valid.
bool isPhoneNumberFormatValid(String phoneNumber) {
  if (phoneNumber.substring(0, 4) != '+962') return false;

  phoneNumber = phoneNumber.substring(4).trim();

  //Remove leading zero.
  if (phoneNumber[0] == '0') phoneNumber = phoneNumber.substring(1);

  if (phoneNumber.length != 9 || phoneNumber[0] != '7') return false;

  return true;
}

///[isSignedIn] returns true when the user sign-in or sing-up (even if the user didn't verify their email)
bool get isSignedIn => _auth.currentUser != null;

bool get isPhoneNumberVerified {
  if (user == null) return false;
  return user.phoneNumber != null;
}

final _auth = FirebaseAuth.instance;

///The value will be assigned by [sendVerificationPhoneMessage].
///so this value can be used in [verifyPhoneNumber].
String _verificationId;

User get user {
  if (_auth.currentUser != null) _auth.currentUser.reload();
  return _auth.currentUser;
}

///Send an sms to message with a code.
Future<bool> sendVerificationPhoneMessage(String phoneNumber) async {
  if (!isPhoneNumberFormatValid(phoneNumber)) return false;

  var result = true;

  await _auth.verifyPhoneNumber(
    phoneNumber: phoneNumber,
    timeout: const Duration(minutes: 2),
    // this callback is called only when the verification is successfully completed
    // automatically using Auto Retrieval (without the need of user input).
    //Android only.
    verificationCompleted: (phoneAuthCredential) async {
      print('verificationCompleted');
      // try {
      //   await _auth.signInWithCredential(phoneAuthCredential);
      // } catch (e) {
      //   print(e);
      //   result = false;
      // }
    },

    verificationFailed: (FirebaseAuthException e) {
      print('phone verificationFailed');
      result = false;
    },
    codeSent: (verificationId, forceResendingToken) {
      print('codeSent');
      _verificationId = verificationId;
    },
    codeAutoRetrievalTimeout: (verificationId) {},
  );

  return result;
}

///Call [sendVerificationPhoneMessage] before this function.
Future<bool> verifyPhoneNumber(String smsCode) async {
  if (_verificationId == null) {
    print(
        'Error: Call sendVerificationPhoneMessage function before calling verifyPhoneNumber');
    return false;
  }

  try {
    final phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: _verificationId, smsCode: smsCode);

    await _auth.signInWithCredential(phoneAuthCredential);
  } catch (e) {
    print(e);
    return false;
  }

  return true;
}

Future<void> signOut() async {
  await _auth.signOut();
}
