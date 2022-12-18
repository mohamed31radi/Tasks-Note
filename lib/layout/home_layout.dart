import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/modules/setting/setting.dart';
import 'package:todo_app/modules/task_list/task_list.dart';
import 'package:todo_app/providers/tabs_provder.dart';

class HomeLayout extends StatelessWidget {
  static const String routName='Home';
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TabsProvider(),
      builder: (context, child) {
        var provider=Provider.of<TabsProvider>(context);
        return Scaffold(
          extendBody: true,
          appBar: AppBar(
            title: Text('Route Tasks'),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            shape: StadiumBorder(
                side: BorderSide(
                  color: Colors.white,
                  width: 4,
                )
            ),
            onPressed: () {

            },
            child: Icon(Icons.add),
          ),
          body: tabs[provider.currentIndex],
          bottomNavigationBar: BottomAppBar(
            notchMargin: 8,
            shape: CircularNotchedRectangle(),
            child: BottomNavigationBar(
                currentIndex: provider.currentIndex,
                onTap: (index) {
                  provider.changTab(index);
                },
                items: [
                  BottomNavigationBarItem(
                      label: 'List',
                      icon: Icon(Icons.list
                      )),
                  BottomNavigationBarItem(
                    label: 'Setting',
                    icon: Icon(Icons.settings),
                  ),
                ]
            ),
          ),
        );
      },
    );
  }
  List<Widget> tabs=[SettingScreen(),TaskList()];
}
