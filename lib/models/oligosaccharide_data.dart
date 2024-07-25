class OligosaccharideData {
  final IDs ids;
  final Features features;

  OligosaccharideData({
    required this.ids,
    required this.features,
  });

  factory OligosaccharideData.fromJson(List entries) {
    return OligosaccharideData(
      ids: IDs.fromJson(entries),
      features: Features.fromJson(entries),
    );
  }
}

class IDs {
  final List<List<String?>?> entityID;
  final List<List<List<String?>?>?> asymID;
  final List<List<List<String?>?>?> authAsymID;

  IDs({
    required this.entityID,
    required this.asymID,
    required this.authAsymID,
  });

  factory IDs.fromJson(List entries) {
    List<List<String?>?> entityIDBuild = [];
    List<List<List<String?>?>?> asymIDBuild = [];
    List<List<List<String?>?>?> authAsymIDBuild = [];
    
    try {
      for (Map<String, dynamic> entry in entries) {
        List<Map<String, dynamic>?>? branchEnts = entry['branched_entities']?.cast<Map<String, dynamic>?>();

        entityIDBuild.add(branchEnts
              ?.map((e) => e?['rcsb_branched_entity_container_identifiers']?['rcsb_id'] as String?)
              .toList());
        asymIDBuild.add(branchEnts
              ?.map((e) => (e?['rcsb_branched_entity_container_identifiers']?['asym_ids'] as List?)
                ?.map((f) => f as String?)
                .toList())
              .toList());
        authAsymIDBuild.add(branchEnts
              ?.map((e) => (e?['rcsb_branched_entity_container_identifiers']?['auth_asym_ids'] as List?)
                ?.map((f) => f as String?)
                .toList())
              .toList());
      }
      return IDs(
        entityID: entityIDBuild,
        asymID: asymIDBuild,
        authAsymID: authAsymIDBuild
      );
    } catch (e) {
      throw FormatException('Invalid JSON format: $e');
    }
  }
}

class Features {
  final List<List<num?>?> chainLength;
  final List<List<List<String?>?>?> linDescType;
  final List<List<List<String?>?>?> linDesc;
  final List<List<String?>?> molecName;
  final List<List<List<String?>?>?> monosacc;
  final List<List<List<List<String?>?>?>?> glycosylation;

  Features({
    required this.chainLength,
    required this.linDescType,
    required this.linDesc,
    required this.molecName,
    required this.monosacc,
    required this.glycosylation,
  });

  factory Features.fromJson(List entries) {
    List<List<num?>?> chainLengthBuild = [];
    List<List<List<String?>?>?> linDescTypeBuild = [];
    List<List<List<String?>?>?> linDescBuild = [];
    List<List<String?>?> molecNameBuild = [];
    List<List<List<String?>?>?> monosaccBuild = [];
    List<List<List<List<String?>?>?>?> glycosylationBuild = [];
    
    try {
      for (Map<String, dynamic> entry in entries) {
        List<Map<String, dynamic>?>? branchEnts = entry['branched_entities']?.cast<Map<String, dynamic>?>();

        chainLengthBuild.add(
              branchEnts
                ?.map((e) => e?['pdbx_entity_branch']?['rcsb_branched_component_count'] as num?)
                .toList());
        linDescTypeBuild.add(
              branchEnts
                ?.map((e) => (e?['pdbx_entity_branch_descriptor'] as List?)
                  ?.map((f) => f?['type'] as String?)
                  .toList())
                .toList());
        linDescBuild.add(
              branchEnts
                ?.map((e) => (e?['pdbx_entity_branch_descriptor'] as List?)
                  ?.map((f) => f?['descriptor'] as String?)
                  .toList())
                .toList());
        molecNameBuild.add(
              branchEnts
                ?.map((e) => e?['rcsb_branched_entity']?['pdbx_description'] as String?)
                .toList());
        monosaccBuild.add(
              branchEnts
                ?.map((e) => (e?['rcsb_branched_entity_container_identifiers']?['chem_comp_monomers'] as List?)
                  ?.map((f) => f as String?)
                  .toList())
                .toList());
        glycosylationBuild.add(
              branchEnts
                ?.map((e) => (e?['branched_entity_instances'] as List?)
                  ?.map((f) => (f?['rcsb_branched_struct_conn'] as List?)
                    ?.map((g) => g?['role'] as String?)
                    .toList())
                  .toList())
                .toList());
      }
      return Features(
        chainLength: chainLengthBuild,
        linDescType: linDescTypeBuild,
        linDesc: linDescBuild,
        molecName: molecNameBuild,
        monosacc: monosaccBuild,
        glycosylation: glycosylationBuild,
      );
    } catch (e) {
      throw FormatException('Invalid JSON format: $e');
    }
  }
}

// class OligosaccharideData {
//   final IDs ids;
//   final Features features;

//   OligosaccharideData({
//     required this.ids,
//     required this.features,
//   });

