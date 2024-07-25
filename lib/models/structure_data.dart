class StructureData {
  final Keywords keywords;
  final Deposition deposition;
  final EntryFeatures entryFeatures;
  final GroupDeposition groupDeposition;
  final Dimensions dimensions;
  final List<String?> components;
  final BindingAffinity bindingAffinity;
  final CrystalProperties crystalProperties;
  final Methods methods;
  final XRayData xRayData;
  final XRayMethod xRayMethod;
  final EMMethod emMethod;
  final NMRMethod nmrMethod;
  final PublicationsPrimary publicationsPrimary;

  StructureData({
    required this.keywords,
    required this.deposition,
    required this.entryFeatures,
    required this.groupDeposition,
    required this.dimensions,
    required this.components,
    required this.bindingAffinity,
    required this.crystalProperties,
    required this.methods,
    required this.xRayData,
    required this.xRayMethod,
    required this.emMethod,
    required this.nmrMethod,
    required this.publicationsPrimary,
  });

  factory StructureData.fromJson(List entries) {
    return StructureData(
      keywords: Keywords.fromJson(entries),
      deposition: Deposition.fromJson(entries),
      entryFeatures: EntryFeatures.fromJson(entries),
      groupDeposition: GroupDeposition.fromJson(entries),
      dimensions: Dimensions.fromJson(entries),
      components: _buildComponentsList(entries),
      bindingAffinity: BindingAffinity.fromJson(entries),
      crystalProperties: CrystalProperties.fromJson(entries),
      methods: Methods.fromJson(entries),
      xRayData: XRayData.fromJson(entries),
      xRayMethod: XRayMethod.fromJson(entries),
      emMethod: EMMethod.fromJson(entries),
      nmrMethod: NMRMethod.fromJson(entries),
      publicationsPrimary: PublicationsPrimary.fromJson(entries),
    );
  }
}

List<String?> _buildComponentsList(List entries) {
  List<String?> components = [];
  try {
    for (Map<String, dynamic> entry in entries) {
      components.add(entry['rcsb_binding_affinity']?[0]?['comp_id'] as String?);
    }
    return components;
  } catch (e) {
    throw FormatException('Invalid JSON format: $e');
  }
}

class Keywords {
  final List<String?> pdbID;
  final List<List<String?>?> emdbID;
  final List<List<String?>?> dbID;
  final List<String?> pmCentralID;
  final List<num?> pmID;
  final List<String?> doi;
  final List<String?> structKeywords;

  Keywords({
    required this.pdbID,
    required this.emdbID,
    required this.dbID,
    required this.pmCentralID,
    required this.pmID,
    required this.doi,
    required this.structKeywords,
  });

  factory Keywords.fromJson(List entries) {
    List<String?> pdbIDBuild = [];
    List<List<String?>?> emdbIDBuild = [];
    List<List<String?>?> dbIDBuild = [];
    List<String?> pmCentralIDBuild = [];
    List<num?> pmIDBuild = [];
    List<String?> doiBuild = [];
    List<String?> structKeywordsBuild = [];

    try {
      for (Map<String, dynamic> entry in entries) {
        Map<String, dynamic>? ids = entry['rcsb_entry_container_identifiers'];
        Map<String, dynamic>? pubmed = entry['pubmed'];

        pdbIDBuild.add(ids?['entry_id'] as String?);
        emdbIDBuild.add((ids?['emdb_ids'] as List?)?.map((e) => e as String?).toList());
        dbIDBuild.add((entry['pdbx_database_related'] as List?)
            ?.map((e) => (e as Map<String, dynamic>?)?['db_id'] as String?).toList());
        pmCentralIDBuild.add(pubmed?['rcsb_pubmed_central_id'] as String?);
        pmIDBuild.add(pubmed?['rcsb_pubmed_container_identifiers']?['pubmed_id'] as num?);
        doiBuild.add(pubmed?['rcsb_pubmed_doi'] as String?);
        structKeywordsBuild.add(entry['struct_keywords']?['pdbx_keywords'] as String?);

      }
      return Keywords(
        pdbID: pdbIDBuild, 
        emdbID: emdbIDBuild, 
        dbID: dbIDBuild, 
        pmCentralID: pmCentralIDBuild,
        pmID: pmIDBuild,
        doi: doiBuild,
        structKeywords: structKeywordsBuild,
      );
    } catch (e) {
      throw FormatException('Invalid JSON format: $e');
    }
  }
}

class Deposition {
  final List<List<String?>?> author;
  final List<String?> title;
  final List<String?> depoDate;
  final List<String?> releaseDate;
  final List<List<String?>?> projCenterName;
  final List<List<String?>?> projCenterInitials;
  final List<List<String?>?> projName;

  Deposition({
    required this.author,
    required this.title,
    required this.depoDate,
    required this.releaseDate,
    required this.projCenterName,
    required this.projCenterInitials,
    required this.projName,
  });

  factory Deposition.fromJson(List entries) {
    List<List<String?>?> authorBuild = [];
    List<String?> titleBuild = [];
    List<String?> depoDateBuild = [];
    List<String?> releaseDateBuild = [];
    List<List<String?>?> projCenterNameBuild = [];
    List<List<String?>?> projCenterInitialsBuild = [];
    List<List<String?>?> projNameBuild = [];
    
    try {
      for (Map<String, dynamic> entry in entries) {
        List<Map<String, dynamic>?>? project = entry['pdbx_SG_project']?.cast<Map<String, dynamic>?>();
        Map<String, dynamic>? accessInfo = entry['rcsb_accession_info'];

        authorBuild.add((entry['audit_author'] as List?)
            ?.map((e) => (e as Map<String, dynamic>?)?['name'] as String?)
            .toList());
        titleBuild.add(entry['struct']?['title'] as String?);
        depoDateBuild.add(accessInfo?['deposit_date'] as String?);
        releaseDateBuild.add(accessInfo?['initial_release_date'] as String?);
        projCenterNameBuild.add(project?.map((e) => e?['full_name_of_center'] as String?).toList());
        projCenterInitialsBuild.add(project?.map((e) => e?['initial_of_center'] as String?).toList());
        projNameBuild.add(project?.map((e) => e?['project_name'] as String?).toList());
      }
      return Deposition(
        author: authorBuild,
        title: titleBuild,
        depoDate: depoDateBuild,
        releaseDate: releaseDateBuild,
        projCenterName: projCenterNameBuild,
        projCenterInitials: projCenterInitialsBuild,
        projName: projNameBuild,
      );
    } catch (e) {
      throw FormatException('Invalid JSON format: $e');
    }
  }
}

class EntryFeatures {
  final List<num?> numNHAtoms;
  final List<num?> depoCount;
  final List<num?> numNonPolyIn;
  final List<num?> numPolyIn;
  final List<num?> numPolyResi;
  final List<num?> numH2O;
  final List<num?> disulfBCount;
  final List<num?> numEnt;
  final List<num?> molecWeight;
  final List<num?> numNonPolyEnt;
  final List<String?> entryPolyComp;
  final List<num?> numDNAEnt;
  final List<num?> numNAHybridEnt;
  final List<num?> numProteinEnt;
  final List<num?> numRNAEnt;
  final List<List<num?>?> refRes;
  final List<String?> types;

  EntryFeatures({
    required this.numNHAtoms,
    required this.depoCount,
    required this.numNonPolyIn,
    required this.numPolyIn,
    required this.numPolyResi,
    required this.numH2O,
    required this.disulfBCount,
    required this.numEnt,
    required this.molecWeight,
    required this.numNonPolyEnt,
    required this.entryPolyComp,
    required this.numDNAEnt,
    required this.numNAHybridEnt,
    required this.numProteinEnt,
    required this.numRNAEnt,
    required this.refRes,
    required this.types,
  });

  factory EntryFeatures.fromJson(List entries) {
    List<num?> numNHAtomsBuild = [];
    List<num?> depoCountBuild = [];
    List<num?> numNonPolyInBuild = [];
    List<num?> numPolyInBuild = [];
    List<num?> numPolyResiBuild = [];
    List<num?> numH2OBuild = [];
    List<num?> disulfBCountBuild = [];
    List<num?> numEntBuild = [];
    List<num?> molecWeightBuild = [];
    List<num?> numNonPolyEntBuild = [];
    List<String?> entryPolyCompBuild = [];
    List<num?> numDNAEntBuild = [];
    List<num?> numNAHybridEntBuild = [];
    List<num?> numProteinEntBuild = [];
    List<num?> numRNAEntBuild = [];
    List<List<num?>?> refResBuild = [];
    List<String?> typesBuild = [];

    try {
      for (Map<String, dynamic> entry in entries) {
        Map<String, dynamic>? entryInfo = entry['rcsb_entry_info'];

        numNHAtomsBuild.add(entryInfo?['deposited_atom_count'] as num?);
        depoCountBuild.add(entryInfo?['deposited_model_count'] as num?);
        numNonPolyInBuild.add(entryInfo?['deposited_nonpolymer_entity_instance_count'] as num?);
        numPolyInBuild.add(entryInfo?['deposited_polymer_entity_instance_count'] as num?);
        numPolyResiBuild.add(entryInfo?['deposited_polymer_monomer_count'] as num?);
        numH2OBuild.add(entryInfo?['deposited_solvent_atom_count'] as num?);
        disulfBCountBuild.add(entryInfo?['disulfide_bond_count'] as num?);
        numEntBuild.add(entryInfo?['entity_count'] as num?);
        molecWeightBuild.add(entryInfo?['molecular_weight'] as num?);
        numNonPolyEntBuild.add(entryInfo?['nonpolymer_entity_count'] as num?);
        entryPolyCompBuild.add(entryInfo?['polymer_composition'] as String?);
        numDNAEntBuild.add(entryInfo?['polymer_entity_count_DNA'] as num?);
        numNAHybridEntBuild.add(entryInfo?['polymer_entity_count_nucleic_acid_hybrid'] as num?);
        numProteinEntBuild.add(entryInfo?['polymer_entity_count_protein'] as num?);
        numRNAEntBuild.add(entryInfo?['polymer_entity_count_RNA'] as num?);
        refResBuild.add((entryInfo?['resolution_combined'] as List?)
          ?.map((e) => e as num?)
          .toList());
        typesBuild.add(entryInfo?['selected_polymer_entity_types'] as String?);
      }
      return EntryFeatures(
        numNHAtoms: numNHAtomsBuild,
        depoCount: depoCountBuild,
        numNonPolyIn: numNonPolyInBuild,
        numPolyIn: numPolyInBuild,
        numPolyResi: numPolyResiBuild,
        numH2O: numH2OBuild,
        disulfBCount: disulfBCountBuild,
        numEnt: numEntBuild,
        molecWeight: molecWeightBuild,
        numNonPolyEnt: numNonPolyEntBuild,
        entryPolyComp: entryPolyCompBuild,
        numDNAEnt: numDNAEntBuild,
        numNAHybridEnt: numNAHybridEntBuild,
        numProteinEnt: numProteinEntBuild,
        numRNAEnt: numRNAEntBuild,
        refRes: refResBuild,
        types: typesBuild,
      );
    } catch (e) {
      throw FormatException('Invalid JSON format: $e');
    }
  }
}

