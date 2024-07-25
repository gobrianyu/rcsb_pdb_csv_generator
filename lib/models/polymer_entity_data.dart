class PolymerEntityData {
  final IDs ids;
  final EntitySourceOrganism entitySourceOrganism;
  final PolymerFeatures polymerFeatures;

  PolymerEntityData({
    required this.ids,
    required this.entitySourceOrganism,
    required this.polymerFeatures,
  });

  factory PolymerEntityData.fromJson(List entries) {
    return PolymerEntityData(
      ids: IDs.fromJson(entries),
      entitySourceOrganism: EntitySourceOrganism.fromJson(entries),
      polymerFeatures: PolymerFeatures.fromJson(entries),
    );
  }
}

class IDs {
  final List<String?> entityID;
  final List<String?> entryID;
  final List<List<String?>?> asymID;
  final List<List<String?>?> authAsymID;

  IDs({
    required this.entityID,
    required this.entryID,
    required this.asymID,
    required this.authAsymID,
  });

  factory IDs.fromJson(List entries) {
    List<String?> entityIDBuild = [];
    List<String?> entryIDBuild = [];
    List<List<String?>?> asymIDBuild = [];
    List<List<String?>?> authAsymIDBuild = [];

    try {
      for (Map<String, dynamic> entry in entries) {
        entityIDBuild.add(entry['rcsb_polymer_entity_container_identifiers']?['entity_id'] as String?);
        entryIDBuild.add(entry['rcsb_polymer_entity_container_identifiers']?['entry_id'] as String?);
        asymIDBuild.add((entry['polymer_entity_instances'] as List?)
              ?.map((e) => e?['rcsb_polymer_entity_instance_container_identifiers']?['asym_id'] as String?)
              .toList());
        authAsymIDBuild.add((entry['polymer_entity_instances'] as List?)
              ?.map((e) => e?['rcsb_polymer_entity_instance_container_identifiers']?['auth_asym_id'] as String?)
              .toList());
      }
      return IDs(
        entityID: entityIDBuild,
        entryID: entryIDBuild,
        asymID: asymIDBuild,
        authAsymID: authAsymIDBuild,
      );
    } catch (e) {
      throw FormatException('Invalid JSON format: $e');
    }
  }
}

class EntitySourceOrganism {
  final List<List<List<String?>?>?> expHost;
  final List<List<List<String?>?>?> srcOrg;
  final List<List<List<num?>?>?> taxID;
  final List<List<List<List<String?>?>?>?> provSrc;
  final List<List<List<List<String?>?>?>?> geneName;

  EntitySourceOrganism({
    required this.expHost,
    required this.srcOrg,
    required this.taxID,
    required this.provSrc,
    required this.geneName,
  });
  
  factory EntitySourceOrganism.fromJson(List entries) {
    List<List<List<String?>?>?> expHostBuild = [];
    List<List<List<String?>?>?> srcOrgBuild = [];
    List<List<List<num?>?>?> taxIDBuild = [];
    List<List<List<List<String?>?>?>?> provSrcBuild = [];
    List<List<List<List<String?>?>?>?> geneNameBuild = [];
    try {
      for (Map<String, dynamic> entry in entries) {
        List<Map<String, dynamic>?>? polyEnts = entry['polymer_entities']?.cast<Map<String, dynamic>?>();

        expHostBuild.add(polyEnts
              ?.map((e) => (e?['rcsb_entity_host_organism'] as List?)
                ?.map((f) => f?['ncbi_scientific_name'] as String?)
                .toList())
              .toList());
        srcOrgBuild.add(polyEnts
              ?.map((e) => (e?['rcsb_entity_source_organism'] as List?)
                ?.map((f) => f?['ncbi_scientific_name'] as String?)
                .toList())
              .toList());
        taxIDBuild.add(polyEnts
              ?.map((e) => (e?['rcsb_entity_source_organism'] as List?)
                ?.map((f) => f?['ncbi_taxonomy_id'] as num?)
                .toList())
              .toList());
        provSrcBuild.add(polyEnts
              ?.map((e) => (e?['rcsb_entity_source_organism'] as List?)
                ?.map((f) => (f?['rcsb_gene_name'] as List?)
                  ?.map((g) => g?['provenance_source'] as String?)
                  .toList())
                .toList())
              .toList());
        geneNameBuild.add(polyEnts
              ?.map((e) => (e?['rcsb_entity_source_organism'] as List?)
                ?.map((f) => (f?['rcsb_gene_name'] as List?)
                  ?.map((g) => g?['value'] as String?)
                  .toList())
                .toList())
              .toList());
      }
      return EntitySourceOrganism(
        expHost: expHostBuild,
        srcOrg: srcOrgBuild,
        taxID: taxIDBuild,
        provSrc: provSrcBuild,
        geneName: geneNameBuild,
      );
    } catch (e) {
      throw FormatException('Invalid JSON format: $e');
    }
  }
}

