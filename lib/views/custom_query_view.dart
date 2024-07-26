import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:rcsb_pdb_json2csv_flex/models/category.dart';
import 'package:rcsb_pdb_json2csv_flex/models/json_write_object.dart';
import 'package:rcsb_pdb_json2csv_flex/models/sub_category.dart';
import 'package:rcsb_pdb_json2csv_flex/models/option_key.dart';


class CustomQueryView extends StatefulWidget {
  const CustomQueryView({super.key});

  @override
  CustomQueryViewState createState() => CustomQueryViewState();
}

class CustomQueryViewState extends State<CustomQueryView> {

  // FIELDS:
  // search controllers
  final TextEditingController searchController = TextEditingController(); // controller for query search bar
  final TextEditingController filterController = TextEditingController(); // controller for data type filter search bar
  
  final List<OptionKey> allOptions = [
    OptionKey.s1o0,
    OptionKey.s4o0,
    OptionKey.s4o1,
    OptionKey.s4o2,
    OptionKey.s4o3,
    OptionKey.s4o4,
    OptionKey.s4o5,
    OptionKey.s4o6,
    OptionKey.s9o0,
    OptionKey.s9o1,
    OptionKey.s9o2,
    OptionKey.s9o3,
    OptionKey.s9o4,
    OptionKey.s9o10,
    OptionKey.s9o11,
    OptionKey.s11o0,
    OptionKey.s11o1,
    OptionKey.s11o2,
    OptionKey.s11o3,
    OptionKey.s11o4,
    OptionKey.s11o11,
    OptionKey.s11o6,
    OptionKey.s11o5,
    OptionKey.s11o7,
    OptionKey.s11o8,
    OptionKey.s11o9,
    OptionKey.s11o10,
    OptionKey.s8o0,
    OptionKey.s7o0,
    OptionKey.s7o1,
    OptionKey.s7o2,
    OptionKey.s7o3,
    OptionKey.s7o4,
    OptionKey.s7o5,
    OptionKey.s1o4,
    OptionKey.s1o5,
    OptionKey.s1o6,
    OptionKey.s0o2,
    OptionKey.s3o0,
    OptionKey.s3o1,
    OptionKey.s3o2,
    OptionKey.s3o3,
    OptionKey.s12o0,
    OptionKey.s12o1,
    OptionKey.s12o2,
    OptionKey.s12o3,
    OptionKey.s12o4,
    OptionKey.s12o5,
    OptionKey.s12o6,
    OptionKey.s12o7,
    OptionKey.s12o8,
    OptionKey.s12o9,
    OptionKey.s12o10,
    OptionKey.s12o11,
    OptionKey.s12o12,
    OptionKey.s12o13,
    OptionKey.s12o14,
    OptionKey.s12o15,
    OptionKey.s12o16,
    OptionKey.s12o17,
    OptionKey.s12o18,
    OptionKey.s12o19,
    OptionKey.s12o20,
    OptionKey.s12o21,
    OptionKey.s0o3,
    OptionKey.s0o4,
    OptionKey.s0o5,
    OptionKey.s1o2,
    OptionKey.s1o3,
    OptionKey.s5o0,
    OptionKey.s6o0,
    OptionKey.s6o1,
    OptionKey.s6o2,
    OptionKey.s6o3,
    OptionKey.s6o4,
    OptionKey.s6o5,
    OptionKey.s0o1,
    OptionKey.s0o0,
    OptionKey.s2o0,
    OptionKey.s2o1,
    OptionKey.s2o2,
    OptionKey.s2o3,
    OptionKey.s2o4,
    OptionKey.s2o5,
    OptionKey.s2o6,
    OptionKey.s2o7,
    OptionKey.s2o8,
    OptionKey.s2o9,
    OptionKey.s2o10,
    OptionKey.s2o11,
    OptionKey.s2o12,
    OptionKey.s2o13,
    OptionKey.s2o14,
    OptionKey.s2o15,
    OptionKey.s2o16,
    OptionKey.s8o1,
    OptionKey.s9o5,
    OptionKey.s9o12,
    OptionKey.s9o13,
    OptionKey.s13o4,
    OptionKey.s13o5,
    OptionKey.s13o6,
    OptionKey.s13o7,
    OptionKey.s13o0,
    OptionKey.s13o3,
    OptionKey.s13o1,
    OptionKey.s13o2,
    OptionKey.s10o0,
    OptionKey.s10o1,
    OptionKey.s10o2,
    OptionKey.s10o3,
    OptionKey.s10o4,
    OptionKey.s10o5,
    OptionKey.s10o6,
    OptionKey.s10o7,
    OptionKey.s10o8,
    OptionKey.s1o1,
    OptionKey.s0o6,
    OptionKey.s4o7,
    OptionKey.s9o6,
    OptionKey.s9o7,
    OptionKey.s9o8,
    OptionKey.s9o9,
    OptionKey.p2o0,
    OptionKey.p2o1,
    OptionKey.p2o3,
    OptionKey.p2o4,
    OptionKey.p2o2,
    OptionKey.p2o8,
    OptionKey.p2o9,
    OptionKey.p2o10,
    OptionKey.p2o11,
    OptionKey.p2o12,
    OptionKey.p2o13,
    OptionKey.p2o14,
    OptionKey.p2o5,
    OptionKey.p0o2,
    OptionKey.p0o3,
    OptionKey.p2o6,
    OptionKey.p2o7,
    OptionKey.p1o0,
    OptionKey.p1o1,
    OptionKey.p1o2,
    OptionKey.p1o3,
    OptionKey.p1o4,
    OptionKey.p2o15,
    OptionKey.p2o16,
    OptionKey.p2o17,
    OptionKey.p0o0,
    OptionKey.p0o1,
    OptionKey.p2o18,
    OptionKey.p2o19,
    OptionKey.p2o20,
    OptionKey.p2o21,
    OptionKey.a1o1,
    OptionKey.a1o0,
    OptionKey.a1o2,
    OptionKey.a0o0,
    OptionKey.a1o5,
    OptionKey.a1o3,
    OptionKey.a1o4,
    OptionKey.a1o6,
    OptionKey.a1o7,
    OptionKey.n1o0,
    OptionKey.n1o1,
    OptionKey.n1o2,
    OptionKey.n1o3,
    OptionKey.n1o4,
    OptionKey.n1o5,
    OptionKey.n1o6,
    OptionKey.n1o7,
    OptionKey.n1o8,
    OptionKey.n1o9,
    OptionKey.n0o0,
    OptionKey.n0o1,
    OptionKey.n0o2,
    OptionKey.o0o0,
    OptionKey.o0o1,
    OptionKey.o0o2,
    OptionKey.o1o4,
    OptionKey.o1o0,
    OptionKey.o1o1,
    OptionKey.o1o2,
    OptionKey.o1o3,
    OptionKey.o1o5,
  ];