class GroupDeposition {
  final List<List<String?>?> id;
  final List<List<String?>?> description;
  final List<List<String?>?> title;
  final List<List<String?>?> type;

  GroupDeposition({
    required this.id,
    required this.description,
    required this.title,
    required this.type,
  });

  factory GroupDeposition.fromJson(List entries) {
    List<List<String?>?> idBuild = [];
    List<List<String?>?> descriptionBuild = [];
    List<List<String?>?> titleBuild = [];
    List<List<String?>?> typeBuild = [];
    
    try {
      for (Map<String, dynamic> entry in entries) {
        List<Map<String, dynamic>?>? group = entry['pdbx_deposit_group']?.cast<Map<String, dynamic>?>();

        idBuild.add(group?.map((e) => e?['group_id'] as String?).toList());
        descriptionBuild.add(group?.map((e) => e?['group_description'] as String?).toList());
        titleBuild.add(group?.map((e) => e?['group_title'] as String?).toList());
        typeBuild.add(group?.map((e) => e?['group_type'] as String?).toList());
      }
      return GroupDeposition(
        id: idBuild,
        description: descriptionBuild,
        title: titleBuild,
        type: typeBuild
      );
    } catch (e) {
      throw FormatException('Invalid JSON format: $e');
    }
  }
}

class Dimensions {
  final List<num?> zNum;
  final List<num?> alpha;
  final List<num?> beta;
  final List<num?> gamma;
  final List<num?> lA;
  final List<num?> lB;
  final List<num?> lC;
  final List<String?> spaceGroup;

  Dimensions({
    required this.zNum,
    required this.alpha,
    required this.beta,
    required this.gamma,
    required this.lA,
    required this.lB,
    required this.lC,
    required this.spaceGroup,
  });

  factory Dimensions.fromJson(List entries) {
    final List<num?> zNumBuild = [];
    final List<num?> alphaBuild = [];
    final List<num?> betaBuild = [];
    final List<num?> gammaBuild = [];
    final List<num?> lABuild = [];
    final List<num?> lBBuild = [];
    final List<num?> lCBuild = [];
    final List<String?> spaceGroupBuild = [];

    try {
      for (Map<String, dynamic> entry in entries) {
        Map<String, dynamic>? cell = entry['cell'];

        zNumBuild.add(cell?['Z_PDB'] as num?);
        alphaBuild.add(cell?['angle_alpha'] as num?);
        betaBuild.add(cell?['angle_beta'] as num?);
        gammaBuild.add(cell?['angle_gamma'] as num?);
        lABuild.add(cell?['length_a'] as num?);
        lBBuild.add(cell?['length_b'] as num?);
        lCBuild.add(cell?['length_c'] as num?);
        spaceGroupBuild.add(entry['symmetry']?['space_group_name_H_M'] as String?);
      }
      return Dimensions(
        zNum: zNumBuild,
        alpha: alphaBuild,
        beta: betaBuild,
        gamma: gammaBuild,
        lA: lABuild,
        lB: lBBuild,
        lC: lCBuild,
        spaceGroup: spaceGroupBuild
      );
    } catch (e) {
      throw FormatException('Invalid JSON format: $e');
    }
  }
}

class BindingAffinity {
  final List<List<num?>?> value;
  final List<List<String?>?> provenanceCode;
  final List<List<num?>?> refSequenceID;
  final List<List<String?>?> symbol;
  final List<List<String?>?> type;
  final List<List<String?>?> unit;

  BindingAffinity({
    required this.value,
    required this.provenanceCode,
    required this.refSequenceID,
    required this.symbol,
    required this.type,
    required this.unit,
  });

  factory BindingAffinity.fromJson(List entries) {
    List<List<num?>?> valueBuild = [];
    List<List<String?>?> provenanceCodeBuild = [];
    List<List<num?>?> refSequenceIDBuild = [];
    List<List<String?>?> symbolBuild = [];
    List<List<String?>?> typeBuild = [];
    List<List<String?>?> unitBuild = [];
    
    try {
      for (Map<String, dynamic> entry in entries) {
        List<Map<String, dynamic>?>? bA = entry['rcsb_binding_affinity']?.cast<Map<String, dynamic>?>();

        valueBuild.add(bA?.map((e) => e?['value'] as num?).toList());
        provenanceCodeBuild.add(bA?.map((e) => e?['provenance_code'] as String?).toList());
        refSequenceIDBuild.add(bA?.map((e) => e?['reference_sequence_identity'] as num?).toList());
        symbolBuild.add(bA?.map((e) => e?['symbol'] as String?).toList());
        typeBuild.add(bA?.map((e) => e?['type'] as String?).toList());
        unitBuild.add(bA?.map((e) => e?['unit'] as String?).toList());
      }
      return BindingAffinity(
        value: valueBuild,
        provenanceCode: provenanceCodeBuild,
        refSequenceID: refSequenceIDBuild,
        symbol: symbolBuild,
        type: typeBuild,
        unit: unitBuild,
      );
    } catch (e) {
      throw FormatException('Invalid JSON format: $e');
    }
  }
}

class CrystalProperties {
  final List<List<num?>?> matthews;
  final List<List<num?>?> perSolvent;
  final List<List<String?>?> crystalMeth;
  final List<List<num?>?> ph;
  final List<List<String?>?> growthProc;
  final List<List<num?>?> temp;

  CrystalProperties({
    required this.matthews,
    required this.perSolvent,
    required this.crystalMeth,
    required this.ph,
    required this.growthProc,
    required this.temp,
  });

  factory CrystalProperties.fromJson(List entries) {
    try {
      final List<List<num?>?> matthewsBuild = [];
      final List<List<num?>?> perSolventBuild = [];
      final List<List<String?>?> crystalMethBuild = [];
      final List<List<num?>?> phBuild = [];
      final List<List<String?>?> growthProcBuild = [];
      final List<List<num?>?> tempBuild = [];

      for (Map<String, dynamic> entry in entries) {
        List<Map<String, dynamic>?>? density = entry['exptl_crystal']?.cast<Map<String, dynamic>?>();
        List<Map<String, dynamic>?>? growth = entry['exptl_crystal_grow']?.cast<Map<String, dynamic>?>();

        matthewsBuild.add(density?.map((e) => e?['density_Matthews'] as num?).toList());
        perSolventBuild.add(density?.map((e) => e?['density_percent_sol'] as num?).toList());
        crystalMethBuild.add(growth?.map((e) => e?['method'] as String?).toList());
        phBuild.add(growth?.map((e) => e?['pH'] as num?).toList());
        growthProcBuild.add(growth?.map((e) => e?['pdbx_details'] as String?).toList());
        tempBuild.add(growth?.map((e) => e?['temp'] as num?).toList());
      }
      return CrystalProperties(
        matthews: matthewsBuild,
        perSolvent: perSolventBuild,
        crystalMeth: crystalMethBuild,
        ph: phBuild,
        growthProc: growthProcBuild,
        temp: tempBuild,
      );
    } catch (e) {
      throw FormatException('Invalid JSON format: $e');
    }
  }
}

class Methods {
  final List<List<String?>?> experimental;
  final List<String?> structDeter;

  Methods({
    required this.experimental,
    required this.structDeter,
  });

  factory Methods.fromJson(List entries) {
    List<List<String?>?> experimentalBuild = [];
    List<String?> structDeterBuild = [];

    try {
      for (Map<String, dynamic> entry in entries) {

        experimentalBuild.add((entry['exptl'] as List?)?.map((e) => (e as Map<String, dynamic>?)?['method'] as String?).toList());
        structDeterBuild.add(entry['rcsb_entry_info']?['structure_determination_methodology'] as String?);
      }
      return Methods(
        experimental: experimentalBuild,
        structDeter: structDeterBuild
      );
    } catch (e) {
      throw FormatException('Invalid JSON format: $e');
    }
  }
}

class XRayData {
  final List<List<num?>?> collectionTemp;
  final List<List<String?>?> detector;
  final List<List<String?>?> collectionDate;
  final List<List<String?>?> diffSourceGen;
  final List<List<String?>?> diffSourceM;
  final List<num?> collectionRes;
  final List<List<num?>?> bWilsonEst;
  final List<List<num?>?> redundancy;
  final List<List<num?>?> perPossRefl;
  final List<List<num?>?> rValMergeInten;
  final List<List<String?>?> diffSourceSyncSite;
  final List<List<String?>?> diffSourceSyncBeam;
  final List<num?> minDiffWave;
  final List<num?> maxDiffWave;

  XRayData({
    required this.collectionTemp,
    required this.detector,
    required this.collectionDate,
    required this.diffSourceGen,
    required this.diffSourceM,
    required this.collectionRes,
    required this.bWilsonEst,
    required this.redundancy,
    required this.perPossRefl,
    required this.rValMergeInten,
    required this.diffSourceSyncSite,
    required this.diffSourceSyncBeam,
    required this.minDiffWave,
    required this.maxDiffWave,
  });