class PolymerFeatures {
  final List<List<String?>?> sequence;
  final List<List<String?>?> entPolyType;
  final List<List<num?>?> numTotal;
  final List<List<num?>?> sequenceLen;
  final List<List<String?>?> macromolecType;
  final List<List<List<String?>?>?> plasmidName;
  final List<List<List<num?>?>?> clusterID;
  final List<List<List<num?>?>?> clusterIDThresh;
  final List<List<num?>?> molecWeight;
  final List<List<String?>?> macromolecName; // description
  final List<List<List<String?>?>?> macromolecNameList; // combined [list]
  final List<List<List<String?>?>?> ecNum;
  final List<List<List<String?>?>?> ecProvSrc;
  final List<List<List<String?>?>?> provCodeECO;
  final List<List<List<String?>?>?> provSrc;
  final List<List<List<String?>?>?> annotID;
  final List<List<List<List<String?>?>?>?> annotLineage;
  final List<List<List<String?>?>?> annotType;
  final List<List<List<String?>?>?> accessCode;
  final List<List<List<String?>?>?> dbName;
  final List<List<List<String?>?>?> provCode;
  final List<List<List<String?>?>?> value;
  
  PolymerFeatures({
    required this.sequence,
    required this.entPolyType,
    required this.numTotal,
    required this.sequenceLen,
    required this.macromolecType,
    required this.plasmidName,
    required this.clusterID,
    required this.clusterIDThresh,
    required this.molecWeight,
    required this.macromolecName,
    required this.macromolecNameList,
    required this.ecNum,
    required this.ecProvSrc,
    required this.provCodeECO,
    required this.provSrc,
    required this.annotID,
    required this.annotLineage,
    required this.annotType,
    required this.accessCode,
    required this.dbName,
    required this.provCode,
    required this.value,
  });

