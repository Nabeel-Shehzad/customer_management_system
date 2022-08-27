import 'package:customer_management_system/main.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ChangeTheme extends StatefulWidget {
  const ChangeTheme({Key? key}) : super(key: key);

  @override
  _ChangeThemeState createState() => _ChangeThemeState();
}

class _ChangeThemeState extends State<ChangeTheme> {
  bool _checked = false;
  @override
  void initState() {
    getTheme();
    super.initState();
  }
  void getTheme() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      _checked = preferences.getBool('theme') as bool;
    });
  }
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: Text(
        "Change Theme",
        style: TextStyle(fontSize: 60),
      ),
      content: Center(
        child: Column(
          children: [
            ToggleSwitch(
                checked: _checked,
                onChanged: (v) {
                  setState(() {
                    _checked = v;
                    if(_checked == true){
                      MyHomePage.of(context)?.changeTheme(ThemeMode.dark,true);
                    }else{
                      MyHomePage.of(context)?.changeTheme(ThemeMode.light, false);
                    }
                  });
                },
                content: Text(_checked == true ? 'Dark' : 'Light')
            ),
          ],
        ),
      ),
    );
  }
}
