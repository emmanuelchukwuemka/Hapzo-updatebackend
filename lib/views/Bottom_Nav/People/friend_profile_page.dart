import 'package:haptext_api/bloc/home/cubit/home_cubit.dart';
import 'package:haptext_api/bloc/people/cubit/people_cubit.dart';
import 'package:haptext_api/exports.dart';
import 'package:haptext_api/models/searched_user_model.dart';
import 'package:haptext_api/views/Bottom_Nav/exports.dart';
import 'package:haptext_api/common/theme/custom_theme_extension.dart';

class FriendProfilePage extends StatefulWidget {
  final SearchedUserModel user;

  const FriendProfilePage({super.key, required this.user});

  @override
  State<FriendProfilePage> createState() => _FriendProfilePageState();
}

class _FriendProfilePageState extends State<FriendProfilePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final posts = await context
          .read<HomeCubit>()
          .fetchUserPosts(userId: widget.user.id ?? '');
      if (posts != null) {
        setState(() {
          widget.user.userPhotoPost =
              posts.where((e) => e.postFormat == "photo").toList();
          widget.user.userTextPost =
              posts.where((e) => e.postFormat == "text").toList();
          widget.user.userPhotoPost =
              posts.where((e) => e.postFormat == "audio").toList();
          widget.user.userPhotoPost =
              posts.where((e) => e.postFormat == "video").toList();
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final watchPeople = context.watch<PeopleCubit>();
    return AbsorbPointer(
      absorbing: watchPeople.state is PeopleFollowing,
      child: Opacity(
        opacity: watchPeople.state is PeopleFollowing ? 0.5 : 1.0,
        child: Scaffold(
          backgroundColor: context.theme.bgColor,
          appBar: AppBar(
              iconTheme: IconThemeData(color: context.theme.primaryColor),
              backgroundColor: context.theme.appBarColor,
              title: AppText(
                  text: '@${widget.user.username ?? ''}',
                  color: context.theme.titleTextColor,
                  fontWeight: FontWeight.bold),
              elevation: 0),
          body: ListView(
            children: [
              PictureContainer(user: widget.user),
              Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: AppText(
                      text: '${widget.user.profile?.bio ?? ''}  ',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: context.theme.titleTextColor)),
              Row(
                children: [
                  const SizedBox(width: 12),
                  AppText(
                      text: '${widget.user.followingCount ?? 0} following',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.blueGrey),
                  const SizedBox(width: 15),
                  AppText(
                      text: '${widget.user.followerCount ?? 0}followers',
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.blueGrey),
                  const SizedBox(width: 15),
                  AppText(
                      text: '${widget.user.mentionCount ?? 0}Mutual',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.blueGrey),
                ],
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    Appbutton(
                        isLoading: watchPeople.state is PeopleFollowing,
                        onTap: () {
                          context
                              .read<PeopleCubit>()
                              .followUser(userId: widget.user.id ?? '');
                        },
                        width: 120,
                        height: 40,
                        buttonColor: context.theme.greyColor,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.library_add,
                                  color: Colors.white),
                              const SizedBox(width: 10),
                              AppText(
                                  text: widget.user.following
                                      ? "Unfollow"
                                      : 'Follow',
                                  color: Colors.white)
                            ])),
                    const SizedBox(width: 10),
                    Appbutton(
                        onTap: () {
                          context.push(RouteName.chatPage.path);
                        },
                        width: 120,
                        height: 40,
                        buttonColor: context.theme.primaryColor,
                        child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.chat, color: Colors.white),
                              SizedBox(width: 10),
                              AppText(text: 'Message', color: Colors.white)
                            ]))
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: [
                    TitleAndValueWidget(
                        title: "Name",
                        value:
                            "${widget.user.profile?.firstName ?? ""} ${widget.user.profile?.lastName ?? ""}"),
                    TitleAndValueWidget(
                        title: "Tag Name",
                        value: "@${widget.user.username ?? ""}"),
                    TitleAndValueWidget(
                        title: "Birthday",
                        value: "@${widget.user.profile?.birthDate ?? ""}"),
                    TitleAndValueWidget(
                        title: "Occupation",
                        value: widget.user.profile?.occupation ?? ""),
                    TitleAndValueWidget(
                        title: "Height",
                        value: "${widget.user.profile?.height ?? ""}"),
                    TitleAndValueWidget(
                        title: "Ethnicity",
                        value: widget.user.profile?.ethnicity ?? ""),
                    TitleAndValueWidget(
                        title: "Religion",
                        value: widget.user.profile?.ethnicity ?? ""),
                    TitleAndValueWidget(
                        title: "Relationship status",
                        value: widget.user.profile?.relationshipStatus ?? ""),
                    TitleAndValueWidget(
                        title: "Relationship status",
                        value: widget.user.profile?.relationshipStatus ?? ""),
                    TitleAndValueWidget(
                        title: "Location",
                        value: widget.user.profile?.location ?? ""),
                    Container(
                      padding: const EdgeInsets.all(10),
                      height: 50,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Looking for',
                              style: TextStyle(
                                  color: context.theme.greyColor,
                                  fontWeight: FontWeight.w500)),
                          const Text('Anime, Football',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TitleAndValueWidget extends StatelessWidget {
  const TitleAndValueWidget(
      {super.key, required this.title, required this.value});
  final String title, value;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          AppText(
              text: title,
              color: context.theme.greyColor,
              fontWeight: FontWeight.w500),
          AppText(text: value, color: Colors.grey, fontWeight: FontWeight.w500)
        ]));
  }
}
