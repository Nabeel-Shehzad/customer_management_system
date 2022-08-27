import 'package:customer_management_system/model/client.dart';
import 'package:customer_management_system/services/services.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../login/login.dart';

class ModifyClient extends StatefulWidget {
  const ModifyClient({Key? key}) : super(key: key);

  @override
  _ModifyClientState createState() => _ModifyClientState();
}

class _ModifyClientState extends State<ModifyClient> {
  final _key = GlobalKey<FormState>();
  var clientNumberController = TextEditingController();
  var clientNameController = TextEditingController();
  var clientAddressController = TextEditingController();
  var searchController = TextEditingController();
  List<Client> _clients = [];
  String _deleted = '';
  String _updated = '';

  _getData(String number) {
    EasyLoading.show(status: 'Please wait!!!');
    Services.getClient(number).then((value) {
      setState(() {
        _clients = value;
      });
      if (_clients.length == 1) {
        EasyLoading.dismiss();
        clientNumberController.text = _clients[0].cLnr;
        clientNameController.text = _clients[0].cLname;
        clientAddressController.text = _clients[0].clAdres;
      } else {
        EasyLoading.showError("Can't find any client with this number");
      }
    });
  }

  _deleteClient(String id) {
    EasyLoading.show(status: "Please wait!!!");
    Services.deleteClient(id).then((value) {
      setState(() {
        _deleted = value;
      });
      if (_deleted == 'success') {
        EasyLoading.dismiss();
        EasyLoading.showSuccess('Client Deleted');
        clearFields();
      } else {
        EasyLoading.dismiss();
        EasyLoading.showError("$_deleted try again later.");
      }
    });
  }

  void clearFields() {
    clientAddressController.clear();
    clientNameController.clear();
    clientNumberController.clear();
    searchController.clear();
  }

  _updateClient(String id, String number, String name, String address) {
    EasyLoading.show(status: 'Please wait!!!');
    Services.updateClient(id, number, name, address).then((value) {
      setState(() {
        _updated = value;
      });
      if (_updated == 'success') {
        EasyLoading.dismiss();
        EasyLoading.showSuccess('Client updated');
        clearFields();
      } else {
        EasyLoading.dismiss();
        EasyLoading.showError("$_updated try again later.");
      }
    });
  }
  Widget getButton(){
    if(Login.access == '1') {
      return FilledButton(
        child: Text('Delete'),
        onPressed: () => {
          _deleteClient(_clients[0].id),
        },
      );
    }return Text('');
  }

  @override
  Widget build(BuildContext context) {return Form(
    key: _key,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Modify Client',
          style: TextStyle(fontSize: 60),
        ),
        SizedBox(
          height: 30,
        ),
        Row(
          children: [
            SizedBox(width: 20),
            Flexible(
                flex: 1,
                fit: FlexFit.loose,
                child: SizedBox(
                  child: TextFormBox(
                    controller: searchController,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Please enter a client number';
                      } else {
                        return null;
                      }
                    },
                    placeholder: 'Please enter client number...',
                  ),
                )),
            SizedBox(
              width: 20,
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.loose,
              child: SizedBox(
                width: 300,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                  child: FilledButton(
                    child: Text(
                      'Search',
                      style: TextStyle(fontSize: 16),
                    ),
                    onPressed: () => {
                      if (searchController.text.isEmpty)
                        {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return ContentDialog(
                                  title: Text('Client Number missing!!!'),
                                  content:
                                  Text('Provide a valid client number'),
                                  actions: [
                                    Button(
                                        child: Text('Ok'),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        })
                                  ],
                                );
                              }),
                        }
                      else
                        {
                          _getData(searchController.text),
                        }
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(
              height: 20,
              width: 20,
            ),
            Expanded(
                child: Text(
                  'Client Number: ',
                  style: TextStyle(fontSize: 18),
                )),
            SizedBox(
              width: 20,
            ),
            Expanded(
                child: TextFormBox(
                  controller: clientNumberController,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'please add client Number';
                    }
                    return null;
                  },
                  placeholder: 'Number',
                )),
            SizedBox(
              width: 20,
            )
          ],
        ),
        Row(
          children: [
            SizedBox(
              width: 20,
            ),
            Expanded(
                child: Text(
                  'Client Name: ',
                  style: TextStyle(fontSize: 18),
                )),
            SizedBox(
              width: 20,
            ),
            Expanded(
                child: TextFormBox(
                  controller: clientNameController,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Please enter Client Name';
                    }
                    return null;
                  },
                  placeholder: 'Name',
                )),
            SizedBox(
              width: 20,
            )
          ],
        ),
        Row(
          children: [
            SizedBox(
              width: 20,
            ),
            Expanded(
                child: Text(
                  'Client Address: ',
                  style: TextStyle(fontSize: 18),
                )),
            SizedBox(
              width: 20,
            ),
            Expanded(
                child: TextFormBox(
                  controller: clientAddressController,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Please enter Client Address';
                    }
                    return null;
                  },
                  placeholder: 'Address',
                )),
            SizedBox(
              width: 20,
            )
          ],
        ),
        Row(
          children: [
            SizedBox(
              width: 20,
            ),
            Expanded(
                child: getButton()),
            SizedBox(
              width: 20,
            ),
            Expanded(
                child: Button(
                  child: Text('Edit'),
                  onPressed: () => {
                    _updateClient(_clients[0].id, clientNumberController.text,
                        clientNameController.text, clientAddressController.text),
                  },
                )),
            SizedBox(
              width: 20,
            ),
          ],
        ),
      ],
    ),
  );

  }
}
