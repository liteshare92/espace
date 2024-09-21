// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, avoid_print, prefer_const_constructors

import 'package:espace/build_appbart.dart';
import 'package:espace/contact_page.dart';
import 'package:espace/map_page.dart';
import 'package:espace/services_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Espace Beeggee',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primaryColor: Colors.red,
        textTheme: TextTheme(
          bodyLarge: TextStyle(fontSize: 16, fontFamily: 'Poppins'),
          bodyMedium: TextStyle(fontSize: 14, fontFamily: 'Poppins'),
          titleLarge: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.red,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
          ),
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.green),
      ),

      //
      home: const AuthPage(),
    );
  }
}

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _smsController = TextEditingController();
  String verificationId = '';

  void _verifyPhone() async {
    await _auth.verifyPhoneNumber(
      phoneNumber: _phoneController.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        print('Verification failed: ${e.message}');
        if (e.code == 'too-many-requests') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  'Too many login attempts. Please try again later or contact support.'),
              duration: Duration(seconds: 5),
            ),
          );
        }
      },
      codeSent: (String verId, int? resendToken) {
        setState(() {
          verificationId = verId;
        });
      },
      codeAutoRetrievalTimeout: (String verId) {
        verificationId = verId;
      },
    );
  }

  void _signInWithPhoneNumber() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: _smsController.text,
    );

    await _auth.signInWithCredential(credential);
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const ProductListPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar('Login', context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.center, // Centers text horizontally
            children: [
              // Message de bienvenue
              const Text(
                'Bienvenue dans Espace Beeggee !',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Veuillez saisir votre numéro de téléphone',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                  height: 20), // Espace entre le message et les champs
              TextField(
                  controller: _phoneController,
                  decoration:
                      const InputDecoration(labelText: 'Numéro de téléphone')),
              ElevatedButton(
                  onPressed: _verifyPhone,
                  child: const Text('Envoyer le code')),
              TextField(
                  controller: _smsController,
                  decoration: const InputDecoration(labelText: 'Code SMS')),
              ElevatedButton(
                  onPressed: _signInWithPhoneNumber,
                  child: const Text('Se connecter')),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = [
    ServicesPage(),
    ContactPage(),
    MapPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // appBar: buildAppBar('Accueil'),
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Services'),
          BottomNavigationBarItem(
              icon: Icon(Icons.contact_mail), label: 'Contact'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Localisation'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