  Box<Map>? mapBox; // = Hive.box<Map>('mapBox');
  Box<List>? listBox; // = Hive.box<List>('listBox');
  // Map<String, String>? targets;
  List<int>? favs;

  // search Strings
  String filter = ''; // holds user entry for filterController
  String query = ''; // holds user entry for searchController
  String queryCopy = ''; // holds a copy of query for searchController; serves as a lock (unnecessary)
  
  // CSV generation fields
  String? destination; // folder destination for generated CSV file
  String fileName = ''; // name of generated CSV file; built on generation date and time (see _writeToCsv method below)

  // CSV generation options
  bool open = false;
  bool process = false;

  // user selected data types
  List<OptionKey> visibleOptions = []; // used for typed filter search
  Category? selectedCategory; // used for large categories (e.g. Structure Data, Polymer Entity Data, etc.)
  SubCategory? selectedSubCategory; // used for sub categories (e.g. Keywords and IDs, Chemical Components, etc.)
  List<OptionKey> selectedOptions = []; // list of selected options; used to specify API query and CSV generation

  // locks
  bool searchLock = false; // scuffed lock used to prevent user from modifying search params while querying API
  bool successful = false; // true if successfully queried API; also used as a lock to prevent user from modifying params before CSV generation
  
  // console text  
  String optionDescription = ''; // option description; displays on hover
  String optionTitle = ''; // option name; displays on hover
  String errorMsg = ''; // error message to display when relevant

  // API results
  List resultsFound = []; // list of result IDs from search API
  late JsonWObject jsonObject; // converted data from data API


  // CONSTANTS
  // list of categories
  final List<Category> cats = [Category.struct, Category.poly, Category.assem, Category.nonpoly, Category.oligo];
  final String delimiter = '|'; // delimiter for CSV file generation
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
    searchController.addListener(_onSearchUpdate);
    filterController.addListener(_onFilterUpdate);
    // targets = mapBox.get('myMap')?.cast<String, String>();

