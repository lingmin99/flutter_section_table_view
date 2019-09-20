import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_section_table_view/flutter_section_table_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FullList extends StatefulWidget {
  @override
  _FullListState createState() => _FullListState();
}

class _FullListState extends State<FullList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  int sectionCount = 0;
  final controller = SectionTableController(sectionTableViewScrollTo: (section, row, isScrollDown) {
    print('received scroll to $section $row scrollDown:$isScrollDown');
  });
  final refreshController = RefreshController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Full List'),
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
          enablePullDown: true,
          enablePullUp: true,
          onRefresh: () {

            Future.delayed(const Duration(milliseconds: 2009)).then((val) {
              refreshController.loadComplete();
              setState(() {
                sectionCount = 4;
              });
            });
          },
          onLoading: (){
              sectionCount++;
          },
          refreshController: refreshController,
          sectionCount: sectionCount,
          numOfRowInSection: (section) {
            return section == 0 ? 1 : 4;
          },
          cellAtIndexPath: (section, row) {
            return Container(
              height: 44.0,
              child: Center(
                child: Text('Cell $section $row'),
              ),
            );
          },
          sliversInSection: (section){
            return [SliverList(
              delegate: SliverChildBuilderDelegate((BuildContext context, int index){
                return Container(height: 39, color: Colors.red,);
              },
                  childCount: 3
              ),
            )];
          },
          headerInSection: (section) {
            return Container(
              height: 25.0,
              color: Colors.grey,
              child: Text('Header $section'),
            );
          },
          divider: Container(
            color: Colors.green,
            height: 1.0,
          ),
          controller: controller, //SectionTableController
          dividerHeight: () => 1.0,
          cellHeightAtIndexPath: (section, row) => 44.0,
        ),
      ),
    );
  }
}