  factory XRayData.fromJson(List entries) {
    List<List<num?>?> collectionTempBuild = [];
    List<List<String?>?> detectorBuild = [];
    List<List<String?>?> collectionDateBuild = [];
    List<List<String?>?> diffSourceGenBuild = [];
    List<List<String?>?> diffSourceMBuild = [];
    List<num?> collectionResBuild = [];
    List<List<num?>?> bWilsonEstBuild = [];
    List<List<num?>?> redundancyBuild = [];
    List<List<num?>?> perPossReflBuild = [];
    List<List<num?>?> rValMergeIntenBuild = [];
    List<List<String?>?> diffSourceSyncSiteBuild = [];
    List<List<String?>?> diffSourceSyncBeamBuild = [];
    List<num?> minDiffWaveBuild = [];
    List<num?> maxDiffWaveBuild = [];

    try {
      for (Map<String, dynamic> entry in entries) {
        List<Map<String, dynamic>?>? detect = entry['diffrn_detector']?.cast<Map<String, dynamic>?>();
        List<Map<String, dynamic>?>? source = entry['diffrn_source']?.cast<Map<String, dynamic>?>();
        Map<String, dynamic>? entryInfo = entry['rcsb_entry_info'];
        List<Map<String, dynamic>?>? reflns = entry['reflns']?.cast<Map<String, dynamic>?>();

        collectionTempBuild.add((entry['diffrn'] as List?)?.map((e) => e?['ambient_temp'] as num?).toList());
        detectorBuild.add(detect?.map((e) => e?['detector'] as String?).toList());
        collectionDateBuild.add(detect?.map((e) => e?['pdbx_collection_date'] as String?).toList());
        diffSourceGenBuild.add(source?.map((e) => e?['source'] as String?).toList());
        diffSourceMBuild.add(source?.map((e) => e?['type'] as String?).toList());
        collectionResBuild.add(entryInfo?['diffrn_resolution_high']?['value'] as num?);
        bWilsonEstBuild.add(reflns?.map((e) => e?['B_iso_Wilson_estimate'] as num?).toList());
        redundancyBuild.add(reflns?.map((e) => e?['pdbx_redundancy'] as num?).toList());
        perPossReflBuild.add(reflns?.map((e) => e?['percent_possible_obs'] as num?).toList());
        rValMergeIntenBuild.add(reflns?.map((e) => e?['pdbx_Rmerge_I_obs'] as num?).toList());
        diffSourceSyncSiteBuild.add(source?.map((e) => e?['pdbx_synchrotron_site'] as String?).toList());
        diffSourceSyncBeamBuild.add(source?.map((e) => e?['pdbx_synchrotron_beamline'] as String?).toList());
        minDiffWaveBuild.add(entryInfo?['diffrn_radiation_wavelength_minimum'] as num?);
        maxDiffWaveBuild.add(entryInfo?['diffrn_radiation_wavelength_maximum'] as num?);
      }
      return XRayData(
        collectionTemp: collectionTempBuild,
        detector: detectorBuild,
        collectionDate: collectionDateBuild,
        diffSourceGen: diffSourceGenBuild,
        diffSourceM: diffSourceMBuild,
        collectionRes: collectionResBuild,
        bWilsonEst: bWilsonEstBuild,
        redundancy: redundancyBuild,
        perPossRefl: perPossReflBuild,
        rValMergeInten: rValMergeIntenBuild,
        diffSourceSyncSite: diffSourceSyncSiteBuild,
        diffSourceSyncBeam: diffSourceSyncBeamBuild,
        minDiffWave: minDiffWaveBuild,
        maxDiffWave: maxDiffWaveBuild,
      );
    } catch (e) {
      throw FormatException('Invalid JSON format: $e');
    }
  }
}

class XRayMethod {
  final List<List<num?>?> avgB;
  final List<List<num?>?> rFree;
  final List<List<num?>?> rWork;
  final List<List<num?>?> rAll;
  final List<List<num?>?> rObserved;
  final List<List<num?>?> highResLimit;
  final List<List<num?>?> reflectRefine;
  final List<List<String?>?> structDeter;
  final List<List<String?>?> refineID;

  XRayMethod({
    required this.avgB,
    required this.rFree,
    required this.rWork,
    required this.rAll,
    required this.rObserved,
    required this.highResLimit,
    required this.reflectRefine,
    required this.structDeter,
    required this.refineID,
  });

  factory XRayMethod.fromJson(List entries) {
    List<List<num?>?> avgBBuild = [];
    List<List<num?>?> rFreeBuild = [];
    List<List<num?>?> rWorkBuild = [];
    List<List<num?>?> rAllBuild = [];
    List<List<num?>?> rObservedBuild = [];
    List<List<num?>?> highResLimitBuild = [];
    List<List<num?>?> reflectRefineBuild = [];
    List<List<String?>?> structDeterBuild = [];
    List<List<String?>?> refineIDBuild = [];
    
    try {
      for (Map<String, dynamic> entry in entries) {
        List<Map<String, dynamic>?>? refine = entry['refine']?.cast<Map<String, dynamic>?>();

        avgBBuild.add(refine?.map((e) => e?['B_iso_mean'] as num?).toList());
        rFreeBuild.add(refine?.map((e) => e?['ls_R_factor_R_free'] as num?).toList());
        rWorkBuild.add(refine?.map((e) => e?['ls_R_factor_R_work'] as num?).toList());
        rAllBuild.add(refine?.map((e) => e?['ls_R_factor_all'] as num?).toList());
        rObservedBuild.add(refine?.map((e) => e?['ls_R_factor_obs'] as num?).toList());
        highResLimitBuild.add(refine?.map((e) => e?['ls_d_res_high'] as num?).toList());
        reflectRefineBuild.add(refine?.map((e) => e?['ls_number_reflns_obs'] as num?).toList());
        structDeterBuild.add(refine?.map((e) => e?['pdbx_method_to_determine_struct'] as String?).toList());
        refineIDBuild.add(refine?.map((e) => e?['pdbx_refine_id'] as String?).toList());
      }
      return XRayMethod(
        avgB: avgBBuild,
        rFree: rFreeBuild,
        rWork: rWorkBuild,
        rAll: rAllBuild,
        rObserved: rObservedBuild,
        highResLimit: highResLimitBuild,
        reflectRefine: reflectRefineBuild,
        structDeter: structDeterBuild,
        refineID: refineIDBuild
      );
    } catch (e) {
      throw FormatException('Invalid JSON format: $e');
    }
  }
}

class EMMethod {
  final List<List<num?>?> emRes;
  final List<List<String?>?> symmType;
  final List<List<num?>?> emDiffRes;
  final List<String?> aggState;
  final List<String?> reconstrMethod;
  final List<List<String?>?> filmDetModel;
  final List<List<String?>?> microscopeModel;
  final List<List<String?>?> pointSymm;
  final List<List<String?>?> embed;
  final List<List<String?>?> stain;
  final List<List<String?>?> vitrify;
  final List<List<num?>?> accVolt;

  EMMethod({
    required this.emRes,
    required this.symmType,
    required this.emDiffRes,
    required this.aggState,
    required this.reconstrMethod,
    required this.filmDetModel,
    required this.microscopeModel,
    required this.pointSymm,
    required this.embed,
    required this.stain,
    required this.vitrify,
    required this.accVolt,
  });

  factory EMMethod.fromJson(List entries) {
    List<List<num?>?> emResBuild = [];
    List<List<String?>?> symmTypeBuild = [];
    List<List<num?>?> emDiffResBuild = [];
    List<String?> aggStateBuild = [];
    List<String?> reconstrMethodBuild = [];
    List<List<String?>?> filmDetModelBuild = [];
    List<List<String?>?> microscopeModelBuild = [];
    List<List<String?>?> pointSymmBuild = [];
    List<List<String?>?> embedBuild = [];
    List<List<String?>?> stainBuild = [];
    List<List<String?>?> vitrifyBuild = [];
    List<List<num?>?> accVoltBuild = [];
    
    try {
      for (Map<String, dynamic> entry in entries) {
        List<Map<String, dynamic>?>? em3d = entry['em_3d_reconstruction']?.cast<Map<String, dynamic>?>();
        Map<String, dynamic>? experiment = entry['em_experiment'];
        List<Map<String, dynamic>?>? imaging = entry['em_imaging']?.cast<Map<String, dynamic>?>();
        List<Map<String, dynamic>?>? specimen = entry['em_specimen']?.cast<Map<String, dynamic>?>();

        emResBuild.add(em3d?.map((e) => e?['resolution'] as num?).toList());
        symmTypeBuild.add(em3d?.map((e) => e?['symmetry_type'] as String?).toList());
        emDiffResBuild.add((entry['em_diffraction_stats'] as List?)?.map((e) => e?['high_resolution'] as num?).toList());
        aggStateBuild.add(experiment?['aggregation_state'] as String?);
        reconstrMethodBuild.add(experiment?['reconstruction_method'] as String?);
        filmDetModelBuild.add((entry['em_image_recording'] as List?)?.map((e) => e?['film_or_detector_model'] as String?).toList());
        microscopeModelBuild.add(imaging?.map((e) => e?['microscope_model'] as String?).toList());
        pointSymmBuild.add((entry['em_single_particle_entity'] as List?)?.map((e) => e?['point_symmetry'] as String?).toList());
        embedBuild.add(specimen?.map((e) => e?['embedding_applied'] as String?).toList());
        stainBuild.add(specimen?.map((e) => e?['staining_applied'] as String?).toList());
        vitrifyBuild.add(specimen?.map((e) => e?['vitrification_applied'] as String?).toList());
        accVoltBuild.add(imaging?.map((e) => e?['accelerating_voltage'] as num?).toList());
      }
      return EMMethod(
        emRes: emResBuild,
        symmType: symmTypeBuild,
        emDiffRes: emDiffResBuild,
        aggState: aggStateBuild,
        reconstrMethod: reconstrMethodBuild,
        filmDetModel: filmDetModelBuild,
        microscopeModel: microscopeModelBuild,
        pointSymm: pointSymmBuild,
        embed: embedBuild,
        stain: stainBuild,
        vitrify: vitrifyBuild,
        accVolt: accVoltBuild,
      );
    } catch (e) {
      throw FormatException('Invalid JSON format: $e');
    }
  }
}

