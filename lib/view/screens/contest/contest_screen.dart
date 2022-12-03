import 'package:coders_arena/constants/color_constants.dart';
import 'package:coders_arena/controller/contest_list_screen_controller.dart';
import 'package:coders_arena/enums/enums.dart';
import 'package:coders_arena/utils/device_size.dart';
import 'package:coders_arena/utils/shimmer.dart';
import 'package:coders_arena/utils/space_provider.dart';
import 'package:coders_arena/view/common_ui/contest_list_data_tile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ContestScreen extends StatelessWidget {
  const ContestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ContestListScreenController controller = ContestListScreenController();
    // controller.fetchContests();
    Shimmer shimmer = Shimmer();
    SpaceProvider spaceProvider = SpaceProvider();
    return Consumer<ContestListScreenController>(
      builder: (context,contestListController,child){
        if(contestListController.contestListStatus == ContestListStatus.nil)
          {
            contestListController.fetchContests();
          }
        switch (contestListController.contestListStatus) {
          case ContestListStatus.nil:
            return Center(
              child: MaterialButton(
                color: darkBlueColor,
                onPressed: () {
                  contestListController.fetchContests();
                },
                child: const Text(
                  'Refresh Page',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            );
          case ContestListStatus.fetching:
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Contests',
                      style: GoogleFonts.nunito(
                        textStyle: TextStyle(
                          fontSize: displayWidth(context)*0.09,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 6,
                    itemBuilder: (context,index){
                      return shimmer.shimmerForContests(spaceProvider, context);
                    },
                  ),
                ),
              ],
            );
          case ContestListStatus.fetched:
            if(contestListController.contestList.isNotEmpty){
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Contests',
                        style: GoogleFonts.nunito(
                          textStyle: TextStyle(
                            fontSize: displayWidth(context)*0.09,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: contestListController.contestList.length,
                      itemBuilder: (context,index){
                        return ContestListTile(contestListModel: contestListController.contestList[index]);
                      },
                    ),
                  ),
                  // Expanded(
                  //   child: ListView.builder(
                  //     shrinkWrap: true,
                  //     itemCount: 6,
                  //     itemBuilder: (context,index){
                  //       return shimmer.shimmerForContests(spaceProvider, context);
                  //     },
                  //   ),
                  // ),
                ],
              );
            }
            return const Center(
                child:  Text('Nothing Here!'));
        }
      }
    );
  }
}
