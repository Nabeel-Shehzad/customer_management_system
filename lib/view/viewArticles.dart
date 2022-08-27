import 'package:customer_management_system/model/article.dart';
import 'package:customer_management_system/services/services.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
class ViewArticles extends StatefulWidget {
  const ViewArticles({Key? key}) : super(key: key);

  @override
  _ViewArticlesState createState() => _ViewArticlesState();
}

class _ViewArticlesState extends State<ViewArticles> {
  List<Article> _articles = [];

  @override
  void initState(){
    super.initState();
    _getArticles();
  }
  _getArticles(){
    EasyLoading.show(status: 'Please wait!!!');
    Services.getAllArticles().then((value) {
      setState(() {
        _articles = value;
      });
      EasyLoading.dismiss();
      EasyLoading.showSuccess('');
    });
  }
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: Text(
        'Articles',
        style: TextStyle(fontSize: 60),
      ),
      content: SizedBox.expand(
        child: Scrollbar(
          child: ListView.builder(
              padding: EdgeInsets.only(right: 16.0),
              itemCount: _articles.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Text(_articles[index].artnr),
                  title: Text(_articles[index].artnaam),
                  subtitle: Row(
                    children: [
                      Expanded(child: Text(_articles[index].artpr))
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
