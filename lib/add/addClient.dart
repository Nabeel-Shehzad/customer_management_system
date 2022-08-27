import 'dart:async';

import 'package:customer_management_system/services/services.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class AddClient extends StatefulWidget {
  const AddClient({Key? key}) : super(key: key);

  @override
  _AddClientState createState() => _AddClientState();
}

class _AddClientState extends State<AddClient> {
  var clientNumberController = TextEditingController();
  var clientNameController = TextEditingController();
  var clientAddressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    EasyLoading.addStatusCallback((status) {
      if (status == EasyLoadingStatus.dismiss) {
        _timer?.cancel();
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Add Client',
                style: TextStyle(fontSize: 60),
              )
            ],
          ),
          SizedBox(
            height: 40,
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
          SizedBox(
            height: 30,
          ),
          Button(
            child: SizedBox(width: 200, child: Text('Add Client')),
            onPressed: () => {
              EasyLoading.show(status: 'Please wait!!'),
              if (_formKey.currentState!.validate())
                {
                  Services.addClient(
                          clientNumberController.text,
                          clientNameController.text,
                          clientAddressController.text)
                      .then((value) => {
                            if ('success' == value)
                              {
                                EasyLoading.showSuccess('Client Added'),
                                clientNumberController.clear(),
                                clientNameController.clear(),
                                clientAddressController.clear(),
                                EasyLoading.dismiss()
                              }else{
                              EasyLoading.showError(value),
                            }
                          })
                }else{
                EasyLoading.showError('Please add valid data'),
              }
            },
            style: ButtonStyle(
              padding: ButtonState.all(EdgeInsets.all(10.0)),
              backgroundColor: ButtonState.all(Colors.orange),
            ),
          )
        ],
      ),
    );
  }
}
