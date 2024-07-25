import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:rcsb_pdb_json2csv_flex/models/json_read_object.dart';


class QueryView extends StatefulWidget {
  const QueryView({super.key});

  @override
  QueryViewState createState() => QueryViewState();
}

class QueryViewState extends State<QueryView> {
  final TextEditingController searchController = TextEditingController();
  String? errorMessage;
  String? destination;
  bool successful = false;
  String query = '';

  @override
  void initState() {
    super.initState();
    searchController.addListener(_onSearchUpdate);
  }

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
              _searchBar(),
              _fileDestination(),
              Row(
                children: [
                  _generateButton(),
                  _generateAndOpenButton(),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(15), 
                child: Text(errorMessage != null ? '$errorMessage' : successful ? 'Successfully generated CSV file.' : '', style: TextStyle(color: successful? Colors.green : Colors.red),)
              ),
              const SizedBox(height: 30),
            ],
          ),
          // _isHovering
          //     ? _showInfo()
          //     : Container()
        ],
      ),
    );
  }

  void _onSearchUpdate() {
    query = searchController.text;
    setState(() {});
  }

  Widget _searchBar() {
    return Container(
      margin: EdgeInsets.only(left: 15),
      padding: EdgeInsets.only(left: 10),
      width: 400,
      height: 32,
      decoration: BoxDecoration(
        border: Border.all(width: 0.8),
        borderRadius: BorderRadius.all(Radius.circular(16))
      ),
      child: Row(
        children: [
          Container(
            width: 388,
            child: TextField(
              controller: searchController,
              style: TextStyle(
                fontSize: 14,
              ),
              decoration: InputDecoration(
                hintText: 'Search...',
                hintStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                suffixIcon: IconButton( // search field (x) button.
                  icon: const Icon(Icons.search, size: 20, color: Colors.black),
                  padding: EdgeInsets.all(0),
                  onPressed: () => _queryApi(), // Clearing search field.
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
          // _openFile();
        },
        child: const Text('Generate and Open', style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400)),
      ),
    );
  }

    Widget _fileDestination() {
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
                      onTap: () => _openFolderExplorer(),
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
                onPressed: () => _openFolderExplorer(),
                child: const Text('Browse', style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400)),
              ),
              const SizedBox(width: 10),
            ],
          ),
        ]
      ),
    );
  }

  // void _openFileExplorer(BuildContext context) async {
  //   successful = false;
  //   errorMessage = null;
  //   setState(() {});
  //   try {
  //     final newResult = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['json']);
  //     if (newResult != null) {
  //       result = newResult;
  //       final newPath = result!.files.single.path!;
  //       file = File(newPath);
  //       destination ??= newPath.substring(0, newPath.length - newPath.split('\\').last.length - 1);
  //       setState(() {});
  //     } else {
  //       // user cancelled the file picker
  //     }
  //   } catch (_) {}
  // }

  void _openFolderExplorer() async {
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

  Future<JsonRObject?> _queryApi() async {
    print('start');
    if (query == '') {
      return null;
    }
    print('client query: $query');
    var client = http.Client();
    JsonRObject parsedObj;
    try {
      final searchUrl = 'https://search.rcsb.org/rcsbsearch/v2/query?json=%7B"query":%7B"type":"terminal"%2C"label":"full_text"%2C"service":"full_text"%2C"parameters":%7B"value":"$query"%7D%7D%2C"return_type":"entry"%2C"request_options":%7B"paginate":%7B"rows":10000%2C"start":0%7D%2C"results_verbosity":"compact"%2C"results_content_type":%5B"experimental"%5D%2C"sort":%5B%7B"sort_by":"score"%2C"direction":"desc"%7D%5D%2C"scoring_strategy":"combined"%7D%7D';
      print('requesting result set from RCSB search through url: $searchUrl');
      final searchResponse = await client.get(
          Uri.parse(searchUrl));
      final Map<String, dynamic> searchParsed = jsonDecode(searchResponse.body);
      final List<String>? resultSet = (searchParsed['result_set'] as List?)?.map((e) => '$e').toList();
      print('received response: $resultSet');
      if (resultSet == null) {
        // do nothing
      } else {
        final resultSetString = resultSet.asString();
        // TODO: format result set
        try {
          String entrySet = resultSetString.substring(1, resultSetString.length - 1);
          String dataUrl = 'https://data.rcsb.org/graphql?query=%7B%0A%20%20entries(entry_ids:%20%5B$entrySet%5D)%0A%20%20%7B%0A%20%20%20%20rcsb_id%0A%20%20%20%20audit_author%20%7B%0A%20%20%20%20%20%20name%0A%20%20%20%20%7D%0A%20%20%20%20cell%20%7B%0A%20%20%20%20%20%20Z_PDB%0A%20%20%20%20%20%20angle_alpha%0A%20%20%20%20%20%20angle_beta%0A%20%20%20%20%20%20angle_gamma%0A%20%20%20%20%20%20length_a%0A%20%20%20%20%20%20length_b%0A%20%20%20%20%20%20length_c%0A%20%20%20%20%7D%0A%20%20%20%20diffrn%20%7B%0A%20%20%20%20%20%20ambient_temp%0A%20%20%20%20%7D%0A%20%20%20%20diffrn_detector%20%7B%0A%20%20%20%20%20%20detector%0A%20%20%20%20%20%20pdbx_collection_date%0A%20%20%20%20%7D%0A%20%20%20%20diffrn_source%20%7B%0A%20%20%20%20%20%20source%0A%20%20%20%20%20%20type%0A%20%20%20%20%20%20pdbx_synchrotron_site%0A%20%20%20%20%20%20pdbx_synchrotron_beamline%0A%20%20%20%20%7D%0A%20%20%20%20em_3d_reconstruction%20%7B%0A%20%20%20%20%20%20resolution%0A%20%20%20%20%20%20symmetry_type%0A%20%20%20%20%7D%0A%20%20%20%20em_diffraction_stats%20%7B%0A%20%20%20%20%20%20high_resolution%0A%20%20%20%20%7D%0A%20%20%20%20em_experiment%20%7B%0A%20%20%20%20%20%20aggregation_state%0A%20%20%20%20%20%20reconstruction_method%0A%20%20%20%20%7D%0A%20%20%20%20em_imaging%20%7B%0A%20%20%20%20%20%20accelerating_voltage%0A%20%20%20%20%20%20microscope_model%0A%20%20%20%20%7D%0A%20%20%20%20em_image_recording%20%7B%0A%20%20%20%20%20%20film_or_detector_model%0A%20%20%20%20%7D%0A%20%20%20%20em_single_particle_entity%20%7B%0A%20%20%20%20%20%20point_symmetry%0A%20%20%20%20%7D%0A%20%20%20%20em_specimen%20%7B%0A%20%20%20%20%20%20embedding_applied%0A%20%20%20%20%20%20staining_applied%0A%20%20%20%20%20%20vitrification_applied%0A%20%20%20%20%7D%0A%20%20%20%20exptl%20%7B%0A%20%20%20%20%20%20method%0A%20%20%20%20%7D%0A%20%20%20%20exptl_crystal%20%7B%0A%20%20%20%20%20%20density_Matthews%0A%20%20%20%20%20%20density_percent_sol%0A%20%20%20%20%7D%0A%20%20%20%20exptl_crystal_grow%20%7B%0A%20%20%20%20%20%20method%0A%20%20%20%20%20%20pH%0A%20%20%20%20%20%20pdbx_details%0A%20%20%20%20%20%20temp%0A%20%20%20%20%7D%0A%20%20%20%20pdbx_SG_project%20%7B%0A%20%20%20%20%20%20full_name_of_center%0A%20%20%20%20%20%20initial_of_center%0A%20%20%20%20%20%20project_name%0A%20%20%20%20%7D%0A%20%20%20%20pdbx_database_related%20%7B%0A%20%20%20%20%20%20db_id%0A%20%20%20%20%7D%0A%20%20%20%20pdbx_deposit_group%20%7B%0A%20%20%20%20%20%20group_id%0A%20%20%20%20%20%20group_description%0A%20%20%20%20%20%20group_title%0A%20%20%20%20%20%20group_type%0A%20%20%20%20%7D%0A%20%20%20%20pdbx_nmr_ensemble%20%7B%0A%20%20%20%20%20%20conformer_selection_criteria%0A%20%20%20%20%20%20conformers_calculated_total_number%0A%20%20%20%20%20%20conformers_submitted_total_number%0A%20%20%20%20%7D%0A%20%20%20%20pdbx_nmr_exptl%20%7B%0A%20%20%20%20%20%20type%0A%20%20%20%20%7D%0A%20%20%20%20pdbx_nmr_exptl_sample_conditions%20%7B%0A%20%20%20%20%20%20ionic_strength%0A%20%20%20%20%20%20pH%0A%20%20%20%20%20%20pressure%0A%20%20%20%20%20%20pressure_units%0A%20%20%20%20%20%20temperature%0A%20%20%20%20%7D%0A%20%20%20%20pdbx_nmr_refine%20%7B%0A%20%20%20%20%20%20details%0A%20%20%20%20%20%20method%0A%20%20%20%20%7D%0A%20%20%20%20pdbx_nmr_representative%20%7B%0A%20%20%20%20%20%20conformer_id%0A%20%20%20%20%20%20selection_criteria%0A%20%20%20%20%7D%0A%20%20%20%20pdbx_nmr_sample_details%20%7B%0A%20%20%20%20%20%20contents%0A%20%20%20%20%20%20solvent_system%0A%20%20%20%20%7D%0A%20%20%20%20pdbx_nmr_software%20%7B%0A%20%20%20%20%20%20authors%0A%20%20%20%20%20%20classification%0A%20%20%20%20%20%20name%0A%20%20%20%20%20%20version%0A%20%20%20%20%7D%0A%20%20%20%20pdbx_nmr_spectrometer%20%7B%0A%20%20%20%20%20%20field_strength%0A%20%20%20%20%20%20manufacturer%0A%20%20%20%20%20%20model%0A%20%20%20%20%7D%0A%20%20%20%20pubmed%20%7B%0A%20%20%20%20%20%20rcsb_pubmed_central_id%0A%20%20%20%20%20%20rcsb_pubmed_container_identifiers%20%7B%0A%20%20%20%20%20%20%20%20pubmed_id%0A%20%20%20%20%20%20%7D%0A%20%20%20%20%20%20rcsb_pubmed_doi%0A%20%20%20%20%7D%0A%20%20%20%20rcsb_accession_info%20%7B%0A%20%20%20%20%20%20deposit_date%0A%20%20%20%20%20%20initial_release_date%0A%20%20%20%20%7D%0A%20%20%20%20rcsb_binding_affinity%20%7B%0A%20%20%20%20%20%20comp_id%0A%20%20%20%20%20%20value%0A%20%20%20%20%20%20provenance_code%0A%20%20%20%20%20%20reference_sequence_identity%0A%20%20%20%20%20%20symbol%0A%20%20%20%20%20%20type%0A%20%20%20%20%20%20unit%0A%20%20%20%20%7D%0A%20%20%20%20rcsb_entry_container_identifiers%20%7B%0A%20%20%20%20%20%20emdb_ids%0A%20%20%20%20%20%20entry_id%0A%20%20%20%20%7D%0A%20%20%20%20rcsb_entry_info%20%7B%0A%20%20%20%20%20%20deposited_atom_count%0A%20%20%20%20%20%20deposited_model_count%0A%20%20%20%20%20%20deposited_nonpolymer_entity_instance_count%0A%20%20%20%20%20%20deposited_polymer_entity_instance_count%0A%20%20%20%20%20%20deposited_polymer_monomer_count%0A%20%20%20%20%20%20deposited_solvent_atom_count%0A%20%20%20%20%20%20disulfide_bond_count%0A%20%20%20%20%20%20entity_count%0A%20%20%20%20%20%20molecular_weight%0A%20%20%20%20%20%20nonpolymer_entity_count%0A%20%20%20%20%20%20polymer_composition%0A%20%20%20%20%20%20polymer_entity_count_DNA%0A%20%20%20%20%20%20polymer_entity_count_nucleic_acid_hybrid%0A%20%20%20%20%20%20polymer_entity_count_protein%0A%20%20%20%20%20%20polymer_entity_count_RNA%0A%20%20%20%20%20%20resolution_combined%0A%20%20%20%20%20%20selected_polymer_entity_types%0A%20%20%20%20%20%20structure_determination_methodology%0A%20%20%20%20%20%20diffrn_resolution_high%20%7B%0A%20%20%20%20%20%20%20%20value%0A%20%20%20%20%20%20%7D%0A%20%20%20%20%20%20diffrn_radiation_wavelength_minimum%0A%20%20%20%20%20%20diffrn_radiation_wavelength_maximum%0A%20%20%20%20%7D%0A%20%20%20%20rcsb_primary_citation%20%7B%0A%20%20%20%20%20%20journal_volume%0A%20%20%20%20%20%20page_first%0A%20%20%20%20%20%20page_last%0A%20%20%20%20%20%20pdbx_database_id_DOI%0A%20%20%20%20%20%20rcsb_authors%0A%20%20%20%20%20%20rcsb_journal_abbrev%0A%20%20%20%20%20%20title%0A%20%20%20%20%20%20year%0A%20%20%20%20%7D%0A%20%20%20%20refine%20%7B%0A%20%20%20%20%20%20B_iso_mean%0A%20%20%20%20%20%20ls_R_factor_R_free%0A%20%20%20%20%20%20ls_R_factor_R_work%0A%20%20%20%20%20%20ls_R_factor_all%0A%20%20%20%20%20%20ls_R_factor_obs%0A%20%20%20%20%20%20ls_d_res_high%0A%20%20%20%20%20%20ls_number_reflns_obs%0A%20%20%20%20%20%20pdbx_method_to_determine_struct%0A%20%20%20%20%20%20pdbx_refine_id%0A%20%20%20%20%7D%0A%20%20%20%20struct%20%7B%0A%20%20%20%20%20%20title%0A%20%20%20%20%7D%0A%20%20%20%20struct_keywords%20%7B%0A%20%20%20%20%20%20pdbx_keywords%0A%20%20%20%20%7D%0A%20%20%20%20symmetry%20%7B%0A%20%20%20%20%20%20space_group_name_H_M%0A%20%20%20%20%7D%0A%20%20%20%20reflns%20%7B%0A%20%20%20%20%20%20B_iso_Wilson_estimate%0A%20%20%20%20%20%20pdbx_redundancy%0A%20%20%20%20%20%20percent_possible_obs%0A%20%20%20%20%20%20pdbx_Rmerge_I_obs%0A%20%20%20%20%7D%0A%20%20%20%20polymer_entities%20%7B%0A%20%20%20%20%20%20entity_poly%20%7B%0A%20%20%20%20%20%20%20%20pdbx_seq_one_letter_code_can%0A%20%20%20%20%20%20%20%20rcsb_entity_polymer_type%0A%20%20%20%20%20%20%20%20rcsb_sample_sequence_length%0A%20%20%20%20%20%20%20%20type%0A%20%20%20%20%20%20%7D%0A%20%20%20%20%20%20rcsb_polymer_entity%20%7B%0A%20%20%20%20%20%20%20%20pdbx_number_of_molecules%0A%20%20%20%20%20%20%20%20formula_weight%0A%20%20%20%20%20%20%20%20pdbx_description%0A%20%20%20%20%20%20%20%20rcsb_enzyme_class_combined%20%7B%0A%20%20%20%20%20%20%20%20%20%20ec%0A%20%20%20%20%20%20%20%20%20%20provenance_source%0A%20%20%20%20%20%20%20%20%7D%0A%20%20%20%20%20%20%20%20rcsb_macromolecular_names_combined%20%7B%0A%20%20%20%20%20%20%20%20%20%20name%0A%20%20%20%20%20%20%20%20%20%20provenance_code%0A%20%20%20%20%20%20%20%20%20%20provenance_source%0A%20%20%20%20%20%20%20%20%7D%0A%20%20%20%20%20%20%7D%0A%20%20%20%20%20%20entity_src_gen%20%7B%0A%20%20%20%20%20%20%20%20plasmid_name%0A%20%20%20%20%20%20%7D%0A%20%20%20%20%20%20polymer_entity_instances%20%7B%0A%20%20%20%20%20%20%20%20rcsb_polymer_entity_instance_container_identifiers%20%7B%0A%20%20%20%20%20%20%20%20%20%20asym_id%0A%20%20%20%20%20%20%20%20%20%20auth_asym_id%0A%20%20%20%20%20%20%20%20%7D%0A%20%20%20%20%20%20%7D%0A%20%20%20%20%20%20rcsb_cluster_membership%20%7B%0A%20%20%20%20%20%20%20%20cluster_id%0A%20%20%20%20%20%20%20%20identity%0A%20%20%20%20%20%20%7D%0A%20%20%20%20%20%20rcsb_entity_host_organism%20%7B%0A%20%20%20%20%20%20%20%20ncbi_scientific_name%0A%20%20%20%20%20%20%7D%0A%20%20%20%20%20%20rcsb_entity_source_organism%20%7B%0A%20%20%20%20%20%20%20%20ncbi_scientific_name%0A%20%20%20%20%20%20%20%20ncbi_taxonomy_id%0A%20%20%20%20%20%20%20%20rcsb_gene_name%20%7B%0A%20%20%20%20%20%20%20%20%20%20provenance_source%0A%20%20%20%20%20%20%20%20%20%20value%0A%20%20%20%20%20%20%20%20%7D%0A%20%20%20%20%20%20%7D%0A%20%20%20%20%20%20rcsb_polymer_entity_annotation%20%7B%0A%20%20%20%20%20%20%20%20annotation_id%0A%20%20%20%20%20%20%20%20annotation_lineage%20%7B%0A%20%20%20%20%20%20%20%20%20%20name%0A%20%20%20%20%20%20%20%20%7D%0A%20%20%20%20%20%20%20%20type%0A%20%20%20%20%20%20%7D%0A%20%20%20%20%20%20rcsb_polymer_entity_container_identifiers%20%7B%0A%20%20%20%20%20%20%20%20entity_id%0A%20%20%20%20%20%20%20%20entry_id%0A%20%20%20%20%20%20%20%20reference_sequence_identifiers%20%7B%0A%20%20%20%20%20%20%20%20%20%20database_accession%0A%20%20%20%20%20%20%20%20%20%20database_name%0A%20%20%20%20%20%20%20%20%7D%0A%20%20%20%20%20%20%7D%0A%20%20%20%20%20%20uniprots%20%7B%0A%20%20%20%20%20%20%20%20rcsb_uniprot_protein%20%7B%0A%20%20%20%20%20%20%20%20%20%20name%20%7B%0A%20%20%20%20%20%20%20%20%20%20%20%20provenance_code%0A%20%20%20%20%20%20%20%20%20%20%20%20value%0A%20%20%20%20%20%20%20%20%20%20%7D%0A%20%20%20%20%20%20%20%20%7D%0A%20%20%20%20%20%20%7D%0A%20%20%20%20%7D%0A%20%20%20%20assemblies%20%7B%0A%20%20%20%20%20%20rcsb_assembly_info%20%7B%0A%20%20%20%20%20%20%20%20polymer_monomer_count%0A%20%20%20%20%20%20%20%20polymer_entity_instance_count%0A%20%20%20%20%20%20%7D%0A%20%20%20%20%20%20pdbx_struct_assembly%20%7B%0A%20%20%20%20%20%20%20%20oligomeric_count%0A%20%20%20%20%20%20%7D%0A%20%20%20%20%20%20rcsb_assembly_container_identifiers%20%7B%0A%20%20%20%20%20%20%20%20assembly_id%0A%20%20%20%20%20%20%7D%0A%20%20%20%20%20%20rcsb_struct_symmetry%20%7B%0A%20%20%20%20%20%20%20%20kind%0A%20%20%20%20%20%20%20%20oligomeric_state%0A%20%20%20%20%20%20%20%20stoichiometry%0A%20%20%20%20%20%20%20%20symbol%0A%20%20%20%20%20%20%20%20type%0A%20%20%20%20%20%20%7D%0A%20%20%20%20%7D%0A%20%20%20%20nonpolymer_entities%20%7B%0A%20%20%20%20%20%20nonpolymer_comp%20%7B%0A%20%20%20%20%20%20%20%20chem_comp%20%7B%0A%20%20%20%20%20%20%20%20%20%20formula%0A%20%20%20%20%20%20%20%20%20%20formula_weight%0A%20%20%20%20%20%20%20%20%20%20id%0A%20%20%20%20%20%20%20%20%20%20name%0A%20%20%20%20%20%20%20%20%7D%0A%20%20%20%20%20%20%20%20rcsb_chem_comp_descriptor%20%7B%0A%20%20%20%20%20%20%20%20%20%20InChI%0A%20%20%20%20%20%20%20%20%20%20InChIKey%0A%20%20%20%20%20%20%20%20%20%20SMILES%0A%20%20%20%20%20%20%20%20%7D%0A%20%20%20%20%20%20%20%20rcsb_chem_comp_related%20%7B%0A%20%20%20%20%20%20%20%20%20%20resource_accession_code%0A%20%20%20%20%20%20%20%20%20%20resource_name%0A%20%20%20%20%20%20%20%20%7D%0A%20%20%20%20%20%20%7D%0A%20%20%20%20%20%20rcsb_nonpolymer_entity_annotation%20%7B%0A%20%20%20%20%20%20%20%20type%0A%20%20%20%20%20%20%7D%0A%20%20%20%20%20%20rcsb_nonpolymer_entity_container_identifiers%20%7B%0A%20%20%20%20%20%20%20%20entity_id%0A%20%20%20%20%20%20%7D%0A%20%20%20%20%20%20nonpolymer_entity_instances%20%7B%0A%20%20%20%20%20%20%20%20rcsb_nonpolymer_entity_instance_container_identifiers%20%7B%0A%20%20%20%20%20%20%20%20%20%20asym_id%0A%20%20%20%20%20%20%20%20%20%20auth_asym_id%0A%20%20%20%20%20%20%20%20%7D%0A%20%20%20%20%20%20%7D%0A%20%20%20%20%7D%0A%20%20%20%20branched_entities%20%7B%0A%20%20%20%20%20%20rcsb_branched_entity_container_identifiers%20%7B%0A%20%20%20%20%20%20%20%20rcsb_id%0A%20%20%20%20%20%20%20%20asym_ids%0A%20%20%20%20%20%20%20%20auth_asym_ids%0A%20%20%20%20%20%20%20%20chem_comp_monomers%0A%20%20%20%20%20%20%7D%0A%20%20%20%20%20%20pdbx_entity_branch%20%7B%0A%20%20%20%20%20%20%20%20rcsb_branched_component_count%0A%20%20%20%20%20%20%7D%0A%20%20%20%20%20%20pdbx_entity_branch_descriptor%20%7B%0A%20%20%20%20%20%20%20%20type%0A%20%20%20%20%20%20%20%20descriptor%0A%20%20%20%20%20%20%7D%0A%20%20%20%20%20%20rcsb_branched_entity%20%7B%0A%20%20%20%20%20%20%20%20pdbx_description%0A%20%20%20%20%20%20%7D%0A%20%20%20%20%20%20branched_entity_instances%20%7B%0A%20%20%20%20%20%20%20%20rcsb_branched_struct_conn%20%7B%0A%20%20%20%20%20%20%20%20%20%20role%0A%20%20%20%20%20%20%20%20%7D%0A%20%20%20%20%20%20%7D%0A%20%20%20%20%7D%0A%20%20%7D%0A%7D';
          
          print('requesting data from RCSB PDB through url: $dataUrl');

          final dataResponse = await client.get(Uri.parse(dataUrl));
          
          print('received response: ${dataResponse.body}');

          final jsonString = jsonDecode(dataResponse.body);
          List entries = jsonString['data']?['entries'];

          parsedObj = JsonRObject.initializeFromJson(jsonEncode(entries));
          //print(entries);
          print('successfully converted to Json object for the following entries: ${parsedObj.structureData.keywords.pdbID}');
          print('end');
          return parsedObj;
        } catch (e) {
          throw Exception('failed to query: $e');
        }
      }
    } catch (e) {
      throw Exception('failed to query (no results): $e');
    } finally {
      client.close();
    }
    throw Exception('impossible');
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