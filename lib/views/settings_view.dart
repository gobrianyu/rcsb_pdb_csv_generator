import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:url_launcher/url_launcher.dart';


class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  SettingsViewState createState() => SettingsViewState();
}

class SettingsViewState extends State<SettingsView> {

  // FIELDS:
  final TextEditingController accessController = TextEditingController(); // controller for data type filter search bar
  final TextEditingController targetController = TextEditingController(); // controller for

  Box<Map>? mapBox;
  Map<String, String>? targets;

  // search Strings
  String accessText = ''; // holds user entry for filterController
  String targetText = '';


  // CONSTANTS
  // theme colours
  final Color bgColour = const Color.fromARGB(255, 56, 92, 121); // main background colour; ~dark blue
  final Color darkColour1 = const Color.fromARGB(255, 106, 106, 106);
  final Color darkColour2 = const Color.fromARGB(255, 64, 64, 64);
  final Color accentColourDark = const Color.fromARGB(255, 59, 91, 75); // darker accent colour; ~dark green
  final Color accentColourLight = const Color.fromARGB(255, 85, 137, 110); // lighter accent colour; ~green
  final Color buttonColourHover = const Color.fromARGB(255, 185, 190, 205);
  final Color buttonColourLight = const Color.fromARGB(255, 182, 186, 201);
  final Color textColourLight = const Color.fromARGB(220, 255, 255, 255);
  final Color containerColourLight = const Color.fromARGB(255, 250, 250, 250);
  final Color lockColour = const Color.fromARGB(155, 255, 255, 255); // lock colour (slightly translucent); ~white
  final Color selectionColour = const Color.fromARGB(255, 32, 107, 168); // option selection (check box) colour; ~blue

  // Initialises state, specifically for the two text field controllers.
  @override
  void initState() {
    super.initState();
    accessController.addListener(_onAccessUpdate);
    targetController.addListener(_onTargetUpdate);
    mapBox = Hive.box<Map>('mapBox');
    targets = mapBox?.get('targets')?.cast<String, String>() ?? {};
  }

