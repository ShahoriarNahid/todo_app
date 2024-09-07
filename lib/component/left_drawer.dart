import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/helpers/k_text.dart';
import '../base/base.dart';
import '../helpers/global_helper.dart';
import '../helpers/route.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  // final menuC = Get.put(MenuController1());
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    color: Colors.indigo,
                    width: Get.width,
                    height: 250,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 16,
                        ),
                        Container(
                            height: 100,
                            width: 100,
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(0, 0),
                                    blurRadius: 8.0,
                                  ),
                                ]),
                            child: CircleAvatar(
                              radius: 45,
                              child: Icon(Icons.person),
                            )),
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 13.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  KText(
                                    text: 'Mr. Exe',
                                    bold: true,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    //ExpansionPanelList.radio is for expanded only one element at a time
                    physics: BouncingScrollPhysics(),
                    child: ExpansionPanelList.radio(
                      dividerColor: Color(0xFFB6B8C5),
                      expandedHeaderPadding: EdgeInsets.zero,
                      elevation: 0.0,
                      expansionCallback: (index, isExpanded) {
                        //  print(isExpanded);
                      },
                      children: Base.menuController
                          .getLeftDrawer()
                          .map(
                            (item) => ExpansionPanelRadio(
                              value: item.title!,
                              canTapOnHeader: true,
                              headerBuilder: (context, isExpanded) {
                                return ListTile(
                                  visualDensity: VisualDensity(vertical: -4),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10.0,
                                    vertical: 0.0,
                                  ),
                                  horizontalTitleGap: 10.0,
                                  minVerticalPadding: 0.0,
                                  leading: Icon(Icons.ac_unit,
                                      color: Color(0xFF2A3050)),
                                  title: Text(
                                    item.title!,
                                    style: TextStyle(
                                        fontFamily: 'Manrope',
                                        fontSize: 14.0,
                                        color: Color(0xFF2A3050),
                                        fontWeight: FontWeight.w600),
                                  ),
                                );
                              },
                              body: Column(
                                children: item.children!
                                    .map(
                                      (tile) => Container(
                                        color: Colors.green,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Color(0xFFE7F4F9),
                                            border: Border(
                                              bottom: BorderSide(
                                                  color: Color(0xFFA3CCDC)),
                                            ),
                                          ),
                                          child: ListTile(
                                            tileColor: Color(0xFFC5DCE4),
                                            visualDensity:
                                                VisualDensity(vertical: -4),
                                            minLeadingWidth: 3.0,
                                            leading: Padding(
                                              padding:
                                                  EdgeInsets.only(left: 7.0),
                                              child: Icon(Icons.ac_unit,
                                                  color: Color(0xFF2A3050)),
                                            ),
                                            title: Padding(
                                              padding: EdgeInsets.zero,
                                              child: Text(
                                                tile.title!,
                                                style: TextStyle(
                                                    fontFamily: 'Manrope',
                                                    fontSize: 14.0,
                                                    color: Color(0xFF2A3050),
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                            onTap: () async {
                                              Base.menuController
                                                  .pushMenuLeft(tile.title!);
                                            },
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  Container(
                      color: Color(0xFFB6B8C5),
                      width: double.infinity,
                      height: 1.0),
                  Container(
                    color: Colors.white,
                    child: ListTile(
                      onTap: () {
                        Global.confirmDialog(onConfirmed: () {
                          Base.loginController.logout();
                          back();
                        });
                      },

                      contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                      horizontalTitleGap: 10.0,
                      minVerticalPadding: 0.0,
                      //minLeadingWidth: 10.0,
                      leading:
                          Icon(Icons.logout_outlined, color: Color(0xFF2A3050)),
                      title: Text(
                        'Logout',
                        style: TextStyle(
                            fontFamily: 'Manrope',
                            fontSize: 14.0,
                            color: Color(0xFF2A3050),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Container(
                      color: Color(0xFFB6B8C5),
                      width: double.infinity,
                      height: 1.0),
                ],
              ),
            ),
          ),
          SizedBox(height: 5),
          Expanded(
            flex: 0,
            child: Align(
              alignment: Alignment.center,
              child: KText(
                text: 'Version 1.0.0',
                bold: true,
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