  factory PolymerFeatures.fromJson(List entries) {
    List<List<String?>?> sequenceBuild = [];
    List<List<String?>?> entPolyTypeBuild = [];
    List<List<num?>?> numTotalBuild = [];
    List<List<num?>?> sequenceLenBuild = [];
    List<List<String?>?> macromolecTypeBuild = [];
    List<List<List<String?>?>?> plasmidNameBuild = [];
    List<List<List<num?>?>?> clusterIDBuild = [];
    List<List<List<num?>?>?> clusterIDThreshBuild = [];
    List<List<num?>?> molecWeightBuild = [];
    List<List<String?>?> macromolecNameBuild = [];
    List<List<List<String?>?>?> macromolecNameListBuild = [];
    List<List<List<String?>?>?> ecNumBuild = [];
    List<List<List<String?>?>?> ecProvSrcBuild = [];
    List<List<List<String?>?>?> provCodeECOBuild = [];
    List<List<List<String?>?>?> provSrcBuild = [];
    List<List<List<String?>?>?> annotIDBuild = [];
    List<List<List<List<String?>?>?>?> annotLineageBuild = [];
    List<List<List<String?>?>?> annotTypeBuild = [];
    List<List<List<String?>?>?> accessCodeBuild = [];
    List<List<List<String?>?>?> dbNameBuild = [];
    List<List<List<String?>?>?> provCodeBuild = [];
    List<List<List<String?>?>?> valueBuild = [];

    try {
      for (Map<String, dynamic> entry in entries) {
        List<Map<String, dynamic>?>? polyEnts = entry['polymer_entities']?.cast<Map<String, dynamic>?>();
        
        sequenceBuild.add(
              polyEnts
                ?.map((e) => e?['entity_poly']?['pdbx_seq_one_letter_code_can'] as String?)
                .toList());
        entPolyTypeBuild.add(
              polyEnts
                ?.map((e) => e?['entity_poly']?['rcsb_entity_polymer_type'] as String?)
                .toList());
        numTotalBuild.add(
              polyEnts
                ?.map((e) => e?['rcsb_polymer_entity']?['pdbx_number_of_molecules'] as num?)
                .toList());
        sequenceLenBuild.add(
              polyEnts
                ?.map((e) => e?['entity_poly']?['rcsb_sample_sequence_length'] as num?)
                .toList());
        macromolecTypeBuild.add(
              polyEnts
                ?.map((e) => e?['entity_poly']?['type'] as String?)
                .toList());
        plasmidNameBuild.add(
              polyEnts
                ?.map((e) => (e?['entity_src_gen'] as List?)
                  ?.map((f) => f?['plasmid_name'] as String?)
                  .toList())
                .toList());
        clusterIDBuild.add(
              polyEnts
                ?.map((e) => (e?['rcsb_cluster_membership'] as List?)
                  ?.map((f) => f?['cluster_id'] as num?)
                  .toList())
                .toList());
        clusterIDThreshBuild.add(
              polyEnts
                ?.map((e) => (e?['rcsb_cluster_membership'] as List?)
                  ?.map((f) => f?['identity'] as num?)
                  .toList())
                .toList());
        molecWeightBuild.add(
              polyEnts
                ?.map((e) => e?['rcsb_polymer_entity']?['formula_weight'] as num?)
                .toList());
        macromolecNameBuild.add(
              polyEnts
                ?.map((e) => e?['rcsb_polymer_entity']?['pdbx_description'] as String?)
                .toList());
        macromolecNameListBuild.add(
              polyEnts
                ?.map((e) => (e?['rcsb_polymer_entity']?['rcsb_macromolecular_names_combined'] as List?)
                  ?.map((f) => (f?['name'] as String?))
                  .toList())
                .toList());
        ecNumBuild.add(
              polyEnts
                ?.map((e) => (e?['rcsb_polymer_entity']?['rcsb_enzyme_class_combined'] as List?)
                  ?.map((f) => f?['ec'] as String?)
                  .toList())
                .toList());
        ecProvSrcBuild.add(
              polyEnts
                ?.map((e) => (e?['rcsb_polymer_entity']?['rcsb_enzyme_class_combined'] as List?)
                  ?.map((f) => f?['provenance_source'] as String?)
                  .toList())
                .toList());
        provCodeECOBuild.add(
              polyEnts
                ?.map((e) => (e?['rcsb_polymer_entity']?['rcsb_macromolecular_names_combined'] as List?)
                  ?.map((f) => f?['provenance_code'] as String?)
                  .toList())
                .toList());
        provSrcBuild.add(
              polyEnts
                ?.map((e) => (e?['rcsb_polymer_entity']?['rcsb_macromolecular_names_combined'] as List?)
                  ?.map((f) => f['provenance_source'] as String?)
                  .toList())
                .toList());
        annotIDBuild.add(
              polyEnts
                ?.map((e) => (e?['rcsb_polymer_entity_annotation'] as List?)
                  ?.map((f) => f?['annotation_id'] as String?)
                  .toList())
                .toList());
        annotLineageBuild.add(
              polyEnts
                ?.map((e) => (e?['rcsb_polymer_entity_annotation'] as List?)
                  ?.map((f) => (f?['annotation_lineage'] as List?)
                    ?.map((g) => g?['name'] as String?)
                    .toList())
                  .toList())
                .toList());
        annotTypeBuild.add(
              polyEnts
                ?.map((e) => (e?['rcsb_polymer_entity_annotation'] as List?)
                  ?.map((f) => f?['type'] as String?)
                  .toList())
                .toList());
        accessCodeBuild.add(
              polyEnts
                ?.map((e) => (e?['rcsb_polymer_entity_container_identifiers']?['reference_sequence_identifiers'] as List?)
                  ?.map((f) => f?['database_accession'] as String?)
                  .toList())
                .toList());
        dbNameBuild.add(
              polyEnts
                ?.map((e) => (e?['rcsb_polymer_entity_container_identifiers']?['reference_sequence_identifiers'] as List?)
                  ?.map((f) => f?['database_name'] as String?)
                  .toList())
                .toList());
        provCodeBuild.add(
              polyEnts
                ?.map((e) => (e?['uniprots'] as List?)
                  ?.map((f) => f?['rcsb_uniprot_protein']?['name']?['provenance_code'] as String?)
                  .toList())
                .toList());
        valueBuild.add(
              polyEnts
                ?.map((e) => (e?['uniprots'] as List?)
                  ?.map((f) => f?['rcsb_uniprot_protein']?['name']?['value'] as String?)
                  .toList())
                .toList());
      }
      return PolymerFeatures(
        sequence: sequenceBuild,
        entPolyType: entPolyTypeBuild,
        numTotal: numTotalBuild,
        sequenceLen: sequenceLenBuild,
        macromolecType: macromolecTypeBuild,
        plasmidName: plasmidNameBuild,
        clusterID: clusterIDBuild,
        clusterIDThresh: clusterIDThreshBuild,
        molecWeight: molecWeightBuild,
        macromolecName: macromolecNameBuild,
        macromolecNameList: macromolecNameListBuild,
        ecNum: ecNumBuild,
        ecProvSrc: ecProvSrcBuild,
        provCodeECO: provCodeECOBuild,
        provSrc: provSrcBuild,
        annotID: annotIDBuild,
        annotLineage: annotLineageBuild,
        annotType: annotTypeBuild,
        accessCode: accessCodeBuild,
        dbName: dbNameBuild,
        provCode: provCodeBuild,
        value: valueBuild,
      );
    } catch (e) {
      throw FormatException('Invalid JSON format: $e');
    }
  }
}

