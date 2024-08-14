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
  final TextEditingController accessController = TextEditingController(); // controller for accession code text field
  final TextEditingController targetController = TextEditingController(); // controller for target text field
  final TextEditingController filterController = TextEditingController();
  final TextEditingController dropController = TextEditingController();


  bool showDrop = false;
  num selectedNum = 1;

  Box<List>? filterBox;
  Box<Map>? mapBox;

  List<String>? filter1;
  List<String>? filter2;
  List<String>? filter3;
  Map<String, String>? targets;

  // search Strings
  String accessText = ''; // holds user entry for accessController
  String targetText = ''; // holds user entry for targetController
  String filterText = '';


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
    filterController.addListener(_onFilterUpdate);

    filterBox = Hive.box<List>('filterBox');
    mapBox = Hive.box<Map>('mapBox');

    filter1 = filterBox?.get('filter1')?.cast<String>() ?? [];
    filter2 = filterBox?.get('filter2')?.cast<String>() ?? [];
    filter3 = filterBox?.get('filter3')?.cast<String>() ?? [];
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
          _accessPanel(),
          _filterPanel(),
          _infoPanel(),
        ],
      ),
    );
  }

  // Builds data type selector and filter for user to select data types
  // to query to the API.
  Container _accessPanel() {
    return Container( // white box background
      height: 620,
      width: 470,
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
                width: 400,
                child: Row(
                  children: [
                    Container(
                      width: 190,
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
                      width: 210,
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

  Container _filterPanel() {
    return Container( // white box background
      height: 620,
      width: 220,
      padding: const EdgeInsets.only(top: 20, left: 35, right: 35),
      margin: const EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 48),
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
              'Set Filters',
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
                width: 180,
                child: Row(
                  children: [
                    Container(
                      width: 70,
                      padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                      child: Text(
                        'Name',
                        style: TextStyle(
                          color: textColourLight,
                          fontWeight: FontWeight.w500
                        ),
                      )
                    ),
                    Container(
                      width: 70,
                      padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                      child: Text(
                        'Level',
                        style: TextStyle(
                          color: textColourLight,
                          fontWeight: FontWeight.w500
                        ),
                      )
                    ),
                  ]
                )
              ),
              _currentFilters(),
              const SizedBox(height: 15),
            ],
          ),
          Row(
            children: [
              _filterBar(),
              const SizedBox(width: 2),
              _dropUp(),
              _addFilterButton()
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
          width: 400,
          color: containerColourLight,
          child: const Center(
            child: Text('Nothing to show.')
          )
        );
      }
      return Container(
        height: 410,
        width: 400,
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
      width: 400,
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
                width: 190,
                padding: const EdgeInsets.only(left: 10, right: 10, top: 1, bottom: 1),
                child: Text(
                  accessCode,
                  overflow: TextOverflow.ellipsis,
                )
              ),
              Container(
                width: 180,
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

  Widget _currentFilters() {
    Map<String, num> filters = {};
    if (filter1 != null) {
      for (String filter in filter1!) {
        filters[filter] = 1;
      }
    }
    if (filter2 != null) {
      for (String filter in filter2!) {
        filters[filter] = 2;
      }
    }
    if (filter3 != null) {
      for (String filter in filter3!) {
        filters[filter] = 3;
      }
    }
    if (filters.isEmpty) {
      return Container(
        height: 410,
        width: 180,
        color: containerColourLight,
        child: const Center(
          child: Text('Nothing to show.')
        )
      );
    }
    return Container(
      height: 410,
      width: 180,
      color: containerColourLight,
      child: SingleChildScrollView(
        child: Column(
          children: filters.entries.map((entry) => _filterTile(entry.key, entry.value)).toList()
        )
      ),
    );
  }

  Widget _filterTile(String name, num level) {
    return SizedBox(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 83,
                padding: const EdgeInsets.only(left: 10, right: 10, top: 1, bottom: 1),
                child: Text(
                  name,
                  overflow: TextOverflow.ellipsis,
                )
              ),
              Container(
                width: 47,
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Text(
                  '$level',
                  overflow: TextOverflow.ellipsis,
                )
              ),
              InkWell(
                child: const Icon(Icons.clear, size: 16),
                onTap: () => setState(() {
                  if (filter1!.contains(name)) {
                    filter1!.remove(name);
                    filterBox?.put('filter1', filter1!);
                  } else if (filter2!.contains(name)) {
                    filter2!.remove(name);
                    filterBox?.put('filter2', filter2!);
                  } else {
                    filter3!.remove(name);
                    filterBox?.put('filter3', filter3!);
                  }
                }),
              )
            ]
          ),
          const Divider(height: 0)
        ],
      ),
    );
  }

  Widget _addFilterButton() {
    return Transform.scale(
      scale: 0.75,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: buttonColourLight
        ),
        child: IconButton(
          icon: const Icon(Icons.add, color: Colors.black),
          onPressed: () {
            if (filterText.trim() != '' &&
                filter1?.contains(filterText.trim()) == false && 
                filter2?.contains(filterText.trim()) == false && 
                filter3?.contains(filterText.trim()) == false) {
              setState(() {
                if (selectedNum == 1) {
                  filter1?.add(filterText);
                  filterBox!.put('filter1', filter1!);
                } else if (selectedNum == 2) {
                  filter2?.add(filterText);
                  filterBox!.put('filter2', filter2!);
                } else {
                  filter3?.add(filterText);
                  filterBox!.put('filter3', filter3!);
                }
              });
            }
          },
        ),
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
                'Software Information | v1.2',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500
                )
              ),
              const SizedBox(height: 10),
              const Text(
                'Welcome to the unofficial CSV getter for RCSB PDB. This software requires a strong network connection as it uses a search API and a data API provided by RCSB PDB to query protein entries. For more implemen-tation details, please refer to the originating GitHub repository:',
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
              const SizedBox(height: 20),
              const Text(
                'Querying',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'This software accepts general search term(s), entry ID(s), or sequence. Up to 10,000 results can be returned, sorted by score (large searches are not recommended without a stable internet connection). Multiple search terms can be entered at once by separating terms with a comma (e.g. "Term A, Term B"). For more information, refer to the RCSB PDB search API.',
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 20),
              const Text(
                'Setting Accession Code Targets',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Setting accession code targets is linked to the \'Process file\' option found next to the \'Generate CSV\' button. Accession codes that have been submitted are automatically saved locally once the \'Add+\' button is clicked. No data is stored or accessed remotely.',
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 20),
              const Text(
                'Setting Ligand ID Filters',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Setting ligand ID filters is linked to the \'Process file\' option found next to the \'Generate CSV\' button. Ligand ID filters are sorted into three levels: 1, 2, and 3. Levels 1 and 2 IDs are completely ignored in the processed CSV file, while level 3 IDs are kept only if no other ligand IDs are available. Filters are automatically saved locally upon submission. No data is stored or accessed remotely.',
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 20),
              const Text(
                'Searching Data Types',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Use the top search bar to assist in filtering data types. Data types are filtered by their main categories, sub-categories, names, and internal IDs. A data type will be displayed if a match is found for any one of these parameters.',
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 5),
              const Text(
                'Internal IDs are unique, hardcoded keys corresponding to each data type. These are typically in the format of x#o#, where x is a letter representing the category (e.g., \'s\' for \'Structure Data\') followed by a number, the letter o, and another number. A complete list of ID-to-data-type mapping is available in the originating GitHub repository.',
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 20),
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
              const SizedBox(height: 30)
            ],
          ),
        )
      )
    );
  }

  Widget _dropUp() {
    return InkWell(
      child: Container(
        margin: const EdgeInsets.only(top: 5, bottom: 5),
        padding: const EdgeInsets.only(bottom: 1),
        width: 28,
        height: 32,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 0.8),
          borderRadius: const BorderRadius.all(Radius.circular(3))
        ),
        child: Center(
          child: Text(
            '$selectedNum',
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        )
      ),
      onTap: () {
        setState(() => showDrop = !showDrop);
      }
    );
  }

  // Search bar for the main panel's data type filtering.
  Widget _filterBar() {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 5, bottom: 5),
          padding: const EdgeInsets.only(left: 2),
          width: 80,
          height: 32,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 0.8),
            borderRadius: const BorderRadius.all(Radius.circular(3))
          ),
          child: Row(
            children: [
              SizedBox(
                width: 75,
                child: TextField(
                  controller: filterController,
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
                    hintText: 'Filter...',
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
        ),
        showDrop 
              ? Container(
                margin: const EdgeInsets.only(top: 5, bottom: 5),
                padding: const EdgeInsets.only(left: 2),
                width: 80,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 0.8),
                  borderRadius: const BorderRadius.all(Radius.circular(3))
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 1),
                    InkWell(
                      child: Container(
                        height: 22,
                        width: 22,
                        decoration: BoxDecoration(
                          color: selectedNum == 1 ? buttonColourLight : containerColourLight,
                          borderRadius: const BorderRadius.all(Radius.circular(3)),
                        ),
                        child: const Center(
                          child: Text(
                            '1'
                          ),
                        )
                      ),
                      onTap: () {
                        setState(() {
                          selectedNum = 1;
                          showDrop = false;
                        });
                      }
                    ),
                    const SizedBox(width: 3),
                    InkWell(
                      child: Container(
                        height: 22,
                        width: 22,
                        decoration: BoxDecoration(
                          color: selectedNum == 2 ? buttonColourLight : containerColourLight,
                          borderRadius: const BorderRadius.all(Radius.circular(3)),
                        ),
                        child: const Center(
                          child: Text(
                            '2'
                          ),
                        )
                      ),
                      onTap: () {
                        setState(() {
                          selectedNum = 2;
                          showDrop = false;
                        });
                      }
                    ),
                    const SizedBox(width: 3),
                    InkWell(
                      child: Container(
                        height: 22,
                        width: 22,
                        decoration: BoxDecoration(
                          color: selectedNum == 3 ? buttonColourLight : containerColourLight,
                          borderRadius: const BorderRadius.all(Radius.circular(3)),
                        ),
                        child: const Center(
                          child: Text(
                            '3'
                          ),
                        )
                      ),
                      onTap: () {
                        setState(() {
                          selectedNum = 3;
                          showDrop = false;
                        });
                      }
                    )
                  ],
                )
              )
              : const SizedBox()
      ],
    );
  }
  
  // Search bar for the main panel's data type filtering.
  Widget _accessBar() {
    return Container(
      margin: const EdgeInsets.only(top: 5, bottom: 5),
      padding: const EdgeInsets.only(left: 2),
      width: 125,
      height: 32,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 0.8),
        borderRadius: const BorderRadius.all(Radius.circular(3))
      ),
      child: Row(
        children: [
          SizedBox(
            width: 120,
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
                hintText: 'Accession code...',
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
      width: 125,
      height: 32,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 0.8),
        borderRadius: const BorderRadius.all(Radius.circular(3))
      ),
      child: Row(
        children: [
          SizedBox(
            width: 120,
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
                hintText: 'Target...',
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

  // Method called on updates to the filter search bar. Updates what data
  // type selectors to show on the main panel.
  void _onFilterUpdate() {
    setState(() {
      filterText = filterController.text.trim();
    });
  }
}