    mapBox = Hive.box<Map>('mapBox');
    listBox = Hive.box<List>('listBox');
    favs = listBox?.get('favs')?.cast<int>() ?? [];
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
          _mainFilterPanel(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _liveFilterPanel(),
              _fileDestination(),
            ],
          ),
        ],
      ),
    );
  }

  // Builds data type selector and filter for user to select data types
  // to query to the API.
  Container _mainFilterPanel() {
    return Container( // white box background
      height: 620,
      width: 720,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(left: 50, right: 20, top: 40, bottom: 48),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
      child: Column(
        children: [
          // top layer; including title, search bar, and select/clear all button
          Container(
            padding: const EdgeInsets.only(left: 15, right: 15),
            height: 40,
            child: Row(
              children: [
                // title
                const Text(
                  'Create Custom Tabular Report',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500
                  )
                ),
                const Spacer(),
                // search bar
                _filterBar(),
                const Spacer(),
                // select/clear all button (with lock)
                Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    _allButton(),
                    // button lock; active when waiting for API response or after successful API query
                    searchLock || successful
                          ? Container(height: 50, width: 50, color: lockColour) 
                          : const SizedBox(),
                  ],
                )
              ]
            ),
          ),
          // data type categories and selectors
          Stack(
            alignment: Alignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFilterButtons(),
                  _getOptions(),
                ],
              ),
              // main lock; active when waiting for API response or after successful API query
              searchLock || successful 
                    ? Container(height: 520, width: 670, color: lockColour) 
                    : const SizedBox(),
              // loading indicator; active when waiting for API response
              searchLock 
                    ? CircularProgressIndicator(color: accentColourLight, strokeWidth: 6,) 
                    : const SizedBox(),
              // reset query button; active after successful API query; 
              // allows users to end query process and modify search params
              successful
                    ? _resetButton()
                    : const SizedBox()
            ],
          ),
        ],
      ),
    );
  }

  // Reset query button. Active after a successful API query.
  // Allows users to end query process (turn off lock) and modify
  // search params to begin a new query process.
  Widget _resetButton() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: accentColourLight
      ),
      child: IconButton(
        icon: Icon(
          Icons.refresh,
          size: 40,
          color: textColourLight,
        ),
        tooltip: 'Reset',
        onPressed: () => setState(() => successful = false),
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
          // data type selection display
          _liveSelectionDisplay(),
          // console and search bar
          Column(
            children: [
              const SizedBox(height: 225),
              _console(),
              _searchBar(),
            ],
          )
        ],
      )
    );
  }

  // Vertical list display of user's data type selection. Users can remove
  // entries from the list or hover (mouse) over to view more information.
  // Displays text: "Nothing to show." when no data types are selected.
  Column _liveSelectionDisplay() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text('Selected Data Types'), // title
        Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            // grey outside container
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.only(bottom: 95),
              color: containerColourLight,
              height: 300,
              width: 370,
              // contents
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(top: BorderSide())
                ),
                height: 200,
                width: 370,
                child: selectedOptions.isEmpty // content depending on whether selected data types list is empty
                      ? const Center(
                        child: Text('Nothing to show.', style: TextStyle(fontSize: 12)), // case: no data types selected (empty list)
                      )
                      : SingleChildScrollView( // scrollable list of selected data types 
                        child: Column(
                          children: selectedOptions.map((e) => _liveTile(e)).toList()
                        )
                      ),
              ),
            ),
            // search lock; active when waiting for API response or after successful API query
            successful || searchLock 
                  ? Container(height: 300, width: 500, color: lockColour) 
                  : const SizedBox()
          ],
        ),
      ],
    );
  }

  // Entry tile for the provided (user selected) `option` to display
  // in the live selection display panel. Includes option title, hover
  // handling, and a remove button.
  Widget _liveTile(OptionKey option) {
    return Column(
      children: [
        Container(
          color: containerColourLight,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 3, bottom: 3),
                child: MouseRegion( // hover handling
                  // display description on enter
                  onEnter: (_) {
                    setState(() {
                      optionDescription = option.description == '' 
                            ? '${option.optionTitle}: No description available.' 
                            : '${option.optionTitle}: ${option.description}';
                      optionTitle = '${option.catTitle} | ${option.subCatTitle}';
                    });
                  },
                  // reset on exit
                  onExit: (_) {
                    setState(() {
                      optionDescription = '';
                      optionTitle = '';
                    });
                  },
                  child: SizedBox(
                    width: 333,
                    child: Text(
                      option.optionTitle,
                      style: const TextStyle(fontSize: 12),
                      softWrap: true,
                    ),
                  ),
                ),
              ),
              // remove button
              GestureDetector(
                child: const Icon(
                  Icons.clear,
                  size: 15,
                  color: Colors.black
                ),
                onTap: () => setState(() {
                  selectedOptions.remove(option);
                  errorMsg = '';
                }),
              ),
            ]
          ),
        ),
        const Divider(height: 0, color: Color.fromARGB(255, 230, 230, 230)),
      ]
    );
  }

  // Console panel within live panel. Displays errors, warnings, and status changes
  // (e.g. results found for query). Displays data type description when user hovers
  // on entries within live panel.
  Widget _console() {
    return Container(
      width: 380,
      height: 130,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
      decoration: BoxDecoration(
        color: darkColour2,
        border: Border.all(color: darkColour1, width: 2),
        borderRadius: const BorderRadius.all(Radius.circular(28))
      ),
      child: optionDescription == '' 
            ? _defaultConsoleText()
            : _hoverConsoleText()
    );
  }

  // Default console text (i.e. when the user is not hovering on an entry). Displays
  // any errors, warnings, and status changes. Warning/error cases include:
  // - failure to select at least 1 data type (warning; yellow; persistent)
  // - failure to provide query (error; red; occurs when user sends empty query)
  // - failed query (error; red; occurs when user's query fails to return in time);
  //   either the query is too large and/or user network is too slow/is unavailable
  // - empty result (error; red; occurs when user's query returns no results)
  // - failure to provide destination (error; red; occurs when user fails to provide
  //   destination for generated CSV file)
  // - failure to generate CSV file (error; red; occurs when CSV file generation fails)
  //
  // Other information includes:
  // - number of data types selected
  // - number of entries found for user query
  // - hover tips
  Column _defaultConsoleText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // title
        Text(
          '--Console',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: textColourLight
          )
        ),
        const SizedBox(height: 5),
        // number of data types selected
        Text(
          'Data types selected: (${selectedOptions.length})',
          style: TextStyle(
            fontSize: 12,
            color: textColourLight
          )
        ),
        // warning: failure to select at least 1 data type
        selectedOptions.isEmpty 
              ? const Text(
                '► Ensure that at least 1 data type is selected before querying.',
                style: TextStyle(
                  fontSize: 12,
                  color: Color.fromARGB(255, 214, 195, 103)
                )
              ) 
              : const SizedBox(),
        // unconditional hover tip
        Text(
          'Hover on entries for more information.',
          style: TextStyle(
            fontSize: 12,
            color: textColourLight
          )
        ),
        // error message
        errorMsg == ''
              ? const SizedBox()
              : Text(
                errorMsg,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color.fromARGB(255, 190, 84, 77)
                )
              ),
        // number of entries found for user query
        successful
              ? Column(
                children: [
                  const SizedBox(height: 5),
                  Text(
                    'Found (${resultsFound.length}${resultsFound.length >= 10000 ? '+' : ''}) entries for \'$queryCopy\'.',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w500
                    )
                  ),
                ],
              )
              : const SizedBox()
      ],
    );
  }

  // Console text displayed on hover. Includes the following information
  // for the selected entry:
  // - category name
  // - subcategory name
  // - data type name
  // - data type description (if available)
  Column _hoverConsoleText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '--Console 【$optionTitle】', // contains category and subcategory names
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: textColourLight
          )
        ),
        const SizedBox(height: 5),
        Text(
          optionDescription,
          softWrap: true,
          style: TextStyle(
            fontSize: 12,
            color: textColourLight
          )
        ),
      ],
    );
  }

  // Icon button that selects or clears all. If one or more data types are already
  // selected visible window, shows a clear all button. Otherwise, shows a select all
  // button. Button only affects data types in the currently visible window.
  Widget _allButton() {
    // cases for select all button
    if (selectedCategory == null && selectedSubCategory == null && selectedOptions.isEmpty
          || selectedSubCategory != null && (selectedSubCategory as SubCategory).optionKeys.where((e) => selectedOptions.contains(e)).isEmpty
          || selectedCategory != null && (selectedCategory as Category).catKeys.where((e) => e.optionKeys.where((f) => selectedOptions.contains(f)).isNotEmpty).isEmpty) {
      return IconButton(
        icon: const Icon(Icons.select_all, color: Colors.black),
        tooltip: 'Select all',
        onPressed: () {
          if (selectedSubCategory != null && filter == '') {
            for (OptionKey option in (selectedSubCategory as SubCategory).optionKeys) {
              selectedOptions.add(option);
            }
          } else if (selectedCategory != null && filter == '') {
            for (SubCategory subCat in (selectedCategory as Category).catKeys) {
              for (OptionKey option in subCat.optionKeys) {
                selectedOptions.add(option);
              }
            }
          } else if (filter == '') {
            for (Category cat in cats) {
              for (SubCategory subCat in cat.catKeys) {
                for (OptionKey option in subCat.optionKeys) {
                  selectedOptions.add(option);
                }
              }
            }
          } else {
            for (OptionKey option in visibleOptions) {
              selectedOptions.add(option);
            }
          }
          errorMsg = '';
          setState(() {});
        }
      );
    }
    // cases for clear all button
    return IconButton(
      icon: const Icon(Icons.deselect, color: Colors.black),
      tooltip: 'Clear all',
      onPressed: () {
        if (selectedSubCategory != null && filter == '') {
          for (OptionKey option in (selectedSubCategory as SubCategory).optionKeys) {
            selectedOptions.remove(option);
          }
        } else if (selectedCategory != null && filter == '') {
          for (SubCategory subCat in (selectedCategory as Category).catKeys) {
            for (OptionKey option in subCat.optionKeys) {
              selectedOptions.remove(option);
            }
          }
        } else if (filter == '') {
          selectedOptions.clear();
        } else {
          for (OptionKey option in visibleOptions) {
            selectedOptions.remove(option);
          }
        }
        errorMsg = '';
        setState(() {});
      }
    );
  }

  // Builds dynamic column of filter buttons within main panel. Displays
  // only category buttons by default, and displays dropdown-type list of
  // subcategories upon selecting a category.
  Widget _buildFilterButtons() {
    List<Widget> filters = [];
    for (Category cat in cats) {
      filters.add(
        CoarseFilterButton(
          category: cat,
          onTap: filterOnTap(cat),
          selected: cat == selectedCategory,
          color: darkColour2,
          hoverColor: darkColour1,
          selectColor: accentColourDark,
        )
      );
      if (selectedCategory == cat) {
        for (SubCategory subCat in cat.catKeys) {
          filters.add(
            FineFilterButton(
              subCat: subCat, 
              onTap: subFilterOnTap(subCat), 
              selected: subCat == selectedSubCategory,
              color: buttonColourLight,
              hoverColor: buttonColourHover,
              selectColor: accentColourLight,
            ),
          );
        }
      }
    }
    return Container(
      width: 290,
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: filters
      ),
    );
  }

  // Filters visible data types to only be those within
  // the provided category `cat`.
  void Function() filterOnTap(Category cat) {
    return () => setState(() {
      if (selectedCategory == cat) {
        selectedCategory = null;
        selectedSubCategory = null;
      } else {
        selectedCategory = cat;
        selectedSubCategory = null;
      }
      _onFilterUpdate();
    });
  }

  // Filters visible data types to only be those within
  // the provided subcategory `subCat`.
  void Function() subFilterOnTap(SubCategory subCat) {
    return () => setState(() {
      if (selectedSubCategory == subCat) {
        selectedSubCategory = null;
      } else {
        selectedSubCategory = subCat;
        visibleOptions = [];
      }
      _onFilterUpdate();
    });
  }

  // Filters data types list in main panel based on user selected subcategory and category,
  // and on user inputted search bar.
  Widget _getOptions() {
    List<Widget> options = []; // list of data type selectors to return
    if (filter != '') { // case where search bar has input
      if (visibleOptions.isEmpty) { // case where no data types match user's search bar input
        options = [const Center(
          child: Text(
            'No matches.',
            style: TextStyle(fontSize: 12)
          )
        )];
      } else { // case where data type matches are found for user's search bar input
        options = [
          _buildFilterOptions(Category.struct),
          _buildFilterOptions(Category.poly),
          _buildFilterOptions(Category.assem),
          _buildFilterOptions(Category.nonpoly),
          _buildFilterOptions(Category.oligo),
        ].expand((e) => e).toList();
      }
    } else if (selectedSubCategory != null) { // case where user selected a subcategory
      options.add(
        Container(
          padding: const EdgeInsets.only(left: 10, top: 2, bottom: 3),
          width: 350,
          decoration: BoxDecoration(
            color: darkColour2
          ),
          child: Text(
            (selectedSubCategory as SubCategory).superCat,
            style: TextStyle(
              color: textColourLight,
              fontWeight: FontWeight.w600,
            ),
          )
        )
      );
      options.addAll(_buildSubOptions(selectedSubCategory as SubCategory));
    } else if (selectedCategory != null) { // case where user selected a category
      options = _buildOptions(selectedCategory as Category);
    } else { // default case
      options = [
        _buildFavs(),
        _buildOptions(Category.struct),
        _buildOptions(Category.poly),
        _buildOptions(Category.assem),
        _buildOptions(Category.nonpoly),
        _buildOptions(Category.oligo),
      ].expand((e) => e).toList();
    }
    // returning scrolling widget of options
    return Container(
      height: 524,
      width: 390,
      padding: const EdgeInsets.all(15.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: options,
        )
      ),
    );
  }

  // List of favourite data types to display in default view.
  List<Widget> _buildFavs() {
    if (favs == null) {
      return [];
    }
    favs?.sort((a, b) => a.compareTo(b));
    List<Widget> title = [
      Container(
        padding: const EdgeInsets.only(left: 10, top: 2, bottom: 3),
        width: 350,
        decoration: BoxDecoration(
          color: accentColourDark
        ),
        child: Row(
          children: [
            Icon(Icons.star_rounded, color: textColourLight, size: 18),
            const SizedBox(width: 5),
            Text(
              'Favourites',
              style: TextStyle(
                color: textColourLight,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        )
      )
    ];
    if (favs?.isEmpty == true) {
      return title 
        + [Container(
            color: containerColourLight,
            padding: const EdgeInsets.all(2),
            child: const Center(
              child: Text(
                'No favourites.',
                style: TextStyle(fontSize: 12)
              )
            )
          )];
    }
    return title + (favs ?? []).map((e) => OptionSelector(
      selectedOptions: selectedOptions,
      favs: favs,
      option: allOptions[e],
      onTap: selectorOnTap(allOptions[e]),
      onFav: selectorOnFav(allOptions[e]),
      onEnter: selectorOnEnter(allOptions[e]),
      onExit: selectorOnExit(),
      color: containerColourLight,
      selectColor: selectionColour,
    )).toList();
  }

  // Builds data type selectors from provided category `cat`.
  List<Widget> _buildOptions(Category cat) {
    return [_buildOptionsTitle(cat)] + cat.catKeys.map((e) => _buildSubOptions(e)).toList().expand((e) => e).toList();
  }

  // Builds data type selectors from provided category `cat` and
  // search bar input.
  List<Widget> _buildFilterOptions(Category cat) {
    List<OptionKey> subs = [];
    for (OptionKey key in visibleOptions) {
      if (key.catTitle == cat.title) {
        subs.add(key);
      }
    }
    if (subs.isNotEmpty) {
      return [_buildOptionsTitle(cat)] + cat.catKeys.map((e) => _buildFilterSubOptions(e)).toList().expand((e) => e).toList();
    }
    return [const SizedBox()];
  }

  // Builds data type selector title from provided category `cat`.
  Widget _buildOptionsTitle(Category cat) {
    return Container(
      padding: const EdgeInsets.only(left: 10, top: 2, bottom: 3),
      width: 350,
      decoration: BoxDecoration(
        color: darkColour2
      ),
      child: Text(
        cat.title,
        style: TextStyle(
          color: textColourLight,
          fontWeight: FontWeight.w600,
        ),
      )
    );
  }

  // Builds data type selectors from provided subcategory `subCat`.
  List<Widget> _buildSubOptions(SubCategory subCat) {
    return [_buildSubOptionsTitle(subCat)] + subCat.optionKeys.map((e) => OptionSelector(
      selectedOptions: selectedOptions,
      favs: favs,
      option: e,
      onTap: selectorOnTap(e),
      onFav: selectorOnFav(e),
      onEnter: selectorOnEnter(e),
      onExit: selectorOnExit(),
      color: containerColourLight,
      selectColor: selectionColour,
    )).toList();
  }

  // Builds data type selectors from provided subcategory `subCat`
  // and search bar input.
  List<Widget> _buildFilterSubOptions(SubCategory subCat) {
    List<OptionKey> subs = [];
    for (OptionKey key in visibleOptions) {
      if (key.subCatTitle == subCat.title && key.catTitle == subCat.superCat) {
        subs.add(key);
      }
    }
    if (subs.isNotEmpty) {
      return [_buildSubOptionsTitle(subCat)] + subCat.optionKeys.where((e) => visibleOptions.contains(e)).map((e) => OptionSelector(
        selectedOptions: selectedOptions,
        favs: favs,
        option: e,
        onTap: selectorOnTap(e),
        onFav: selectorOnFav(e),
        onEnter: selectorOnEnter(e),
        onExit: selectorOnExit(),
        color: containerColourLight,
        selectColor: selectionColour,
      )).toList();
    }
    return [const SizedBox()];
  }

  // Builds data type selector title from provided subcategory `subCat`.
  Widget _buildSubOptionsTitle(SubCategory subCat) {
    return Container(
      padding: const EdgeInsets.only(left: 4, bottom: 2, top: 1),
      width: 350,
      decoration: BoxDecoration(
        color: buttonColourLight
      ),
      child: Text(
        subCat.title,
        style: const TextStyle(
          fontSize: 13
        )
      )
    );
  }

  void Function() selectorOnTap(OptionKey option) {
    return () => setState(() {
      if (selectedOptions.contains(option)) {
        selectedOptions.remove(option);
      } else {
        selectedOptions.add(option);
      }
      errorMsg = '';
    });
  }

  void Function() selectorOnFav(OptionKey option) {
    return () {
      if (favs != null) {
        if (favs!.contains(option.key)) {
          favs!.remove(option.key);
          listBox?.put('favs', favs!);
        } else {
          favs!.add(option.key);
          listBox?.put('favs', favs!);
        }
      } else if (favs == null) {
        favs = [option.key];
        listBox?.put('favs', favs!);
      }
      setState(() {});
    };
  }

  void Function() selectorOnEnter(OptionKey option) {
    return () => setState(() {
      optionDescription = option.description == '' 
            ? '${option.optionTitle}: No description available.' 
            : '${option.optionTitle}: ${option.description}';
      optionTitle = '${option.catTitle} | ${option.subCatTitle}';
    });
  }

  void Function() selectorOnExit() {
    return () => setState(() {
      optionDescription = '';
      optionTitle = '';
    });
  }

  // Search bar for the main panel's data type filtering.
  Widget _filterBar() {
    return Container(
      margin: const EdgeInsets.only(top: 5, bottom: 5),
      padding: const EdgeInsets.only(left: 2),
      width: 300,
      height: 32,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 0.8),
        borderRadius: const BorderRadius.all(Radius.circular(16))
      ),
      child: Row(
        children: [
          SizedBox(
            width: 296,
            child: TextField(
              enabled: !searchLock && !successful, // locks during API search and after successful query
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
              decoration: InputDecoration(
                hintText: 'Search data types...',
                hintStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                prefixIcon: const Icon(Icons.search, size: 20),
                suffixIcon: InkWell(
                  onTap: () {
                    setState(() => filterController.clear());
                  },
                  child: const Icon(Icons.clear, size: 18)
                )
              ),
            ),
          ),
        ],
      )
    );
  }

  // Method called on updates to the filter search bar. Updates what data
  // type selectors to show on the main panel.
  void _onFilterUpdate() {
    setState(() {
      filter = filterController.text.trim();
    });
    List<OptionKey> matches = [];
    if (selectedSubCategory != null) {
      for (OptionKey opt in selectedSubCategory!.optionKeys) {
          if (opt.catTitle.toLowerCase().contains(filter.toLowerCase()) || 
            opt.subCatTitle.toLowerCase().contains(filter.toLowerCase()) || 
            opt.optionTitle.toLowerCase().contains(filter.toLowerCase()) || 
            opt.name.toLowerCase() == filter.toLowerCase()) {
          matches.add(opt);
        }
      }
    } else if (selectedCategory != null) {
      for (SubCategory subCat in selectedCategory!.catKeys) {
        for (OptionKey opt in subCat.optionKeys) {
          if (opt.catTitle.toLowerCase().contains(filter.toLowerCase()) || 
              opt.subCatTitle.toLowerCase().contains(filter.toLowerCase()) || 
              opt.optionTitle.toLowerCase().contains(filter.toLowerCase()) || 
              opt.name.toLowerCase() == filter.toLowerCase()) {
            matches.add(opt);
          }
        }
      }
    } else {
      for (Category cat in cats) {
        for (SubCategory subCat in cat.catKeys) {
          for (OptionKey opt in subCat.optionKeys) {
            if (opt.catTitle.toLowerCase().contains(filter.toLowerCase()) || 
                opt.subCatTitle.toLowerCase().contains(filter.toLowerCase()) || 
                opt.optionTitle.toLowerCase().contains(filter.toLowerCase()) || 
                opt.name.toLowerCase() == filter.toLowerCase()) {
              matches.add(opt);
            }
          }
        }
      }
    }
    setState(() => visibleOptions = matches);
  }

  // Search bar to send query to RCSB PDB's API.
  Widget _searchBar() {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      padding: const EdgeInsets.only(left: 10),
      width: 350,
      height: 32,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 0.8),
        borderRadius: const BorderRadius.all(Radius.circular(16))
      ),
      child: Row(
        children: [
          SizedBox(
            width: 338,
            child: TextField(
              enabled: !searchLock && !successful, // locks during API search and after successful query
              controller: searchController,
              cursorColor: Colors.black,
              cursorWidth: 1,
              style: const TextStyle(
                fontSize: 14,
              ),
              onSubmitted: (_) => searchLock // locked when another query is being processed
                    ? null
                    : _queryApi(), // calls _queryAPI method when user presses enter
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
              decoration: InputDecoration(
                hintText: 'Send query to RCSB PDB...',
                hintStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                suffixIcon: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: accentColourLight
                  ),
                  child: IconButton( // search field search button; icon changes depending on search state
                    icon: Icon(searchLock ? Icons.downloading : successful ? Icons.download_done : Icons.search, size: 20, color: Colors.white),
                    tooltip: successful ? 'Search Again' : 'Search',
                    padding: const EdgeInsets.all(0),
                    onPressed: () => searchLock ? null : _queryApi(), // querying PDB API
                  ),
                ),
              ),
            ),
          ),
        ],
      )
    );
  }

  // Method called on user input changes to the search bar.
  void _onSearchUpdate() {
    query = searchController.text;
    errorMsg = '';
    setState(() {});
  }

  // File destination selector.
  Widget _fileDestination() {
    return Container(
      width: 420,
      height: 177,
      margin: const EdgeInsets.only(left: 15, top: 15),
      padding: const EdgeInsets.only(left: 20, top: 30),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topRight: Radius.circular(50), topLeft: Radius.circular(50))
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Destination Folder', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Row(
            children: [
              Container(
                width: 338,
                padding: const EdgeInsets.only(left: 15, right: 3, top: 5, bottom: 5),
                decoration: BoxDecoration(
                  border: Border.all(width: 0.8)
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => _openFolderExplorer(),
                      child: SizedBox(
                        width: 293,
                        child: Text(
                          destination ?? 'Select destination folder...',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: destination == null ? const Color.fromARGB(255, 112, 112, 112) : Colors.black,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 25,
                      child: GestureDetector(
                        onTap:() => setState(() {
                          destination = null;
                          errorMsg = '';
                        }),
                        child: const Icon(Icons.clear, size: 20),
                      ),
                    ),
                  ],
                )
              ),
              const SizedBox(width: 7),
              // browse folder icon button
              Transform.scale(
                scale: 0.8,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: buttonColourLight
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.folder_open,
                      color: Colors.black,
                    ),
                    tooltip: 'Browse',
                    onPressed: () => _openFolderExplorer(),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          // generate button and options; lockable
          Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _generateButton(),
                  const SizedBox(width: 15),
                  _generateOptions(),
                ],
              ),
              successful ? Container() : Container(
                color: lockColour,
                width: 370,
                height: 50,
              ),
            ],
          ),
        ]
      ),
    );
  }

  // Calls method to generate a CSV from downloaded data.
  // Locked in higher widget when no data is available.
  Widget _generateButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 7),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0)),
          fixedSize: const Size(150, 30),
          backgroundColor: buttonColourLight,
          shadowColor: Colors.black
        ),
        onPressed: () async {
          if (open) {
            await _writeToCsv();
            _openFile();
          }
          _writeToCsv();
        },
        child: const Text('Generate CSV', style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400)),
      ),
    );
  }

  // CSV generation options, including:
  // - opening the CSV file upon successful generation
  // - processing CSV file formatting to be more compact
  Widget _generateOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // open option
        GestureDetector(
          onTap: () {
            setState(() => open = !open);
          },
          child: Row(
            children: [
              Icon(
                open ? Icons.check_box : Icons.check_box_outline_blank,
                size: 20
              ),
              const SizedBox(width: 3),
              const Text(
                'Open generated file',
                style: TextStyle(
                  fontSize: 13
                )
              ),
            ],
          ),
        ),
        // process option
        GestureDetector(
          onTap: () {
            setState(() => process = !process);
          },
          child: Row(
            children: [
              Icon(
                process ? Icons.check_box : Icons.check_box_outline_blank,
                size: 20
              ),
              const SizedBox(width: 3),
              const Text(
                'Process file',
                style: TextStyle(
                  fontSize: 13
                )
              ),
            ],
          ),
        )
      ]
    );
  }

  // Opens file from current destination.
  Future<void> _openFile() async {
    try {
      await OpenFile.open('$destination\\$fileName');
    } on Exception catch (_) {
      return;
    }
  }

  // Opens file explorer (Windows)
  void _openFolderExplorer() async {
    errorMsg = '';
    setState(() {});
    try {
      final newDestination = await FilePicker.platform.getDirectoryPath();
      if (newDestination != null) {
        destination = newDestination;
      }
      setState(() {});
    } catch (_) {}
  }

  // Writes to a CSV file from current JSON object with user selected file destination.
  // Generated file name is in the format 'rcsb_pdb_custom_report_YYYYMMDDhhmmss'.
  Future<void> _writeToCsv() async {
    if (destination == null) {
      errorMsg = '► No destination directory selected.';
      setState(() {});
      return;
    }
    final DateTime now = DateTime.now();
    // naming CSV file
    setState(() => fileName = 'rcsb_pdb_custom_report_${now.year}${now.month}${now.day}${now.hour}${now.minute}${now.second}.csv');
    final IOSink sink = File('$destination\\$fileName').openWrite(encoding: utf8); // creates CSV file and opens sink
    
    sink.done.ignore();

    sink.write('sep=$delimiter\n'); // setting delimiter symbol to be final constant `delimiter`
    if (!process) {
      await _writeHeader(sink); // writing headers
    }
    await _writeCats(sink); // writing categories

    if (process) { // extra processing options
      sink.write('${delimiter}PDB Web Linker${delimiter}Download PDB File');
      if (selectedOptions.contains(OptionKey.s0o5)) {
        sink.write('${delimiter}DOI Linker${delimiter}Literature');
      }
      if (selectedOptions.contains(OptionKey.p2o18)) {
        sink.write('${delimiter}Target');
      }
    }
    sink.write('\n');

    for (int i = 0; i < resultsFound.length; i++) {
      sink.write('${resultsFound[i]}');
      if (process) { // case where processing is required
        for (OptionKey option in selectedOptions) {
          sink.write('$delimiter${option.contentP(jsonObject.all[i]) ?? ''}'.replaceAll('\n', '\\n'));
        }
        sink.write('$delimiter${resultsFound[i]}$delimiter${resultsFound[i]}.pdb');
        if (selectedOptions.contains(OptionKey.s0o5)) {
          String? doi = OptionKey.s0o5.contentP(jsonObject.all[i])?.replaceAll('\n', '\\n');
          if (doi != null) {
            sink.write('$delimiter$doi$delimiter${doi.split('/').last}.pdf');
          } else {
            sink.write('$delimiter$delimiter');
          }
        }
        if (selectedOptions.contains(OptionKey.p2o18)) {
          sink.write('$delimiter${_getTarget(OptionKey.p2o18.contentP(jsonObject.all[i]))}'.replaceAll('\n', '\\n'));
        }
        sink.write('\n');
      } else { // case where processing option not selected
        int maxLength = 0; // maximum rows required for this entry
        for (OptionKey option in selectedOptions) {
          if (option.needSpan()) {
            List? list = option.contentW(jsonObject.all[i]);
            if (list == null) {
              sink.write(delimiter);
            } else {
              if (list.length > maxLength) {
                maxLength = list.length; // update maximum rows when relevant on first pass
              }
              sink.write('$delimiter${list[0]}'.replaceAll('\n', '\\n'));
            }
          } else {
            sink.write('$delimiter${option.contentW(jsonObject.all[i]) ?? ''}'.replaceAll('\n', '\\n'));
          }
        }
        sink.write('\n');
        // writing additional rows
        for (int j = 1; j < maxLength; j++) {
          for (OptionKey option in selectedOptions) {
            if (option.needSpan()) {
              List? list = option.contentW(jsonObject.all[i]);
              if (list == null || list.length <= j) {
                sink.write(delimiter);
              } else {
                sink.write('$delimiter${list[j]}'.replaceAll('\n', '\\n'));
              }
            } else {
              sink.write(delimiter);
            }
          }
          sink.write('\n');
        }
      }
    }

    try {
      await sink.flush();
      await sink.close();
    } on FileSystemException catch (e) {
      errorMsg = 'Error: Unable to write a new CSV file: $e'; // CSV generation fail state
      setState(() {});
      return;
    }
  }

  // Writes headers to the provided `sink` based 
  // on user selected data types.
  Future<void> _writeHeader(IOSink sink) async {
    int numSD = 0;
    int numPED = 0;
    int numAD = 0;
    int numNPED = 0;
    int numOD = 0;

    for (OptionKey key in selectedOptions) {
      switch (key.catTitle) {
        case 'Structure Data': numSD++;
        case 'Polymer Entity Data': numPED++;
        case 'Assembly Data': numAD++;
        case 'Non-Polymer Entity Data': numNPED++;
        case 'Oligosaccharide Data': numOD++;
      }
    }

    sink.write('Identifier');
    await _writeHeaderHelper(sink, 'Structure Data', numSD);
    await _writeHeaderHelper(sink, 'Polymer Entity Data', numPED);
    await _writeHeaderHelper(sink, 'Assembly Data', numAD);
    await _writeHeaderHelper(sink, 'Non-Polymer Entity Data', numNPED);
    await _writeHeaderHelper(sink, 'Oligosaccharide Data', numOD);
    sink.write('\n');
  }

  // Helper method; writes header and spacers to the provided
  // `sink` for the provided header `title` and `spacerCount`.
  Future<void> _writeHeaderHelper(IOSink sink, String title, int spacerCount) async {
    if (spacerCount != 0) {
      sink.write('$delimiter$title');
      for (int i = 1; i < spacerCount; i++) {
        sink.write(delimiter);
      }
    }
  }

  // Writes categories to the provided `sink` based
  // on user selected data types.
  Future<void> _writeCats(IOSink sink) async {
    sink.write('Entry ID');
    selectedOptions.sort((a, b) => a.key.compareTo(b.key));
    for (OptionKey key in selectedOptions) {
      sink.write('$delimiter${key.optionTitle}');
    }
  }

  // Gets targets from stored Hive box and finds corresponding
  // target of provided accession code if present.
  String _getTarget(String code) {
    Map<String, String>? targets = mapBox?.get('targets')?.cast<String, String>();
    if (targets != null) {
      return targets[code] ?? '';
    }
    return '';
  }

  // Queries RCSB PDB's search and data APIs from user's search query input.
  void _queryApi() async {
    if (searchLock) { // ends if lock is not unlocked
      return;
    }

    final List<OptionKey> sortedOptions = List.from(selectedOptions); // list copy of user selected data types
    sortedOptions.sort((a, b) => a.key.compareTo(b.key)); // sorting list copy
    
    searchLock = true; // locks searchLock
    successful = false; // resets successful status
    queryCopy = query; // creates image of user query (unnecessary in current implementation)
    setState(() {});

    if (query == '') { // ends and releases lock if empty query
      errorMsg = '► Please provide a query.';
      searchLock = false;
      setState(() {});
      return;
    } else if (selectedOptions.isEmpty) { // ends and releases lock if no data types selected; redundant check (should be impossible)
      searchLock = false;
      return;
    }

    var client = http.Client();
    JsonWObject parsedObj; // initialising JSON object
    // querying search API
    try {
      final searchUrl = 'https://search.rcsb.org/rcsbsearch/v2/query?json=%7B"query":%7B"type":"terminal"%2C"label":"full_text"%2C"service":"full_text"%2C"parameters":%7B"value":"$query"%7D%7D%2C"return_type":"entry"%2C"request_options":%7B"paginate":%7B"rows":10000%2C"start":0%7D%2C"results_verbosity":"compact"%2C"results_content_type":%5B"experimental"%5D%2C"sort":%5B%7B"sort_by":"score"%2C"direction":"desc"%7D%5D%2C"scoring_strategy":"combined"%7D%7D';
      final searchResponse = await client.get(Uri.parse(searchUrl)); // response
      final Map<String, dynamic> searchParsed = jsonDecode(searchResponse.body); // decoding JSON
      
      // retrieving entry results
      final List<String>? resultSet = (searchParsed['result_set'] as List?)?.map((e) => '$e').toList();
      setState(() {
        resultsFound.clear();
        resultsFound.addAll(resultSet as List);
      });

      if (resultSet == null) {
        // do nothing
      } else {
        final resultSetString = resultSet.asString();
        // querying data API from retrieved responses and options
        try {
          String entrySet = resultSetString.substring(1, resultSetString.length - 1);

          List<String> optionAddresses = sortedOptions.map((e) => e.address).toList(); // getting options formatted as URL String
          String optionUrl = '';
          for (String option in optionAddresses) { // generating options portion of URL
            optionUrl = '$optionUrl$option';
          }
          
          final String dataUrl = 'https://data.rcsb.org/graphql?query=%7Bentries(entry_ids:%5B$entrySet%5D)%7Brcsb_id$optionUrl%7D%7D';
          final dataResponse = await client.get(Uri.parse(dataUrl));
          final jsonString = jsonDecode(dataResponse.body); // decoding JSON
          List entries = jsonString['data']?['entries']; // lightly parsing JSON
          parsedObj = JsonWObject.initializeFromJson(jsonEncode(entries)); // creating JSON object from resulting String
          
          setState(() {
            jsonObject = parsedObj;
            successful = true;
          });
        } catch (e) {
          errorMsg = '► Failed to query. Server may not have responded in time.\n► Your query was: \'$queryCopy\''; // case: failed to query data API
          setState(() {});
          throw Exception('failed to query: $e');
        } finally {
          setState(() => searchLock = false);
          client.close();
        }
      }
    } catch (e) {
      if (errorMsg == '') {
        errorMsg = '► No results. Please check that your query is correct.\n► Your query was: \'$queryCopy\'.'; // case: failed to query search API
      }
      searchLock = false;
      setState(() {});
      client.close();
    }
    return;
  }
}

