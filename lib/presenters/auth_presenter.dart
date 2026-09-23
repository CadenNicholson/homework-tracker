import '../models/auth_model.dart';

class AuthPresenter {
  final AuthModel _model = AuthModel();

  Future<String?> login(String email,String password){
    return _model.login(email,password);
  }

  Future<String?> signUp(String email, String password){
    return _model.signUp(email, password);
  }
  Future<void> logout() => _model.signOut();

  Future<void> sendPasswordResetEmail(String email) => _model.resetPassword(email);

  Stream authStateChanges() => _model.authStateChanges();

  String? getCurrentUserEmail() => _model.currentUser?.email;
}