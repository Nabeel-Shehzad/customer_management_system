import 'package:customer_management_system/model/supplier.dart';
import 'package:customer_management_system/services/services.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../login/login.dart';
class ModifySupplier extends StatefulWidget {
  const ModifySupplier({Key? key}) : super(key: key);

  @override
  _ModifySupplierState createState() => _ModifySupplierState();
}

class _ModifySupplierState extends State<ModifySupplier> {
  final _key = GlobalKey<FormState>();
  var supplierLevnrController = TextEditingController();
  var supplierLevNameController = TextEditingController();
  var supplierLevAddressController = TextEditingController();
  var searchController = TextEditingController();
  List<Supplier> _suppliers = [];
  String _deleted = '';
  String _updated = '';
  _getData(String levnr){
    EasyLoading.show(status: 'Please wait!!!');
    Services.getSupplier(levnr).then((value) {
      setState(() {
        _suppliers = value;
      });
      if(_suppliers.length == 1){
        EasyLoading.dismiss();
        supplierLevnrController.text = _suppliers[0].levnr;
        supplierLevNameController.text = _suppliers[0].levname;
        supplierLevAddressController.text = _suppliers[0].levadres;
      }else {
        EasyLoading.showError("Can't find any supplier with this number");
      }
    });
  }
  _deleteSupplier(String id){
    EasyLoading.show(status: 'Please wait!!!');
    Services.deleteSupplier(id).then((value) {
      setState(() {
        _deleted = value;
      });
      if(_deleted == 'success'){
        EasyLoading.dismiss();
        EasyLoading.showSuccess('Supplier Deleted');
        clearFields();
      } else {
        EasyLoading.dismiss();
        EasyLoading.showError("$_deleted try again later.");
      }
    });
  }
  _updatedSupplier(String id,String levnr,String levname,String levadres){
    EasyLoading.show(status: 'Please wait!!!');
    Services.updateSupplier(id, levnr, levname, levadres).then((value) {
      setState(() {
        _updated = value;
      });
      if (_updated == 'success') {
        EasyLoading.dismiss();
        EasyLoading.showSuccess('Supplier updated');
        clearFields();
      } else {
        EasyLoading.dismiss();
        EasyLoading.showError("$_updated try again later.");
      }
    });
  }
  void clearFields() {
    supplierLevnrController.clear();
    supplierLevNameController.clear();
    supplierLevAddressController.clear();
    searchController.clear();
  }
  Widget getButton(){
    if(Login.access == '1') {
      return FilledButton(
        child: Text('Delete'),
        onPressed: () => {
          _deleteSupplier(_suppliers[0].id),
        },
      );
    }return Text('');
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Modify Supplier',
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
                          return 'Please enter a Supplier number';
                        } else {
                          return null;
                        }
                      },
                      placeholder: 'Please enter Supplier number...',
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
                                    title: Text('Supplier Number missing!!!'),
                                    content:
                                    Text('Provide a valid Supplier number'),
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
                    'Supplier Number: ',
                    style: TextStyle(fontSize: 18),
                  )),
              SizedBox(
                width: 20,
              ),
              Expanded(
                  child: TextFormBox(
                    controller: supplierLevnrController,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'please add Supplier Number';
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
                    'Supplier Name: ',
                    style: TextStyle(fontSize: 18),
                  )),
              SizedBox(
                width: 20,
              ),
              Expanded(
                  child: TextFormBox(
                    controller: supplierLevNameController,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Please enter Supplier Name';
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
                    'Supplier Address: ',
                    style: TextStyle(fontSize: 18),
                  )),
              SizedBox(
                width: 20,
              ),
              Expanded(
                  child: TextFormBox(
                    controller: supplierLevAddressController,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Please enter Supplier Address';
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
                  child:getButton()),
              SizedBox(
                width: 20,
              ),
              Expanded(
                  child: Button(
                    child: Text('Edit'),
                    onPressed: () => {
                      _updatedSupplier(_suppliers[0].id, supplierLevnrController.text,
                          supplierLevNameController.text, supplierLevAddressController.text),
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
