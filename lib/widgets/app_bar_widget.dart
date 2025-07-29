import 'package:haptext_api/exports.dart';
import 'package:haptext_api/views/screen/authentication/forget_password.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget(
      {super.key,
      required this.title,
      this.centerTitle = true,
      this.hasLeading = true,
      this.close = false,
      this.ontap,
      this.actions,
      this.titleColor});
  final String title;
  final bool hasLeading, close, centerTitle;
  final Function()? ontap;
  final List<Widget>? actions;
  final Color? titleColor;
  @override
  Widget build(BuildContext context) {
    return AppBar(
        forceMaterialTransparency: true,
        toolbarHeight: MediaQuery.sizeOf(context).width * 0.12,
        leading: hasLeading ? const AppBackButton() : const SizedBox.shrink(),
        leadingWidth: MediaQuery.sizeOf(context).width * 0.12,
        centerTitle: centerTitle,
        title: AppText(
            text: title,
            color: titleColor ?? Colors.orange,
            fontWeight: FontWeight.w700,
            fontSize: 16),
        actions: actions);
  }

  @override
  Size get preferredSize => Size(double.infinity, 20.h);
}
