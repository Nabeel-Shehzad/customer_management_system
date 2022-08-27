import 'package:customer_management_system/model/client.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../services/services.dart';

class ViewClients extends StatefulWidget {
  const ViewClients({Key? key}) : super(key: key);

  @override
  _ViewClientsState createState() => _ViewClientsState();
}

class _ViewClientsState extends State<ViewClients> {
  List<Client> _clients = [];

  @override
  void initState() {
    super.initState();
    _getClient();
  }

  _getClient() {
    EasyLoading.show(status: 'Loading Clients...');
    Services.getClients().then((clients) {
      setState(() {
        _clients = clients;
      });
      EasyLoading.showSuccess('');
      EasyLoading.dismiss();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: Text(
        'Clients',
        style: TextStyle(fontSize: 60),
      ),
      content: SizedBox.expand(
        child: Scrollbar(
          child: ListView.builder(
              padding: EdgeInsets.only(right: 16.0),
              itemCount: _clients.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Text(_clients[index].cLnr),
                  title: Text(_clients[index].cLname),
                  subtitle: Row(
                    children: [
                      Expanded(child: Text(_clients[index].clAdres))
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
