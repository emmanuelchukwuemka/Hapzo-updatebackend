import 'package:haptext_api/views/Bottom_Nav/exports.dart';
import 'package:haptext_api/exports.dart';

class Followers extends StatefulWidget {
  const Followers({Key? key}) : super(key: key);

  @override
  State<Followers> createState() => _FollowersState();
}

class _FollowersState extends State<Followers> {
  Future<void> getData() async {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
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
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search,
                  // color: context.theme.greyColor,
                ),
              ),
              const SizedBox(width: 10.0),
              const AppText(text: 'Search', color: Colors.white)
            ],
          )),
      // BODY CONTAINER
      true
          ? const Expanded(
              child: Center(
                  child: AppText(
                      text: 'Your followers will appear here.',
                      color: Colors.orange,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.bold,
                      fontSize: 28)),
            )
          : Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.only(bottom: 7.50, left: 5.0, right: 5.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 5.0,
                      mainAxisSpacing: 5.0,
                      childAspectRatio: 0.8),
                  itemCount: 0,
                  itemBuilder: (context, index) => friendCardWidget(context,
                      "_userData!.followers![index]", 'assets/images/me.jpg'),
                ),
              ),
            ),
    ]);
  }
}
