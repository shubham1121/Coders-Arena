import 'package:coders_arena/constants/color_constants.dart';
import 'package:coders_arena/utils/device_size.dart';
import 'package:coders_arena/utils/space_provider.dart';
import 'package:coders_arena/view/screens/feed/add_post_screen.dart';
import 'package:coders_arena/view/screens/contest/contest_screen.dart';
import 'package:coders_arena/view/screens/feed/feed_screen.dart';
import 'package:coders_arena/view/screens/profile/my_profile_screen.dart';
import 'package:coders_arena/view/screens/search/search_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final AuthService _authService = AuthService(FirebaseAuth.instance);
  final spaceProvider = SpaceProvider();
  bool isLoading = false;
  int index = 4;
  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<User?>(context);
    final screenIcons = <Widget>[
      const Icon(
        Icons.add_box_outlined,
      ),
      const Icon(
        Icons.search_outlined,
      ),
      const Icon(
        CupertinoIcons.home,
      ),
      const Icon(
        Icons.emoji_events_outlined,
      ),
      const Icon(
        Icons.person_outline,
      ),
    ];
    final screens = [
      const AddPostScreen(),
      const SearchScreen(),
      const FeedScreen(),
      const ContestScreen(),
      const MyProfileScreen(),
    ];

    return SafeArea(
      child: Scaffold(
        body: screens[index],
        // screens[index],
        backgroundColor: darkBlueColor,
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            iconTheme: IconThemeData(
                color: Colors.grey.shade300,
                size: displayWidth(context) * 0.065),
          ),
          child: CurvedNavigationBar(
            backgroundColor: darkBlueColor,
            color: lightBlueColor,
            buttonBackgroundColor: lightBlueColor,
            items: screenIcons,
            height: displayHeight(context) * 0.07,
            animationCurve: Curves.easeOut,
            animationDuration: const Duration(milliseconds: 400),
            index: index,
            onTap: (index) => setState(() => this.index = index),
          ),
        ),
      ),
    );
  }
}