class NMRMethod {
  final List<String?> conformerCrit;
  final List<num?> conformerCalc;
  final List<num?> conformerSubm;
  final List<List<String?>?> type;
  final List<List<String?>?> ionicStr;
  final List<List<String?>?> ph;
  final List<List<String?>?> pressure;
  final List<List<String?>?> pressureUnit;
  final List<List<String?>?> temp;
  final List<List<String?>?> details;
  final List<List<String?>?> method;
  final List<String?> conformerID;
  final List<String?> selectionCrit;
  final List<List<String?>?> contents;
  final List<List<String?>?> solventSys;
  final List<List<String?>?> swAuthor;
  final List<List<String?>?> classification;
  final List<List<String?>?> name;
  final List<List<String?>?> version;
  final List<List<num?>?> fieldStr;
  final List<List<String?>?> manufacturer;
  final List<List<String?>?> model;

  NMRMethod({
    required this.conformerCrit,
    required this.conformerCalc,
    required this.conformerSubm,
    required this.type,
    required this.ionicStr,
    required this.ph,
    required this.pressure,
    required this.pressureUnit,
    required this.temp,
    required this.details,
    required this.method,
    required this.conformerID,
    required this.selectionCrit,
    required this.contents,
    required this.solventSys,
    required this.swAuthor,
    required this.classification,
    required this.name,
    required this.version,
    required this.fieldStr,
    required this.manufacturer,
    required this.model,
  });

  factory NMRMethod.fromJson(List entries) {
    List<String?> conformerCritBuild = [];
    List<num?> conformerCalcBuild = [];
    List<num?> conformerSubmBuild = [];
    List<List<String?>?> typeBuild = [];
    List<List<String?>?> ionicStrBuild = [];
    List<List<String?>?> phBuild = [];
    List<List<String?>?> pressureBuild = [];
    List<List<String?>?> pressureUnitBuild = [];
    List<List<String?>?> tempBuild = [];
    List<List<String?>?> detailsBuild = [];
    List<List<String?>?> methodBuild = [];
    List<String?> conformerIDBuild = [];
    List<String?> selectionCritBuild = [];
    List<List<String?>?> contentsBuild = [];
    List<List<String?>?> solventSysBuild = [];
    List<List<String?>?> swAuthorBuild = [];
    List<List<String?>?> classificationBuild = [];
    List<List<String?>?> nameBuild = [];
    List<List<String?>?> versionBuild = [];
    List<List<num?>?> fieldStrBuild = [];
    List<List<String?>?> manufacturerBuild = [];
    List<List<String?>?> modelBuild = [];

    try {
      for (Map<String, dynamic> entry in entries) {
        Map<String, dynamic>? nmrEnsemble = entry['pdbx_nmr_ensemble'];
        List<Map<String, dynamic>?>? conditions = entry['pdbx_nmr_exptl_sample_conditions']?.cast<Map<String, dynamic>?>();
        List<Map<String, dynamic>?>? refine = entry['pdbx_nmr_refine']?.cast<Map<String, dynamic>?>();
        Map<String, dynamic>? representative = entry['pdbx_nmr_representative'];
        List<Map<String, dynamic>?>? sample = entry['pdbx_nmr_sample_details']?.cast<Map<String, dynamic>?>();
        List<Map<String, dynamic>?>? sw = entry['pdbx_nmr_software']?.cast<Map<String, dynamic>?>();
        List<Map<String, dynamic>?>? spectrometer = entry['pdbx_nmr_spectrometer']?.cast<Map<String, dynamic>?>();

        conformerCritBuild.add(nmrEnsemble?['conformer_selection_criteria'] as String?);
        conformerCalcBuild.add(nmrEnsemble?['conformers_calculated_total_number'] as num?);
        conformerCalcBuild.add(nmrEnsemble?['conformers_submitted_total_number'] as num?);
        typeBuild.add((entry['pdbx_nmr_exptl'] as List?)?.map((e) => e?['type'] as String?).toList());
        ionicStrBuild.add(conditions?.map((e) => e?['ionic_strength'] as String?).toList());
        phBuild.add(conditions?.map((e) => e?['pH'] as String?).toList());
        pressureBuild.add(conditions?.map((e) => e?['pressure'] as String?).toList());
        pressureUnitBuild.add(conditions?.map((e) => e?['pressure_units'] as String?).toList());
        tempBuild.add(conditions?.map((e) => e?['temperature'] as String?).toList());
        detailsBuild.add(refine?.map((e) => e?['details'] as String?).toList());
        methodBuild.add(refine?.map((e) => e?['method'] as String?).toList());
        conformerIDBuild.add(representative?['conformer_id'] as String?);
        selectionCritBuild.add(representative?['selection_criteria'] as String?);
        contentsBuild.add(sample?.map((e) => e?['contents'] as String?).toList());
        solventSysBuild.add(sample?.map((e) => e?['solvent_system'] as String?).toList());
        swAuthorBuild.add(sw?.map((e) => e?['authors'] as String?).toList());
        classificationBuild.add(sw?.map((e) => e?['classification'] as String?).toList());
        nameBuild.add(sw?.map((e) => e?['name'] as String?).toList());
        versionBuild.add(sw?.map((e) => e?['version'] as String?).toList());
        fieldStrBuild.add(spectrometer?.map((e) => e?['field_strength'] as num?).toList());
        manufacturerBuild.add(spectrometer?.map((e) => e?['manufacturer'] as String?).toList());
        modelBuild.add(spectrometer?.map((e) => e?['model'] as String?).toList());
      }
      return NMRMethod(
        conformerCrit: conformerCritBuild,
        conformerCalc: conformerCalcBuild,
        conformerSubm: conformerSubmBuild,
        type: typeBuild,
        ionicStr: ionicStrBuild,
        ph: phBuild,
        pressure: pressureBuild,
        pressureUnit: pressureUnitBuild,
        temp: tempBuild,
        details: detailsBuild,
        method: methodBuild,
        conformerID: conformerIDBuild,
        selectionCrit: selectionCritBuild,
        contents: contentsBuild,
        solventSys: solventSysBuild,
        swAuthor: swAuthorBuild,
        classification: classificationBuild,
        name: nameBuild,
        version: versionBuild,
        fieldStr: fieldStrBuild,
        manufacturer: manufacturerBuild,
        model: modelBuild,
      );
    } catch (e) {
      throw FormatException('Invalid JSON format: $e');
    }
  }
}

class PublicationsPrimary {
  final List<List<String?>?> author;
  final List<String?> title;
  final List<num?> year;
  final List<String?> journal;
  final List<String?> vol;
  final List<String?> firstPg;
  final List<String?> lastPg;
  final List<String?> doi;

  PublicationsPrimary({
    required this.author,
    required this.title,
    required this.year,
    required this.journal,
    required this.vol,
    required this.firstPg,
    required this.lastPg,
    required this.doi,
  });

  factory PublicationsPrimary.fromJson(List entries) {
    List<List<String?>?> authorBuild = [];
    List<String?> titleBuild = [];
    List<num?> yearBuild = [];
    List<String?> journalBuild = [];
    List<String?> volBuild = [];
    List<String?> firstPgBuild = [];
    List<String?> lastPgBuild = [];
    List<String?> doiBuild = [];

    try {
      for (Map<String, dynamic> entry in entries) {
        Map<String, dynamic>? primaries = entry['rcsb_primary_citation'];

        authorBuild.add((primaries?['rcsb_authors'] as List?)?.map((e) => e as String?).toList());
        titleBuild.add(primaries?['title'] as String?);
        yearBuild.add(primaries?['year'] as num?);
        journalBuild.add(primaries?['rcsb_journal_abbrev'] as String?);
        volBuild.add(primaries?['journal_volume'] as String?);
        firstPgBuild.add(primaries?['page_first'] as String?);
        lastPgBuild.add(primaries?['page_last'] as String?);
        doiBuild.add(primaries?['pdbx_database_id_DOI'] as String?);
      }
      return PublicationsPrimary(
        author: authorBuild,
        title: titleBuild,
        year: yearBuild,
        journal: journalBuild,
        vol: volBuild,
        firstPg: firstPgBuild,
        lastPg: lastPgBuild,
        doi: doiBuild,
      );
    } catch (e) {
      throw FormatException('Invalid JSON format: $e');
    }
  }
}

// class StructureData {
//   final Keywords keywords;
//   final Deposition deposition;
//   final EntryFeatures entryFeatures;
//   final GroupDeposition groupDeposition;
//   final Dimensions dimensions;
//   final List<String?> components;
//   final BindingAffinity bindingAffinity;
//   final CrystalProperties crystalProperties;
//   final Methods methods;
//   final XRayData xRayData;
//   final XRayMethod xRayMethod;
//   final EMMethod emMethod;
//   final NMRMethod nmrMethod;
//   final PublicationsPrimary publicationsPrimary;

//   StructureData({
//     required this.keywords,
//     required this.deposition,
//     required this.entryFeatures,
//     required this.groupDeposition,
//     required this.dimensions,
//     required this.components,
//     required this.bindingAffinity,
//     required this.crystalProperties,
//     required this.methods,
//     required this.xRayData,
//     required this.xRayMethod,
//     required this.emMethod,
//     required this.nmrMethod,
//     required this.publicationsPrimary,
//   });

