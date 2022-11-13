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
          return const Center(
            child: CircularProgressIndicator(),
          );
        case PostsStatus.fetched:
          if (postController.feedScreenPosts.isNotEmpty) {
            for (List<PostModel> postList
                in postController.feedScreenPosts.values) {
              debugPrint(postList.toString());
              return Column(
                children: [
                  CustomisedAppBar(),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: postList.length,
                      itemBuilder: (context, index) {
                        return Consumer<UserController>(
                          builder: (context,userController,child){
                            return FutureBuilder<UserModel?>(
                                future: userController.getUser(postList[index].uid),
                                builder: (context,snapshot){
                                  if(snapshot.connectionState == ConnectionState.done && snapshot.hasData)
                                  {
                                    return DesignPost(
                                      postModel: postList[index],
                                      userModel: snapshot.data!,
                                    );
                                  }
                                  else
                                  {
                                    return shimmer.shimmerForFeeds(spaceProvider, context);
                                  }
                                });
                          },
                        );
                      },
                    ),
                  ),
                ],
              )
                ;
            }
          }
          return const Center(
            child: Text('Nothing Here!'),
          );
      }
    });
  }
}
