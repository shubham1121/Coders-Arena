
import 'package:coders_arena/controller/add_post_screen_controller.dart';
import 'package:coders_arena/controller/all_users_controller.dart';
import 'package:coders_arena/controller/authentication_screen_controller.dart';
import 'package:coders_arena/controller/contest_list_screen_controller.dart';
import 'package:coders_arena/controller/disposable_controller.dart';
import 'package:coders_arena/controller/feed_screen_controller.dart';
import 'package:coders_arena/controller/my_posts_controller.dart';
import 'package:coders_arena/controller/user_controller.dart';
import 'package:coders_arena/controller/verify_email_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppProviders {
  static List<DisposableProvider> getDisposableProviders(BuildContext context) {
    return [
      Provider.of<MyPostsController>(context, listen: false),
      Provider.of<AuthScreenController>(context, listen: false),
      Provider.of<AddPostScreenController>(context, listen: false),
      Provider.of<UserController>(context, listen: false),
      Provider.of<AllUsersController>(context, listen: false),
      Provider.of<AuthScreenController>(context, listen: false),
      Provider.of<ContestListScreenController>(context, listen: false),
      Provider.of<FeedScreenController>(context, listen: false),
      Provider.of<VerifyEmailScreenController>(context, listen: false),
    ];
  }

  static void disposeAllDisposableProviders(BuildContext context) {
    getDisposableProviders(context).forEach((disposableProvider) {
      disposableProvider.disposeValues();
    });
  }
}