// class PolymerEntityData {
//   final IDs ids;
//   final EntitySourceOrganism entitySourceOrganism;
//   final PolymerFeatures polymerFeatures;

//   PolymerEntityData({
//     required this.ids,
//     required this.entitySourceOrganism,
//     required this.polymerFeatures,
//   });

//   factory PolymerEntityData.fromJson(List entries) {
//     return PolymerEntityData(
//       ids: IDs.fromJson(entries),
//       entitySourceOrganism: EntitySourceOrganism.fromJson(entries),
//       polymerFeatures: PolymerFeatures.fromJson(entries),
//     );
//   }
// }

// class IDs {
//   final List<String?> entityID;
//   final List<String?> entryID;
//   final List<List<String?>?> asymID;
//   final List<List<String?>?> authAsymID;

//   IDs({
//     required this.entityID,
//     required this.entryID,
//     required this.asymID,
//     required this.authAsymID,
//   });

//   factory IDs.fromJson(List entries) {
//     List<String?> entityIDBuild = [];
//     List<String?> entryIDBuild = [];
//     List<List<String?>?> asymIDBuild = [];
//     List<List<String?>?> authAsymIDBuild = [];

//     try {
//       for (Map<String, dynamic> entry in entries) {
//         entityIDBuild.add(entry['rcsb_polymer_entity_container_identifiers']?['entity_id'] as String?);
//         entryIDBuild.add(entry['rcsb_polymer_entity_container_identifiers']?['entry_id'] as String?);
//         asymIDBuild.add((entry['polymer_entity_instances'] as List?)
//               ?.map((e) => e?['rcsb_polymer_entity_instance_container_identifiers']?['asym_id'] as String?)
//               .toList());
//         authAsymIDBuild.add((entry['polymer_entity_instances'] as List?)
//               ?.map((e) => e?['rcsb_polymer_entity_instance_container_identifiers']?['auth_asym_id'] as String?)
//               .toList());
//       }
//       return IDs(
//         entityID: entityIDBuild,
//         entryID: entryIDBuild,
//         asymID: asymIDBuild,
//         authAsymID: authAsymIDBuild,
//       );
//     } catch (e) {
//       throw FormatException('Invalid JSON format: $e');
//     }
//   }
// }

// class EntitySourceOrganism {
//   final List<List<List<String?>?>?> expHost;
//   final List<List<List<String?>?>?> srcOrg;
//   final List<List<List<num?>?>?> taxID;
//   final List<List<List<List<String?>?>?>?> provSrc;
//   final List<List<List<List<String?>?>?>?> geneName;