  // Main build method. Root builder of this view's UI.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColour,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _mainPanel(),
          _infoPanel(),
        ],
      ),
    );
  }

  // Builds data type selector and filter for user to select data types
  // to query to the API.
  Container _mainPanel() {
    return Container( // white box background
      height: 620,
      width: 670,
      padding: const EdgeInsets.only(top: 20, left: 35, right: 35),
      margin: const EdgeInsets.only(left: 50, right: 20, top: 40, bottom: 48),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // top layer; including title, search bar, and select/clear all button
          Container(
            alignment: Alignment.centerLeft,
            height: 40,
            child: const Text(
              'Set Accession Code Targets',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500
              )
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: darkColour2,
                width: 600,
                child: Row(
                  children: [
                    Container(
                      width: 290,
                      padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                      child: Text(
                        'Accession Code',
                        style: TextStyle(
                          color: textColourLight,
                          fontWeight: FontWeight.w500
                        ),
                      )
                    ),
                    Container(
                      width: 310,
                      padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                      child: Text(
                        'Target',
                        style: TextStyle(
                          color: textColourLight,
                          fontWeight: FontWeight.w500
                        ),
                      )
                    ),
                  ]
                )
              ),
              _currentTargets(),
              const SizedBox(height: 15),
            ],
          ),
          Row(
            children: [
              _accessBar(),
              const SizedBox(width: 10),
              const Icon(Icons.arrow_forward),
              const SizedBox(width: 10),
              _targetBar(),
              const SizedBox(width: 10),
              _addButton()
            ],
          )
        ],
      ),
    );
  }

  Widget _currentTargets() {
    if (targets != null) {
      if (targets!.isEmpty) {
        return Container(
          height: 410,
          width: 600,
          color: containerColourLight,
          child: const Center(
            child: Text('Nothing to show.')
          )
        );
      }
      return Container(
        height: 410,
        width: 600,
        color: containerColourLight,
        child: SingleChildScrollView(
          child: Column(
            children: targets!.entries.map((entry) => _targetTile(entry.key, entry.value)).toList()
          )
        ),
      );
    }
    return Container(
      height: 410,
      width: 600,
      color: containerColourLight,
      child: const Center(
        child: Text('Nothing to show.')
      )
    );
  }

  Widget _targetTile(String accessCode, String target, ) {
    return SizedBox(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 290,
                padding: const EdgeInsets.only(left: 10, right: 10, top: 1, bottom: 1),
                child: Text(
                  accessCode,
                  overflow: TextOverflow.ellipsis,
                )
              ),
              Container(
                width: 280,
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Text(
                  target,
                  overflow: TextOverflow.ellipsis,
                )
              ),
              InkWell(
                child: const Icon(Icons.clear, size: 16),
                onTap: () => setState(() {
                  targets!.remove(accessCode);
                  mapBox?.put('targets', targets!);
                }),
              )
            ]
          ),
          const Divider(height: 0)
        ],
      ),
    );
  }

  Widget _addButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0)),
        fixedSize: const Size(95, 30),
        backgroundColor: buttonColourLight,
        shadowColor: Colors.black
      ),
      onPressed: () {
        if (accessText.trim() != '' && targetText.trim() != '') {
          targets ??= {};
          targets![accessText] = targetText;
          mapBox?.put('targets', targets!);
          accessController.clear();
          targetController.clear();
          setState(() {});
        }
      },
      child: const Row(
        children: [
          Text('Add', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400)),
          SizedBox(width: 3),
          Icon(Icons.add, color: Colors.black, size: 18)
        ],
      ),
    );
  }

  // Live panel showing user selected data types, a console for status
  // updates and errors, and the database query search bar.
  Widget _infoPanel() {
    // white background container
    return Container(
      width: 420,
      height: 730,
      margin: const EdgeInsets.only(left: 15, top: 40),
      padding: const EdgeInsets.only(left: 31, right: 25, top: 31, bottom: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topRight: Radius.circular(50), topLeft: Radius.circular(50))
      ),
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(right: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Setting Accession Code Targets',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Setting accession code targets is linked to the \'Process file\' option found next to the \'Generate CSV\' button. Accession codes that have been submitted are automatically saved locally once the \'Add+\' button is clicked. No data is stored or accessed remotely and locally stored boxes are encrypted.',
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 10),
              const Text(
                'Error Codes on the Console',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500
                )
              ),
              const SizedBox(height: 10),
              const Text(
                'Error and warning codes may appear on the console. Most will provide further details and instructions on how to solve the error. However certain errors that occur may require further attention:',
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 5),
              const Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  '\'Failed to query. Server may not have responded in time.\' This error may occur either due to an excessive (large) query or the network being too slow.',
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(height: 5),
              const Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  '\'Error: Unable to write a new CSV file {}.\' Users should not typically encounter this error. If encountered, please check that no files in the destination folder is valid and that there are no files of the same name as the attempted generation file (see \'Software Information\' below for more on file name format). If issue persists, please contact the developer.',
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Software Information | v1.0',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500
                )
              ),
              const SizedBox(height: 10),
              const Text(
                'Welcome to the unofficial CSV getter for RCSB PDB. This software requires a strong network connection as it uses a search API and a data API provided by RCSB PDB to query protein entries. For more implementation details, please refer to the originating GitHub repository:',
                textAlign: TextAlign.justify,
                softWrap: true,
              ),
              const SizedBox(height: 5),
              InkWell(
                onTap: () async {
                  final Uri url = Uri.parse('https://www.github.com/gobrianyu/rcsb_pdb_csv_generator/');
                  if (!await launchUrl(url)) {
                    // do nothing
                  }
                },
                child: const Center(child: Text('github.com/gobrianyu/rcsb_pdb_csv_generator', style: TextStyle(fontWeight: FontWeight.w500, color: Colors.blue))),
              ),
              const SizedBox(height: 5),
              const Text('Files generated by this software are named in the following format:', textAlign: TextAlign.justify,),
              const SizedBox(height: 5),
              const Center(child: Text('rcsb_pdb_custom_report_{TIME}.csv,')),
              const SizedBox(height: 5),
              const Text('where {TIME} is the local system\'s time on CSV generation, formatted as \'YYYYMMDDhhmmss\'.', textAlign: TextAlign.justify,),
              const SizedBox(height: 10),
              const Text('Developed by Brian Yu, 2024.'),
            ],
          ),
        )
      )
    );
  }
  
  // Search bar for the main panel's data type filtering.
  Widget _accessBar() {
    return Container(
      margin: const EdgeInsets.only(top: 5, bottom: 5),
      padding: const EdgeInsets.only(left: 2),
      width: 205,
      height: 32,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 0.8),
        borderRadius: const BorderRadius.all(Radius.circular(3))
      ),
      child: Row(
        children: [
          SizedBox(
            width: 200,
            child: TextField(
              controller: accessController,
              cursorColor: Colors.black,
              cursorWidth: 1,
              style: const TextStyle(
                fontSize: 14,
              ),
              // context menu (i.e. cut, copy, paste, select all options)
              contextMenuBuilder: (BuildContext context, EditableTextState editableTextState) {
                return AdaptiveTextSelectionToolbar(
                  anchors: editableTextState.contextMenuAnchors,
                  children: editableTextState.contextMenuButtonItems
                      .map((ContextMenuButtonItem buttonItem) {
                    return CupertinoButton(
                      minSize: 25,
                      borderRadius: null,
                      color: containerColourLight,
                      onPressed: buttonItem.onPressed,
                      padding: const EdgeInsets.only(left: 10.0),
                      pressedOpacity: 0.7,
                      child: SizedBox(
                        width: 310,
                        child: Text(
                          CupertinoTextSelectionToolbarButton.getButtonLabel(
                              context, buttonItem),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12
                          )
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
              decoration: const InputDecoration(
                hintText: 'Enter accession code...',
                hintStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 5),
              ),
            ),
          ),
        ],
      )
    );
  }

  // Search bar for the main panel's data type filtering.
  Widget _targetBar() {
    return Container(
      margin: const EdgeInsets.only(top: 5, bottom: 5),
      padding: const EdgeInsets.only(left: 2),
      width: 205,
      height: 32,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 0.8),
        borderRadius: const BorderRadius.all(Radius.circular(3))
      ),
      child: Row(
        children: [
          SizedBox(
            width: 200,
            child: TextField(
              controller: targetController,
              cursorColor: Colors.black,
              cursorWidth: 1,
              style: const TextStyle(
                fontSize: 14,
              ),
              // context menu (i.e. cut, copy, paste, select all options)
              contextMenuBuilder: (BuildContext context, EditableTextState editableTextState) {
                return AdaptiveTextSelectionToolbar(
                  anchors: editableTextState.contextMenuAnchors,
                  children: editableTextState.contextMenuButtonItems
                      .map((ContextMenuButtonItem buttonItem) {
                    return CupertinoButton(
                      minSize: 25,
                      borderRadius: null,
                      color: containerColourLight,
                      onPressed: buttonItem.onPressed,
                      padding: const EdgeInsets.only(left: 10.0),
                      pressedOpacity: 0.7,
                      child: SizedBox(
                        width: 310,
                        child: Text(
                          CupertinoTextSelectionToolbarButton.getButtonLabel(
                              context, buttonItem),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12
                          )
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
              decoration: const InputDecoration(
                hintText: 'Enter target...',
                hintStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 5),
              ),
            ),
          ),
        ],
      )
    );
  }

  // Method called on updates to the filter search bar. Updates what data
  // type selectors to show on the main panel.
  void _onAccessUpdate() {
    setState(() {
      accessText = accessController.text.trim();
    });
  }

  // Method called on updates to the filter search bar. Updates what data
  // type selectors to show on the main panel.
  void _onTargetUpdate() {
    setState(() {
      targetText = targetController.text.trim();
    });
  }
}