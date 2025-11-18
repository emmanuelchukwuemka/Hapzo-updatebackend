import 'package:haptext_api/exports.dart';
import 'package:haptext_api/models/searched_user_model.dart';
import 'package:haptext_api/views/Bottom_Nav/exports.dart';
import 'package:haptext_api/common/theme/custom_theme_extension.dart';
import 'package:haptext_api/views/Bottom_Nav/People/see_all.dart';

class PictureContainer extends StatefulWidget {
  const PictureContainer({super.key, required this.user});
  final SearchedUserModel user;

  @override
  State<PictureContainer> createState() => _PictureContainerState();
}

class _PictureContainerState extends State<PictureContainer> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AppshadowContainer(
      onTap: () {},
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(
          horizontal: size.width * .01, vertical: size.width * .015),
      height: size.width * 1.15,
      width: size.width,
      child: Column(
        children: [
          // SizedBox(height: 20),
          Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ImageView()));
                },
                child: Container(
                  height: size.width * .67,
                  width: size.width * .65,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: const DecorationImage(
                          image: AssetImage('assets/images/asta.jpg'),
                          fit: BoxFit.cover)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      color: Colors.orange.withValues(alpha: .35),
                    ),
                  ),
                ),
              ),
              SizedBox(width: size.width * .01),
              Column(
                children: [
                  Container(
                    height: size.width * .33,
                    width: size.width * .32,
                    decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.circular(15),
                        image: const DecorationImage(
                            image: AssetImage('assets/images/me.jpg'),
                            fit: BoxFit.cover)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        color: Colors.red.withValues(alpha: .4),
                      ),
                    ),
                  ),
                  SizedBox(height: size.width * .01),
                  Container(
                    height: size.width * .33,
                    width: size.width * .32,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: const DecorationImage(
                            image: AssetImage('assets/images/vegeta.jpg'),
                            fit: BoxFit.cover)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        color: Colors.green.withValues(alpha: .35),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: size.width * .01),
          Row(
            children: [
              Container(
                height: size.width * .33,
                width: size.width * .32,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: const DecorationImage(
                        image: AssetImage('assets/images/sasuke.jpg'),
                        fit: BoxFit.cover)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    color: Colors.pink.withValues(alpha: .5),
                  ),
                ),
              ),
              SizedBox(width: size.width * .01),
              Container(
                height: size.width * .33,
                width: size.width * .32,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: const DecorationImage(
                        image: AssetImage('assets/images/yuno.jpg'),
                        fit: BoxFit.cover)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    color: Colors.purple.withValues(alpha: .4),
                  ),
                ),
              ),
              SizedBox(width: size.width * .01),
              Container(
                  height: size.width * .33,
                  width: size.width * .32,
                  decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(15)))
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const SeeAll()));
                },
                child: Padding(
                    padding: const EdgeInsets.only(top: 10.0, right: 10.0),
                    child: AppText(
                        text: 'See all posts',
                        color: context.theme.primaryColor))),
          )
        ],
      ),
    );
  }
}