//   factory StructureData.fromJson(List entries) {
//     return StructureData(
//       keywords: Keywords.fromJson(entries),
//       deposition: Deposition.fromJson(entries),
//       entryFeatures: EntryFeatures.fromJson(entries),
//       groupDeposition: GroupDeposition.fromJson(entries),
//       dimensions: Dimensions.fromJson(entries),
//       components: _buildComponentsList(entries),
//       bindingAffinity: BindingAffinity.fromJson(entries),
//       crystalProperties: CrystalProperties.fromJson(entries),
//       methods: Methods.fromJson(entries),
//       xRayData: XRayData.fromJson(entries),
//       xRayMethod: XRayMethod.fromJson(entries),
//       emMethod: EMMethod.fromJson(entries),
//       nmrMethod: NMRMethod.fromJson(entries),
//       publicationsPrimary: PublicationsPrimary.fromJson(entries),
//     );
//   }
// }

// List<String?> _buildComponentsList(List entries) {
//   List<String?> components = [];
//   try {
//     for (Map<String, dynamic> entry in entries) {
//       components.add(entry['data']['rcsb_binding_affinity']?[0]?['comp_id'] as String?);
//     }
//     return components;
//   } catch (e) {
//     throw FormatException('Invalid JSON format: $e');
//   }
// }

// class Keywords {
//   final List<String?> pdbID;
//   final List<List<String?>?> emdbID;
//   final List<List<String?>?> dbID;
//   final List<String?> pmCentralID;
//   final List<num?> pmID;
//   final List<String?> doi;
//   final List<String?> structKeywords;

//   Keywords({
//     required this.pdbID,
//     required this.emdbID,
//     required this.dbID,
//     required this.pmCentralID,
//     required this.pmID,
//     required this.doi,
//     required this.structKeywords,
//   });

//   factory Keywords.fromJson(List entries) {
//     List<String?> pdbIDBuild = [];
//     List<List<String?>?> emdbIDBuild = [];
//     List<List<String?>?> dbIDBuild = [];
//     List<String?> pmCentralIDBuild = [];
//     List<num?> pmIDBuild = [];
//     List<String?> doiBuild = [];
//     List<String?> structKeywordsBuild = [];

//     try {
//       for (Map<String, dynamic> entry in entries) {
//         Map<String, dynamic> data = entry['data'];
//         Map<String, dynamic>? ids = data['rcsb_entry_container_identifiers'];
//         Map<String, dynamic>? pubmed = data['pubmed'];

//         pdbIDBuild.add(ids?['entry_id'] as String?);
//         emdbIDBuild.add((ids?['emdb_ids'] as List?)?.map((e) => e as String?).toList());
//         dbIDBuild.add((entry['data']['pdbx_database_related'] as List?)
//             ?.map((e) => (e as Map<String, dynamic>?)?['db_id'] as String?).toList());
//         pmCentralIDBuild.add(pubmed?['rcsb_pubmed_central_id'] as String?);
//         pmIDBuild.add(pubmed?['rcsb_pubmed_container_identifiers']?['pubmed_id'] as num?);
//         doiBuild.add(pubmed?['rcsb_pubmed_doi'] as String?);
//         structKeywordsBuild.add(data['struct_keywords']?['pdbx_keywords'] as String?);

//       }
//       return Keywords(
//         pdbID: pdbIDBuild, 
//         emdbID: emdbIDBuild, 
//         dbID: dbIDBuild, 
//         pmCentralID: pmCentralIDBuild,
//         pmID: pmIDBuild,
//         doi: doiBuild,
//         structKeywords: structKeywordsBuild,
//       );
//     } catch (e) {
//       throw FormatException('Invalid JSON format: $e');
//     }
//   }
// }

// class Deposition {
//   final List<List<String?>?> author;
//   final List<String?> title;
//   final List<String?> depoDate;
//   final List<String?> releaseDate;
//   final List<List<String?>?> projCenterName;
//   final List<List<String?>?> projCenterInitials;
//   final List<List<String?>?> projName;

//   Deposition({
//     required this.author,
//     required this.title,
//     required this.depoDate,
//     required this.releaseDate,
//     required this.projCenterName,
//     required this.projCenterInitials,
//     required this.projName,
//   });

//   factory Deposition.fromJson(List entries) {
//     List<List<String?>?> authorBuild = [];
//     List<String?> titleBuild = [];
//     List<String?> depoDateBuild = [];
//     List<String?> releaseDateBuild = [];
//     List<List<String?>?> projCenterNameBuild = [];
//     List<List<String?>?> projCenterInitialsBuild = [];
//     List<List<String?>?> projNameBuild = [];
    
//     try {
//       for (Map<String, dynamic> entry in entries) {
//         Map<String, dynamic> data = entry['data'];
//         List<Map<String, dynamic>?>? project = data['pdbx_SG_project']?.cast<Map<String, dynamic>?>();
//         Map<String, dynamic>? accessInfo = data['rcsb_accession_info'];

//         authorBuild.add((data['audit_author'] as List?)
//             ?.map((e) => (e as Map<String, dynamic>?)?['name'] as String?)
//             .toList());
//         titleBuild.add(data['struct']?['title'] as String?);
//         depoDateBuild.add(accessInfo?['deposit_date'] as String?);
//         releaseDateBuild.add(accessInfo?['initial_release_date'] as String?);
//         projCenterNameBuild.add(project?.map((e) => e?['full_name_of_center'] as String?).toList());
//         projCenterInitialsBuild.add(project?.map((e) => e?['initial_of_center'] as String?).toList());
//         projNameBuild.add(project?.map((e) => e?['project_name'] as String?).toList());
//       }
//       return Deposition(
//         author: authorBuild,
//         title: titleBuild,
//         depoDate: depoDateBuild,
//         releaseDate: releaseDateBuild,
//         projCenterName: projCenterNameBuild,
//         projCenterInitials: projCenterInitialsBuild,
//         projName: projNameBuild,
//       );
//     } catch (e) {
//       throw FormatException('Invalid JSON format: $e');
//     }
//   }
// }

// class EntryFeatures {
//   final List<num?> numNHAtoms;
//   final List<num?> depoCount;
//   final List<num?> numNonPolyIn;
//   final List<num?> numPolyIn;
//   final List<num?> numPolyResi;
//   final List<num?> numH2O;
//   final List<num?> disulfBCount;
//   final List<num?> numEnt;
//   final List<num?> molecWeight;
//   final List<num?> numNonPolyEnt;
//   final List<String?> entryPolyComp;
//   final List<num?> numDNAEnt;
//   final List<num?> numNAHybridEnt;
//   final List<num?> numProteinEnt;
//   final List<num?> numRNAEnt;
//   final List<List<num?>?> refRes;
//   final List<String?> types;

//   EntryFeatures({
//     required this.numNHAtoms,
//     required this.depoCount,
//     required this.numNonPolyIn,
//     required this.numPolyIn,
//     required this.numPolyResi,
//     required this.numH2O,
//     required this.disulfBCount,
//     required this.numEnt,
//     required this.molecWeight,
//     required this.numNonPolyEnt,
//     required this.entryPolyComp,
//     required this.numDNAEnt,
//     required this.numNAHybridEnt,
//     required this.numProteinEnt,
//     required this.numRNAEnt,
//     required this.refRes,
//     required this.types,
//   });

//   factory EntryFeatures.fromJson(List entries) {
//     List<num?> numNHAtomsBuild = [];
//     List<num?> depoCountBuild = [];
//     List<num?> numNonPolyInBuild = [];
//     List<num?> numPolyInBuild = [];
//     List<num?> numPolyResiBuild = [];
//     List<num?> numH2OBuild = [];
//     List<num?> disulfBCountBuild = [];
//     List<num?> numEntBuild = [];
//     List<num?> molecWeightBuild = [];
//     List<num?> numNonPolyEntBuild = [];
//     List<String?> entryPolyCompBuild = [];
//     List<num?> numDNAEntBuild = [];
//     List<num?> numNAHybridEntBuild = [];
//     List<num?> numProteinEntBuild = [];
//     List<num?> numRNAEntBuild = [];
//     List<List<num?>?> refResBuild = [];
//     List<String?> typesBuild = [];

//     try {
//       for (Map<String, dynamic> entry in entries) {
//         Map<String, dynamic> data = entry['data'];
//         Map<String, dynamic>? entryInfo = data['rcsb_entry_info'];

//         numNHAtomsBuild.add(entryInfo?['deposited_atom_count'] as num?);
//         depoCountBuild.add(entryInfo?['deposited_model_count'] as num?);
//         numNonPolyInBuild.add(entryInfo?['deposited_nonpolymer_entity_instance_count'] as num?);
//         numPolyInBuild.add(entryInfo?['deposited_polymer_entity_instance_count'] as num?);
//         numPolyResiBuild.add(entryInfo?['deposited_polymer_monomer_count'] as num?);
//         numH2OBuild.add(entryInfo?['deposited_solvent_atom_count'] as num?);
//         disulfBCountBuild.add(entryInfo?['disulfide_bond_count'] as num?);
//         numEntBuild.add(entryInfo?['entity_count'] as num?);
//         molecWeightBuild.add(entryInfo?['molecular_weight'] as num?);
//         numNonPolyEntBuild.add(entryInfo?['nonpolymer_entity_count'] as num?);
//         entryPolyCompBuild.add(entryInfo?['polymer_composition'] as String?);
//         numDNAEntBuild.add(entryInfo?['polymer_entity_count_DNA'] as num?);
//         numNAHybridEntBuild.add(entryInfo?['polymer_entity_count_nucleic_acid_hybrid'] as num?);
//         numProteinEntBuild.add(entryInfo?['polymer_entity_count_protein'] as num?);
//         numRNAEntBuild.add(entryInfo?['polymer_entity_count_RNA'] as num?);
//         refResBuild.add((entryInfo?['resolution_combined'] as List?)
//           ?.map((e) => e as num?)
//           .toList());
//         typesBuild.add(entryInfo?['selected_polymer_entity_types'] as String?);
//       }
//       return EntryFeatures(
//         numNHAtoms: numNHAtomsBuild,
//         depoCount: depoCountBuild,
//         numNonPolyIn: numNonPolyInBuild,
//         numPolyIn: numPolyInBuild,
//         numPolyResi: numPolyResiBuild,
//         numH2O: numH2OBuild,
//         disulfBCount: disulfBCountBuild,
//         numEnt: numEntBuild,
//         molecWeight: molecWeightBuild,
//         numNonPolyEnt: numNonPolyEntBuild,
//         entryPolyComp: entryPolyCompBuild,
//         numDNAEnt: numDNAEntBuild,
//         numNAHybridEnt: numNAHybridEntBuild,
//         numProteinEnt: numProteinEntBuild,
//         numRNAEnt: numRNAEntBuild,
//         refRes: refResBuild,
//         types: typesBuild,
//       );
//     } catch (e) {
//       throw FormatException('Invalid JSON format: $e');
//     }
//   }
// }

