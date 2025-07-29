import 'package:cached_network_image/cached_network_image.dart';
import 'package:haptext_api/exports.dart';

class AppNetwokImage extends StatelessWidget {
  const AppNetwokImage(
      {super.key,
      required this.height,
      required this.width,
      this.fit,
      required this.imageUrl,
      this.radius});
  final double height, width;
  final BoxFit? fit;
  final String imageUrl;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return imageUrl == ''
        ? ClipRRect(
            borderRadius: BorderRadius.circular(radius ?? 0),
            child: Image.asset('assets/images/hapz_logo.png',
                width: width, height: height, fit: fit),
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(radius ?? 0),
            child: CachedNetworkImage(
                width: width,
                height: height,
                fit: fit,
                imageUrl: imageUrl,
                placeholder: (context, url) => Image.asset(
                    'assets/images/hapz_logo.png',
                    width: width,
                    height: height,
                    fit: BoxFit.cover),
                errorWidget: (context, url, error) => Image.asset(
                    'assets/images/hapz_logo.png',
                    width: width,
                    height: height,
                    fit: BoxFit.cover)),
          );
  }
}