//   EntitySourceOrganism({
//     required this.expHost,
//     required this.srcOrg,
//     required this.taxID,
//     required this.provSrc,
//     required this.geneName,
//   });
  
//   factory EntitySourceOrganism.fromJson(List entries) {
//     List<List<List<String?>?>?> expHostBuild = [];
//     List<List<List<String?>?>?> srcOrgBuild = [];
//     List<List<List<num?>?>?> taxIDBuild = [];
//     List<List<List<List<String?>?>?>?> provSrcBuild = [];
//     List<List<List<List<String?>?>?>?> geneNameBuild = [];
//     try {
//       for (Map<String, dynamic> entry in entries) {
//         List<Map<String, dynamic>?>? polyEnts = entry['polymer_entities']?.cast<Map<String, dynamic>?>();

//         expHostBuild.add(polyEnts
//               ?.map((e) => (e?['rcsb_entity_host_organism'] as List?)
//                 ?.map((f) => f?['ncbi_scientific_name'] as String?)
//                 .toList())
//               .toList());
//         srcOrgBuild.add(polyEnts
//               ?.map((e) => (e?['rcsb_entity_source_organism'] as List?)
//                 ?.map((f) => f?['ncbi_scientific_name'] as String?)
//                 .toList())
//               .toList());
//         taxIDBuild.add(polyEnts
//               ?.map((e) => (e?['rcsb_entity_source_organism'] as List?)
//                 ?.map((f) => f?['ncbi_taxonomy_id'] as num?)
//                 .toList())
//               .toList());
//         provSrcBuild.add(polyEnts
//               ?.map((e) => (e?['rcsb_entity_source_organism'] as List?)
//                 ?.map((f) => (f?['rcsb_gene_name'] as List?)
//                   ?.map((g) => g?['provenance_source'] as String?)
//                   .toList())
//                 .toList())
//               .toList());
//         geneNameBuild.add(polyEnts
//               ?.map((e) => (e?['rcsb_entity_source_organism'] as List?)
//                 ?.map((f) => (f?['rcsb_gene_name'] as List?)
//                   ?.map((g) => g?['value'] as String?)
//                   .toList())
//                 .toList())
//               .toList());
//       }
//       return EntitySourceOrganism(
//         expHost: expHostBuild,
//         srcOrg: srcOrgBuild,
//         taxID: taxIDBuild,
//         provSrc: provSrcBuild,
//         geneName: geneNameBuild,
//       );
//     } catch (e) {
//       throw FormatException('Invalid JSON format: $e');
//     }
//   }
// }

// class PolymerFeatures {
//   final List<List<String?>?> sequence;
//   final List<List<String?>?> entPolyType;
//   final List<List<num?>?> numTotal;
//   final List<List<num?>?> sequenceLen;
//   final List<List<String?>?> macromolecType;
//   final List<List<List<String?>?>?> plasmidName;
//   final List<List<List<num?>?>?> clusterID;
//   final List<List<List<num?>?>?> clusterIDThresh;
//   final List<List<num?>?> molecWeight;
//   final List<List<String?>?> macromolecName; // description
//   final List<List<List<String?>?>?> macromolecNameList; // combined [list]
//   final List<List<List<String?>?>?> ecNum;
//   final List<List<List<String?>?>?> ecProvSrc;
//   final List<List<List<String?>?>?> provCodeECO;
//   final List<List<List<String?>?>?> provSrc;
//   final List<List<List<String?>?>?> annotID;
//   final List<List<List<List<String?>?>?>?> annotLineage;
//   final List<List<List<String?>?>?> annotType;
//   final List<List<List<String?>?>?> accessCode;
//   final List<List<List<String?>?>?> dbName;
//   final List<List<List<String?>?>?> provCode;
//   final List<List<List<String?>?>?> value;
  
//   PolymerFeatures({
//     required this.sequence,
//     required this.entPolyType,
//     required this.numTotal,
//     required this.sequenceLen,
//     required this.macromolecType,
//     required this.plasmidName,
//     required this.clusterID,
//     required this.clusterIDThresh,
//     required this.molecWeight,
//     required this.macromolecName,
//     required this.macromolecNameList,
//     required this.ecNum,
//     required this.ecProvSrc,
//     required this.provCodeECO,
//     required this.provSrc,
//     required this.annotID,
//     required this.annotLineage,
//     required this.annotType,
//     required this.accessCode,
//     required this.dbName,
//     required this.provCode,
//     required this.value,
//   });

