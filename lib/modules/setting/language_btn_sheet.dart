import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/setting_provider.dart';
import 'package:todo_app/shared/style/color.dart';


class LanguageBtnSheet extends StatelessWidget {
  const LanguageBtnSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingProvider>(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 35, vertical: 20),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              provider.changeLanguage('en');
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'English',
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      color: provider.language == 'en'
                          ? Theme.of(context).primaryColor
                          : Colors.lightGreen),
                ),
                Icon(Icons.done,
                    size: 30,
                    color: provider.language == 'en'
                        ? Theme.of(context).primaryColor
                        : Colors.transparent),
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          InkWell(
            onTap: () {
              provider.changeLanguage('ar');
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "اللغة العربية",
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      color: provider.language == 'ar'
                          ? Theme.of(context).primaryColor
                          : Colors.lightGreen),
                ),
                Icon(Icons.done,
                    size: 30,
                    color: provider.language == 'ar'
                        ? Theme.of(context).primaryColor
                        : Colors.transparent),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
