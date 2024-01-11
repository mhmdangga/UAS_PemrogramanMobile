import 'package:firebase_auth/firebase_auth.dart';
import 'package:fix/global/cummon/toast.dart';
import 'package:fix/src/user_auth/firebase_auth_implementasion/firebase_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<LoginPage> {
  bool _isHiddenPassword = true;

  bool _isSignIn = false;

  final FirebaseAuthService _auth = FirebaseAuthService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final emailController = TextEditingController();
  final passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose

    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/login.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left: 35, top: 135),
              child: Column(
                children: [
                  Image.asset(
                    'assets/logo/HIKY.png',
                    width: 100.0,
                    height: 100.0,
                  ),
                  SizedBox(height: 10), // Spasi antara gambar dan teks
                  Text(
                    'Welcome back',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 35, right: 35),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _emailController,
                              // obscureText: _isHidden,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Email",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              validator: (value) {
                                bool emailValid = RegExp(
                                  r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
                                ).hasMatch(value!);

                                if (value.isEmpty) {
                                  return 'Email tidak boleh kosong'; // Pesan kesalahan jika email kosong
                                }

                                if (!emailValid) {
                                  return 'Email tidak valid'; // Pesan kesalahan jika email tidak sesuai dengan pola yang Anda tentukan
                                }

                                return null; // Validasi sukses
                              },
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              controller: _passwordController,
                              obscureText: _isHiddenPassword,
                              style: TextStyle(),
                              decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Password",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _isHiddenPassword = !_isHiddenPassword;
                                    });
                                  },
                                  child: Icon(_isHiddenPassword
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Password tidak boleh kosong';
                                } else if (value.length < 6) {
                                  return 'Password terlalu pendek';
                                }
                                return null; // Validasi sukses
                              },
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Sign in',
                                  style: TextStyle(
                                      fontSize: 27,
                                      fontWeight: FontWeight.w700),
                                ),
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Color(0xff4c505b),
                                  child: _isSignIn
                                      ? CircularProgressIndicator(
                                          color: Colors.white,
                                        )
                                      : IconButton(
                                          color: Colors.white,
                                          onPressed: () async {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              // Kedua validasi telah terpenuhi
                                              bool signInResult =
                                                  await _signIn(); // Panggil _signUp dari instance RegisterPage

                                              if (signInResult) {
                                                showToast(
                                                    message:
                                                        'User berhasil login');
                                              } else {
                                                showToast(
                                                    message:
                                                        'User gagal login');
                                              }
                                            }
                                          },
                                          icon: Icon(
                                            Icons.arrow_forward,
                                          ),
                                        ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, '/register');
                                      },
                                      child: Text(
                                        'Sign Up',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            color: Color(0xff4c505b),
                                            fontSize: 18),
                                      ),
                                      style: ButtonStyle(),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, '/forgotpw');
                                      },
                                      child: Text(
                                        'Forgot Password',
                                        style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          color: Color(0xff4c505b),
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        // Aksi yang akan dijalankan saat logo Google ditekan
                                        print('Logo Google ditekan!');
                                        _signInWithGoogle();
                                      },
                                      child: Image.asset(
                                        'assets/logo/google.png',
                                        width: 40.0,
                                        height: 40.0,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 30.0,
                                    ), // Jarak antara logo Google dan Apple
                                    InkWell(
                                      onTap: () {
                                        // Aksi yang akan dijalankan saat logo Apple ditekan
                                        print('Logo Apple ditekan!');
                                      },
                                      child: Image.asset(
                                        'assets/logo/apple.png',
                                        width: 40.0,
                                        height: 40.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // autentikasi signin
  Future<bool> _signIn() async {
    setState(() {
      _isSignIn = true;
    });

    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    setState(() {
      _isSignIn = false;
    });

    if (user != null) {
      print("User Berhasil Login");
      Navigator.pushNamed(context, "/homepage");
      return true;
    } else {
      showToast(message: 'ada eror');
      return false;
    }
  }

  // signin untuk google
  Future<void> _signInWithGoogle() async {
    // melakukkan deklarasi variabel _googleSignIn dengan tipe GoogleSignIn();
    final GoogleSignIn _googleSignIn = GoogleSignIn();

    try {
      // Lakukan sign out dari Google sebelum mencoba login kembali
      await _googleSignIn.signOut();

      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        await _firebaseAuth.signInWithCredential(credential);
        Navigator.pushNamed(context, "/homepage");
        showToast(message: "Berhasil login dengan Google");
      }
    } catch (e) {
      showToast(message: "Terjadi kesalahan: $e");
    }
  }
}






