// class GroupDeposition {
//   final List<List<String?>?> id;
//   final List<List<String?>?> description;
//   final List<List<String?>?> title;
//   final List<List<String?>?> type;

//   GroupDeposition({
//     required this.id,
//     required this.description,
//     required this.title,
//     required this.type,
//   });

//   factory GroupDeposition.fromJson(List entries) {
//     List<List<String?>?> idBuild = [];
//     List<List<String?>?> descriptionBuild = [];
//     List<List<String?>?> titleBuild = [];
//     List<List<String?>?> typeBuild = [];
    
//     try {
//       for (Map<String, dynamic> entry in entries) {
//         Map<String, dynamic> data = entry['data'];
//         List<Map<String, dynamic>?>? group = data['pdbx_deposit_group']?.cast<Map<String, dynamic>?>();

//         idBuild.add(group?.map((e) => e?['group_id'] as String?).toList());
//         descriptionBuild.add(group?.map((e) => e?['group_description'] as String?).toList());
//         titleBuild.add(group?.map((e) => e?['group_title'] as String?).toList());
//         typeBuild.add(group?.map((e) => e?['group_type'] as String?).toList());
//       }
//       return GroupDeposition(
//         id: idBuild,
//         description: descriptionBuild,
//         title: titleBuild,
//         type: typeBuild
//       );
//     } catch (e) {
//       throw FormatException('Invalid JSON format: $e');
//     }
//   }
// }

// class Dimensions {
//   final List<num?> zNum;
//   final List<num?> alpha;
//   final List<num?> beta;
//   final List<num?> gamma;
//   final List<num?> lA;
//   final List<num?> lB;
//   final List<num?> lC;
//   final List<String?> spaceGroup;

//   Dimensions({
//     required this.zNum,
//     required this.alpha,
//     required this.beta,
//     required this.gamma,
//     required this.lA,
//     required this.lB,
//     required this.lC,
//     required this.spaceGroup,
//   });

//   factory Dimensions.fromJson(List entries) {
//     final List<num?> zNumBuild = [];
//     final List<num?> alphaBuild = [];
//     final List<num?> betaBuild = [];
//     final List<num?> gammaBuild = [];
//     final List<num?> lABuild = [];
//     final List<num?> lBBuild = [];
//     final List<num?> lCBuild = [];
//     final List<String?> spaceGroupBuild = [];

//     try {
//       for (Map<String, dynamic> entry in entries) {
//         Map<String, dynamic> data = entry['data'];
//         Map<String, dynamic>? cell = data['cell'];

//         zNumBuild.add(cell?['Z_PDB'] as num?);
//         alphaBuild.add(cell?['angle_alpha'] as num?);
//         betaBuild.add(cell?['angle_beta'] as num?);
//         gammaBuild.add(cell?['angle_gamma'] as num?);
//         lABuild.add(cell?['length_a'] as num?);
//         lBBuild.add(cell?['length_b'] as num?);
//         lCBuild.add(cell?['length_c'] as num?);
//         spaceGroupBuild.add(data['symmetry']?['space_group_name_H_M'] as String?);
//       }
//       return Dimensions(
//         zNum: zNumBuild,
//         alpha: alphaBuild,
//         beta: betaBuild,
//         gamma: gammaBuild,
//         lA: lABuild,
//         lB: lBBuild,
//         lC: lCBuild,
//         spaceGroup: spaceGroupBuild
//       );
//     } catch (e) {
//       throw FormatException('Invalid JSON format: $e');
//     }
//   }
// }

// class BindingAffinity {
//   final List<List<num?>?> value;
//   final List<List<String?>?> provenanceCode;
//   final List<List<num?>?> refSequenceID;
//   final List<List<String?>?> symbol;
//   final List<List<String?>?> type;
//   final List<List<String?>?> unit;

//   BindingAffinity({
//     required this.value,
//     required this.provenanceCode,
//     required this.refSequenceID,
//     required this.symbol,
//     required this.type,
//     required this.unit,
//   });

//   factory BindingAffinity.fromJson(List entries) {
//     List<List<num?>?> valueBuild = [];
//     List<List<String?>?> provenanceCodeBuild = [];
//     List<List<num?>?> refSequenceIDBuild = [];
//     List<List<String?>?> symbolBuild = [];
//     List<List<String?>?> typeBuild = [];
//     List<List<String?>?> unitBuild = [];
    
//     try {
//       for (Map<String, dynamic> entry in entries) {
//         Map<String, dynamic> data = entry['data'];
//         List<Map<String, dynamic>?>? bA = data['rcsb_binding_affinity']?.cast<Map<String, dynamic>?>();

//         valueBuild.add(bA?.map((e) => e?['value'] as num?).toList());
//         provenanceCodeBuild.add(bA?.map((e) => e?['provenance_code'] as String?).toList());
//         refSequenceIDBuild.add(bA?.map((e) => e?['reference_sequence_identity'] as num?).toList());
//         symbolBuild.add(bA?.map((e) => e?['symbol'] as String?).toList());
//         typeBuild.add(bA?.map((e) => e?['type'] as String?).toList());
//         unitBuild.add(bA?.map((e) => e?['unit'] as String?).toList());
//       }
//       return BindingAffinity(
//         value: valueBuild,
//         provenanceCode: provenanceCodeBuild,
//         refSequenceID: refSequenceIDBuild,
//         symbol: symbolBuild,
//         type: typeBuild,
//         unit: unitBuild,
//       );
//     } catch (e) {
//       throw FormatException('Invalid JSON format: $e');
//     }
//   }
// }

// class CrystalProperties {
//   final List<List<num?>?> matthews;
//   final List<List<num?>?> perSolvent;
//   final List<List<String?>?> crystalMeth;
//   final List<List<num?>?> ph;
//   final List<List<String?>?> growthProc;
//   final List<List<num?>?> temp;

//   CrystalProperties({
//     required this.matthews,
//     required this.perSolvent,
//     required this.crystalMeth,
//     required this.ph,
//     required this.growthProc,
//     required this.temp,
//   });

//   factory CrystalProperties.fromJson(List entries) {
//     try {
//       final List<List<num?>?> matthewsBuild = [];
//       final List<List<num?>?> perSolventBuild = [];
//       final List<List<String?>?> crystalMethBuild = [];
//       final List<List<num?>?> phBuild = [];
//       final List<List<String?>?> growthProcBuild = [];
//       final List<List<num?>?> tempBuild = [];

//       for (Map<String, dynamic> entry in entries) {
//         Map<String, dynamic> data = entry['data'];
//         List<Map<String, dynamic>?>? density = data['exptl_crystal']?.cast<Map<String, dynamic>?>();
//         List<Map<String, dynamic>?>? growth = data['exptl_crystal_grow']?.cast<Map<String, dynamic>?>();

//         matthewsBuild.add(density?.map((e) => e?['density_Matthews'] as num?).toList());
//         perSolventBuild.add(density?.map((e) => e?['density_percent_sol'] as num?).toList());
//         crystalMethBuild.add(growth?.map((e) => e?['method'] as String?).toList());
//         phBuild.add(growth?.map((e) => e?['pH'] as num?).toList());
//         growthProcBuild.add(growth?.map((e) => e?['pdbx_details'] as String?).toList());
//         tempBuild.add(growth?.map((e) => e?['temp'] as num?).toList());
//       }
//       return CrystalProperties(
//         matthews: matthewsBuild,
//         perSolvent: perSolventBuild,
//         crystalMeth: crystalMethBuild,
//         ph: phBuild,
//         growthProc: growthProcBuild,
//         temp: tempBuild,
//       );
//     } catch (e) {
//       throw FormatException('Invalid JSON format: $e');
//     }
//   }
// }

// class Methods {
//   final List<List<String?>?> experimental;
//   final List<String?> structDeter;

//   Methods({
//     required this.experimental,
//     required this.structDeter,
//   });

//   factory Methods.fromJson(List entries) {
//     List<List<String?>?> experimentalBuild = [];
//     List<String?> structDeterBuild = [];

//     try {
//       for (Map<String, dynamic> entry in entries) {
//         Map<String, dynamic> data = entry['data'];

//         experimentalBuild.add((data['exptl'] as List?)?.map((e) => (e as Map<String, dynamic>?)?['method'] as String?).toList());
//         structDeterBuild.add(data['rcsb_entry_info']?['structure_determination_methodology'] as String?);
//       }
//       return Methods(
//         experimental: experimentalBuild,
//         structDeter: structDeterBuild
//       );
//     } catch (e) {
//       throw FormatException('Invalid JSON format: $e');
//     }
//   }
// }

// class XRayData {
//   final List<List<num?>?> collectionTemp;
//   final List<List<String?>?> detector;
//   final List<List<String?>?> collectionDate;
//   final List<List<String?>?> diffSourceGen;
//   final List<List<String?>?> diffSourceM;
//   final List<num?> collectionRes;
//   final List<List<num?>?> bWilsonEst;
//   final List<List<num?>?> redundancy;
//   final List<List<num?>?> perPossRefl;
//   final List<List<num?>?> rValMergeInten;
//   final List<List<String?>?> diffSourceSyncSite;
//   final List<List<String?>?> diffSourceSyncBeam;
//   final List<num?> minDiffWave;
//   final List<num?> maxDiffWave;

