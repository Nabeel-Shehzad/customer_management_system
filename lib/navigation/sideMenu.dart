import 'package:customer_management_system/add/addArticle.dart';
import 'package:customer_management_system/add/addClient.dart';
import 'package:customer_management_system/add/addSupplier.dart';
import 'package:customer_management_system/add/changeTheme.dart';
import 'package:customer_management_system/add/makeInvoice.dart';
import 'package:customer_management_system/modify/modifyArticle.dart';
import 'package:customer_management_system/modify/modifyClient.dart';
import 'package:customer_management_system/modify/modifySupplier.dart';
import 'package:customer_management_system/view/viewArticles.dart';
import 'package:customer_management_system/view/viewClients.dart';
import 'package:customer_management_system/view/viewSuppliers.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/cupertino.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  int index = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DesktopWindow.setMinWindowSize(Size(1000, 600));
  }

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      appBar: NavigationAppBar(
        title: Text('Client Management System',style: TextStyle(fontSize: 20),),
        automaticallyImplyLeading: true,
      ),
      content: NavigationBody(
        index: index,
        children: const [
          MakeInvoice(),
          AddClient(),
          AddSupplier(),
          AddArticle(),
          ModifyClient(),
          ModifySupplier(),
          ModifyArticle(),
          ViewClients(),
          ViewSuppliers(),
          ViewArticles(),
          ChangeTheme(),
        ],
      ),
      pane: NavigationPane(
          selected: index,
          displayMode: PaneDisplayMode.open,
          onChanged: (newIndex) {
            setState(() {
              index = newIndex;
            });
          },
          footerItems: [
            PaneItem(
              title: Text('Change Theme'),
              icon: Icon(FluentIcons.settings),
            )
          ],
          items: [
            PaneItem(icon: Icon(FluentSystemIcons.ic_fluent_collections_add_regular), title: Text("Make Invoice")),
            PaneItem(icon: Icon(FluentSystemIcons.ic_fluent_person_add_regular), title: Text("Add Client")),
            PaneItem(icon: Icon(FluentIcons.add_group), title: Text('Add Supplier')),
            PaneItem(icon: Icon(FluentIcons.add_notes), title: Text('Add Article')),
            PaneItem(icon: Icon(FluentIcons.edit), title: Text("Modify Clients")),
            PaneItem(icon: Icon(FluentIcons.account_activity), title: Text('Modify Supplier')),
            PaneItem(icon: Icon(FluentIcons.edit_create), title: Text('Modify Article')),
            PaneItem(icon: Icon(FluentIcons.list), title: Text("View Clients")),
            PaneItem(icon: Icon(FluentIcons.line_style), title: Text('View Supplier')),
            PaneItem(icon: Icon(FluentIcons.list_mirrored), title: Text('View Articles')),
          ]),
    );
  }
}
