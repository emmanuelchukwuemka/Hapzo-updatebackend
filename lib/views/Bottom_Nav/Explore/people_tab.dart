import 'package:haptext_api/bloc/people/cubit/people_cubit.dart';
import 'package:haptext_api/exports.dart';
import 'package:haptext_api/utils/extensions.dart';

class PeopleTab extends StatefulWidget {
  const PeopleTab({super.key});

  @override
  State<PeopleTab> createState() => _PeopleTabState();
}

class _PeopleTabState extends State<PeopleTab> {
  @override
  Widget build(BuildContext context) {
    final watchPeople = context.watch<PeopleCubit>();
    final searchedPeople = watchPeople.searchedUsers;
    final size = MediaQuery.sizeOf(context);
    return BlocListener<PeopleCubit, PeopleState>(
      listener: (context, state) {
        if (state is PeopleSearched) {
          context.push(RouteName.friendsProfilePage.path, extra: state.user);
        }
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: searchedPeople.length,
        itemBuilder: (context, index) {
          return AppshadowContainer(
            onTap: () {
              if (searchedPeople[index].profile?.firstName == null) {
                context.read<PeopleCubit>().fetchUserProfileById(
                    userId: searchedPeople[index].id ?? "0");
              } else {
                context.push(RouteName.friendsProfilePage.path,
                    extra: searchedPeople[index]);
              }
            },
            padding: EdgeInsets.all(size.width * 0.04),
            margin: EdgeInsets.only(bottom: size.width * 0.04),
            color: Theme.of(context).primaryColorDark,
            child: Row(children: [
              AppNetwokImage(
                  height: size.width * 0.1,
                  width: size.width * 0.1,
                  radius: size.width * 0.8,
                  fit: BoxFit.cover,
                  imageUrl: searchedPeople[index].profilePicture ?? ""),
              const SizedBox(width: 6),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                AppText(
                    text:
                        searchedPeople[index].username?.capitalizeFirstChar() ??
                            '',
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
                const SizedBox(height: 5),
                Row(children: [
                  const Icon(Icons.people, size: 16, color: Colors.grey),
                  const SizedBox(width: 2),
                  AppText(
                      text:
                          "${searchedPeople[index].followerCount} Followers • ${searchedPeople[index].followingCount} Following",
                      color: Colors.white,
                      fontSize: 10),
                ])
              ]),
              const Spacer(),
              Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                const Row(children: [
                  Icon(Icons.favorite, size: 16, color: Colors.red),
                  SizedBox(width: 2),
                  AppText(text: "3.2k", color: Colors.white, fontSize: 12),
                ]),
                const SizedBox(height: 5),
                Row(children: [
                  const Icon(Icons.alternate_email,
                      size: 16, color: Colors.blue),
                  const SizedBox(width: 1),
                  AppText(
                      text:
                          "${searchedPeople[index].mentionCount ?? 0} Mentions",
                      color: Colors.white,
                      fontSize: 12),
                ])
              ])
            ]),
          );
        },
      ),
    );
  }
}
