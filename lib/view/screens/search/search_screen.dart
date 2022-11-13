import 'package:coders_arena/utils/shimmer.dart';
import 'package:coders_arena/utils/space_provider.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Shimmer shimmer = Shimmer();
    final SpaceProvider spaceProvider = SpaceProvider();
    return shimmer.shimmerForFeeds(spaceProvider, context);
  }
}
