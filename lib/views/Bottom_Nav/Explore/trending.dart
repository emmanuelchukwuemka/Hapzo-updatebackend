import 'package:haptext_api/exports.dart';
import 'package:haptext_api/views/Bottom_Nav/exports.dart';
import 'package:haptext_api/common/theme/custom_theme_extension.dart';

class Trending extends StatefulWidget {
  const Trending({Key? key}) : super(key: key);

  @override
  State<Trending> createState() => _TrendingState();
}

class _TrendingState extends State<Trending> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.bgColor,
      appBar: AppBar(
          backgroundColor: context.theme.appBarColor,
          automaticallyImplyLeading: false,
          iconTheme: IconThemeData(color: context.theme.primaryColor),
          title: AppText(
              text: '  Trending',
              color: context.theme.primaryColor,
              fontWeight: FontWeight.bold)),
      body: GridView.builder(
          padding: const EdgeInsets.all(5),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: 2.5,
              mainAxisSpacing: 2.5),
          itemCount: 6,
          itemBuilder: (context, index) =>
              PostCard(relation: "follow", index: index)),
    );
  }
}
