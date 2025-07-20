import 'package:haptext_api/exports.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
// import 'package:haptext_api/exports.dart';

class Appbutton extends StatelessWidget {
  const Appbutton(
      {super.key,
      this.buttonColor,
      this.child,
      this.label,
      this.onTap,
      this.width,
      this.height,
      this.labelColor,
      this.isLoading = false,
      this.gradient = false,
      this.borderColor,
      this.border,
      this.labelSize,
      this.labelWeight});

  final Color? buttonColor, borderColor, labelColor;
  final Widget? child;
  final String? label;
  final Function()? onTap;
  final double? width, height, labelSize;
  final bool isLoading, gradient;
  final bool? border;
  final FontWeight? labelWeight;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return AppshadowContainer(
        onTap: onTap,
        shadowcolour: Colors.transparent,
        width: width ?? size.width,
        border: border ?? false,
        borderColor: borderColor ?? Colors.transparent,
        height: height ?? size.height * 0.065,
        radius: size.width * 0.02,
        color: buttonColor ?? Colors.orange,
        child: isLoading
            ? LoadingAnimationWidget.beat(color: Colors.white, size: 30.sp)
            : child ??
                AppText(
                    text: label ?? '',
                    color: labelColor ?? Colors.white,
                    fontSize: labelSize ?? 16,
                    fontWeight: labelWeight ?? FontWeight.bold));
  }
}
