import 'dart:convert';

import 'package:rcsb_pdb_json2csv_flex/models/assembly_data.dart';
import 'package:rcsb_pdb_json2csv_flex/models/non_polymer_entity_data.dart';
import 'package:rcsb_pdb_json2csv_flex/models/oligosaccharide_data.dart';
import 'package:rcsb_pdb_json2csv_flex/models/polymer_entity_data.dart';
import 'package:rcsb_pdb_json2csv_flex/models/structure_data.dart';

class JsonRObject {
  final StructureData _sd;
  final PolymerEntityData _ped;
  final AssemblyData _ad;
  final NonPolymerEntityData _nped;
  final OligosaccharideData _od;

  StructureData get structureData => _sd;
  PolymerEntityData get polymerEntityData => _ped;
  AssemblyData get assemblyData => _ad;
  NonPolymerEntityData get nonPolymerEntityData => _nped;
  OligosaccharideData get oligosaccharideData => _od;

  JsonRObject.initializeFromJson(String jsonString) : 
        _sd = StructureData.fromJson(_decodeJsonData(jsonString)), 
        _ped = PolymerEntityData.fromJson(_decodeJsonData(jsonString)),
        _ad = AssemblyData.fromJson(_decodeJsonData(jsonString)),
        _nped = NonPolymerEntityData.fromJson(_decodeJsonData(jsonString)),
        _od = OligosaccharideData.fromJson(_decodeJsonData(jsonString));
}

List _decodeJsonData(String jsonString) {
  try {
    return jsonDecode(jsonString) as List;
  } catch (e) {
    throw FormatException('Invalid JSON format: $e');
  }
}