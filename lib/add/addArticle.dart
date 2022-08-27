import 'package:customer_management_system/model/supplier.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../services/services.dart';

class AddArticle extends StatefulWidget {
  const AddArticle({Key? key}) : super(key: key);

  @override
  _AddArticleState createState() => _AddArticleState();
}

class _AddArticleState extends State<AddArticle> {
  var articleNumberController = TextEditingController();
  var articleNameController = TextEditingController();
  var articlePriceController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<Supplier> _suppliers = [];
  String? currentValue;
  String _adding = '';

  @override
  void initState() {
    super.initState();
    _getSuppliers();
  }

  _addArticle(String artnr,String artnaam,String levid,String artpr){
    EasyLoading.show(status: 'Please wait!!!');
    Services.addArticle(artnr, artnaam, levid, artpr).then((value) {
      setState(() {
        _adding = value;
      });
      if(_adding == "success"){
        EasyLoading.dismiss();
        EasyLoading.showSuccess('Article Added');
        _clearFields();
      }else{
        EasyLoading.dismiss();
        EasyLoading.showError(_adding);
      }
    });
  }
  _clearFields(){
    articlePriceController.clear();
    articleNameController.clear();
    articleNumberController.clear();
  }

  _getSuppliers() {
    EasyLoading.show(status: 'Please wait!!!');
    Services.getAllSuppliers().then((value) {
      setState(() {
        _suppliers = value;
      });
      EasyLoading.showSuccess('');
      EasyLoading.dismiss();
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
                'Add Article',
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
                'Article Number: ',
                style: TextStyle(fontSize: 18),
              )),
              SizedBox(
                width: 20,
              ),
              Expanded(
                  child: TextFormBox(
                controller: articleNumberController,
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'please add Article Number';
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
                'Article Description: ',
                style: TextStyle(fontSize: 18),
              )),
              SizedBox(
                width: 20,
              ),
              Expanded(
                  child: TextFormBox(
                controller: articleNameController,
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Please enter Article Description';
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
                'Supplier ID/Name: ',
                style: TextStyle(fontSize: 18),
              )),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Combobox<String>(
                  placeholder: Text('Selected ID'),
                  isExpanded: true,
                  items: _suppliers
                      .map((e) => ComboboxItem<String>(
                            value: e.id+" "+e.levname,
                            child: Text(e.id+" "+e.levname),
                          ))
                      .toList(),
                  value: currentValue,
                  onChanged: (value) {
                    if (value != null) setState(() => currentValue = value);
                  },
                ),
              ),
              SizedBox(
                width: 20,
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              SizedBox(
                width: 20,
              ),
              Expanded(
                  child: Text(
                'Purchase Price: ',
                style: TextStyle(fontSize: 18),
              )),
              SizedBox(
                width: 20,
              ),
              Expanded(
                  child: TextFormBox(
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                controller: articlePriceController,
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Please enter Purchase Price';
                  }
                  return null;
                },
                placeholder: 'Price',
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
            child: SizedBox(width: 200, child: Text('Add Article')),
            onPressed: () => {
              EasyLoading.show(status: 'Please wait!!'),
              if (_formKey.currentState!.validate())
                {
                  _addArticle(articleNumberController.text, articleNameController.text,
                      currentValue!.split(" ")[0], articlePriceController.text)
                }
              else {
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
