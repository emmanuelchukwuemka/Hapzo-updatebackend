import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:haptext_api/bloc/home/cubit/home_cubit.dart';
import 'package:haptext_api/exports.dart';
import 'package:haptext_api/widgets/app_bar_widget.dart';

class ConfirmImageUpload extends StatefulWidget {
  final PlatformFile pickedFile;

  const ConfirmImageUpload({Key? key, required this.pickedFile})
      : super(key: key);

  @override
  State<ConfirmImageUpload> createState() => _ConfirmImageUploadState();
}

class _ConfirmImageUploadState extends State<ConfirmImageUpload> {
  final captionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final watchHome = context.watch<HomeCubit>();
    final size = MediaQuery.sizeOf(context);
    return BlocListener<HomeCubit, HomeState>(
      listener: (context, state) async {
        if (state is HomePostCreated) {
          ToastMessage.showSuccessToast(message: "Photo post created");
          await Future.delayed(const Duration(seconds: 2));
          context.go(RouteName.bottomNav.path);
        }
      },
      child: AbsorbPointer(
        absorbing: watchHome.state is HomeLoading,
        child: Scaffold(
          appBar: const AppBarWidget(title: "Create Photo Post"),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  30.verticalSpace,
                  InputField(
                      title: "Vide caption (optional)",
                      controller: captionController),
                  30.verticalSpace,
                  Center(
                      child: Image.file(File(widget.pickedFile.path!),
                          width: double.infinity,
                          height: size.height * 0.63,
                          fit: BoxFit.cover)),
                  30.verticalSpace,
                  Appbutton(
                    isLoading: watchHome.state is HomeLoading,
                    label: "Confirm",
                    onTap: () {
                      context.read<HomeCubit>().createImagePost(
                          image: File(widget.pickedFile.path!),
                          caption: captionController.text);
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
