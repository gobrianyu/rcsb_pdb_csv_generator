class NonPolymerEntityData {
  final IDs ids;
  final Features features;

  NonPolymerEntityData({
    required this.ids,
    required this.features,
  });

  factory NonPolymerEntityData.fromJson(List entries) {
    return NonPolymerEntityData(
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
        List<Map<String, dynamic>?>? nonPolyEnts = entry['nonpolymer_entity_instances'];

        entityIDBuild.add(nonPolyEnts
              ?.map((e) => e?['nonpolymer_entity_instance_container_identifiers']?['entity_id'] as String?)
              .toList());
        asymIDBuild.add(
              nonPolyEnts?.map((e) => (e?['nonpolymer_entity_instances'] as List?)
                ?.map((f) => f?['rcsb_nonpolymer_instance_container_identifiers']?['asym_id'] as String?)
                .toList())
              .toList());
        authAsymIDBuild.add(nonPolyEnts
              ?.map((e) => (e?['nonpolymer_entity_instances'] as List?)
                ?.map((f) => f?['rcsb_nonpolymer_instance_container_identifiers']?['auth_asym_id'] as String?)
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
  final List<List<String?>?> ligandFormula;
  final List<List<num?>?> ligandMW;
  final List<List<String?>?> ligandID;
  final List<List<String?>?> ligandName;
  final List<List<String?>?> inChI;
  final List<List<String?>?> inChIKey;
  final List<List<String?>?> ligandSmiles;
  final List<List<List<String?>?>?> relatedCode;
  final List<List<List<String?>?>?> relatedName;
  final List<List<List<String?>?>?> ligandInterest;

  Features({
    required this.ligandFormula,
    required this.ligandMW,
    required this.ligandID,
    required this.ligandName,
    required this.inChI,
    required this.inChIKey,
    required this.ligandSmiles,
    required this.relatedCode,
    required this.relatedName,
    required this.ligandInterest,
  });

  factory Features.fromJson(List entries) {
    List<List<String?>?> ligandFormulaBuild = [];
    List<List<num?>?> ligandMWBuild = [];
    List<List<String?>?> ligandIDBuild = [];
    List<List<String?>?> ligandNameBuild = [];
    List<List<String?>?> inChIBuild = [];
    List<List<String?>?> inChIKeyBuild = [];
    List<List<String?>?> ligandSmilesBuild = [];
    List<List<List<String?>?>?> relatedCodeBuild = [];
    List<List<List<String?>?>?> relatedNameBuild = [];
    List<List<List<String?>?>?> ligandInterestBuild = [];

    try {
      for (Map<String, dynamic> entry in entries) {
        List<Map<String, dynamic>?>? npe = entry['nonpolymer_entities']?.cast<Map<String, dynamic>?>();
        
        ligandFormulaBuild.add(npe
              ?.map((e) => e?['nonpolymer_comp']?['chem_comp']?['formula'] as String?)
              .toList());
        ligandMWBuild.add(npe
              ?.map((e) => e?['nonpolymer_comp']?['chem_comp']?['formula_weight'] as num?)
              .toList());
        ligandIDBuild.add(npe
              ?.map((e) => e?['nonpolymer_comp']?['chem_comp']?['id'] as String?)
              .toList());
        ligandNameBuild.add(npe
              ?.map((e) => e?['nonpolymer_comp']?['chem_comp']?['name'] as String?)
              .toList());
        inChIBuild.add(npe
              ?.map((e) => e?['nonpolymer_comp']?['rcsb_chem_comp_descriptor']?['InChI'] as String?)
              .toList());
        inChIKeyBuild.add(npe
              ?.map((e) => e?['nonpolymer_comp']?['rcsb_chem_comp_descriptor']?['InChIKey'] as String?)
              .toList());
        ligandSmilesBuild.add(npe
              ?.map((e) => e?['nonpolymer_comp']?['rcsb_chem_comp_descriptor']?['SMILES_stereo'] as String?)
              .toList());
        relatedCodeBuild.add(npe
              ?.map((e) => (e?['nonpolymer_comp']?['rcsb_chem_comp_related'] as List?)
                ?.map((f) => f?['resource_accession_code'] as String?)
                .toList())
              .toList());
        relatedNameBuild.add(npe
              ?.map((e) => (e?['nonpolymer_comp']?['rcsb_chem_comp_related'] as List?)
                ?.map((f) => f?['resource_name'] as String?)
                .toList())
              .toList());
        ligandInterestBuild.add(npe
              ?.map((e) => (e?['rcsb_nonpolymer_entity_annotation'] as List?)
                ?.map((f) => f?['type'] as String?)
                .toList())
              .toList());
      }
      return Features(
        ligandFormula: ligandFormulaBuild,
        ligandMW: ligandMWBuild,
        ligandID: ligandIDBuild,
        ligandName: ligandNameBuild,
        inChI: inChIBuild,
        inChIKey: inChIKeyBuild,
        ligandSmiles: ligandSmilesBuild,
        relatedCode: relatedCodeBuild,
        relatedName: relatedNameBuild,
        ligandInterest: ligandInterestBuild,
      );
    } catch (e) {
      throw FormatException('Invalid JSON format: $e');
    }
  }
}

// class NonPolymerEntityData {
//   final IDs ids;
//   final Features features;

//   NonPolymerEntityData({
//     required this.ids,
//     required this.features,
//   });

//   factory NonPolymerEntityData.fromJson(List entries) {
//     return NonPolymerEntityData(
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
//         List<Map<String, dynamic>?>? nonPolyEnts = data['nonpolymer_entity_instances'];

//         entityIDBuild.add(nonPolyEnts
//               ?.map((e) => e?['nonpolymer_entity_instance_container_identifiers']?['entity_id'] as String?)
//               .toList());
//         asymIDBuild.add(
//               nonPolyEnts?.map((e) => (e?['nonpolymer_entity_instances'] as List?)
//                 ?.map((f) => f?['rcsb_nonpolymer_instance_container_identifiers']?['asym_id'] as String?)
//                 .toList())
//               .toList());
//         authAsymIDBuild.add(nonPolyEnts
//               ?.map((e) => (e?['nonpolymer_entity_instances'] as List?)
//                 ?.map((f) => f?['rcsb_nonpolymer_instance_container_identifiers']?['auth_asym_id'] as String?)
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
//   final List<List<String?>?> ligandFormula;
//   final List<List<num?>?> ligandMW;
//   final List<List<String?>?> ligandID;
//   final List<List<String?>?> ligandName;
//   final List<List<String?>?> inChI;
//   final List<List<String?>?> inChIKey;
//   final List<List<String?>?> ligandSmiles;
//   final List<List<List<String?>?>?> relatedCode;
//   final List<List<List<String?>?>?> relatedName;
//   final List<List<List<String?>?>?> ligandInterest;

//   Features({
//     required this.ligandFormula,
//     required this.ligandMW,
//     required this.ligandID,
//     required this.ligandName,
//     required this.inChI,
//     required this.inChIKey,
//     required this.ligandSmiles,
//     required this.relatedCode,
//     required this.relatedName,
//     required this.ligandInterest,
//   });

//   factory Features.fromJson(List entries) {
//     List<List<String?>?> ligandFormulaBuild = [];
//     List<List<num?>?> ligandMWBuild = [];
//     List<List<String?>?> ligandIDBuild = [];
//     List<List<String?>?> ligandNameBuild = [];
//     List<List<String?>?> inChIBuild = [];
//     List<List<String?>?> inChIKeyBuild = [];
//     List<List<String?>?> ligandSmilesBuild = [];
//     List<List<List<String?>?>?> relatedCodeBuild = [];
//     List<List<List<String?>?>?> relatedNameBuild = [];
//     List<List<List<String?>?>?> ligandInterestBuild = [];

//     try {
//       for (Map<String, dynamic> entry in entries) {
//         Map<String, dynamic> data = entry['data'];
//         List<Map<String, dynamic>?>? npe = data['nonpolymer_entities']?.cast<Map<String, dynamic>?>();
        
//         ligandFormulaBuild.add(npe
//               ?.map((e) => e?['nonpolymer_comp']?['chem_comp']?['formula'] as String?)
//               .toList());
//         ligandMWBuild.add(npe
//               ?.map((e) => e?['nonpolymer_comp']?['chem_comp']?['formula_weight'] as num?)
//               .toList());
//         ligandIDBuild.add(npe
//               ?.map((e) => e?['nonpolymer_comp']?['chem_comp']?['id'] as String?)
//               .toList());
//         ligandNameBuild.add(npe
//               ?.map((e) => e?['nonpolymer_comp']?['chem_comp']?['name'] as String?)
//               .toList());
//         inChIBuild.add(npe
//               ?.map((e) => e?['nonpolymer_comp']?['rcsb_chem_comp_descriptor']?['InChI'] as String?)
//               .toList());
//         inChIKeyBuild.add(npe
//               ?.map((e) => e?['nonpolymer_comp']?['rcsb_chem_comp_descriptor']?['InChIKey'] as String?)
//               .toList());
//         ligandSmilesBuild.add(npe
//               ?.map((e) => e?['nonpolymer_comp']?['rcsb_chem_comp_descriptor']?['SMILES'] as String?)
//               .toList());
//         relatedCodeBuild.add(npe
//               ?.map((e) => (e?['nonpolymer_comp']?['rcsb_chem_comp_related'] as List?)
//                 ?.map((f) => f?['resource_accession_code'] as String?)
//                 .toList())
//               .toList());
//         relatedNameBuild.add(npe
//               ?.map((e) => (e?['nonpolymer_comp']?['rcsb_chem_comp_related'] as List?)
//                 ?.map((f) => f?['resource_name'] as String?)
//                 .toList())
//               .toList());
//         ligandInterestBuild.add(npe
//               ?.map((e) => (e?['rcsb_nonpolymer_entity_annotation'] as List?)
//                 ?.map((f) => f?['type'] as String?)
//                 .toList())
//               .toList());
//       }
//       return Features(
//         ligandFormula: ligandFormulaBuild,
//         ligandMW: ligandMWBuild,
//         ligandID: ligandIDBuild,
//         ligandName: ligandNameBuild,
//         inChI: inChIBuild,
//         inChIKey: inChIKeyBuild,
//         ligandSmiles: ligandSmilesBuild,
//         relatedCode: relatedCodeBuild,
//         relatedName: relatedNameBuild,
//         ligandInterest: ligandInterestBuild,
//       );
//     } catch (e) {
//       throw FormatException('Invalid JSON format: $e');
//     }
//   }
// }