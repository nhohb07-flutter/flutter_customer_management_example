import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  Widget build(BuildContext context) {
    var headerChild = new DrawerHeader(child: new Text("Header"));
    var aboutChild = new AboutListTile(
        child: new Text("About"),
        applicationName: "Application Name",
        applicationVersion: "v1.0.0",
        applicationIcon: new Icon(Icons.adb),
        icon: new Icon(Icons.info));

    ListTile getNavItem(var icon, String s) {
      return new ListTile(
        leading: new Icon(icon),
        title: new Text(s),
        onTap: () {},
      );
    }

    var myNavChildren = [
      headerChild,
      getNavItem(Icons.settings, "Customer List"),
      getNavItem(Icons.home, "Home"),
      getNavItem(Icons.account_box, "Account"),
      aboutChild
    ];

    ListView listView = new ListView(children: myNavChildren);

    return new Drawer(
      child: listView,
    );
  }
}