// String extensions: additional self-described methods for List<String>'s
extension StringExtensions on List<String> {
  // Returns a String representation of a List of Strings
  // where each element is wrapped in double quotes `"` and
  // without square brackets, seperated by commas with no space.
  // (e.g. ['hello', 'world'] becomes the String '"hello","world"')
  String asString() {
    String toReturn = '"';
    for (String entry in this) {
      toReturn = '$toReturn"$entry",';
    }
    return toReturn.substring(0, toReturn.length);
  }
}

// This class represents a coarse filter button (category dropdown button)
// on this view's main panel.
class CoarseFilterButton extends StatefulWidget {
  final Category category;
  final VoidCallback onTap;
  final bool selected;
  final Color color;
  final Color selectColor;
  final Color hoverColor;

  const CoarseFilterButton({
    super.key, 
    required this.category, 
    required this.onTap, 
    required this.selected, 
    this.color = Colors.white, 
    this.selectColor = Colors.black, 
    this.hoverColor = Colors.grey,
  });

  @override
  CoarseFilterButtonState createState() => CoarseFilterButtonState();  
}

class CoarseFilterButtonState extends State<CoarseFilterButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      onHover: (hovering) {
        setState(() => _isHovering = hovering);
      },
      child: Container(
        width: 300,
        margin: const EdgeInsets.only(bottom: 1),
        padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
        decoration: BoxDecoration(
          color: widget.selected 
                ? widget.selectColor
                : _isHovering 
                      ? widget.hoverColor 
                      : widget.color
        ),
        child: Row(
          children: [
            Text(
              widget.category.title,
              style: TextStyle(
                color: const Color.fromARGB(220, 255, 255, 255),
                fontWeight: widget.selected ? FontWeight.w600 : FontWeight.normal
              )
            ),
            const Spacer(),
            Icon(
              widget.selected 
                    ? Icons.keyboard_arrow_down 
                    : Icons.chevron_right,
              color: const Color.fromARGB(220, 255, 255, 255),
              size: 17
            ),
            const SizedBox(width: 5),
          ],
        )
      ),
    );
  }
}

