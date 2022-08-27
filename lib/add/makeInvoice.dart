import 'dart:developer';
import 'dart:io';
import 'package:customer_management_system/model/article.dart';
import 'package:customer_management_system/model/client.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import '../services/services.dart';

class MakeInvoice extends StatefulWidget {
  const MakeInvoice({Key? key}) : super(key: key);

  @override
  _MakeInvoiceState createState() => _MakeInvoiceState();
}

class _MakeInvoiceState extends State<MakeInvoice> {
  final file = File('Invoice.pdf');
  final _formKey = GlobalKey<FormState>();
  String? currentClient;
  String? currentArticle;
  List<Client> _clients = [];
  List<Article> _article = [];
  String _adding = '';

  @override
  void initState() {
    super.initState();
    _getArticles();
    _getClients();
  }
  Future<void> _createPDF()async{
    EasyLoading.show(status: "Generating PDF");
    PdfDocument document = PdfDocument();
    final page = document.pages.add();

    page.graphics.drawString('Client Management System', PdfStandardFont(PdfFontFamily.helvetica, 30),
    bounds: Rect.fromLTWH(10, 10, 300, 50));
    PdfGrid grid = PdfGrid();
    grid.style = PdfGridStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica,18),
      cellPadding: PdfPaddings(left: 5,right: 2,top: 2,bottom: 2),
    );
    grid.columns.add(count: 4);
    grid.headers.add(1);

    PdfGridRow header = grid.headers[0];
    header.cells[0].value = "Client ID";
    header.cells[1].value = "Client";
    header.cells[2].value = "Article ID";
    header.cells[3].value = "Article Name";

    PdfGridRow row = grid.rows.add();
    row.cells[0].value = currentClient!.split(" ")[0];
    row.cells[1].value = currentClient!.split(" ")[1];
    row.cells[2].value = currentArticle!.split(",")[0];
    row.cells[3].value = currentArticle!.split(",")[1];

    grid.draw(page: page,
        bounds: Rect.fromLTWH(
            0, 50, page.getClientSize().width, page.getClientSize().height));

    List<int> bytes = document.save();
    document.dispose();
    await file.writeAsBytes(bytes);
    EasyLoading.dismiss();
    EasyLoading.showSuccess('Generated');
  }

  _addSale(String client,String article,String price){
    EasyLoading.show(status: 'Please wait!!!');
    Services.addSale(client, article, price).then((value) {
      _adding = value;
    });
    if(_adding == 'success'){
      EasyLoading.dismiss();
      EasyLoading.showSuccess('Invoice Saved');
    }else{
      EasyLoading.dismiss();
      EasyLoading.showError(_adding);
    }
  }

  _getArticles() {
    EasyLoading.show(status: 'Please wait!!!');
    Services.getAllArticles().then((value) {
      setState(() {
        _article = value;
      });
      EasyLoading.showSuccess('');
      EasyLoading.dismiss();
    });
  }

  _getClients() {
    Services.getClients().then((value) {
      setState(() {
        _clients = value;
      });
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
                'Make Invoice',
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
                width: 20,
              ),
              Expanded(
                  child: Text(
                'Client ID/Name: ',
                style: TextStyle(fontSize: 18),
              )),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Combobox<String>(
                  placeholder: Text('Selected ID'),
                  isExpanded: true,
                  items: _clients
                      .map((e) => ComboboxItem<String>(
                            value: e.id + " " + e.cLname,
                            child: Text(e.id + " " + e.cLname),
                          ))
                      .toList(),
                  value: currentClient,
                  onChanged: (value) {
                    if (value != null) setState(() => currentClient = value);
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
                'Article ID/Name: ',
                style: TextStyle(fontSize: 18),
              )),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Combobox<String>(
                  placeholder: Text('Selected ID'),
                  isExpanded: true,
                  items: _article
                      .map((e) => ComboboxItem<String>(
                            value: e.id + "," + e.artnaam+","+e.artpr,
                            child: Text(e.id + "," + e.artnaam+","+e.artpr),
                          ))
                      .toList(),
                  value: currentArticle,
                  onChanged: (value) {
                    if (value != null) setState(() => currentArticle = value);
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
                  child: FilledButton(
                child: Text('Generate PDF'),
                onPressed: () async => {
                  _createPDF()
                },
              )),
              SizedBox(
                width: 20,
              ),
              Expanded(
                  child: Button(
                child: Text('Save'),
                onPressed: () => {
                  _addSale(currentClient!.split(" ")[0], currentArticle!.split(",")[0], currentArticle!.split(",")[2])
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
