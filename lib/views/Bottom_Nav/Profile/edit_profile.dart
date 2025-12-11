import 'dart:developer';
import 'dart:io';

import 'package:haptext_api/bloc/auth/cubit/auth_cubit.dart';
import 'package:haptext_api/bloc/profile/cubit/profile_cubit.dart';
import 'package:haptext_api/exports.dart';
import 'package:haptext_api/utils/extensions.dart';
import 'package:haptext_api/views/Bottom_Nav/exports.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final firstController = TextEditingController();
  final lastNameController = TextEditingController();
  final birthdayController = TextEditingController();
  final ocupationController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final ethnicityController = TextEditingController();
  final relationshipStatusController = TextEditingController();
  final locationController = TextEditingController();
  final biographyController = TextEditingController();
  File? profilePhoto;
  File? coverPhoto;
  final formkey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    firstController.text =
        context.read<AuthCubit>().useInfo.profile?.firstName ?? "";
    lastNameController.text =
        context.read<AuthCubit>().useInfo.profile?.lastName ?? "";
    biographyController.text =
        context.read<AuthCubit>().useInfo.profile?.bio ?? "";
    ocupationController.text =
        context.read<AuthCubit>().useInfo.profile?.occupation ?? "";
    heightController.text =
        "${context.read<AuthCubit>().useInfo.profile?.height ?? ""}";
    ethnicityController.text =
        context.read<AuthCubit>().useInfo.profile?.ethnicity ?? "";
    relationshipStatusController.text =
        context.read<AuthCubit>().useInfo.profile?.relationshipStatus ?? "";
    locationController.text =
        context.read<AuthCubit>().useInfo.profile?.location ?? "";
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final watchProfile = context.watch<ProfileCubit>();
    return Opacity(
      opacity: watchProfile.state is ProfileLoading ? 0.5 : 1.0,
      child: AbsorbPointer(
        absorbing: watchProfile.state is ProfileLoading,
        child: Scaffold(
            appBar: AppBar(
                forceMaterialTransparency: true,
                iconTheme: const IconThemeData(),
                title: const AppText(
                    text: 'Edit Profile', fontSize: 20, color: Colors.white),
                centerTitle: true,
                actions: const [],
                elevation: 0),
            body: Form(
                key: formkey,
                child: Column(children: [
                  const SizedBox(height: 10),
                  PicsChange(
                    onchangeProfile: (profile) {
                      log("message$profile");
                      setState(() {
                        profilePhoto = profile;
                      });
                    },
                    onchangeCoverPhoto: (profile) {
                      setState(() {
                        coverPhoto = profile;
                      });
                    },
                  ),
                  40.verticalSpace,
                  Expanded(
                      child: ListView(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.04),
                          children: [
                        InputField(
                            title: 'First Name',
                            hintText: 'Enter first name',
                            validator: (p) =>
                                p?.validateName(field: "First Name"),
                            controller: firstController),
                        20.verticalSpace,
                        InputField(
                            title: 'Lat Name',
                            validator: (p) =>
                                p?.validateName(field: "Last Name"),
                            hintText: 'Enter Last name',
                            controller: lastNameController),
                        20.verticalSpace,
                        InputField(
                            title: 'Biography',
                            hintText: 'Enter bio',
                            maxLines: 5,
                            validator: (p) =>
                                p?.validateAnyField(field: "Biography"),
                            controller: biographyController),
                        20.verticalSpace,
                        InputField(
                            title: 'Birthday',
                            validator: (p) => p?.validateDob(),
                            hintText: 'YYYY/MM/DD',
                            keyboardType: TextInputType.datetime,
                            controller: birthdayController),
                        20.verticalSpace,
                        InputField(
                            title: 'Occupation',
                            validator: (p) =>
                                p?.validateAnyField(field: "Occupation"),
                            hintText: 'occupation',
                            controller: ocupationController),
                        20.verticalSpace,
                        InputField(
                            title: 'Height',
                            hintText: '0.00',
                            keyboardType: TextInputType.number,
                            validator: (p) =>
                                p?.validateAnyField(field: "Height"),
                            controller: heightController),
                        20.verticalSpace,
                        InputField(
                            title: 'Weight',
                            keyboardType: TextInputType.number,
                            validator: (p) =>
                                p?.validateAnyField(field: "Weight"),
                            hintText: '0.00',
                            controller: weightController),
                        20.verticalSpace,
                        InputField(
                            title: 'Ethnicity',
                            isReadOnly: true,
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  backgroundColor: Colors.white,
                                  builder: (_) {
                                    return EthicityModalSheet(
                                        ethicity: (value) {
                                      setState(() {
                                        log("message$value");
                                        ethnicityController.text = value;
                                      });
                                    });
                                  });
                            },
                            validator: (p) =>
                                p?.validateAnyField(field: "Ethnicity"),
                            hintText: 'Christianity/Islamic',
                            controller: ethnicityController),
                        20.verticalSpace,
                        InputField(
                            title: 'Relationship status',
                            isReadOnly: true,
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  backgroundColor: Colors.white,
                                  builder: (_) {
                                    return RelationshipModalSheet(
                                        status: (String value) {
                                      log("message$value");
                                      relationshipStatusController.text = value;
                                    });
                                  });
                            },
                            validator: (p) => p?.validateAnyField(
                                field: "Relationship status"),
                            hintText: 'Single/Married/Divorced...',
                            controller: relationshipStatusController),
                        20.verticalSpace,
                        InputField(
                            title: 'Location',
                            validator: (p) =>
                                p?.validateAnyField(field: "Address"),
                            hintText: 'lagos , Nigeria',
                            controller: locationController),
                        60.verticalSpace,
                        Appbutton(
                            isLoading: watchProfile.state is ProfileLoading,
                            onTap: () {
                              if (formkey.currentState?.validate() ?? false) {
                                context.read<ProfileCubit>().createProfile(
                                    userId:
                                        context.read<AuthCubit>().useInfo.id ??
                                            '',
                                    birthDate: birthdayController.text,
                                    ethnicity: ethnicityController.text,
                                    relationshipStatus:
                                        relationshipStatusController.text,
                                    firstName: firstController.text,
                                    lastName: lastNameController.text,
                                    bio: biographyController.text,
                                    occupation: ocupationController.text,
                                    profilePicture:
                                        profilePhoto ?? File("path"),
                                    location: locationController.text,
                                    height: heightController.text,
                                    weight: weightController.text);
                              }
                            },
                            label: 'Save'),
                        60.verticalSpace
                      ]))
                ]))),
      ),
    );
  }
}

