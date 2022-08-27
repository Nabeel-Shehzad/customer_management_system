import 'package:customer_management_system/model/supplier.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../services/services.dart';

class ViewSuppliers extends StatefulWidget {
  const ViewSuppliers({Key? key}) : super(key: key);

  @override
  _ViewSuppliersState createState() => _ViewSuppliersState();
}

class _ViewSuppliersState extends State<ViewSuppliers> {
  List<Supplier> _suppliers = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getSuppliers();
  }

  _getSuppliers(){
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
    return ScaffoldPage(
      header: Text(
        'Suppliers',
        style: TextStyle(fontSize: 60),
      ),
      content: SizedBox.expand(
        child: Scrollbar(
          child: ListView.builder(
              padding: EdgeInsets.only(right: 16.0),
              itemCount: _suppliers.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Text(_suppliers[index].levnr),
                  title: Row(
                    children: [
                      Flexible(child: Text(_suppliers[index].levname))
                    ],
                  ),
                  subtitle: Row(
                    children: [
                      Flexible(child: Text(_suppliers[index].levadres))
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