//   XRayData({
//     required this.collectionTemp,
//     required this.detector,
//     required this.collectionDate,
//     required this.diffSourceGen,
//     required this.diffSourceM,
//     required this.collectionRes,
//     required this.bWilsonEst,
//     required this.redundancy,
//     required this.perPossRefl,
//     required this.rValMergeInten,
//     required this.diffSourceSyncSite,
//     required this.diffSourceSyncBeam,
//     required this.minDiffWave,
//     required this.maxDiffWave,
//   });

//   factory XRayData.fromJson(List entries) {
//     List<List<num?>?> collectionTempBuild = [];
//     List<List<String?>?> detectorBuild = [];
//     List<List<String?>?> collectionDateBuild = [];
//     List<List<String?>?> diffSourceGenBuild = [];
//     List<List<String?>?> diffSourceMBuild = [];
//     List<num?> collectionResBuild = [];
//     List<List<num?>?> bWilsonEstBuild = [];
//     List<List<num?>?> redundancyBuild = [];
//     List<List<num?>?> perPossReflBuild = [];
//     List<List<num?>?> rValMergeIntenBuild = [];
//     List<List<String?>?> diffSourceSyncSiteBuild = [];
//     List<List<String?>?> diffSourceSyncBeamBuild = [];
//     List<num?> minDiffWaveBuild = [];
//     List<num?> maxDiffWaveBuild = [];

//     try {
//       for (Map<String, dynamic> entry in entries) {
//         Map<String, dynamic> data = entry['data'];
//         List<Map<String, dynamic>?>? detect = data['diffrn_detector']?.cast<Map<String, dynamic>?>();
//         List<Map<String, dynamic>?>? source = data['diffrn_source']?.cast<Map<String, dynamic>?>();
//         Map<String, dynamic>? entryInfo = data['rcsb_entry_info'];
//         List<Map<String, dynamic>?>? reflns = data['reflns']?.cast<Map<String, dynamic>?>();

//         collectionTempBuild.add((data['diffrn'] as List?)?.map((e) => e?['ambient_temp'] as num?).toList());
//         detectorBuild.add(detect?.map((e) => e?['detector'] as String?).toList());
//         collectionDateBuild.add(detect?.map((e) => e?['pdbx_collection_date'] as String?).toList());
//         diffSourceGenBuild.add(source?.map((e) => e?['source'] as String?).toList());
//         diffSourceMBuild.add(source?.map((e) => e?['type'] as String?).toList());
//         collectionResBuild.add(entryInfo?['diffrn_resolution_high']?['value'] as num?);
//         bWilsonEstBuild.add(reflns?.map((e) => e?['B_iso_Wilson_estimate'] as num?).toList());
//         redundancyBuild.add(reflns?.map((e) => e?['pdbx_redundancy'] as num?).toList());
//         perPossReflBuild.add(reflns?.map((e) => e?['percent_possible_obs'] as num?).toList());
//         rValMergeIntenBuild.add(reflns?.map((e) => e?['pdbx_Rmerge_I_obs'] as num?).toList());
//         diffSourceSyncSiteBuild.add(source?.map((e) => e?['pdbx_synchrotron_site'] as String?).toList());
//         diffSourceSyncBeamBuild.add(source?.map((e) => e?['pdbx_synchrotron_beamline'] as String?).toList());
//         minDiffWaveBuild.add(entryInfo?['diffrn_radiation_wavelength_minimum'] as num?);
//         maxDiffWaveBuild.add(entryInfo?['diffrn_radiation_wavelength_maximum'] as num?);
//       }
//       return XRayData(
//         collectionTemp: collectionTempBuild,
//         detector: detectorBuild,
//         collectionDate: collectionDateBuild,
//         diffSourceGen: diffSourceGenBuild,
//         diffSourceM: diffSourceMBuild,
//         collectionRes: collectionResBuild,
//         bWilsonEst: bWilsonEstBuild,
//         redundancy: redundancyBuild,
//         perPossRefl: perPossReflBuild,
//         rValMergeInten: rValMergeIntenBuild,
//         diffSourceSyncSite: diffSourceSyncSiteBuild,
//         diffSourceSyncBeam: diffSourceSyncBeamBuild,
//         minDiffWave: minDiffWaveBuild,
//         maxDiffWave: maxDiffWaveBuild,
//       );
//     } catch (e) {
//       throw FormatException('Invalid JSON format: $e');
//     }
//   }
// }

// class XRayMethod {
//   final List<List<num?>?> avgB;
//   final List<List<num?>?> rFree;
//   final List<List<num?>?> rWork;
//   final List<List<num?>?> rAll;
//   final List<List<num?>?> rObserved;
//   final List<List<num?>?> highResLimit;
//   final List<List<num?>?> reflectRefine;
//   final List<List<String?>?> structDeter;
//   final List<List<String?>?> refineID;

//   XRayMethod({
//     required this.avgB,
//     required this.rFree,
//     required this.rWork,
//     required this.rAll,
//     required this.rObserved,
//     required this.highResLimit,
//     required this.reflectRefine,
//     required this.structDeter,
//     required this.refineID,
//   });

//   factory XRayMethod.fromJson(List entries) {
//     List<List<num?>?> avgBBuild = [];
//     List<List<num?>?> rFreeBuild = [];
//     List<List<num?>?> rWorkBuild = [];
//     List<List<num?>?> rAllBuild = [];
//     List<List<num?>?> rObservedBuild = [];
//     List<List<num?>?> highResLimitBuild = [];
//     List<List<num?>?> reflectRefineBuild = [];
//     List<List<String?>?> structDeterBuild = [];
//     List<List<String?>?> refineIDBuild = [];
    
//     try {
//       for (Map<String, dynamic> entry in entries) {
//         Map<String, dynamic> data = entry['data'];
//         List<Map<String, dynamic>?>? refine = data['refine']?.cast<Map<String, dynamic>?>();

//         avgBBuild.add(refine?.map((e) => e?['B_iso_mean'] as num?).toList());
//         rFreeBuild.add(refine?.map((e) => e?['ls_R_factor_R_free'] as num?).toList());
//         rWorkBuild.add(refine?.map((e) => e?['ls_R_factor_R_work'] as num?).toList());
//         rAllBuild.add(refine?.map((e) => e?['ls_R_factor_all'] as num?).toList());
//         rObservedBuild.add(refine?.map((e) => e?['ls_R_factor_obs'] as num?).toList());
//         highResLimitBuild.add(refine?.map((e) => e?['ls_d_res_high'] as num?).toList());
//         reflectRefineBuild.add(refine?.map((e) => e?['ls_number_reflns_obs'] as num?).toList());
//         structDeterBuild.add(refine?.map((e) => e?['pdbx_method_to_determine_struct'] as String?).toList());
//         refineIDBuild.add(refine?.map((e) => e?['pdbx_refine_id'] as String?).toList());
//       }
//       return XRayMethod(
//         avgB: avgBBuild,
//         rFree: rFreeBuild,
//         rWork: rWorkBuild,
//         rAll: rAllBuild,
//         rObserved: rObservedBuild,
//         highResLimit: highResLimitBuild,
//         reflectRefine: reflectRefineBuild,
//         structDeter: structDeterBuild,
//         refineID: refineIDBuild
//       );
//     } catch (e) {
//       throw FormatException('Invalid JSON format: $e');
//     }
//   }
// }

// class EMMethod {
//   final List<List<num?>?> emRes;
//   final List<List<String?>?> symmType;
//   final List<List<num?>?> emDiffRes;
//   final List<String?> aggState;
//   final List<String?> reconstrMethod;
//   final List<List<String?>?> filmDetModel;
//   final List<List<String?>?> microscopeModel;
//   final List<List<String?>?> pointSymm;
//   final List<List<String?>?> embed;
//   final List<List<String?>?> stain;
//   final List<List<String?>?> vitrify;
//   final List<List<num?>?> accVolt;

//   EMMethod({
//     required this.emRes,
//     required this.symmType,
//     required this.emDiffRes,
//     required this.aggState,
//     required this.reconstrMethod,
//     required this.filmDetModel,
//     required this.microscopeModel,
//     required this.pointSymm,
//     required this.embed,
//     required this.stain,
//     required this.vitrify,
//     required this.accVolt,
//   });

//   factory EMMethod.fromJson(List entries) {
//     List<List<num?>?> emResBuild = [];
//     List<List<String?>?> symmTypeBuild = [];
//     List<List<num?>?> emDiffResBuild = [];
//     List<String?> aggStateBuild = [];
//     List<String?> reconstrMethodBuild = [];
//     List<List<String?>?> filmDetModelBuild = [];
//     List<List<String?>?> microscopeModelBuild = [];
//     List<List<String?>?> pointSymmBuild = [];
//     List<List<String?>?> embedBuild = [];
//     List<List<String?>?> stainBuild = [];
//     List<List<String?>?> vitrifyBuild = [];
//     List<List<num?>?> accVoltBuild = [];
    
//     try {
//       for (Map<String, dynamic> entry in entries) {
//         Map<String, dynamic> data = entry['data'];
//         List<Map<String, dynamic>?>? em3d = data['em_3d_reconstruction']?.cast<Map<String, dynamic>?>();
//         Map<String, dynamic>? experiment = data['em_experiment'];
//         List<Map<String, dynamic>?>? imaging = data['em_imaging']?.cast<Map<String, dynamic>?>();
//         List<Map<String, dynamic>?>? specimen = data['em_specimen']?.cast<Map<String, dynamic>?>();