//   factory PolymerFeatures.fromJson(List entries) {
//     List<List<String?>?> sequenceBuild = [];
//     List<List<String?>?> entPolyTypeBuild = [];
//     List<List<num?>?> numTotalBuild = [];
//     List<List<num?>?> sequenceLenBuild = [];
//     List<List<String?>?> macromolecTypeBuild = [];
//     List<List<List<String?>?>?> plasmidNameBuild = [];
//     List<List<List<num?>?>?> clusterIDBuild = [];
//     List<List<List<num?>?>?> clusterIDThreshBuild = [];
//     List<List<num?>?> molecWeightBuild = [];
//     List<List<String?>?> macromolecNameBuild = [];
//     List<List<List<String?>?>?> macromolecNameListBuild = [];
//     List<List<List<String?>?>?> ecNumBuild = [];
//     List<List<List<String?>?>?> ecProvSrcBuild = [];
//     List<List<List<String?>?>?> provCodeECOBuild = [];
//     List<List<List<String?>?>?> provSrcBuild = [];
//     List<List<List<String?>?>?> annotIDBuild = [];
//     List<List<List<List<String?>?>?>?> annotLineageBuild = [];
//     List<List<List<String?>?>?> annotTypeBuild = [];
//     List<List<List<String?>?>?> accessCodeBuild = [];
//     List<List<List<String?>?>?> dbNameBuild = [];
//     List<List<List<String?>?>?> provCodeBuild = [];
//     List<List<List<String?>?>?> valueBuild = [];

//     try {
//       for (Map<String, dynamic> entry in entries) {
//         List<Map<String, dynamic>?>? polyEnts = entry['polymer_entities']?.cast<Map<String, dynamic>?>();
        
