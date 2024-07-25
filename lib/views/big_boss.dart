import 'package:flutter/material.dart';
import 'package:rcsb_pdb_json2csv_flex/views/custom_query_view.dart';
import 'package:rcsb_pdb_json2csv_flex/views/convert_view.dart';
import 'package:rcsb_pdb_json2csv_flex/views/query_view.dart';
import 'package:url_launcher/url_launcher.dart';

class BigBoss extends StatefulWidget {
  const BigBoss({super.key});

  @override
  BigBossState createState() => BigBossState();
}

class BigBossState extends State<BigBoss> {
  int selected = 0;
  Widget body = const CustomQueryView();
  final appBarColor = const Color.fromARGB(255, 217, 229, 241);
  final deselectedColor = const Color.fromARGB(255, 98, 138, 170);
  final selectedColor = const Color.fromARGB(255, 56, 92, 121);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, 70), 
          child: Container(
            color: appBarColor,
            height: 70,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () async {
                    final Uri url = Uri.parse('https://www.rcsb.org/');
                    if (!await launchUrl(url)) {
                      // do nothing
                    }
                  },
                  child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image(image: AssetImage('assets/rcsb_logo.png'), width: 140),
                ),
                ),
                _buildTab(CustomQueryView(), 0, 'Custom Query'),
                SizedBox(width: 1),
                _buildTab(QueryView(), 1, 'Query'),
                SizedBox(width: 1),
                _buildTab(ConvertView(), 2, 'Convert'),
                Spacer(),
              ]
            ),
          )
        ),
        body: body
      );
  }

  Widget _buildTab(Widget body, int key, String name) {
    return InkWell(
      onTap: () => setState(() {
        this.body = body;
        selected = key;
      }),
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Container(
            width: 170,
            height: 50,
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
              color: selected == key
                    ? selectedColor
                    : deselectedColor,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            ),
            child: Text(
              name,
              style: TextStyle(
                color: selected == key ? Colors.white : Colors.white70,
                fontWeight: FontWeight.w500,
                fontSize: 17
              )
            )
          ),
          Container(
            width: 170,
            height: 3,
            color: selected == key ? null : Color.fromARGB(205, 88, 122, 151)
          )
        ],
      ),
    );
  }
}