import 'package:coders_arena/constants/color_constants.dart';
import 'package:coders_arena/controller/feed_screen_controller.dart';
import 'package:coders_arena/controller/user_controller.dart';
import 'package:coders_arena/enums/enums.dart';
import 'package:coders_arena/model/post_model.dart';
import 'package:coders_arena/model/user_model.dart';
import 'package:coders_arena/utils/shimmer.dart';
import 'package:coders_arena/utils/space_provider.dart';
import 'package:coders_arena/view/common_ui/custom_app_bar.dart';
import 'package:coders_arena/view/screens/feed/design_post.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SpaceProvider spaceProvider = SpaceProvider();
    final Shimmer shimmer = Shimmer();
    return Consumer<FeedScreenController>(
        builder: (context, postController, child) {
      if (postController.postsStatus == PostsStatus.nil) {
        postController.fetchPosts();
      }
      switch (postController.postsStatus) {
        case PostsStatus.nil:
          return Center(
            child: MaterialButton(
              color: darkBlueColor,
              onPressed: () {
                postController.fetchPosts();
              },
              child: const Text(
                'Refresh Page',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          );
        case PostsStatus.fetching:
          return Column(
            children: [
              const CustomisedAppBar(),
              Expanded(
                child: ListView.builder(
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return shimmer.shimmerForFeeds(spaceProvider, context);
                  },
                ),
              ),
            ],
          );
        case PostsStatus.fetched:
          if (postController.feedScreenPosts.isNotEmpty) {
            Future<void> handleRefresh() async {
              await postController.fetchPosts();
            }

            return Column(
              children: [
                const CustomisedAppBar(),
                Expanded(
                  child: RefreshIndicator(
                    backgroundColor: lightBlueColor,
                    color: darkBlueColor,
                    onRefresh: handleRefresh,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: postController.feedScreenPosts.length,
                      itemBuilder: (context, index) {
                        return Consumer<UserController>(
                          builder: (context, userController, child) {
                            return DesignPost(
                                postModel:
                                    postController.feedScreenPosts[index],
                                lowDetailUser: userController.allUsers[
                                    postController.feedScreenPosts[index].uid]);
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
            // }
          }
          return const Center(child: Text('Nothing Here!'));
      }
    });
  }
}