//   factory OligosaccharideData.fromJson(List entries) {
//     return OligosaccharideData(
//       ids: IDs.fromJson(entries),
//       features: Features.fromJson(entries),
//     );
//   }
// }

// class IDs {
//   final List<List<String?>?> entityID;
//   final List<List<List<String?>?>?> asymID;
//   final List<List<List<String?>?>?> authAsymID;

//   IDs({
//     required this.entityID,
//     required this.asymID,
//     required this.authAsymID,
//   });

//   factory IDs.fromJson(List entries) {
//     List<List<String?>?> entityIDBuild = [];
//     List<List<List<String?>?>?> asymIDBuild = [];
//     List<List<List<String?>?>?> authAsymIDBuild = [];
    
//     try {
//       for (Map<String, dynamic> entry in entries) {
//         Map<String, dynamic> data = entry['data'];
//         List<Map<String, dynamic>?>? branchEnts = data['branched_entities']?.cast<Map<String, dynamic>?>();

//         entityIDBuild.add(branchEnts
//               ?.map((e) => e?['rcsb_branched_entity_container_identifiers']?['rcsb_id'] as String?)
//               .toList());
//         asymIDBuild.add(branchEnts
//               ?.map((e) => (e?['rcsb_branched_entity_container_identifiers']?['asym_ids'] as List?)
//                 ?.map((f) => f as String?)
//                 .toList())
//               .toList());
//         authAsymIDBuild.add(branchEnts
//               ?.map((e) => (e?['rcsb_branched_entity_container_identifiers']?['auth_asym_ids'] as List?)
//                 ?.map((f) => f as String?)
//                 .toList())
//               .toList());
//       }
//       return IDs(
//         entityID: entityIDBuild,
//         asymID: asymIDBuild,
//         authAsymID: authAsymIDBuild
//       );
//     } catch (e) {
//       throw FormatException('Invalid JSON format: $e');
//     }
//   }
// }

// class Features {
//   final List<List<num?>?> chainLength;
//   final List<List<List<String?>?>?> linDescType;
//   final List<List<List<String?>?>?> linDesc;
//   final List<List<String?>?> molecName;
//   final List<List<List<String?>?>?> monosacc;
//   final List<List<List<List<String?>?>?>?> glycosylation;

//   Features({
//     required this.chainLength,
//     required this.linDescType,
//     required this.linDesc,
//     required this.molecName,
//     required this.monosacc,
//     required this.glycosylation,
//   });

//   factory Features.fromJson(List entries) {
//     List<List<num?>?> chainLengthBuild = [];
//     List<List<List<String?>?>?> linDescTypeBuild = [];
//     List<List<List<String?>?>?> linDescBuild = [];
//     List<List<String?>?> molecNameBuild = [];
//     List<List<List<String?>?>?> monosaccBuild = [];
//     List<List<List<List<String?>?>?>?> glycosylationBuild = [];
    
//     try {
//       for (Map<String, dynamic> entry in entries) {
//         Map<String, dynamic> data = entry['data'];
//         List<Map<String, dynamic>?>? branchEnts = data['branched_entities']?.cast<Map<String, dynamic>?>();

//         chainLengthBuild.add(
//               branchEnts
//                 ?.map((e) => e?['pdbx_entity_branch']?['rcsb_branched_component_count'] as num?)
//                 .toList());
//         linDescTypeBuild.add(
//               branchEnts
//                 ?.map((e) => (e?['pdbx_entity_branch_descriptor'] as List?)
//                   ?.map((f) => f?['type'] as String?)
//                   .toList())
//                 .toList());
//         linDescBuild.add(
//               branchEnts
//                 ?.map((e) => (e?['pdbx_entity_branch_descriptor'] as List?)
//                   ?.map((f) => f?['descriptor'] as String?)
//                   .toList())
//                 .toList());
//         molecNameBuild.add(
//               branchEnts
//                 ?.map((e) => e?['rcsb_branched_entity']?['pdbx_description'] as String?)
//                 .toList());
//         monosaccBuild.add(
//               branchEnts
//                 ?.map((e) => (e?['rcsb_branched_entity_container_identifiers']?['chem_comp_monomers'] as List?)
//                   ?.map((f) => f as String?)
//                   .toList())
//                 .toList());
//         glycosylationBuild.add(
//               branchEnts
//                 ?.map((e) => (e?['branched_entity_instances'] as List?)
//                   ?.map((f) => (f?['rcsb_branched_struct_conn'] as List?)
//                     ?.map((g) => g?['role'] as String?)
//                     .toList())
//                   .toList())
//                 .toList());
//       }
//       return Features(
//         chainLength: chainLengthBuild,
//         linDescType: linDescTypeBuild,
//         linDesc: linDescBuild,
//         molecName: molecNameBuild,
//         monosacc: monosaccBuild,
//         glycosylation: glycosylationBuild,
//       );
//     } catch (e) {
//       throw FormatException('Invalid JSON format: $e');
//     }
//   }
// }