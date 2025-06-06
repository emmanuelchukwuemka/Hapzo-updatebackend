 
import 'package:haptext_api/views/nav/exports.dart';
import 'package:haptext_api/exports.dart';

class Foller extends StatefulWidget {
  const Foller({Key? key}) : super(key: key);

  @override
  State<Foller> createState() => _FollerState();
}

class _FollerState extends State<Foller> {
  UserModel? _userData;
  UserModel? newData;

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
              const Text(
                'Search',
                style: TextStyle(
                    // color: context.theme.greyColor,
                    ),
              )
            ],
          )),
      // BODY CONTAINER
      _userData!.followers!.isEmpty
          ? const Expanded(
              child: Center(
                child: Text(
                  'Your followers will appear here.',
                  style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                      fontSize: 28),
                ),
              ),
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
                  itemCount: _userData!.followers!.length,
                  itemBuilder: (context, index) => FriendCardWidget(context,
                      _userData!.followers![index], 'assets/images/me.jpg'),
                ),
              ),
            ),
    ]);
  }
}
