import 'package:cashfuse/controllers/themeController.dart';
import 'package:cashfuse/views/bottomNavigationBarScreen.dart';
import 'package:cashfuse/widget/customSnackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class ColorPickerPage extends StatefulWidget {
  const ColorPickerPage({Key key, this.themeMode}) : super(key: key);
  final ValueChanged<ThemeMode> themeMode;

  @override
  _ColorPickerPageState createState() => _ColorPickerPageState();
}

class _ColorPickerPageState extends State<ColorPickerPage> with SingleTickerProviderStateMixin {
  TabController tabController;

  List<Color> fullMaterialColors = [
    Colors.black,
    Colors.blue[800],
    Colors.red,
    Colors.redAccent,
    Colors.pink,
    Colors.pinkAccent,
    Colors.purple,
    Colors.purpleAccent,
    Colors.deepPurple,
    Colors.deepPurpleAccent,
    Colors.indigo,
    Colors.indigoAccent,
    Colors.blue,
    Colors.blueAccent,
    Colors.lightBlue,
    Colors.lightBlueAccent,
    Colors.cyan,
    Colors.cyanAccent,
    Colors.teal,
    Colors.tealAccent,
    Colors.green,
    Colors.greenAccent,
    Colors.lightGreen,
    Colors.lightGreenAccent,
    Colors.lime,
    Colors.limeAccent,
    Colors.yellow,
    Colors.yellowAccent,
    Colors.amber,
    Colors.amberAccent,
    Colors.orange,
    Colors.orangeAccent,
    Colors.deepOrange,
    Colors.deepOrangeAccent,
    Colors.brown,
    Colors.grey,
    Colors.blueGrey
  ];

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (() async {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BottomNavigationBarScreen(
              pageIndex: 4,
            ),
          ),
        );
        return;
      }),
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            title: Text(
              AppLocalizations.of(context).theme,
            ),
            leading: InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => BottomNavigationBarScreen(
                      pageIndex: 4,
                    ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Icon(
                  Icons.arrow_back_ios,
                ),
              ),
            ),
          ),
          body: Scrollbar(
            child: GetBuilder<ThemeController>(builder: (themeController) {
              return Container(
                color: Colors.white,
                child: Column(
                  children: [
                    TabBar(
                      controller: tabController,
                      labelColor: Colors.white,
                      unselectedLabelColor: tabController.index != 0 ? themeController.pickColor : themeController.pickSecondaryColor,
                      indicator: BoxDecoration(
                        color: tabController.index == 0 ? themeController.pickColor : themeController.pickSecondaryColor,
                      ),
                      tabs: [
                        Tab(
                          text: AppLocalizations.of(context).primary_color,
                        ),
                        Tab(
                          text: AppLocalizations.of(context).secondary_color,
                        ),
                      ],
                      onTap: (value) {
                        tabController.index = value;
                        setState(() {});
                      },
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: tabController,
                        children: [
                          GridView.builder(
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 5,
                                crossAxisSpacing: 15.0,
                                mainAxisSpacing: 15.0,
                              ),
                              itemCount: fullMaterialColors.length,
                              shrinkWrap: true,
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    if (fullMaterialColors[index].value == themeController.pickSecondaryColor.value) {
                                      showCustomSnackBar('Primary Color & Secondary Should be Different');
                                    } else {
                                      themeController.setPickColor(fullMaterialColors[index]);
                                    }
                                  },
                                  child: Stack(
                                    fit: StackFit.expand,
                                    alignment: Alignment.center,
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: fullMaterialColors[index],
                                      ),
                                      fullMaterialColors[index].value == themeController.pickColor.value
                                          ? Icon(
                                              Icons.check,
                                              color: Colors.white,
                                            )
                                          : SizedBox()
                                    ],
                                  ),
                                );
                              }),
                          GridView.builder(
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 5,
                                crossAxisSpacing: 15.0,
                                mainAxisSpacing: 15.0,
                              ),
                              itemCount: fullMaterialColors.length,
                              shrinkWrap: true,
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    if (fullMaterialColors[index].value == themeController.pickColor.value) {
                                      showCustomSnackBar('Primary Color & Secondary Should be Different');
                                    } else {
                                      themeController.setSecondaryPickColor(fullMaterialColors[index]);
                                    }
                                  },
                                  child: Stack(
                                    fit: StackFit.expand,
                                    alignment: Alignment.center,
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: fullMaterialColors[index],
                                      ),
                                      fullMaterialColors[index].value == themeController.pickSecondaryColor.value
                                          ? Icon(
                                              Icons.check,
                                              color: Colors.white,
                                            )
                                          : SizedBox()
                                    ],
                                  ),
                                );
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          )),
    );
  }
}
