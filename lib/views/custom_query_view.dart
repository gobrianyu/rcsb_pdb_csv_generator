// import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  final TextEditingController searchController = TextEditingController();
  final TextEditingController filterController = TextEditingController();
  String? destination;
  String fileName = '';
  List<OptionKey> visibleOptions = [];
  Category? selectedCategory;
  SubCategory? selectedSubCategory;
  List<OptionKey> selectedOptions = [];
  bool searchLock = false;
  bool successful = false;
  bool open = false;
  bool process = false;
  String query = '';
  String queryCopy = '';
  String description = '';
  String descriptionTitle = '';
  String error = '';
  List resultsFound = [];
  late JsonWObject jsonObject;

  final List<OptionKey> favourites = [OptionKey.s0o5, OptionKey.s1o1, OptionKey.s1o3, OptionKey.s2o15,  OptionKey.p2o18, OptionKey.n1o2, OptionKey.n1o6];
  
  final Color bgColor = const Color.fromARGB(255, 56, 92, 121);
  final Color darkColor1 = const Color.fromARGB(255, 106, 106, 106);
  final Color darkColor2 = const Color.fromARGB(255, 64, 64, 64);
  final Color accentColorDark = const Color.fromARGB(255, 59, 91, 75);
  final Color accentColorLight = const Color.fromARGB(255, 85, 137, 110);
  final Color buttonColorHover = const Color.fromARGB(255, 185, 190, 205);
  final Color buttonColorLight = const Color.fromARGB(255, 182, 186, 201);
  final Color textColorLight = const Color.fromARGB(220, 255, 255, 255);
  final Color containerColorLight = const Color.fromARGB(255, 250, 250, 250);
  final Color selectionColor = const Color.fromARGB(255, 32, 107, 168);
  final List<Category> cats = [Category.struct, Category.poly, Category.assem, Category.nonpoly, Category.oligo];

  @override
  void initState() {
    super.initState();
    searchController.addListener(_onSearchUpdate);
    filterController.addListener(_onFilterUpdate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 620,
                width: 720,
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.only(left: 50, right: 20, top: 40, bottom: 48),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(50))
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      height: 40,
                      child: Row(
                        children: [
                          const Text(
                            'Create Custom Tabular Report',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500
                            )
                          ),
                          Spacer(),
                          _filterBar(),
                          Spacer(),
                          Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              _allButton(),
                              searchLock || successful ? Container(height: 50, width: 50, color: const Color.fromARGB(155, 255, 255, 255)) : const SizedBox()
                            ],
                          )
                        ]
                      ),
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildFilter(),
                            _getOptions(),
                          ],
                        ),
                        searchLock || successful ? Container(height: 520, width: 670, color: const Color.fromARGB(155, 255, 255, 255)) : const SizedBox(),
                        searchLock ? CircularProgressIndicator(color: accentColorLight, strokeWidth: 6,) : SizedBox(),
                        successful
                              ? Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: accentColorLight
                                ),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.refresh,
                                    size: 40,
                                    color: textColorLight,
                                  ),
                                  tooltip: 'Reset',
                                  onPressed: () => setState(() => successful = false),
                                ),
                              ) 
                              : SizedBox()
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _filterLive(),
                  _fileDestination(),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _filterLive() {
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
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Selected Data Types'),
              Stack(
                alignment: AlignmentDirectional.topCenter,
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.only(bottom: 95),
                    color: containerColorLight,
                    height: 300,
                    width: 370,
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(top: BorderSide())
                      ),
                      height: 200,
                      width: 370,
                      child: selectedOptions.isEmpty 
                      ? const Center(
                        child: Text('Nothing to show.', style: TextStyle(fontSize: 12)),
                      )
                      : SingleChildScrollView(
                        child: Column(
                          children: selectedOptions.map((e) => _liveTile(e)).toList()
                        )
                      ),
                    ),
                  ),
                  successful || searchLock ? Container(height: 300, width: 500, color: const Color.fromARGB(155, 255, 255, 255)) : const SizedBox()
                ],
              ),
            ],
          ),
          Column(
            children: [
              const SizedBox(height: 225),
              _consoleText(),
              _searchBar(),
            ],
          )
        ],
      )
    );
  }

  Widget _consoleText() {
    return Container(
      width: 380,
      height: 130,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
      decoration: BoxDecoration(
        color: darkColor2,
        border: Border.all(color: darkColor1, width: 2),
        borderRadius: const BorderRadius.all(Radius.circular(28))
      ),
      child: description == '' 
            ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '--Console',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: textColorLight
                  )
                ),
                const SizedBox(height: 5),
                Text(
                  'Data types selected: (${selectedOptions.length})',
                  style: TextStyle(
                    fontSize: 12,
                    color: textColorLight
                  )
                ),
                selectedOptions.isEmpty 
                      ? const Text(
                        '► Ensure that at least 1 data type is selected before querying.',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color.fromARGB(255, 214, 195, 103)
                        )
                      ) 
                      : Container(),
                Text(
                  'Hover on entries for more information.',
                  style: TextStyle(
                    fontSize: 12,
                    color: textColorLight
                  )
                ),
                error == ''
                      ? Container()
                      : Text(
                        error,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color.fromARGB(255, 190, 84, 77)
                        )
                      ),
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
            )
            : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '--Console 【$descriptionTitle】',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: textColorLight
                  )
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 12,
                    color: textColorLight
                  )
                ),
              ],
            )
    );
  }

  Widget _liveTile(OptionKey option) {
    return Column(
      children: [
        Container(
          color: containerColorLight,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 3, bottom: 3),
                child: MouseRegion(
                  onEnter: (_) {
                    setState(() {
                      description = option.description == '' ? '${option.optionTitle}: No description available.' : '${option.optionTitle}: ${option.description}';
                      descriptionTitle = '${option.catTitle} | ${option.subCatTitle}';
                    });
                  },
                  onExit: (_) {
                    setState(() {
                      description = '';
                      descriptionTitle = '';
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
              GestureDetector(
                child: const Icon(
                  Icons.clear,
                  size: 15,
                  color: Colors.black
                ),
                onTap: () => setState(() {
                  if (selectedOptions.contains(option)) {
                    selectedOptions.remove(option);
                  } else {
                    selectedOptions.add(option);
                  }
                  error = '';
                }),
              ),
            ]
          ),
        ),
        const Divider(height: 0, color: Color.fromARGB(255, 230, 230, 230))
      ]
    );
  }

  Widget _allButton() {
    if (selectedCategory == null && selectedSubCategory == null && selectedOptions.isEmpty
          || selectedSubCategory != null && (selectedSubCategory as SubCategory).optionKeys.where((e) => selectedOptions.contains(e)).isEmpty
          || selectedCategory != null && (selectedCategory as Category).catKeys.where((e) => e.optionKeys.where((f) => selectedOptions.contains(f)).isNotEmpty).isEmpty) {
      return IconButton(
        icon: const Icon(Icons.select_all, color: Colors.black),
        tooltip: 'Select all',
        onPressed: () {
          if (selectedSubCategory != null) {
            for (OptionKey option in (selectedSubCategory as SubCategory).optionKeys) {
              selectedOptions.add(option);
            }
          } else if (selectedCategory != null) {
            for (SubCategory subCat in (selectedCategory as Category).catKeys) {
              for (OptionKey option in subCat.optionKeys) {
                selectedOptions.add(option);
              }
            }
          } else {
            for (Category cat in cats) {
              for (SubCategory subCat in cat.catKeys) {
                for (OptionKey option in subCat.optionKeys) {
                  selectedOptions.add(option);
                }
              }
            }
          }
          error = '';
          setState(() {});
        }
      );
    }
    return IconButton(
      icon: const Icon(Icons.deselect, color: Colors.black),
      tooltip: 'Clear all',
      onPressed: () {
        if (selectedSubCategory != null) {
          for (OptionKey option in (selectedSubCategory as SubCategory).optionKeys) {
            selectedOptions.remove(option);
          }
        } else if (selectedCategory != null) {
          for (SubCategory subCat in (selectedCategory as Category).catKeys) {
            for (OptionKey option in subCat.optionKeys) {
              selectedOptions.remove(option);
            }
          }
        } else {
          selectedOptions.clear();
        }
        error = '';
        setState(() {});
      }
    );
  }

  Widget _buildFilter() {
    List<Category> categories = [Category.struct, Category.poly, Category.assem, Category.nonpoly, Category.oligo];
    List<Widget> filters = [];

    for (Category cat in categories) {
      filters.add(
        CoarseFilterButton(
          category: cat,
          onTap: filterOnTap(cat),
          selected: cat == selectedCategory,
          color: darkColor2,
          hoverColor: darkColor1,
          selectColor: accentColorDark,
        )
      );
      if (selectedCategory == cat) {
        for (SubCategory subCat in cat.catKeys) {
          filters.add(
            FineFilterButton(
              subCat: subCat, 
              onTap: subFilterOnTap(subCat), 
              selected: subCat == selectedSubCategory,
              color: buttonColorLight,
              hoverColor: buttonColorHover,
              selectColor: accentColorLight,
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

  void Function() filterOnTap(Category category) {
    return () => setState(() {
      if (selectedCategory == category) {
        selectedCategory = null;
        selectedSubCategory = null;
      } else {
        selectedCategory = category;
        selectedSubCategory = null;
        visibleOptions = [];
      }
    });
  }

  void Function() subFilterOnTap(SubCategory subCat) {
    return () => setState(() {
      if (selectedSubCategory == subCat) {
        selectedSubCategory = null;
      } else {
        selectedSubCategory = subCat;
        visibleOptions = [];
      }
    });
  }

  Widget _getOptions() {
    List<Widget> options = [];
    // TODO: if (visibleOptions.isNotEmpty) {
      
    // } else 
    if (selectedSubCategory != null) {
      options.add(
        Container(
          padding: const EdgeInsets.only(left: 10, top: 2, bottom: 3),
          width: 350,
          decoration: BoxDecoration(
            color: darkColor2
          ),
          child: Text(
            (selectedSubCategory as SubCategory).superCat,
            style: TextStyle(
              color: textColorLight,
              fontWeight: FontWeight.w600,
            ),
          )
        )
      );
      options.addAll(_buildOptionsSub(selectedSubCategory as SubCategory));
    } else if (selectedCategory != null) {
      options = _buildOptions(selectedCategory as Category);
    } else {
      options = [
        _buildFavs(),
        _buildOptions(Category.struct),
        _buildOptions(Category.poly),
        _buildOptions(Category.assem),
        _buildOptions(Category.nonpoly),
        _buildOptions(Category.oligo),
      ].expand((e) => e).toList();
    }
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

  List<Widget> _buildFavs() {
    favourites.sort((a, b) => a.key.compareTo(b.key));
    List<Widget> title = [
      Container(
        padding: const EdgeInsets.only(left: 10, top: 2, bottom: 3),
        width: 350,
        decoration: BoxDecoration(
          color: accentColorDark
        ),
        child: Row(
          children: [
            Icon(Icons.star_rounded, color: textColorLight, size: 18),
            const SizedBox(width: 5),
            Text(
              'Favourites',
              style: TextStyle(
                color: textColorLight,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        )
      )
    ];
    return title + favourites.map((e) => _optionSelector(e)).toList();
  }

  List<Widget> _buildOptions(Category cat) {
    List<Widget> full = [
      Container(
        padding: const EdgeInsets.only(left: 10, top: 2, bottom: 3),
        width: 350,
        decoration: BoxDecoration(
          color: darkColor2
        ),
        child: Text(
          cat.title,
          style: TextStyle(
            color: textColorLight,
            fontWeight: FontWeight.w600,
          ),
        )
      )
    ];
    return full + cat.catKeys.map((e) => _buildOptionsSub(e)).toList().expand((e) => e).toList();
  }

  List<Widget> _buildOptionsSub(SubCategory subCat) {
    List<Widget> full = [
      Container(
        padding: const EdgeInsets.only(left: 4, bottom: 2, top: 1),
        width: 350,
        decoration: BoxDecoration(
          color: buttonColorLight
        ),
        child: Text(
          subCat.title,
          style: const TextStyle(
            fontSize: 13
          )
        )
      )
    ];
    return full + subCat.optionKeys.map((e) => _optionSelector(e)).toList();
  }

  Widget _optionSelector(OptionKey option) {
    return SizedBox(
      width: 350,
      child: Column(
        children: [
          const Divider(height: 0),
          Container(
            color: containerColorLight,
            child: GestureDetector(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 2, bottom: 3, top: 3, right: 4),
                    child: Icon(
                      selectedOptions.contains(option) 
                            ? Icons.check_box 
                            : Icons.check_box_outline_blank,
                      size: 15,
                      color: selectedOptions.contains(option)
                            ? selectionColor
                            : Colors.black
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 1, bottom: 2),
                    child: SizedBox(
                      width: 329,
                      child: Text(
                        option.optionTitle,
                        style: const TextStyle(fontSize: 12),
                        softWrap: true,
                      ),
                    ),
                  )
                ]
              ),
              onTap: () => setState(() {
                if (selectedOptions.contains(option)) {
                  selectedOptions.remove(option);
                } else {
                  selectedOptions.add(option);
                }
                error = '';
              }),
            ),
          ),
        ],
      ),
    );
  }

  void _onFilterUpdate() {
    String filter = filterController.text;
    List<Category> cats = [Category.struct, Category.poly, Category.assem, Category.nonpoly, Category.oligo];
    List<OptionKey> matches = [];
    for (Category cat in cats) {
      for (SubCategory subCat in cat.catKeys) {
        for (OptionKey opt in subCat.optionKeys) {
          if (opt.catTitle.contains(filter) || opt.subCatTitle.contains(filter) || opt.optionTitle.contains(filter) || opt.name == filter) {
            matches.add(opt);
          }
        }
      }
    }
    setState(() => visibleOptions = matches);
  }

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
            width: 288,
            child: TextField(
              enabled: !searchLock && !successful,
              controller: filterController,
              cursorColor: Colors.black,
              cursorWidth: 1,
              style: const TextStyle(
                fontSize: 14,
              ),
              contextMenuBuilder: (BuildContext context, EditableTextState editableTextState) {
                return AdaptiveTextSelectionToolbar(
                  anchors: editableTextState.contextMenuAnchors,
                  // Build the default buttons, but make them look custom.
                  // In a real project you may want to build different
                  // buttons depending on the platform.
                  children: editableTextState.contextMenuButtonItems
                      .map((ContextMenuButtonItem buttonItem) {
                    return CupertinoButton(
                      minSize: 25,
                      borderRadius: null,
                      color: containerColorLight,
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
                hintText: 'Search data types...',
                hintStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 5),
                prefixIcon: Icon(Icons.search, size: 20)
              ),
            ),
          ),
        ],
      )
    );
  }

  void _onSearchUpdate() {
    query = searchController.text;
    error = '';
    setState(() {});
  }

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
              enabled: !searchLock && !successful,
              controller: searchController,
              cursorColor: Colors.black,
              cursorWidth: 1,
              style: const TextStyle(
                fontSize: 14,
              ),
              onSubmitted: (_) => searchLock ? null : _queryApi(),
              contextMenuBuilder: (BuildContext context, EditableTextState editableTextState) {
                return AdaptiveTextSelectionToolbar(
                  anchors: editableTextState.contextMenuAnchors,
                  // Build the default buttons, but make them look custom.
                  // In a real project you may want to build different
                  // buttons depending on the platform.
                  children: editableTextState.contextMenuButtonItems
                      .map((ContextMenuButtonItem buttonItem) {
                    return CupertinoButton(
                      minSize: 25,
                      borderRadius: null,
                      color: containerColorLight,
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
                    color: accentColorLight
                  ),
                  child: IconButton( // search field search button.
                    icon: Icon(searchLock ? Icons.downloading : successful ? Icons.download_done : Icons.search, size: 20, color: Colors.white),
                    tooltip: successful ? 'Search Again' : 'Search',
                    padding: const EdgeInsets.all(0),
                    onPressed: () => searchLock ? null : _queryApi(), // querying db api
                  ),
                ),
              ),
            ),
          ),
        ],
      )
    );
  }

  Widget _generateButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 7),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0)),
          fixedSize: const Size(150, 30),
          backgroundColor: buttonColorLight,
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

  Widget _generateOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
              SizedBox(width: 3),
              Text(
                'Open generated file',
                style: TextStyle(
                  fontSize: 13
                )
              ),
            ],
          ),
        ),
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
              SizedBox(width: 3),
              Text(
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

  Widget _generateAndOpenButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 7),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0)),
          fixedSize: const Size(180, 30),
          backgroundColor: const Color.fromARGB(255, 182, 186, 201),
          shadowColor: Colors.black
        ),
        onPressed: () async {
          await _writeToCsv();
           _openFile();
        },
        child: const Text('Generate and Open', style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400)),
      ),
    );
  }

  Future<void> _openFile() async {
    try {
      await OpenFile.open('$destination\\$fileName');
    } on Exception catch (_) {
      return;
    }
  }

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
                          error = '';
                        }),
                        child: const Icon(Icons.clear, size: 20),
                      ),
                    ),
                  ],
                )
              ),
              const SizedBox(width: 7),
              Transform.scale(
                scale: 0.8,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: buttonColorLight
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
                color: const Color.fromARGB(155, 255, 255, 255),
                width: 370,
                height: 50,
              ),
            ],
          ),
        ]
      ),
    );
  }

  void _openFolderExplorer() async {
    error = '';
    setState(() {});
    try {
      final newDestination = await FilePicker.platform.getDirectoryPath();
      if (newDestination != null) {
        destination = newDestination;
      }
      setState(() {});
    } catch (_) {}
  }

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

  Future<void> _writeHeaderHelper(IOSink sink, String title, int spacerCount) async {
    if (spacerCount != 0) {
      sink.write('|$title');
      for (int i = 1; i < spacerCount; i++) {
        sink.write('|');
      }
    }
  }

  Future<void> _writeCats(IOSink sink) async {
    sink.write('Entry ID');
    selectedOptions.sort((a, b) => a.key.compareTo(b.key));
    for (OptionKey key in selectedOptions) {
      sink.write('|${key.optionTitle}');
    }
  }

  // Writes to a CSV file from provided `jsonData` with a provided file name and address `fileAddress`.
  // Parameters:
  // - jsonData: JSON object data to write to the CSV file
  // - fileAddress: file address name of new CSV file (without .csv extension; this is added by the method) 
  Future<void> _writeToCsv() async {
    if (destination == null) {
      error = '► No destination directory selected.';
      setState(() {});
      return;
    }

    final DateTime now = DateTime.now();
    setState(() => fileName = 'rcsb_pdb_custom_report_${now.year}${now.month}${now.day}${now.hour}${now.minute}${now.second}.csv');
    final IOSink sink = File('$destination\\$fileName').openWrite(encoding: utf8); // creates CSV file and opens sink
    
    sink.done.ignore();

    sink.write('sep=|\n');
    if (!process) {
      await _writeHeader(sink);
    }
    await _writeCats(sink);

    if (process) {
      sink.write('|PDB Web Linker|Download PDB File');
      if (selectedOptions.contains(OptionKey.s0o5)) {
        sink.write('|DOI Linker|Literature');
      }
      if (selectedOptions.contains(OptionKey.p2o18)) {
        sink.write('|Target');
      }
    }

    sink.write('\n');

    for (int i = 0; i < resultsFound.length; i++) {
      sink.write('${resultsFound[i]}');
      if (process) {
        for (OptionKey option in selectedOptions) {
          sink.write('|${option.contentP(jsonObject.all[i]) ?? ''}'.replaceAll('\n', '\\n'));
        }
        sink.write('|${resultsFound[i]}|${resultsFound[i]}.pdb');
        if (selectedOptions.contains(OptionKey.s0o5)) {
          String? doi = OptionKey.s0o5.contentP(jsonObject.all[i])?.replaceAll('\n', '\\n');
          if (doi != null) {
            sink.write('|$doi|${doi.split('/').last}.pdf');
          } else {
            sink.write('||');
          }
        }
        if (selectedOptions.contains(OptionKey.p2o18)) {
          sink.write('|${_getTarget(OptionKey.p2o18.contentP(jsonObject.all[i]))}'.replaceAll('\n', '\\n'));
        }
        sink.write('\n');
      } else {
        int maxLength = 0;

        for (OptionKey option in selectedOptions) {
          if (option.needSpan()) {
            List? list = option.contentW(jsonObject.all[i]);
            if (list == null) {
              sink.write('|');
            } else {
              if (list.length > maxLength) {
                maxLength = list.length;
              }
              sink.write('|${list[0]}'.replaceAll('\n', '\\n'));
            }
          } else {
            sink.write('|${option.contentW(jsonObject.all[i]) ?? ''}'.replaceAll('\n', '\\n'));
          }
        }

        sink.write('\n');

        for (int j = 1; j < maxLength; j++) {
          for (OptionKey option in selectedOptions) {
            if (option.needSpan()) {
              List? list = option.contentW(jsonObject.all[i]);
              if (list == null || list.length <= j) {
                sink.write('|');
              } else {
                sink.write('|${list[j]}'.replaceAll('\n', '\\n'));
              }
            } else {
              sink.write('|');
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
      error = 'Error: Unable to write a new CSV file: $e';
      setState(() {});
      return;
    }
  }

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

  void _queryApi() async {
    if (searchLock) {
      return;
    }

    final List<OptionKey> sortedOptions = List.from(selectedOptions);
    sortedOptions.sort((a, b) => a.key.compareTo(b.key));
    
    searchLock = true;
    successful = false;
    queryCopy = query;
    setState(() {});
    if (query == '') {
      error = '► Please provide a query.';
      searchLock = false;
      setState(() {});
      return null;
    } else if (selectedOptions.isEmpty) {
      searchLock = false;
      return null;
    }
    print('start');
    print('client query: $query');
    var client = http.Client();
    JsonWObject parsedObj;
    try {
      final searchUrl = 'https://search.rcsb.org/rcsbsearch/v2/query?json=%7B"query":%7B"type":"terminal"%2C"label":"full_text"%2C"service":"full_text"%2C"parameters":%7B"value":"$query"%7D%7D%2C"return_type":"entry"%2C"request_options":%7B"paginate":%7B"rows":10000%2C"start":0%7D%2C"results_verbosity":"compact"%2C"results_content_type":%5B"experimental"%5D%2C"sort":%5B%7B"sort_by":"score"%2C"direction":"desc"%7D%5D%2C"scoring_strategy":"combined"%7D%7D';
      print('requesting result set from RCSB search through url: $searchUrl');
      final searchResponse = await client.get(
          Uri.parse(searchUrl));
      final Map<String, dynamic> searchParsed = jsonDecode(searchResponse.body);
      final List<String>? resultSet = (searchParsed['result_set'] as List?)?.map((e) => '$e').toList();
      setState(() {
        resultsFound.clear();
        resultsFound.addAll(resultSet as List);
      });
      print('received response: $resultSet');
      if (resultSet == null) {
        // do nothing
      } else {
        final resultSetString = resultSet.asString();
        // TODO: format result set
        try {
          String entrySet = resultSetString.substring(1, resultSetString.length - 1);
          List<String> optionAddresses = sortedOptions.map((e) => e.address).toList();
          String optionUrl = '';

          for (String option in optionAddresses) {
            optionUrl = '$optionUrl$option';
          }
          
          final String dataUrl = 'https://data.rcsb.org/graphql?query=%7Bentries(entry_ids:%5B$entrySet%5D)%7Brcsb_id$optionUrl%7D%7D';

          print('requesting data from RCSB PDB through url: $dataUrl');

          final dataResponse = await client.get(Uri.parse(dataUrl));
          
          print('received response: ${dataResponse.body}');

          final jsonString = jsonDecode(dataResponse.body);
          List entries = jsonString['data']?['entries'];
          parsedObj = JsonWObject.initializeFromJson(jsonEncode(entries));
          //print(entries);
          //print('successfully converted to Json object for the following entries: ${parsedObj.all.structData.keywords.pdbID}');
          
          for (var opt in parsedObj.all) {

            if (opt.structData.pubPrim.author != null) {
              List mat = opt.structData.pubPrim.author as List;
              if (mat.length > 2) {
                print('$mat : ${opt.id}');
              }
            }
          }

          // print(parsedObj.all.map((e) => e.structData.crystProp.matthews).toList());
          print('end');
          setState(() => successful = true);
          jsonObject = parsedObj;
        } catch (e) {
          print(e);
          error = '► Failed to query. Server may not have responded in time.\n► Your query was: \'$queryCopy\'';
          setState(() {});
          throw Exception('failed to query: $e');
        } finally {
          setState(() => searchLock = false);
          client.close();
        }
      }
    } catch (e) {
      if (error == '') {
        error = '► No results. Please check that your query is correct.\n► Your query was: \'$queryCopy\'.';
      }
      searchLock = false;
      setState(() {});
      client.close();
    }
    return;
  }
}

extension StringExtensions on List<String> {
  String asString() {
    String toReturn = '"';
    for (String entry in this) {
      toReturn = '$toReturn"$entry",';
    }
    return toReturn.substring(0, toReturn.length);
  }
}

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
        margin: EdgeInsets.only(bottom: 1),
        padding: EdgeInsets.only(left: 10, top: 5, bottom: 5),
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
            Spacer(),
            Icon(widget.selected ? Icons.keyboard_arrow_down : Icons.chevron_right, color: const Color.fromARGB(220, 255, 255, 255), size: 17),
            SizedBox(width: 5),
          ],
        )
      ),
    );
  }
}

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
        margin: EdgeInsets.only(bottom: 1),
        padding: EdgeInsets.only(left: 20, top: 2, bottom: 2),
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
                color: widget.selected ? const Color.fromARGB(220, 255, 255, 255) : Colors.black,
                fontWeight: FontWeight.normal,
                fontSize: 13,
              )
            ),
            Spacer(),
            Icon(widget.selected ? Icons.clear : Icons.chevron_right, color: widget.selected ? const Color.fromARGB(220, 255, 255, 255) : Colors.black, size: 17),
            SizedBox(width: 5),
          ],
        )
      ),
    );
  }
}