// This class represents a coarse filter button (subcategory button)
// on this view's main panel.
class FineFilterButton extends StatefulWidget {
  final SubCategory subCat;
  final VoidCallback onTap;
  final bool selected;
  final Color color;
  final Color selectColor;
  final Color hoverColor;

  const FineFilterButton({
    super.key, 
    required this.subCat, 
    required this.onTap, 
    required this.selected, 
    this.color = Colors.white, 
    this.selectColor = Colors.black, 
    this.hoverColor = Colors.grey,
  });

  @override
  FineFilterButtonState createState() => FineFilterButtonState();  
}

class FineFilterButtonState extends State<FineFilterButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      onHover: (hovering) {
        setState(() => _isHovering = hovering);
      },
      child: Container(
        width: 300,
        margin: const EdgeInsets.only(bottom: 1),
        padding: const EdgeInsets.only(left: 20, top: 2, bottom: 2),
        decoration: BoxDecoration(
          color: widget.selected 
                ? widget.selectColor
                : _isHovering 
                      ? widget.hoverColor 
                      : widget.color
        ),
        child: Row(
          children: [
            Text(
              widget.subCat.title,
              style: TextStyle(
                color: widget.selected ? 
                      const Color.fromARGB(220, 255, 255, 255) 
                      : Colors.black,
                fontWeight: FontWeight.normal,
                fontSize: 13,
              )
            ),
            const Spacer(),
            Icon(
              widget.selected
                    ? Icons.clear
                    : Icons.chevron_right, 
              color: widget.selected 
                    ? const Color.fromARGB(220, 255, 255, 255) 
                    : Colors.black,
              size: 17
            ),
            const SizedBox(width: 5),
          ],
        )
      ),
    );
  }
}

