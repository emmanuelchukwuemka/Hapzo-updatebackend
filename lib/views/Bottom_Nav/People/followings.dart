import 'package:haptext_api/bloc/people/cubit/people_cubit.dart';
import 'package:haptext_api/models/searched_user_model.dart';
import 'package:haptext_api/utils/extensions.dart';
import 'package:haptext_api/views/Bottom_Nav/exports.dart';
import 'package:haptext_api/exports.dart';

class Followings extends StatefulWidget {
  const Followings({Key? key}) : super(key: key);

  @override
  State<Followings> createState() => _FollowingsState();
}

class _FollowingsState extends State<Followings> {
  Future<void> getData() async {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  _showOptionsDialog(BuildContext context) async {
    // setState(() {
    return showDialog(
        context: context,
        builder: (context) => SimpleDialog(
              children: [
                SimpleDialogOption(
                  onPressed: () {},
                  child: const Center(
                    child: Text(
                      'Looking for someone to follow?.. go and read your books!!!!',
                    ),
                  ),
                ),
              ],
            ));
    // });
  }

  @override
  Widget build(BuildContext context) {
    final followings = context.watch<PeopleCubit>().followings;
    final size = MediaQuery.sizeOf(context);
    return Column(children: [
      // SEARCH CONTAINER
      Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          width: double.infinity,
          height: 45.0,
          decoration: BoxDecoration(
              // color: context.theme.appBarColor,
              // border: Border.all(
              //   color: Colors.orange,
              //   // (0xFFFD6104),
              //   width: 1.5,
              //   style: BorderStyle.solid
              // ),
              borderRadius: BorderRadius.circular(7.0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.search,
                      // color: context.theme.greyColor,
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  const AppText(
                    text: 'Search',
                  )
                ],
              ),
              IconButton(
                onPressed: () => _showOptionsDialog(context),
                icon: const Icon(Icons.add),
                // color: context.theme.greyColor,
              ),
            ],
          )),
      // CONTENT
      followings.isEmpty
          ? const Expanded(
              child: Center(
                child: AppText(
                    text: 'The people you follow will appear here.',
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    fontSize: 28),
              ),
            )
          : Expanded(
              child: Padding(
              padding:
                  const EdgeInsets.only(bottom: 5.0, left: 5.0, right: 5.0),
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 5.0,
                      mainAxisSpacing: 5.0,
                      childAspectRatio: 0.8),
                  itemCount: followings.length,
                  itemBuilder: (context, index) {
                    return AppshadowContainer(
                        onTap: () {
                          // if (followings[index].profile?.firstName == null) {
                          //   context.read<PeopleCubit>().fetchUserProfileById(
                          //       userId: followings[index].id ?? "0");
                          // } else {
                          context.push(RouteName.friendsProfilePage.path,
                              extra: SearchedUserModel(
                                  id: followings[index].id,
                                  username: '',
                                  profilePicture:
                                      followings[index].profilePicture,
                                  profile: followings[index]));
                          // }
                        },
                        padding: EdgeInsets.all(size.width * 0.04),
                        margin: EdgeInsets.only(bottom: size.width * 0.04),
                        color: Theme.of(context).primaryColorDark,
                        child: Column(children: [
                          AppNetwokImage(
                              height: size.width * 0.18,
                              width: size.width * 0.18,
                              radius: size.width * 0.9,
                              fit: BoxFit.cover,
                              imageUrl: followings[index].profilePicture ?? ""),
                          const SizedBox(height: 10),
                          AppText(
                              text:
                                  "${followings[index].lastName?.capitalizeFirstChar() ?? ""} ${followings[index].firstName?.capitalizeFirstChar() ?? ""}",
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).primaryColor),
                        ]));
                  }),
            ))
    ]);
  }
}