class EthicityModalSheet extends StatelessWidget {
  const EthicityModalSheet({super.key, required this.ethicity});
  final Function(String value) ethicity;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return SizedBox(
      width: size.width,
      child: Padding(
        padding: EdgeInsets.all(size.width * 0.04),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Center(
              child: AppText(
                  text: "Select Ethnicity",
                  fontSize: 20,
                  fontWeight: FontWeight.w500)),
          30.verticalSpace,
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                  items.length,
                  (index) => GestureDetector(
                        onTap: () {
                          ethicity(items[index]);
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: EdgeInsetsGeometry.only(
                              bottom: size.width * 0.04),
                          child: AppText(
                              text: items[index].capitalizeFirstChar(),
                              fontSize: 16),
                        ),
                      )))
        ]),
      ),
    );
  }

  static List<String> items = [
    "african",
    "asian",
    "caucasian",
    "hispanic",
    "middle eastern",
    "mixed",
    "native american",
    " pacific islander",
    "prefer not say",
    "other"
  ];
}

class RelationshipModalSheet extends StatelessWidget {
  const RelationshipModalSheet({super.key, required this.status});
  final Function(String value) status;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return SizedBox(
      width: size.width,
      child: Padding(
        padding: EdgeInsets.all(size.width * 0.04),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Center(
              child: AppText(
                  text: "Select RelationShip Status",
                  fontSize: 20,
                  fontWeight: FontWeight.w500)),
          30.verticalSpace,
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                  items.length,
                  (index) => GestureDetector(
                        onTap: () {
                          status(items[index]);
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: EdgeInsetsGeometry.only(
                              bottom: size.width * 0.04),
                          child: AppText(
                              text: items[index].capitalizeFirstChar(),
                              fontSize: 16),
                        ),
                      )))
        ]),
      ),
    );
  }

  static List<String> items = [
    "single",
    "in relationship",
    "engaged",
    "married",
    "divorced",
    "widowed",
    "complicated",
    "prefer not say"
  ];
}