// Builds selector widget for the main panel 
// from the provided data type `option`.
class OptionSelector extends StatefulWidget {
  final OptionKey option;
  final List<OptionKey> selectedOptions;
  final List<int>? favs;
  final VoidCallback onTap;
  final VoidCallback onFav;
  final VoidCallback onEnter;
  final VoidCallback onExit;
  final Color color;
  final Color selectColor;
  final Color hoverColor;

  const OptionSelector({
    super.key, 
    required this.option,
    required this.selectedOptions,
    required this.favs,
    required this.onTap,
    required this.onFav,
    required this.onEnter,
    required this.onExit,
    this.color = Colors.white, 
    this.selectColor = Colors.black, 
    this.hoverColor = Colors.grey,
  });

  @override
  OptionSelectorState createState() => OptionSelectorState();  
}

class OptionSelectorState extends State<OptionSelector> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      child: Column(
        children: [
          const Divider(height: 0),
          Container(
            color: widget.color,
            // on-tap handling
            child: MouseRegion(
              // display description on enter
              onEnter: (_) {
                widget.onEnter();
                setState(() => _isHovering = true);
              },
              // reset on exit
              onExit: (_) {
                widget.onExit();
                setState(() => _isHovering = false);
              },
              child: Row(
                children: [
                  InkWell(
                    onTap: widget.onTap,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 2, bottom: 3, top: 3, right: 4),
                          child: Icon( // dynamic check-box icon
                            widget.selectedOptions.contains(widget.option) 
                                  ? Icons.check_box 
                                  : Icons.check_box_outline_blank,
                            size: 15,
                            color: widget.selectedOptions.contains(widget.option)
                                  ? widget.selectColor
                                  : Colors.black
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 1, bottom: 2),
                          child: SizedBox(
                            width: 309,
                            child: Text(
                              widget.option.optionTitle,
                              style: const TextStyle(fontSize: 12),
                              softWrap: true,
                            ),
                          ),
                        )
                      ]
                    ),
                  ),
                  _isHovering || widget.favs?.contains(widget.option.key) == true ? _favsButton(widget.option) : const SizedBox()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  InkWell _favsButton(OptionKey option) {
    return InkWell(
      onTap: () {},
      child: GestureDetector(
        onTap: widget.onFav,
        child: Icon(
          widget.favs?.contains(option.key) == true
            ? Icons.star_rounded
            : Icons.star_border_rounded,
          color: widget.favs?.contains(option.key) == true
            ? const Color.fromARGB(255, 220, 201, 27)
            : Colors.black,
          size: 16
        ),
      )
    );
  }
}