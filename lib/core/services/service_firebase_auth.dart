import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

import '../errors/exceptions.dart';

class FirebaseAuthService {
  Future<User> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      log('Exception in FirebaseAuthService.createUserWithEmailAndPassword method:  ${e.toString()} and code is ${e.code}');
      if (e.code == 'weak-password') {
        throw CustomException(message: 'كلمة المرور المقدمة ضعيفة جدًا.');
      } else if (e.code == 'email-already-in-use') {
        throw CustomException(
            message: 'يوجد حساب بالفعل بهذا البريد الإلكتروني.');
      } else if (e.code == 'invalid-email') {
        throw CustomException(message: 'عنوان البريد الإلكتروني غير صالح.');
      } else if (e.code == 'operation-not-allowed') {
        throw CustomException(message: 'عنوان البريد الإلكتروني غير مسموح به.');
      } else if (e.code == 'network-request-failed') {
        throw CustomException(message: 'يرجى التحقق من الاتصال بالانترنت.');
      } else {
        throw CustomException(
            message: 'حدث خطأ، يرجى المحاولة مرة أخرى لاحقًا.');
      }
    } catch (e) {
      log('Exception in FirebaseAuthService.createUserWithEmailAndPassword method:  ${e.toString()}');
      throw CustomException(message: 'حدث خطأ، يرجى المحاولة مرة أخرى لاحقًا.');
    }
  }

  Future deleteUser() async {
    try {
      await FirebaseAuth.instance.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      log('Exception in FirebaseAuthService.deleteUser method: ${e.toString()}');
      throw CustomException(message: 'حدث خطاء، يرجى المحاولة مرة أخرى لاحقا.');
    } catch (e) {
      log('Exception in FirebaseAuthService.deleteUser method: ${e.toString()}');
      throw CustomException(
          message: 'حدث خطاء، يرجى المحاولة مرة أخرى لاحقًا.');
    }
  }
}
