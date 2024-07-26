import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';


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
          _liveFilterPanel(),
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
                      padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
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
                      padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
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
              SizedBox(height: 15),
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
      return SingleChildScrollView(
        child: Container(
          height: 410,
          width: 600,
          color: containerColourLight,
          child: Column(
            children: targets!.entries.map((entry) => _targetTile(entry.key, entry.value)).toList()
          ),
        )
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
  Widget _liveFilterPanel() {
    // white background container
    return Container(
      width: 420,
      height: 450,
      margin: const EdgeInsets.only(left: 15, top: 40, bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(50))
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          
        ],
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

  // TODO: implement into Hive
  String _getTarget(String code) {
    switch (code) {
      case 'P11362': return 'FGFR1';
      case 'P21802': return 'FGFR2';
      case 'P22607': return 'FGFR3';
      case 'P22455': return 'FGFR4';
      case 'P07333': return 'CSF1R';
      case 'P51449': return 'RORgt';
      case 'Q9NZQ7': return 'PD-L1';
      case 'P21589': return 'CD73';
      case 'P01116': return 'KRAS';
      case 'P61073': return 'CXCR4';
      case 'P00533': return 'EGFR';
      case 'P31153': return 'MAT2a';
      case 'O14744': return 'PRMT5';
      case 'Q07889': return 'SOS1';
      case 'Q07890': return 'SOS2';
      case 'P08581': return 'MET';
      case 'P24941': return 'CDK2';
      case 'P42336': return 'PI3Kalpha';
      case 'P54750': return 'PDE1A';
      case 'Q01064': return 'PDE1B';
      case 'Q14123': return 'PDE1C';
      case 'O00408': return 'PDE2A';
      case 'Q14432': return 'PDE3A';
      case 'Q13370': return 'PDE3B';
      case 'P27815': return 'PDE4A';
      case 'Q07343': return 'PDE4B';
      case 'Q08493': return 'PDE4C';
      case 'Q08499': return 'PDE4D';
      case 'Q5VU43': return 'PDE4DIP';
      case 'O76074': return 'PDE5A';
      case 'P16499': return 'PDE6A';
      case 'P35913': return 'PDE6B';
      case 'P51160': return 'PDE6C';
      case 'O43924': return 'PDE6D';
      case 'P18545': return 'PDE6G';
      case 'Q13956': return 'PDE6H';
      case 'Q13946': return 'PDE7A';
      case 'Q9NP56': return 'PDE7B';
      case 'O60658': return 'PDE8A';
      case 'O95263': return 'PDE8B';
      case 'O76083': return 'PDE9A';
      case 'Q9Y233': return 'PDE10A';
      case 'Q9HCR9': return 'PDE11A';
      case 'Q6L8Q7': return 'PDE12';
      case 'P01116-2': return 'KRAS';
      case 'P28907': return 'CD38';
      case 'P04626': return 'HER2';
      case 'P51531': return 'SMARCA2';
      case 'P11802': return 'CDK4';
      case 'Q00534': return 'CDK6';
      case 'Q13131': return 'AMPK-alpha1';
      case 'P54646': return 'AMPK-alpha2';
      case 'Q9Y478': return 'AMPK-beta1';
      case 'O43741': return 'AMPK-beta2';
      case 'P54619': return 'AMPK-gamma1';
      case 'Q9UGJ0': return 'AMPK-gamma2';
      case 'Q9UGI9': return 'AMPK-gamma3';
      case 'P80385': return 'AMPK-gamma1(Rat)';
      case 'P54645': return 'AMPK-alpha1(Rat)';
      case 'P40763': return 'STAT3';
      case 'P42226': return 'STAT6';
      case 'Q86W56': return 'PARG';
      case 'P51532': return 'SMARCA4';
      default: return '';
    }
  }
}