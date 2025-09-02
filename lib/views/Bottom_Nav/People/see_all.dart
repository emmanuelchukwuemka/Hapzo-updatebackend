import 'package:flutter/material.dart';
import 'package:haptext_api/common/theme/custom_theme_extension.dart';

class SeeAll extends StatefulWidget {
  const SeeAll({Key? key}) : super(key: key);

  @override
  State<SeeAll> createState() => _SeeAllState();
}

class _SeeAllState extends State<SeeAll> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: context.theme.bgColor,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: context.theme.primaryColor,
          ),
          title: Text('@Roman Fortune',
              style: TextStyle(
                  color: context.theme.titleTextColor,
                  fontWeight: FontWeight.bold)),
          backgroundColor: context.theme.appBarColor,
          elevation: 0,
          bottom: TabBar(
            indicatorColor: context.theme.primaryColor,
            indicatorWeight: 2.5,
            labelColor: context.theme.primaryColor,
            unselectedLabelColor: context.theme.greyColor,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400),
            tabs: const [
              Tab(
                icon: Icon(Icons.photo),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [Text('Photos'), Text('947')]),
              ),
              Tab(
                icon: Icon(Icons.video_library_sharp),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [Text('Videos'), Text('1.5k')]),
              ),
              Tab(
                icon: Icon(Icons.audiotrack),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [Text('Audios'), Text('29')]),
              ),
              Tab(
                icon: Icon(Icons.text_snippet),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [Text('Texts'), Text('115')]),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            buildContainer(size),
            buildContainer(size),
            GridView.builder(
              itemCount: 13,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 2.0,
                  mainAxisSpacing: 2.0),
              itemBuilder: (context, index) => SizedBox(
                height: size.width * .33,
                width: size.width * .32,
                child: Stack(
                  children: [
                    const Center(
                      child: Image(
                        image: AssetImage('assets/images/hapz_text.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      height: double.infinity,
                      width: double.infinity,
                      color: Colors.black38,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(25)),
                        child: const Center(
                            child: Icon(
                          Icons.music_note,
                          color: Colors.grey,
                        )),
                      ),
                    )
                  ],
                ),
              ),
            ),
            buildText(size),
          ],
        ),
      ),
    );
  }
}

Widget buildContainer(Size size) {
  return Padding(
    padding: const EdgeInsets.only(top: 3.5, left: 3.0, right: 3.0),
    child: GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, crossAxisSpacing: 2.0, mainAxisSpacing: 2.0),
      itemCount: 17,
      itemBuilder: (context, index) => SizedBox(
        height: size.width * .33,
        width: size.width * .32,
        child: const Image(
          image: AssetImage('assets/images/vegeta.jpg'),
          fit: BoxFit.contain,
        ),
      ),
    ),
  );
}

Widget buildText(Size size) {
  return ListView.builder(
      itemCount: 24,
      itemBuilder: (context, index) => Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
            height: size.height * .22,
            width: size.width,
            decoration: BoxDecoration(
              color: context.theme.bgColor,
              border: Border(
                // top: BorderSide(color: Colors.grey.shade400, width: 0.5),
                bottom: BorderSide(
                  color: context.theme.primaryColor!,
                  width: 0.5,
                ),
              ),
            ),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 5),
                  Expanded(
                    // width: size.width * .9,
                    // height: size.height * .15,
                    // color: Colors.black12,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7.5),
                      child: Column(
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Fortune',
                                  style: TextStyle(
                                    color: context.theme.textColor,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                const Text(
                                  '@paramount . 03 Feb',
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ]),
                          const SizedBox(height: 5),
                          const SizedBox(
                            child: Text(
                              'slhsla;ihdlfhw;oeihr ssfhnskjfsfskjfks skfjskfksfns   sfjbskjfhksherne  skjkfhs ksjfhksf ksjhskjrb fksjs slshfldsjo soalsfnd shdohdof soihfshfsj oshfsiuhsjkfnsd fsukhfkls;lfhs osuhfshf suhfkd fosuhfls oshfoushf shufoshfl siosjfslih sohlsjbvihcis subslnxbv xbv,xnvl sddsf',
                              style: TextStyle(color: Colors.grey),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width * .9,
                    height: 45.0,
                    // color: Colors.orange,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.favorite_border,
                              color: context.theme.greyColor,
                            ),
                            Text(
                              '26k',
                              style: TextStyle(
                                color: context.theme.greyColor,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.chat,
                              color: context.theme.greyColor,
                            ),
                            Text(
                              '5.2k',
                              style: TextStyle(
                                color: context.theme.greyColor,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.share,
                              color: context.theme.greyColor,
                            ),
                            Text(
                              '2k',
                              style: TextStyle(
                                color: context.theme.greyColor,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.download,
                              color: context.theme.greyColor,
                            ),
                            Text(
                              '1.2k',
                              style: TextStyle(
                                color: context.theme.greyColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ));
}
