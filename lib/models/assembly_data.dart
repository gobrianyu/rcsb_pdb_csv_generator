class AssemblyData {
  final List<List<String?>?> assemblyID;
  final Features assemblyFeatures;

  AssemblyData({
    required this.assemblyID,
    required this.assemblyFeatures,
  });

  factory AssemblyData.fromJson(List entries) {
    return AssemblyData(
      assemblyID: _getAssemblyID(entries),
      assemblyFeatures: Features.fromJson(entries),
    );
  }
}

List<List<String?>?> _getAssemblyID(List entries) {
  List<List<String?>?> ids = [];
  try {
    for (Map<String, dynamic> entry in entries) {
      ids.add((entry['assemblies'] as List?)
            ?.map((e) => e?['rcsb_assembly_container_identifiers']?['assembly_id'] as String?)
            .toList());
    }
    return ids;
  } catch (e) {
    throw FormatException('Invalid JSON format: $e');
  }
}

class Features {
  final List<List<num?>?> totalPolyChains;
  final List<List<num?>?> totalPolyRes;
  final List<List<num?>?> oligoCount;
  final List<List<List<String?>?>?> kind;
  final List<List<List<String?>?>?> oligoState;
  final List<List<List<List<String?>?>?>?> stoich;
  final List<List<List<String?>?>?> symbol;
  final List<List<List<String?>?>?> type;

  Features({
    required this.totalPolyChains,
    required this.totalPolyRes,
    required this.oligoCount,
    required this.kind,
    required this.oligoState,
    required this.stoich,
    required this.symbol,
    required this.type,
  });

  factory Features.fromJson(List entries) {
    List<List<num?>?> totalPolyChainsBuild = [];
    List<List<num?>?> totalPolyResBuild = [];
    List<List<num?>?> oligoCountBuild = [];
    List<List<List<String?>?>?> kindBuild = [];
    List<List<List<String?>?>?> oligoStateBuild = [];
    List<List<List<List<String?>?>?>?> stoichBuild = [];
    List<List<List<String?>?>?> symbolBuild = [];
    List<List<List<String?>?>?> typeBuild = [];
    
    try {
      for (Map<String, dynamic> entry in entries) {
        List<Map<String, dynamic>?>? assemblies = entry['assemblies']?.cast<Map<String, dynamic>?>();

        totalPolyChainsBuild.add(assemblies
              ?.map((e) => e?['rcsb_assembly_info']?['polymer_entity_instance_count'] as num?)
              .toList());
        totalPolyResBuild.add(assemblies
              ?.map((e) => e?['rcsb_assembly_info']?['polymer_monomer_count'] as num?)
              .toList());
        oligoCountBuild.add(assemblies
              ?.map((e) => e?['pdbx_struct_assembly']?['oligomeric_count'] as num?)
              .toList());
        kindBuild.add(assemblies
              ?.map((e) => (e?['rcsb_struct_symmetry'] as List?)
                ?.map((f) => f?['kind'] as String?)
                .toList())
              .toList());
        oligoStateBuild.add(assemblies
              ?.map((e) => (e?['rcsb_struct_symmetry'] as List?)
                ?.map((f) => f?['oligomeric_state'] as String?)
                .toList())
              .toList());
        stoichBuild.add(assemblies
              ?.map((e) => (e?['rcsb_struct_symmetry'] as List?)
                ?.map((f) => (f?['stoichiometry'] as List?)
                  ?.map((g) => g as String?)
                  .toList())
                .toList())
              .toList());
        symbolBuild.add(assemblies
              ?.map((e) => (e?['rcsb_struct_symmetry'] as List?)
                ?.map((f) => f?['symbol'] as String?)
                .toList())
              .toList());
        typeBuild.add(assemblies
              ?.map((e) => (e?['rcsb_struct_symmetry'] as List?)
                ?.map((f) => f?['type'] as String?)
                .toList())
              .toList());
      }
      return Features(
        totalPolyChains: totalPolyChainsBuild,
        totalPolyRes: totalPolyResBuild,
        oligoCount: oligoCountBuild,
        kind: kindBuild,
        oligoState: oligoStateBuild,
        stoich: stoichBuild,
        symbol: symbolBuild,
        type: typeBuild,
      );
    } catch (e) {
      throw FormatException('Invalid JSON format: $e');
    }
  }
}

// class AssemblyData {
//   final List<List<String?>?> assemblyID;
//   final Features assemblyFeatures;