//         sequenceBuild.add(
//               polyEnts
//                 ?.map((e) => e?['entity_poly']?['pdbx_seq_one_letter_code_can'] as String?)
//                 .toList());
//         entPolyTypeBuild.add(
//               polyEnts
//                 ?.map((e) => e?['entity_poly']?['rcsb_entity_polymer_type'] as String?)
//                 .toList());
//         numTotalBuild.add(
//               polyEnts
//                 ?.map((e) => e?['rcsb_polymer_entity']?['pdbx_number_of_molecules'] as num?)
//                 .toList());
//         sequenceLenBuild.add(
//               polyEnts
//                 ?.map((e) => e?['entity_poly']?['rcsb_sample_sequence_length'] as num?)
//                 .toList());
//         macromolecTypeBuild.add(
//               polyEnts
//                 ?.map((e) => e?['entity_poly']?['type'] as String?)
//                 .toList());
//         plasmidNameBuild.add(
//               polyEnts
//                 ?.map((e) => (e?['entity_src_gen'] as List?)
//                   ?.map((f) => f?['plasmid_name'] as String?)
//                   .toList())
//                 .toList());
//         clusterIDBuild.add(
//               polyEnts
//                 ?.map((e) => (e?['rcsb_cluster_membership'] as List?)
//                   ?.map((f) => f?['cluster_id'] as num?)
//                   .toList())
//                 .toList());
//         clusterIDThreshBuild.add(
//               polyEnts
//                 ?.map((e) => (e?['rcsb_cluster_membership'] as List?)
//                   ?.map((f) => f?['identity'] as num?)
//                   .toList())
//                 .toList());
//         molecWeightBuild.add(
//               polyEnts
//                 ?.map((e) => e?['rcsb_polymer_entity']?['formula_weight'] as num?)
//                 .toList());
//         macromolecNameBuild.add(
//               polyEnts
//                 ?.map((e) => e?['rcsb_polymer_entity']?['pdbx_description'] as String?)
//                 .toList());
//         macromolecNameListBuild.add(
//               polyEnts
//                 ?.map((e) => (e?['rcsb_polymer_entity']?['rcsb_macromolecular_names_combined'] as List?)
//                   ?.map((f) => (f?['name'] as String?))
//                   .toList())
//                 .toList());
//         ecNumBuild.add(
//               polyEnts
//                 ?.map((e) => (e?['rcsb_polymer_entity']?['rcsb_enzyme_class_combined'] as List?)
//                   ?.map((f) => f?['ec'] as String?)
//                   .toList())
//                 .toList());
//         ecProvSrcBuild.add(
//               polyEnts
//                 ?.map((e) => (e?['rcsb_polymer_entity']?['rcsb_enzyme_class_combined'] as List?)
//                   ?.map((f) => f?['provenance_source'] as String?)
//                   .toList())
//                 .toList());
//         provCodeECOBuild.add(
//               polyEnts
//                 ?.map((e) => (e?['rcsb_polymer_entity']?['rcsb_macromolecular_names_combined'] as List?)
//                   ?.map((f) => f?['provenance_code'] as String?)
//                   .toList())
//                 .toList());
//         provSrcBuild.add(
//               polyEnts
//                 ?.map((e) => (e?['rcsb_polymer_entity']?['rcsb_macromolecular_names_combined'] as List?)
//                   ?.map((f) => f['provenance_source'] as String?)
//                   .toList())
//                 .toList());
//         annotIDBuild.add(
//               polyEnts
//                 ?.map((e) => (e?['rcsb_polymer_entity_annotation'] as List?)
//                   ?.map((f) => f?['annotation_id'] as String?)
//                   .toList())
//                 .toList());
//         annotLineageBuild.add(
//               polyEnts
//                 ?.map((e) => (e?['rcsb_polymer_entity_annotation'] as List?)
//                   ?.map((f) => (f?['annotation_lineage'] as List?)
//                     ?.map((g) => g?['name'] as String?)
//                     .toList())
//                   .toList())
//                 .toList());
//         annotTypeBuild.add(
//               polyEnts
//                 ?.map((e) => (e?['rcsb_polymer_entity_annotation'] as List?)
//                   ?.map((f) => f?['type'] as String?)
//                   .toList())
//                 .toList());
//         accessCodeBuild.add(
//               polyEnts
//                 ?.map((e) => (e?['rcsb_polymer_entity_container_identifiers']?['reference_sequence_identifiers'] as List?)
//                   ?.map((f) => f?['database_accession'] as String?)
//                   .toList())
//                 .toList());
//         dbNameBuild.add(
//               polyEnts
//                 ?.map((e) => (e?['rcsb_polymer_entity_container_identifiers']?['reference_sequence_identifiers'] as List?)
//                   ?.map((f) => f?['database_name'] as String?)
//                   .toList())
//                 .toList());
//         provCodeBuild.add(
//               polyEnts
//                 ?.map((e) => (e?['uniprots'] as List?)
//                   ?.map((f) => f?['rcsb_uniprot_protein']?['name']?['provenance_code'] as String?)
//                   .toList())
//                 .toList());
//         valueBuild.add(
//               polyEnts
//                 ?.map((e) => (e?['uniprots'] as List?)
//                   ?.map((f) => f?['rcsb_uniprot_protein']?['name']?['value'] as String?)
//                   .toList())
//                 .toList());
//       }
//       return PolymerFeatures(
//         sequence: sequenceBuild,
//         entPolyType: entPolyTypeBuild,
//         numTotal: numTotalBuild,
//         sequenceLen: sequenceLenBuild,
//         macromolecType: macromolecTypeBuild,
//         plasmidName: plasmidNameBuild,
//         clusterID: clusterIDBuild,
//         clusterIDThresh: clusterIDThreshBuild,
//         molecWeight: molecWeightBuild,
//         macromolecName: macromolecNameBuild,
//         macromolecNameList: macromolecNameListBuild,
//         ecNum: ecNumBuild,
//         ecProvSrc: ecProvSrcBuild,
//         provCodeECO: provCodeECOBuild,
//         provSrc: provSrcBuild,
//         annotID: annotIDBuild,
//         annotLineage: annotLineageBuild,
//         annotType: annotTypeBuild,
//         accessCode: accessCodeBuild,
//         dbName: dbNameBuild,
//         provCode: provCodeBuild,
//         value: valueBuild,
//       );
//     } catch (e) {
//       throw FormatException('Invalid JSON format: $e');
//     }
//   }
// }