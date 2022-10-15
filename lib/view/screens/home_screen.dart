import 'package:coders_arena/services/firebase_services/firebase_auth.dart';
import 'package:coders_arena/utils/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService _authService = AuthService(FirebaseAuth.instance);
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    return SafeArea(
      child: isLoading ? Loading(false) :
      Scaffold(
        body: Center(
          child: Column(
            children: [
              Text('${user!.displayName}'),
              Text('${user.email}'),
              IconButton(
                onPressed: () {
                  setState(() {
                    isLoading = true;
                    _authService.logout(user).whenComplete(() {
                      setState(() {
                        isLoading=false;
                      });
                    });
                  });
                },
                icon: const Icon(Icons.logout),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