//         emResBuild.add(em3d?.map((e) => e?['resolution'] as num?).toList());
//         symmTypeBuild.add(em3d?.map((e) => e?['symmetry_type'] as String?).toList());
//         emDiffResBuild.add((data['em_diffraction_stats'] as List?)?.map((e) => e?['high_resolution'] as num?).toList());
//         aggStateBuild.add(experiment?['aggregation_state'] as String?);
//         reconstrMethodBuild.add(experiment?['reconstruction_method'] as String?);
//         filmDetModelBuild.add((data['em_image_recording'] as List?)?.map((e) => e?['film_or_detector_model'] as String?).toList());
//         microscopeModelBuild.add(imaging?.map((e) => e?['microscope_model'] as String?).toList());
//         pointSymmBuild.add((data['em_single_particle_entity'] as List?)?.map((e) => e?['point_symmetry'] as String?).toList());
//         embedBuild.add(specimen?.map((e) => e?['embedding_applied'] as String?).toList());
//         stainBuild.add(specimen?.map((e) => e?['staining_applied'] as String?).toList());
//         vitrifyBuild.add(specimen?.map((e) => e?['vitrification_applied'] as String?).toList());
//         accVoltBuild.add(imaging?.map((e) => e?['accelerating_voltage'] as num?).toList());
//       }
//       return EMMethod(
//         emRes: emResBuild,
//         symmType: symmTypeBuild,
//         emDiffRes: emDiffResBuild,
//         aggState: aggStateBuild,
//         reconstrMethod: reconstrMethodBuild,
//         filmDetModel: filmDetModelBuild,
//         microscopeModel: microscopeModelBuild,
//         pointSymm: pointSymmBuild,
//         embed: embedBuild,
//         stain: stainBuild,
//         vitrify: vitrifyBuild,
//         accVolt: accVoltBuild,
//       );
//     } catch (e) {
//       throw FormatException('Invalid JSON format: $e');
//     }
//   }
// }

// class NMRMethod {
//   final List<String?> conformerCrit;
//   final List<num?> conformerCalc;
//   final List<num?> conformerSubm;
//   final List<List<String?>?> type;
//   final List<List<String?>?> ionicStr;
//   final List<List<String?>?> ph;
//   final List<List<String?>?> pressure;
//   final List<List<String?>?> pressureUnit;
//   final List<List<String?>?> temp;
//   final List<List<String?>?> details;
//   final List<List<String?>?> method;
//   final List<String?> conformerID;
//   final List<String?> selectionCrit;
//   final List<List<String?>?> contents;
//   final List<List<String?>?> solventSys;
//   final List<List<String?>?> swAuthor;
//   final List<List<String?>?> classification;
//   final List<List<String?>?> name;
//   final List<List<String?>?> version;
//   final List<List<num?>?> fieldStr;
//   final List<List<String?>?> manufacturer;
//   final List<List<String?>?> model;

//   NMRMethod({
//     required this.conformerCrit,
//     required this.conformerCalc,
//     required this.conformerSubm,
//     required this.type,
//     required this.ionicStr,
//     required this.ph,
//     required this.pressure,
//     required this.pressureUnit,
//     required this.temp,
//     required this.details,
//     required this.method,
//     required this.conformerID,
//     required this.selectionCrit,
//     required this.contents,
//     required this.solventSys,
//     required this.swAuthor,
//     required this.classification,
//     required this.name,
//     required this.version,
//     required this.fieldStr,
//     required this.manufacturer,
//     required this.model,
//   });

//   factory NMRMethod.fromJson(List entries) {
//     List<String?> conformerCritBuild = [];
//     List<num?> conformerCalcBuild = [];
//     List<num?> conformerSubmBuild = [];
//     List<List<String?>?> typeBuild = [];
//     List<List<String?>?> ionicStrBuild = [];
//     List<List<String?>?> phBuild = [];
//     List<List<String?>?> pressureBuild = [];
//     List<List<String?>?> pressureUnitBuild = [];
//     List<List<String?>?> tempBuild = [];
//     List<List<String?>?> detailsBuild = [];
//     List<List<String?>?> methodBuild = [];
//     List<String?> conformerIDBuild = [];
//     List<String?> selectionCritBuild = [];
//     List<List<String?>?> contentsBuild = [];
//     List<List<String?>?> solventSysBuild = [];
//     List<List<String?>?> swAuthorBuild = [];
//     List<List<String?>?> classificationBuild = [];
//     List<List<String?>?> nameBuild = [];
//     List<List<String?>?> versionBuild = [];
//     List<List<num?>?> fieldStrBuild = [];
//     List<List<String?>?> manufacturerBuild = [];
//     List<List<String?>?> modelBuild = [];

//     try {
//       for (Map<String, dynamic> entry in entries) {
//         Map<String, dynamic> data = entry['data'];
//         Map<String, dynamic>? nmrEnsemble = data['pdbx_nmr_ensemble'];
//         List<Map<String, dynamic>?>? conditions = data['pdbx_nmr_exptl_sample_conditions']?.cast<Map<String, dynamic>?>();
//         List<Map<String, dynamic>?>? refine = data['pdbx_nmr_refine']?.cast<Map<String, dynamic>?>();
//         Map<String, dynamic>? representative = data['pdbx_nmr_representative'];
//         List<Map<String, dynamic>?>? sample = data['pdbx_nmr_sample_details']?.cast<Map<String, dynamic>?>();
//         List<Map<String, dynamic>?>? sw = data['pdbx_nmr_software']?.cast<Map<String, dynamic>?>();
//         List<Map<String, dynamic>?>? spectrometer = data['pdbx_nmr_spectrometer']?.cast<Map<String, dynamic>?>();

//         conformerCritBuild.add(nmrEnsemble?['conformer_selection_criteria'] as String?);
//         conformerCalcBuild.add(nmrEnsemble?['conformers_calculated_total_number'] as num?);
//         conformerCalcBuild.add(nmrEnsemble?['conformers_submitted_total_number'] as num?);
//         typeBuild.add((data['pdbx_nmr_exptl'] as List?)?.map((e) => e?['type'] as String?).toList());
//         ionicStrBuild.add(conditions?.map((e) => e?['ionic_strength'] as String?).toList());
//         phBuild.add(conditions?.map((e) => e?['pH'] as String?).toList());
//         pressureBuild.add(conditions?.map((e) => e?['pressure'] as String?).toList());
//         pressureUnitBuild.add(conditions?.map((e) => e?['pressure_units'] as String?).toList());
//         tempBuild.add(conditions?.map((e) => e?['temperature'] as String?).toList());
//         detailsBuild.add(refine?.map((e) => e?['details'] as String?).toList());
//         methodBuild.add(refine?.map((e) => e?['method'] as String?).toList());
//         conformerIDBuild.add(representative?['conformer_id'] as String?);
//         selectionCritBuild.add(representative?['selection_criteria'] as String?);
//         contentsBuild.add(sample?.map((e) => e?['contents'] as String?).toList());
//         solventSysBuild.add(sample?.map((e) => e?['solvent_system'] as String?).toList());
//         swAuthorBuild.add(sw?.map((e) => e?['authors'] as String?).toList());
//         classificationBuild.add(sw?.map((e) => e?['classification'] as String?).toList());
//         nameBuild.add(sw?.map((e) => e?['name'] as String?).toList());
//         versionBuild.add(sw?.map((e) => e?['version'] as String?).toList());
//         fieldStrBuild.add(spectrometer?.map((e) => e?['field_strength'] as num?).toList());
//         manufacturerBuild.add(spectrometer?.map((e) => e?['manufacturer'] as String?).toList());
//         modelBuild.add(spectrometer?.map((e) => e?['model'] as String?).toList());
//       }
//       return NMRMethod(
//         conformerCrit: conformerCritBuild,
//         conformerCalc: conformerCalcBuild,
//         conformerSubm: conformerSubmBuild,
//         type: typeBuild,
//         ionicStr: ionicStrBuild,
//         ph: phBuild,
//         pressure: pressureBuild,
//         pressureUnit: pressureUnitBuild,
//         temp: tempBuild,
//         details: detailsBuild,
//         method: methodBuild,
//         conformerID: conformerIDBuild,
//         selectionCrit: selectionCritBuild,
//         contents: contentsBuild,
//         solventSys: solventSysBuild,
//         swAuthor: swAuthorBuild,
//         classification: classificationBuild,
//         name: nameBuild,
//         version: versionBuild,
//         fieldStr: fieldStrBuild,
//         manufacturer: manufacturerBuild,
//         model: modelBuild,
//       );
//     } catch (e) {
//       throw FormatException('Invalid JSON format: $e');
//     }
//   }
// }

// class PublicationsPrimary {
//   final List<List<String?>?> author;
//   final List<String?> title;
//   final List<num?> year;
//   final List<String?> journal;
//   final List<String?> vol;
//   final List<String?> firstPg;
//   final List<String?> lastPg;
//   final List<String?> doi;

//   PublicationsPrimary({
//     required this.author,
//     required this.title,
//     required this.year,
//     required this.journal,
//     required this.vol,
//     required this.firstPg,
//     required this.lastPg,
//     required this.doi,
//   });

//   factory PublicationsPrimary.fromJson(List entries) {
//     List<List<String?>?> authorBuild = [];
//     List<String?> titleBuild = [];
//     List<num?> yearBuild = [];
//     List<String?> journalBuild = [];
//     List<String?> volBuild = [];
//     List<String?> firstPgBuild = [];
//     List<String?> lastPgBuild = [];
//     List<String?> doiBuild = [];

//     try {
//       for (Map<String, dynamic> entry in entries) {
//         Map<String, dynamic> data = entry['data'];
//         Map<String, dynamic>? primaries = data['rcsb_primary_citation'];

//         authorBuild.add((primaries?['rcsb_authors'] as List?)?.map((e) => e as String?).toList());
//         titleBuild.add(primaries?['title'] as String?);
//         yearBuild.add(primaries?['year'] as num?);
//         journalBuild.add(primaries?['rcsb_journal_abbrev'] as String?);
//         volBuild.add(primaries?['journal_volume'] as String?);
//         firstPgBuild.add(primaries?['page_first'] as String?);
//         lastPgBuild.add(primaries?['page_last'] as String?);
//         doiBuild.add(primaries?['pdbx_database_id_DOI'] as String?);
//       }
//       return PublicationsPrimary(
//         author: authorBuild,
//         title: titleBuild,
//         year: yearBuild,
//         journal: journalBuild,
//         vol: volBuild,
//         firstPg: firstPgBuild,
//         lastPg: lastPgBuild,
//         doi: doiBuild,
//       );
//     } catch (e) {
//       throw FormatException('Invalid JSON format: $e');
//     }
//   }
// }