import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../services/services.dart';
class AddSupplier extends StatefulWidget {
  const AddSupplier({Key? key}) : super(key: key);

  @override
  _AddSupplierState createState() => _AddSupplierState();
}

class _AddSupplierState extends State<AddSupplier> {
  var supplierLevnrController = TextEditingController();
  var supplierLevNameController = TextEditingController();
  var supplierLevAddressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _adding = '';
  _addSupplier(String levnr,String levname,String levadres){
    EasyLoading.show(status: 'Please wait!!!');
    Services.addSupplier(levnr, levname, levadres).then((value) {
      setState(() {
        _adding = value;
      });
      if(_adding == "success"){
        EasyLoading.dismiss();
        EasyLoading.showSuccess('Supplier Added');
        _clearFields();
      }else{
        EasyLoading.dismiss();
        EasyLoading.showError(_adding);
      }
    });
  }

  _clearFields(){
    supplierLevAddressController.clear();
    supplierLevNameController.clear();
    supplierLevnrController.clear();
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
                'Add Supplier',
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
                    'Supplier Levnr: ',
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
                        return 'please add supplier Number';
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
                        return 'Please enter supplier Name';
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
                        return 'Please enter supplier Address';
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
            child: SizedBox(width: 200, child: Text('Add Supplier')),
            onPressed: () => {
              EasyLoading.show(status: 'Please wait!!'),
              if (_formKey.currentState!.validate())
                {
                  _addSupplier(supplierLevnrController.text,
                      supplierLevNameController.text,
                      supplierLevAddressController.text)
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