//   AssemblyData({
//     required this.assemblyID,
//     required this.assemblyFeatures,
//   });

//   factory AssemblyData.fromJson(List entries) {
//     return AssemblyData(
//       assemblyID: _getAssemblyID(entries),
//       assemblyFeatures: Features.fromJson(entries),
//     );
//   }
// }

// List<List<String?>?> _getAssemblyID(List entries) {
//   List<List<String?>?> ids = [];
//   try {
//     for (Map<String, dynamic> entry in entries) {
//       Map<String, dynamic> data = entry['data'];
//       ids.add((data['assemblies'] as List?)
//             ?.map((e) => e?['rcsb_assembly_container_identifiers']?['assembly_id'] as String?)
//             .toList());
//     }
//     return ids;
//   } catch (e) {
//     throw FormatException('Invalid JSON format: $e');
//   }
// }

// class Features {
//   final List<List<num?>?> totalPolyChains;
//   final List<List<num?>?> totalPolyRes;
//   final List<List<num?>?> oligoCount;
//   final List<List<List<String?>?>?> kind;
//   final List<List<List<String?>?>?> oligoState;
//   final List<List<List<List<String?>?>?>?> stoich;
//   final List<List<List<String?>?>?> symbol;
//   final List<List<List<String?>?>?> type;

//   Features({
//     required this.totalPolyChains,
//     required this.totalPolyRes,
//     required this.oligoCount,
//     required this.kind,
//     required this.oligoState,
//     required this.stoich,
//     required this.symbol,
//     required this.type,
//   });

//   factory Features.fromJson(List entries) {
//     List<List<num?>?> totalPolyChainsBuild = [];
//     List<List<num?>?> totalPolyResBuild = [];
//     List<List<num?>?> oligoCountBuild = [];
//     List<List<List<String?>?>?> kindBuild = [];
//     List<List<List<String?>?>?> oligoStateBuild = [];
//     List<List<List<List<String?>?>?>?> stoichBuild = [];
//     List<List<List<String?>?>?> symbolBuild = [];
//     List<List<List<String?>?>?> typeBuild = [];
    
//     try {
//       for (Map<String, dynamic> entry in entries) {
//         Map<String, dynamic> data = entry['data'];
//         List<Map<String, dynamic>?>? assemblies = data['assemblies']?.cast<Map<String, dynamic>?>();

//         totalPolyChainsBuild.add(assemblies
//               ?.map((e) => e?['rcsb_assembly_info']?['polymer_entity_instance_count'] as num?)
//               .toList());
//         totalPolyResBuild.add(assemblies
//               ?.map((e) => e?['rcsb_assembly_info']?['polymer_monomer_count'] as num?)
//               .toList());
//         oligoCountBuild.add(assemblies
//               ?.map((e) => e?['pdbx_struct_assembly']?['oligomeric_count'] as num?)
//               .toList());
//         kindBuild.add(assemblies
//               ?.map((e) => (e?['rcsb_struct_symmetry'] as List?)
//                 ?.map((f) => f?['kind'] as String?)
//                 .toList())
//               .toList());
//         oligoStateBuild.add(assemblies
//               ?.map((e) => (e?['rcsb_struct_symmetry'] as List?)
//                 ?.map((f) => f?['oligomeric_state'] as String?)
//                 .toList())
//               .toList());
//         stoichBuild.add(assemblies
//               ?.map((e) => (e?['rcsb_struct_symmetry'] as List?)
//                 ?.map((f) => (f?['stoichiometry'] as List?)
//                   ?.map((g) => g as String?)
//                   .toList())
//                 .toList())
//               .toList());
//         symbolBuild.add(assemblies
//               ?.map((e) => (e?['rcsb_struct_symmetry'] as List?)
//                 ?.map((f) => f?['symbol'] as String?)
//                 .toList())
//               .toList());
//         typeBuild.add(assemblies
//               ?.map((e) => (e?['rcsb_struct_symmetry'] as List?)
//                 ?.map((f) => f?['type'] as String?)
//                 .toList())
//               .toList());
//       }
//       return Features(
//         totalPolyChains: totalPolyChainsBuild,
//         totalPolyRes: totalPolyResBuild,
//         oligoCount: oligoCountBuild,
//         kind: kindBuild,
//         oligoState: oligoStateBuild,
//         stoich: stoichBuild,
//         symbol: symbolBuild,
//         type: typeBuild,
//       );
//     } catch (e) {
//       throw FormatException('Invalid JSON format: $e');
//     }
//   }
// }