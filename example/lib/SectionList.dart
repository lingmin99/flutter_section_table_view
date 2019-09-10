import 'package:flutter/material.dart';
import 'package:flutter_section_table_view/flutter_section_table_view.dart';

class SectionList extends StatelessWidget {
  final controller = SectionTableController(
      sectionTableViewScrollTo: (section, row, isScrollDown) {
    print('received scroll to $section $row scrollDown:$isScrollDown');
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Section List'),
      ),
      floatingActionButton: FloatingActionButton(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[Text('Scroll'), Icon(Icons.keyboard_arrow_down)],
          ),
          onPressed: () {
            controller.animateTo(2, -1).then((complete) {
              print('animated $complete');
            });
          }),
      body: SafeArea(
        child: SectionTableView(
          sectionCount: 15,
          numOfRowInSection: (section) {
            return section == 0 ? 3 : 4;
          },
          cellAtIndexPath: (section, row) {
            return Container(
              height: 44.0,
              child: Center(
                child: Text('Cell $section $row'),
              ),
            );
          },
          headerInSection: (section) {
            return Container(
              color: Colors.grey,
              child: Text('Headersdfsdfdfsdf\nsdfsdfsdflksjdlfkjsdf $section'),
            );
          },
          sectionFooterHeight: (section){
            return 40;
          },
          footerInSection: (secton){
            return Container(height: 10, color: Colors.redAccent,);
          },
          divider: Container(
            color: Colors.green,
            height: 1.0,
          ),
          controller: controller, //SectionTableController
          dividerHeight: () => 1.0,
          cellHeightAtIndexPath: (section, row) => 44.0,
          onPress: (section, row){
            print("$section --- $row");
          },
        ),
      ),
    );
  }
}
