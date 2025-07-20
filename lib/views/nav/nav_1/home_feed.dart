import 'package:haptext_api/bloc/home/cubit/home_cubit.dart';
import 'package:haptext_api/common/utils.dart';
import 'package:haptext_api/exports.dart';
import 'package:haptext_api/common/theme/custom_theme_extension.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final post = context.watch<HomeCubit>().posts.result;
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: AppBar(
            automaticallyImplyLeading: false,
            title: const AppText(
                text: '  HapzText',
                color: Colors.white,
                fontWeight: FontWeight.bold),
            // backgroundColor: context.theme.appBarColor,
            elevation: 0,
            actions: [
              IconButton(
                  onPressed: () {
                    //  context.read<HomeCubit>()
                    context.push(RouteName.bottomNav.path);
                  },
                  icon: const Icon(Icons.chat),
                  iconSize: 22,
                  color: context.theme.primaryColor),
              const SizedBox(width: 3),
              IconButton(
                  onPressed: () {
                    context.read<HomeCubit>().fetchPosts();
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (_) => const Notifications(),
                    //   ),
                    // );
                  },
                  icon: const Icon(Icons.notifications),
                  iconSize: 22),
              const SizedBox(width: 5),
            ],
            flexibleSpace: ClipPath(
              // clipper: MyCustomClipperForAppBar(),
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFFFC203),
                      Color(0xFFFD8502),
                    ],
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                    tileMode: TileMode.clamp,
                  ),
                ),
              ),
            ),
          ),
        ),
        body: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
          itemCount: post?.length ?? 0,
          itemBuilder: (context, index) {
            return AppshadowContainer(
              margin: EdgeInsets.symmetric(vertical: size.width * 0.02),
              padding: EdgeInsets.all(size.width * 0.04),
              color: context.theme.appBarColor,
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                      text: post?[index].senderId ?? '',
                      fontWeight: FontWeight.w600,
                      color: Colors.deepOrangeAccent),
                  AppText(
                      text: UsefulMethods.formatDate(post?[index].createdAt ??
                          '2025-07-13T18:56:55.550942Z'),
                      color: Colors.deepOrangeAccent),
                  20.verticalSpace,
                  AppshadowContainer(
                      height: size.height * 0.55,
                      padding: EdgeInsets.all(size.width * 0.04),
                      border: true,
                      color: Colors.transparent,
                      borderColor: Colors.white.withAlpha(50),
                      child: AppText(
                          text: post?[index].textContent ?? '',
                          color: Colors.white,
                          maxLines: 150)),
                  20.verticalSpace,
                  Row(children: [
                    AppNetwokImage(
                        height: size.width * 0.1,
                        fit: BoxFit.fill,
                        radius: size.width * 0.9,
                        width: size.width * 0.1,
                        imageUrl: ""),
                    5.horizontalSpace,
                    Appbutton(
                        label: "Your Friend",
                        width: size.width * 0.23,
                        labelSize: 12,
                        height: size.width * 0.09,
                        buttonColor: Colors.green)
                  ]),
                  10.verticalSpace,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: size.width * 0.67,
                          child: AppText(
                              text: post?[index].textContent ?? "",
                              color: Colors.white)),
                      const Spacer(),
                      Column(
                        children: [
                          Row(children: [
                            Icon(Icons.favorite,
                                color: Colors.deepOrangeAccent, size: 25.sp),
                            10.horizontalSpace,
                            Icon(Icons.mode_comment_sharp,
                                color: Colors.deepOrangeAccent, size: 25.sp)
                          ]),
                          10.verticalSpace,
                          Row(children: [
                            Icon(Icons.reply,
                                color: Colors.deepOrangeAccent, size: 25.sp),
                            10.horizontalSpace,
                            Icon(Icons.download,
                                color: Colors.deepOrangeAccent, size: 25.sp)
                          ]),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ); // Replace Container with your actual widget
          },
        ));
  }
}
