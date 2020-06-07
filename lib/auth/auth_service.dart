import 'package:firebase_auth/firebase_auth.dart';
class AuthService{

  final _auth = FirebaseAuth.instance;

  Stream<FirebaseUser> get user =>_auth.onAuthStateChanged;

  Future registerWithEmailAndPassword(String email,String password) async {
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future signInWithEmailAndPassword(String email,String password) async{
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    }catch(e){
      return null;
    }
  }

  Future getCurrentUser() async {
    try{
      FirebaseUser user= await _auth.currentUser();
      return user.uid;
    }catch(e){
      return null;
    }

  }


}