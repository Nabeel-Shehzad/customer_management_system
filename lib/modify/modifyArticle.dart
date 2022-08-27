import 'package:customer_management_system/model/article.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../login/login.dart';
import '../model/supplier.dart';
import '../services/services.dart';
class ModifyArticle extends StatefulWidget {
  const ModifyArticle({Key? key}) : super(key: key);

  @override
  _ModifyArticleState createState() => _ModifyArticleState();
}

class _ModifyArticleState extends State<ModifyArticle> {
  final _key = GlobalKey<FormState>();
  var articleNumberController = TextEditingController();
  var articleNameController = TextEditingController();
  var articlePriceController = TextEditingController();
  var searchController = TextEditingController();
  List<Supplier> _suppliers = [];
  List<Article> _articles = [];
  String? currentValue;
  String _deleted = '';
  String _updated = '';

  @override
  void initState() {
    super.initState();
    _getSuppliers();
  }

  _getData(String number) {
    EasyLoading.show(status: 'Please wait!!!');
    Services.getArticle(number).then((value) {
      setState(() {
        _articles = value;
      });
      if (_articles.length == 1) {
        EasyLoading.dismiss();
        articleNumberController.text = _articles[0].artnr;
        articleNameController.text = _articles[0].artnaam;
        articlePriceController.text = _articles[0].artpr;
      } else {
        EasyLoading.showError("Can't find any Article with this number");
      }
    });
  }
  _updateArticle(String id, String artnr,String artnaam,String levid,String artpr) {
    EasyLoading.show(status: 'Please wait!!!');
    Services.updateArticle(id, artnr,artnaam,levid,artpr).then((value) {
      setState(() {
        _updated = value;
      });
      if (_updated == 'success') {
        EasyLoading.dismiss();
        EasyLoading.showSuccess('Article updated');
        _clearFields();
      } else {
        EasyLoading.dismiss();
        EasyLoading.showError("$_updated try again later.");
      }
    });
  }
  _deleteArticle(String id) {
    EasyLoading.show(status: "Please wait!!!");
    Services.deleteArticle(id).then((value) {
      setState(() {
        _deleted = value;
      });
      if (_deleted == 'success') {
        EasyLoading.dismiss();
        EasyLoading.showSuccess('Article Deleted');
        _clearFields();
      } else {
        EasyLoading.dismiss();
        EasyLoading.showError("$_deleted try again later.");
      }
    });
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
  Widget getButton(){
    if(Login.access == '1') {
      return FilledButton(
        child: Text('Delete'),
        onPressed: () => {
          _deleteArticle(_articles[0].id),
        },
      );
    }return Text('');
  }
  _clearFields(){
    articlePriceController.clear();
    articleNameController.clear();
    articleNumberController.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Modify Article',
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
                          return 'Please enter a Article number';
                        } else {
                          return null;
                        }
                      },
                      placeholder: 'Please enter Article number...',
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
                                    title: Text('Article Number missing!!!'),
                                    content:
                                    Text('Provide a valid Article number'),
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
                    'Article Name: ',
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
                        return 'Please enter Article Name';
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
          SizedBox(height: 20,),
          Row(
            children: [
              SizedBox(
                width: 20,
              ),
              Expanded(
                  child: Text(
                    'Article Price: ',
                    style: TextStyle(fontSize: 18),
                  )),
              SizedBox(
                width: 20,
              ),
              Expanded(
                  child: TextFormBox(
                    controller: articlePriceController,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Please enter Article Price';
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
                  child:  Button(
                    child: Text('Edit'),
                    onPressed: () =>
                    {
                      _updateArticle(_articles[0].id, articleNumberController.text,
                          articleNameController.text, currentValue!.split(" ")[0],
                          articlePriceController.text),
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
