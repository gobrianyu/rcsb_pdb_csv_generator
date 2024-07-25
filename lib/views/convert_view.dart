import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:rcsb_pdb_json2csv_flex/models/json_read_object.dart';


class ConvertView extends StatefulWidget {
  const ConvertView({super.key});

  @override
  ConvertViewState createState() => ConvertViewState();
}

class ConvertViewState extends State<ConvertView> {
  @override
  void initState() {
    super.initState();
  }

  File? file;
  FilePickerResult? result;
  String? destination;
  String? errorMessage;
  bool successful = false;
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _fileSelector(context),
              _fileDestination(context),
              Row(
                children: [
                  _generateButton(context),
                  _generateAndOpenButton(context),
                  _info()
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(15), 
                child: Text(errorMessage != null ? '$errorMessage' : successful ? 'Successfully generated CSV file.' : '', style: TextStyle(color: successful? Colors.green : Colors.red),)
              ),
              const SizedBox(height: 30),
            ],
          ),
          _isHovering
              ? _showInfo()
              : Container()
        ],
      ),
    );
  }

  Widget _info() {
    return MouseRegion(
      onEnter: (details) {
        setState(() {
          _isHovering = true;
        });
      },
      onExit: (details) {
        setState(() {
          _isHovering = false;
        });
      },
      child: const Icon(Icons.info_outline, color: Color.fromARGB(255, 50, 50, 50))
    );
  }

  Widget _showInfo() {
    return Positioned(
      bottom: 155,
      left: 301,
      child: Container(
        padding: const EdgeInsets.all(5),
        width: 280,
        decoration: BoxDecoration(
          border: Border.all(width: 0.5),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: Colors.white
        ),
        child: const Text(
          'This program generates CSV files for JSON files from RCSB PDB\'s Custom Report with EXACTLY the following fields selected: \n • DOI\n • Release Date\n • Structure Title\n • Refinement Resolution (Å)\n • Accession Code(s)\n • Ligand ID\n • Ligand SMILES',
          style: TextStyle(fontSize: 12)
        )
      ),
    );
  }

  Widget _generateButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, top: 15, bottom: 15, right: 7),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0)),
          fixedSize: const Size(150, 30),
          backgroundColor: const Color.fromARGB(255, 182, 186, 201),
          shadowColor: Colors.black
        ),
        onPressed: () => _writeToCsv(),
        child: const Text('Generate CSV', style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400)),
      ),
    );
  }

  Widget _generateAndOpenButton(BuildContext context) {
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
      final String? fileName = file?.path.split('\\').last; 
      await OpenFile.open('$destination\\${fileName?.substring(0, fileName.length - 4)}csv');
    } on Exception catch (_) {
      return;
    }
  }

  Widget _fileSelector(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Select JSON file to convert', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 10),
          Row(
            children: [
              const Text('File name:'),
              const SizedBox(width: 7),
              Container(
                width: 350,
                padding: const EdgeInsets.only(left: 5, right: 3, top: 5, bottom: 5),
                decoration: BoxDecoration(
                  border: Border.all(width: 0.5)
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => _openFileExplorer(context),
                      child: SizedBox(
                        width: 315,
                        child: Text(
                          '${file != null ? file?.path.split('\\').last : ''}',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 25,
                      child: GestureDetector(
                        onTap:() => setState(() {
                          file = null;
                          successful = false;
                          errorMessage = null;
                        }),
                        child: const Icon(Icons.clear, size: 20),
                      ),
                    ),
                  ],
                )
              ),
              const SizedBox(width: 7),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  fixedSize: const Size(120, 30),
                  backgroundColor: const Color.fromARGB(255, 182, 186, 201),
                  shadowColor: Colors.black
                ),
                onPressed: () => _openFileExplorer(context),
                child: const Text('Select File', style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400)),
              ),
              const SizedBox(width: 10),
            ],
          ),
        ]
      ),
    );
  }

  Widget _fileDestination(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Select destination folder', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 10),
          Row(
            children: [
              const Text('Destination:'),
              const SizedBox(width: 7),
              Container(
                width: 338,
                padding: const EdgeInsets.only(left: 5, right: 3, top: 5, bottom: 5),
                decoration: BoxDecoration(
                  border: Border.all(width: 0.5)
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => _openFolderExplorer(context),
                      child: SizedBox(
                        width: 303,
                        child: Text(
                          destination ?? '',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 25,
                      child: GestureDetector(
                        onTap:() => setState(() {
                          destination = null;
                          successful = false;
                          errorMessage = null;
                        }),
                        child: const Icon(Icons.clear, size: 20),
                      ),
                    ),
                  ],
                )
              ),
              const SizedBox(width: 7),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  fixedSize: const Size(120, 30),
                  backgroundColor: const Color.fromARGB(255, 182, 186, 201),
                  shadowColor: Colors.black
                ),
                onPressed: () => _openFolderExplorer(context),
                child: const Text('Browse', style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400)),
              ),
              const SizedBox(width: 10),
            ],
          ),
        ]
      ),
    );
  }

  void _openFileExplorer(BuildContext context) async {
    successful = false;
    errorMessage = null;
    setState(() {});
    try {
      final newResult = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['json']);
      if (newResult != null) {
        result = newResult;
        final newPath = result!.files.single.path!;
        file = File(newPath);
        destination ??= newPath.substring(0, newPath.length - newPath.split('\\').last.length - 1);
        setState(() {});
      } else {
        // user cancelled the file picker
      }
    } catch (_) {}
  }

  void _openFolderExplorer(BuildContext context) async {
    successful = false;
    errorMessage = null;
    setState(() {});
    try {
      final newDestination = await FilePicker.platform.getDirectoryPath();
      if (newDestination != null) {
        destination = newDestination;
      }
      setState(() {});
    } catch (_) {}
  }

  // Writes to a CSV file from provided `jsonData` with a provided file name and address `fileAddress`.
  // Parameters:
  // - jsonData: JSON object data to write to the CSV file
  // - fileAddress: file address name of new CSV file (without .csv extension; this is added by the method) 
  Future<void> _writeToCsv() async {
    // if (file == null) {
    //   errorMessage = 'Error: No JSON file selected.';
    //   setState(() {});
    //   return;
    // } else if (destination == null) {
    //   errorMessage = 'Error: No destination directory selected.';
    //   setState(() {});
    //   return;
    // }
    // JsonRObject jsonData;
    // try {
    //   jsonData = JsonRObject.initializeFromJson(await File('${file?.path}').readAsString());
    // } on Exception catch (_) {
    //   errorMessage = 'Error: Unable to convert file. Please check that the JSON file is in the correct format.';
    //   setState(() {});
    //   return;
    // }
    // final String newName = file!.path.split('\\').last; 
    // final sink = File('$destination\\${newName.substring(0, newName.length - 4)}csv').openWrite(); // creates CSV file and opens sink
    
    // sink.done.ignore();
    
    // // writing header/titles
    // sink.write('''Identifier,StructureData,,,,Polymer EntityData,Non-polymer EntityData,,
    // Entry ID,DOI,Release Date,Refinement Resolution (Å),Structure Title,Accession Code(s),Ligand ID,Ligand SMILES,\n''');
    
    // // writing entries one by one
    // for (Entry entry in jsonData.all) {
    //   final data = entry.data;
    //   final polyEnts = data.polymerEntities; // list of polymer entities
    //   final nonPolyEnts = data.nonPolymerEntities; // list of non polymer entities
    //   var polySize = polyEnts.length - 1; // number of polymer entities in entry
    //   var nonPolySize = nonPolyEnts == null ? 0 : nonPolyEnts.length - 1; // number of non polymer entities in entry
    //   var counter = 0; // counter (inverse of nonPolySize)
    
    //   // writing entry identifier
    //   sink.write('"${entry.id}"');
    //   // writing doi (if applicable)
    //   data.doi == null ? sink.write(',') : sink.write(',"${data.doi}"');
    //   // writing release date (assumed present)
    //   sink.write(',"${data.releaseDate}"');
    //   // writing refinement resolution (if applicable)
    //   data.refinementResolution == null ? sink.write(',') : sink.write(',"${data.refinementResolution}"');
    //   // writing structure title (assumed present)
    //   sink.write(',"${data.structureTitle}"');
    //   // writing 'first' polymer entity in list (reversed) (if applicable)
    //   polyEnts.isEmpty ? sink.write(',') : sink.write(',"${polyEnts[polySize].code}"');
    //   // writing 'first' non polymer entity in list (non reversed) (if applicable)
    //   if (nonPolyEnts != null) sink.write(',"${nonPolyEnts[counter].id}","${nonPolyEnts[counter].smiles}"');
    
    //   sink.write('\n'); // new line
    
    //   // writing excess polymer and non polymer entities to the CSV file;
    //   // only if there are unwritten polymer or non polymer entities 
    //   while (polySize > 0 || (nonPolyEnts != null && nonPolySize > 0)) {
    //     // case: 1 or more unwritten polymer entities; no unwritten non polymer entities
    //     if (polySize > 0 && nonPolySize <= 0) {
    //       polySize--;
    //       sink.write(',,,,,"${polyEnts[polySize].code}"');
    //     }
    //     // case: 1 or more unwritten polymer entities; 1 or more unwritten non polymer entities
    //     else if (polySize > 0 && nonPolyEnts != null && nonPolySize > 0) {
    //       polySize--;
    //       nonPolySize--;
    //       counter++;
    //       sink.write(',,,,,"${polyEnts[polySize].code}","${nonPolyEnts[counter].id}","${nonPolyEnts[counter].smiles}"');
    //     }
    //     // case: no unwritten polymer entities; 1 or more unwritten non polymer entities
    //     else if (polySize <= 0 && nonPolyEnts != null && nonPolySize > 0) {
    //       nonPolySize--;
    //       counter++;
    //       sink.write(',,,,,,"${nonPolyEnts[counter].id}","${nonPolyEnts[counter].smiles}"');
    //     }
    //     sink.write('\n'); // new line
    //   }
    // }
    // try {
    //   await sink.flush();
    //   await sink.close();
    // } on FileSystemException catch (error) {
    //   errorMessage = 'Error: Unable to write a new CSV file: $error';
    //   setState(() {});
    //   return;
    // }
    // errorMessage = null;
    // successful = true;
    // setState(() {});
  }
}