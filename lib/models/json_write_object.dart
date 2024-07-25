import 'dart:convert';

class JsonWObject {
  final List<Entry> _entries;

  List<Entry> get all {
    return List<Entry>.from(_entries, growable: false);
  }

  JsonWObject.initializeFromJson(String jsonString) : _entries = _decodeJsonData(jsonString);

  static List<Entry> _decodeJsonData(String jsonString) {
    try {
      final list = (jsonDecode(jsonString) as List)
          .map((entry) => Entry.fromJson(entry))
          .toList();
      return list;
    } catch (e) {
      throw FormatException('Invalid JSON format: $e');
    }
  }
}

class Entry {
  final String id;
  final StructData structData;
  final PolyData polyData;
  final AssemData assemData;
  final NonPolyData nonPolyData;
  final OligoData oligoData;

  Entry({
    required this.id,
    required this.structData,
    required this.polyData,
    required this.assemData,
    required this.nonPolyData,
    required this.oligoData,
  });

  factory Entry.fromJson(Map<String, dynamic> entry) {
    try {
      return Entry(
        id: entry['rcsb_id'] as String,
        structData: StructData.fromJson(entry),
        polyData: PolyData.fromJson(entry),
        assemData: AssemData.fromJson(entry),
        nonPolyData: NonPolyData.fromJson(entry),
        oligoData: OligoData.fromJson(entry),
      );
    } catch (e) {
      throw FormatException('Invalid Entry format: $e');
    }
  }
}

class StructData {
  final Key key;
  final Dep dep;
  final EntFeat entFeat;
  final GroupDep groupDep;
  final Dim dim;
  final String? comp;
  final BindAff bindAff;
  final CrystProp crystProp;
  final Meth meth;
  final XData xData;
  final XMeth xMeth;
  final EMMeth emMeth;
  final NMRMeth nmrMeth;
  final PubPrim pubPrim;

  StructData({
    required this.key,
    required this.dep,
    required this.entFeat,
    required this.groupDep,
    required this.dim,
    required this.comp,
    required this.bindAff,
    required this.crystProp,
    required this.meth,
    required this.xData,
    required this.xMeth,
    required this.emMeth,
    required this.nmrMeth,
    required this.pubPrim,
  });

  factory StructData.fromJson(Map<String, dynamic> entry) {
    return StructData(
      key: Key.fromJson(entry),
      dep: Dep.fromJson(entry),
      entFeat: EntFeat.fromJson(entry),
      groupDep: GroupDep.fromJson(entry),
      dim: Dim.fromJson(entry),
      comp: entry['rcsb_binding_affinity']?[0]?['comp_id'] as String?,
      bindAff: BindAff.fromJson(entry),
      crystProp: CrystProp.fromJson(entry),
      meth: Meth.fromJson(entry),
      xData: XData.fromJson(entry),
      xMeth: XMeth.fromJson(entry),
      emMeth: EMMeth.fromJson(entry),
      nmrMeth: NMRMeth.fromJson(entry),
      pubPrim: PubPrim.fromJson(entry),
    );
  }
}

class Key {
  final String? pdbID;
  final List<String?>? emdbID;
  final List<String?>? dbID;
  final String? pmCentralID;
  final num? pmID;
  final String? doi;
  final String? structKeywords;

  Key({
    required this.pdbID,
    required this.emdbID,
    required this.dbID,
    required this.pmCentralID,
    required this.pmID,
    required this.doi,
    required this.structKeywords,
  });

  factory Key.fromJson(Map<String, dynamic> entry) {
    try {
      Map<String, dynamic>? ids = entry['rcsb_entry_container_identifiers'];
      Map<String, dynamic>? pubmed = entry['pubmed'];
      return Key(
        pdbID: ids?['entry_id'] as String?,
        emdbID:(ids?['emdb_ids'] as List?)?.map((e) => e as String?).toList(),
        dbID: (entry['pdbx_database_related'] as List?)
            ?.map((e) => (e as Map<String, dynamic>?)?['db_id'] as String?).toList(),
        pmCentralID: pubmed?['rcsb_pubmed_central_id'] as String?,
        pmID: pubmed?['rcsb_pubmed_container_identifiers']?['pubmed_id'] as num?,
        doi: pubmed?['rcsb_pubmed_doi'] as String?,
        structKeywords: entry['struct_keywords']?['pdbx_keywords'] as String?,
      );
    } catch (e) {
      throw FormatException('Invalid JSON format: $e');
    }
  }
}

class Dep {
  final List<String?>? author;
  final String? title;
  final String? depoDate;
  final String? releaseDate;
  final List<String?>? projCenterName;
  final List<String?>? projCenterInitials;
  final List<String?>? projName;

  Dep({
    required this.author,
    required this.title,
    required this.depoDate,
    required this.releaseDate,
    required this.projCenterName,
    required this.projCenterInitials,
    required this.projName,
  });

  factory Dep.fromJson(Map<String, dynamic> entry) {    
    try {
      List<Map<String, dynamic>?>? project = entry['pdbx_SG_project']?.cast<Map<String, dynamic>?>();
      Map<String, dynamic>? accessInfo = entry['rcsb_accession_info'];
      return Dep(
        author: (entry['audit_author'] as List?)
            ?.map((e) => (e as Map<String, dynamic>?)?['name'] as String?)
            .toList(),
        title: entry['struct']?['title'] as String?,
        depoDate: accessInfo?['deposit_date'] as String?,
        releaseDate: accessInfo?['initial_release_date'] as String?,
        projCenterName: project?.map((e) => e?['full_name_of_center'] as String?).toList(),
        projCenterInitials: project?.map((e) => e?['initial_of_center'] as String?).toList(),
        projName: project?.map((e) => e?['project_name'] as String?).toList(),
      );
    } catch (e) {
      throw FormatException('Invalid JSON format: $e');
    }
  }
}

class EntFeat {
  final num? numNHAtoms;
  final num? depoCount;
  final num? numNonPolyIn;
  final num? numPolyIn;
  final num? numPolyResi;
  final num? numH2O;
  final num? disulfBCount;
  final num? numEnt;
  final num? molecWeight;
  final num? numNonPolyEnt;
  final String? entryPolyComp;
  final num? numDNAEnt;
  final num? numNAHybridEnt;
  final num? numProteinEnt;
  final num? numRNAEnt;
  final List<num?>? refRes;
  final String? types;

  EntFeat({
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

  factory EntFeat.fromJson(Map<String, dynamic> entry) {
    try {
      Map<String, dynamic>? entryInfo = entry['rcsb_entry_info'];
      return EntFeat(
        numNHAtoms: entryInfo?['deposited_atom_count'] as num?,
        depoCount: entryInfo?['deposited_model_count'] as num?,
        numNonPolyIn: entryInfo?['deposited_nonpolymer_entity_instance_count'] as num?,
        numPolyIn: entryInfo?['deposited_polymer_entity_instance_count'] as num?,
        numPolyResi: entryInfo?['deposited_polymer_monomer_count'] as num?,
        numH2O: entryInfo?['deposited_solvent_atom_count'] as num?,
        disulfBCount: entryInfo?['disulfide_bond_count'] as num?,
        numEnt: entryInfo?['entity_count'] as num?,
        molecWeight: entryInfo?['molecular_weight'] as num?,
        numNonPolyEnt: entryInfo?['nonpolymer_entity_count'] as num?,
        entryPolyComp: entryInfo?['polymer_composition'] as String?,
        numDNAEnt: entryInfo?['polymer_entity_count_DNA'] as num?,
        numNAHybridEnt: entryInfo?['polymer_entity_count_nucleic_acid_hybrid'] as num?,
        numProteinEnt: entryInfo?['polymer_entity_count_protein'] as num?,
        numRNAEnt: entryInfo?['polymer_entity_count_RNA'] as num?,
        refRes: (entryInfo?['resolution_combined'] as List?)
          ?.map((e) => e as num?)
          .toList(),
        types: entryInfo?['selected_polymer_entity_types'] as String?,
      );
    } catch (e) {
      throw FormatException('Invalid JSON format: $e');
    }
  }
}

class GroupDep {
  final List<String?>? id;
  final List<String?>? description;
  final List<String?>? title;
  final List<String?>? type;

  GroupDep({
    required this.id,
    required this.description,
    required this.title,
    required this.type,
  });

  factory GroupDep.fromJson(Map<String, dynamic> entry) {
    try {
      List<Map<String, dynamic>?>? group = entry['pdbx_deposit_group']?.cast<Map<String, dynamic>?>();
      return GroupDep(
        id: group?.map((e) => e?['group_id'] as String?).toList(),
        description: group?.map((e) => e?['group_description'] as String?).toList(),
        title: group?.map((e) => e?['group_title'] as String?).toList(),
        type: group?.map((e) => e?['group_type'] as String?).toList(),
      );
    } catch (e) {
      throw FormatException('Invalid JSON format: $e');
    }
  }
}

class Dim {
  final num? zNum;
  final num? alpha;
  final num? beta;
  final num? gamma;
  final num? lA;
  final num? lB;
  final num? lC;
  final String? spaceGroup;

  Dim({
    required this.zNum,
    required this.alpha,
    required this.beta,
    required this.gamma,
    required this.lA,
    required this.lB,
    required this.lC,
    required this.spaceGroup,
  });

  factory Dim.fromJson(Map<String, dynamic> entry) {
    try {
      Map<String, dynamic>? cell = entry['cell'];
      return Dim(
        zNum: cell?['Z_PDB'] as num?,
        alpha: cell?['angle_alpha'] as num?,
        beta: cell?['angle_beta'] as num?,
        gamma: cell?['angle_gamma'] as num?,
        lA: cell?['length_a'] as num?,
        lB: cell?['length_b'] as num?,
        lC: cell?['length_c'] as num?,
        spaceGroup: entry['symmetry']?['space_group_name_H_M'] as String?,
      );
    } catch (e) {
      throw FormatException('Invalid JSON format: $e');
    }
  }
}

class BindAff {
  final List<num?>? value;
  final List<String?>? provenanceCode;
  final List<num?>? refSequenceID;
  final List<String?>? symbol;
  final List<String?>? type;
  final List<String?>? unit;

  BindAff({
    required this.value,
    required this.provenanceCode,
    required this.refSequenceID,
    required this.symbol,
    required this.type,
    required this.unit,
  });

  factory BindAff.fromJson(Map<String, dynamic> entry) {    
    try {
      List<Map<String, dynamic>?>? bA = entry['rcsb_binding_affinity']?.cast<Map<String, dynamic>?>();
      return BindAff(
        value: bA?.map((e) => e?['value'] as num?).toList(),
        provenanceCode: bA?.map((e) => e?['provenance_code'] as String?).toList(),
        refSequenceID: bA?.map((e) => e?['reference_sequence_identity'] as num?).toList(),
        symbol: bA?.map((e) => e?['symbol'] as String?).toList(),
        type: bA?.map((e) => e?['type'] as String?).toList(),
        unit: bA?.map((e) => e?['unit'] as String?).toList(),
      );
    } catch (e) {
      throw FormatException('Invalid JSON format: $e');
    }
  }
}

class CrystProp {
  final List<num?>? matthews;
  final List<num?>? perSolvent;
  final List<String?>? crystalMeth;
  final List<num?>? ph;
  final List<String?>? growthProc;
  final List<num?>? temp;

  CrystProp({
    required this.matthews,
    required this.perSolvent,
    required this.crystalMeth,
    required this.ph,
    required this.growthProc,
    required this.temp,
  });

  factory CrystProp.fromJson(Map<String, dynamic> entry) {
    try {
      List<Map<String, dynamic>?>? density = entry['exptl_crystal']?.cast<Map<String, dynamic>?>();
      List<Map<String, dynamic>?>? growth = entry['exptl_crystal_grow']?.cast<Map<String, dynamic>?>();
      return CrystProp(
        matthews: density?.map((e) => e?['density_Matthews'] as num?).toList(),
        perSolvent: density?.map((e) => e?['density_percent_sol'] as num?).toList(),
        crystalMeth: growth?.map((e) => e?['method'] as String?).toList(),
        ph: growth?.map((e) => e?['pH'] as num?).toList(),
        growthProc: growth?.map((e) => e?['pdbx_details'] as String?).toList(),
        temp: growth?.map((e) => e?['temp'] as num?).toList(),
      );
    } catch (e) {
      throw FormatException('Invalid JSON format: $e');
    }
  }
}

class Meth {
  final List<String?>? experimental;
  final String? structDeter;

  Meth({
    required this.experimental,
    required this.structDeter,
  });

  factory Meth.fromJson(Map<String, dynamic> entry) {
    try {
      return Meth(
        experimental: (entry['exptl'] as List?)?.map((e) => (e as Map<String, dynamic>?)?['method'] as String?).toList(),
        structDeter: entry['rcsb_entry_info']?['structure_determination_methodology'] as String?,
      );
    } catch (e) {
      throw FormatException('Invalid JSON format: $e');
    }
  }
}

class XData {
  final List<num?>? collectionTemp;
  final List<String?>? detector;
  final List<String?>? collectionDate;
  final List<String?>? diffSourceGen;
  final List<String?>? diffSourceM;
  final num? collectionRes;
  final List<num?>? bWilsonEst;
  final List<num?>? redundancy;
  final List<num?>? perPossRefl;
  final List<num?>? rValMergeInten;
  final List<String?>? diffSourceSyncSite;
  final List<String?>? diffSourceSyncBeam;
  final num? minDiffWave;
  final num? maxDiffWave;

  XData({
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

  factory XData.fromJson(Map<String, dynamic> entry) {
    try {
      List<Map<String, dynamic>?>? detect = entry['diffrn_detector']?.cast<Map<String, dynamic>?>();
      List<Map<String, dynamic>?>? source = entry['diffrn_source']?.cast<Map<String, dynamic>?>();
      Map<String, dynamic>? entryInfo = entry['rcsb_entry_info'] as Map<String, dynamic>?;
      List<Map<String, dynamic>?>? reflns = entry['reflns']?.cast<Map<String, dynamic>?>();
      return XData(
        collectionTemp: (entry['diffrn'] as List?)?.map((e) => e?['ambient_temp'] as num?).toList(),
        detector: detect?.map((e) => e?['detector'] as String?).toList(),
        collectionDate: detect?.map((e) => e?['pdbx_collection_date'] as String?).toList(),
        diffSourceGen: source?.map((e) => e?['source'] as String?).toList(),
        diffSourceM: source?.map((e) => e?['type'] as String?).toList(),
        collectionRes: (entryInfo?['diffrn_resolution_high'] as Map<String, dynamic>?)?['value'] as num?,
        bWilsonEst: reflns?.map((e) => e?['B_iso_Wilson_estimate'] as num?).toList(),
        redundancy: reflns?.map((e) => e?['pdbx_redundancy'] as num?).toList(),
        perPossRefl: reflns?.map((e) => e?['percent_possible_obs'] as num?).toList(),
        rValMergeInten: reflns?.map((e) => e?['pdbx_Rmerge_I_obs'] as num?).toList(),
        diffSourceSyncSite: source?.map((e) => e?['pdbx_synchrotron_site'] as String?).toList(),
        diffSourceSyncBeam: source?.map((e) => e?['pdbx_synchrotron_beamline'] as String?).toList(),
        minDiffWave: entryInfo?['diffrn_radiation_wavelength_minimum'] as num?,
        maxDiffWave: entryInfo?['diffrn_radiation_wavelength_maximum'] as num?,
      );
    } catch (e) {
      throw FormatException('Invalid JSON format: $e');
    }
  }
}

class XMeth {
  final List<num?>? avgB;
  final List<num?>? rFree;
  final List<num?>? rWork;
  final List<num?>? rAll;
  final List<num?>? rObserved;
  final List<num?>? highResLimit;
  final List<num?>? reflectRefine;
  final List<String?>? structDeter;
  final List<String?>? refineID;

  XMeth({
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

  factory XMeth.fromJson(Map<String, dynamic> entry) {
    try {
      List<Map<String, dynamic>?>? refine = entry['refine']?.cast<Map<String, dynamic>?>();
      return XMeth(
        avgB: refine?.map((e) => e?['B_iso_mean'] as num?).toList(),
        rFree: refine?.map((e) => e?['ls_R_factor_R_free'] as num?).toList(),
        rWork: refine?.map((e) => e?['ls_R_factor_R_work'] as num?).toList(),
        rAll: refine?.map((e) => e?['ls_R_factor_all'] as num?).toList(),
        rObserved: refine?.map((e) => e?['ls_R_factor_obs'] as num?).toList(),
        highResLimit: refine?.map((e) => e?['ls_d_res_high'] as num?).toList(),
        reflectRefine: refine?.map((e) => e?['ls_number_reflns_obs'] as num?).toList(),
        structDeter: refine?.map((e) => e?['pdbx_method_to_determine_struct'] as String?).toList(),
        refineID: refine?.map((e) => e?['pdbx_refine_id'] as String?).toList(),
      );
    } catch (e) {
      throw FormatException('Invalid JSON format: $e');
    }
  }
}

class EMMeth {
  final List<num?>? emRes;
  final List<String?>? symmType;
  final List<num?>? emDiffRes;
  final String? aggState;
  final String? reconstrMethod;
  final List<String?>? filmDetModel;
  final List<String?>? microscopeModel;
  final List<String?>? pointSymm;
  final List<String?>? embed;
  final List<String?>? stain;
  final List<String?>? vitrify;
  final List<num?>? accVolt;

  EMMeth({
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

  factory EMMeth.fromJson(Map<String, dynamic> entry) {
    
    try {
      List<Map<String, dynamic>?>? em3d = entry['em_3d_reconstruction']?.cast<Map<String, dynamic>?>();
      Map<String, dynamic>? experiment = entry['em_experiment'];
      List<Map<String, dynamic>?>? imaging = entry['em_imaging']?.cast<Map<String, dynamic>?>();
      List<Map<String, dynamic>?>? specimen = entry['em_specimen']?.cast<Map<String, dynamic>?>();
      return EMMeth(
        emRes: em3d?.map((e) => e?['resolution'] as num?).toList(),
        symmType: em3d?.map((e) => e?['symmetry_type'] as String?).toList(),
        emDiffRes: (entry['em_diffraction_stats'] as List?)?.map((e) => e?['high_resolution'] as num?).toList(),
        aggState: experiment?['aggregation_state'] as String?,
        reconstrMethod: experiment?['reconstruction_method'] as String?,
        filmDetModel: (entry['em_image_recording'] as List?)?.map((e) => e?['film_or_detector_model'] as String?).toList(),
        microscopeModel: imaging?.map((e) => e?['microscope_model'] as String?).toList(),
        pointSymm: (entry['em_single_particle_entity'] as List?)?.map((e) => e?['point_symmetry'] as String?).toList(),
        embed: specimen?.map((e) => e?['embedding_applied'] as String?).toList(),
        stain: specimen?.map((e) => e?['staining_applied'] as String?).toList(),
        vitrify: specimen?.map((e) => e?['vitrification_applied'] as String?).toList(),
        accVolt: imaging?.map((e) => e?['accelerating_voltage'] as num?).toList(),
      );
    } catch (e) {
      throw FormatException('Invalid JSON format: $e');
    }
  }
}

class NMRMeth {
  final String? conformerCrit;
  final num? conformerCalc;
  final num? conformerSubm;
  final List<String?>? type;
  final List<String?>? ionicStr;
  final List<String?>? ph;
  final List<String?>? pressure;
  final List<String?>? pressureUnit;
  final List<String?>? temp;
  final List<String?>? details;
  final List<String?>? method;
  final String? conformerID;
  final String? selectionCrit;
  final List<String?>? contents;
  final List<String?>? solventSys;
  final List<String?>? swAuthor;
  final List<String?>? classification;
  final List<String?>? name;
  final List<String?>? version;
  final List<num?>? fieldStr;
  final List<String?>? manufacturer;
  final List<String?>? model;

  NMRMeth({
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

  factory NMRMeth.fromJson(Map<String, dynamic> entry) {
    try {
      Map<String, dynamic>? nmrEnsemble = entry['pdbx_nmr_ensemble'];
      List<Map<String, dynamic>?>? conditions = entry['pdbx_nmr_exptl_sample_conditions']?.cast<Map<String, dynamic>?>();
      List<Map<String, dynamic>?>? refine = entry['pdbx_nmr_refine']?.cast<Map<String, dynamic>?>();
      Map<String, dynamic>? representative = entry['pdbx_nmr_representative'];
      List<Map<String, dynamic>?>? sample = entry['pdbx_nmr_sample_details']?.cast<Map<String, dynamic>?>();
      List<Map<String, dynamic>?>? sw = entry['pdbx_nmr_software']?.cast<Map<String, dynamic>?>();
      List<Map<String, dynamic>?>? spectrometer = entry['pdbx_nmr_spectrometer']?.cast<Map<String, dynamic>?>();
      return NMRMeth(
        conformerCrit: nmrEnsemble?['conformer_selection_criteria'] as String?,
        conformerCalc: nmrEnsemble?['conformers_calculated_total_number'] as num?,
        conformerSubm: nmrEnsemble?['conformers_submitted_total_number'] as num?,
        type: (entry['pdbx_nmr_exptl'] as List?)?.map((e) => e?['type'] as String?).toList(),
        ionicStr: conditions?.map((e) => e?['ionic_strength'] as String?).toList(),
        ph: conditions?.map((e) => e?['pH'] as String?).toList(),
        pressure: conditions?.map((e) => e?['pressure'] as String?).toList(),
        pressureUnit: conditions?.map((e) => e?['pressure_units'] as String?).toList(),
        temp: conditions?.map((e) => e?['temperature'] as String?).toList(),
        details: refine?.map((e) => e?['details'] as String?).toList(),
        method: refine?.map((e) => e?['method'] as String?).toList(),
        conformerID: representative?['conformer_id'] as String?,
        selectionCrit: representative?['selection_criteria'] as String?,
        contents: sample?.map((e) => e?['contents'] as String?).toList(),
        solventSys: sample?.map((e) => e?['solvent_system'] as String?).toList(),
        swAuthor: sw?.map((e) => e?['authors'] as String?).toList(),
        classification: sw?.map((e) => e?['classification'] as String?).toList(),
        name: sw?.map((e) => e?['name'] as String?).toList(),
        version: sw?.map((e) => e?['version'] as String?).toList(),
        fieldStr: spectrometer?.map((e) => e?['field_strength'] as num?).toList(),
        manufacturer: spectrometer?.map((e) => e?['manufacturer'] as String?).toList(),
        model: spectrometer?.map((e) => e?['model'] as String?).toList(),
      );
    } catch (e) {
      throw FormatException('Invalid JSON format: $e');
    }
  }
}

class PubPrim {
  final List<String?>? author;
  final String? title;
  final num? year;
  final String? journal;
  final String? vol;
  final String? firstPg;
  final String? lastPg;
  final String? doi;

  PubPrim({
    required this.author,
    required this.title,
    required this.year,
    required this.journal,
    required this.vol,
    required this.firstPg,
    required this.lastPg,
    required this.doi,
  });

  factory PubPrim.fromJson(Map<String, dynamic> entry) {
    try {
      Map<String, dynamic>? primaries = entry['rcsb_primary_citation'];
      return PubPrim(
        author: (primaries?['rcsb_authors'] as List?)?.map((e) => e as String?).toList(),
        title: primaries?['title'] as String?,
        year: primaries?['year'] as num?,
        journal: primaries?['rcsb_journal_abbrev'] as String?,
        vol: primaries?['journal_volume'] as String?,
        firstPg: primaries?['page_first'] as String?,
        lastPg: primaries?['page_last'] as String?,
        doi: primaries?['pdbx_database_id_DOI'] as String?,
      );
    } catch (e) {
      throw FormatException('Invalid JSON format: $e');
    }
  }
}


class PolyData {
  final PolyIDs ids;
  final EntSourceOrg entSourceOrg;
  final PolyFeat polyFeat;

  PolyData({
    required this.ids,
    required this.entSourceOrg,
    required this.polyFeat,
  });

  factory PolyData.fromJson(Map<String, dynamic> entry) {
    return PolyData(
      ids: PolyIDs.fromJson(entry),
      entSourceOrg: EntSourceOrg.fromJson(entry),
      polyFeat: PolyFeat.fromJson(entry),
    );
  }
}

class PolyIDs {
  final String? entityID;
  final String? entryID;
  final List<String?>? asymID;
  final List<String?>? authAsymID;

  PolyIDs({
    required this.entityID,
    required this.entryID,
    required this.asymID,
    required this.authAsymID,
  });

  factory PolyIDs.fromJson(Map<String, dynamic> entry) {
    try {
      return PolyIDs(
        entityID: entry['rcsb_polymer_entity_container_identifiers']?['entity_id'] as String?,
        entryID: entry['rcsb_polymer_entity_container_identifiers']?['entry_id'] as String?,
        asymID: (entry['polymer_entity_instances'] as List?)
              ?.map((e) => e?['rcsb_polymer_entity_instance_container_identifiers']?['asym_id'] as String?)
              .toList(),
        authAsymID: (entry['polymer_entity_instances'] as List?)
              ?.map((e) => e?['rcsb_polymer_entity_instance_container_identifiers']?['auth_asym_id'] as String?)
              .toList(),
      );
    } catch (e) {
      throw FormatException('Invalid JSON format: $e');
    }
  }
}

class EntSourceOrg {
  final List<List<String?>?>? expHost;
  final List<List<String?>?>? srcOrg;
  final List<List<num?>?>? taxID;
  final List<List<List<String?>?>?>? provSrc;
  final List<List<List<String?>?>?>? geneName;

  EntSourceOrg({
    required this.expHost,
    required this.srcOrg,
    required this.taxID,
    required this.provSrc,
    required this.geneName,
  });
  
  factory EntSourceOrg.fromJson(Map<String, dynamic> entry) {
    try {
      List<Map<String, dynamic>?>? polyEnts = entry['polymer_entities']?.cast<Map<String, dynamic>?>();
      return EntSourceOrg(
        expHost: polyEnts
              ?.map((e) => (e?['rcsb_entity_host_organism'] as List?)
                ?.map((f) => f?['ncbi_scientific_name'] as String?)
                .toList())
              .toList(),
        srcOrg: polyEnts
              ?.map((e) => (e?['rcsb_entity_source_organism'] as List?)
                ?.map((f) => f?['ncbi_scientific_name'] as String?)
                .toList())
              .toList(),
        taxID: polyEnts
              ?.map((e) => (e?['rcsb_entity_source_organism'] as List?)
                ?.map((f) => f?['ncbi_taxonomy_id'] as num?)
                .toList())
              .toList(),
        provSrc: polyEnts
              ?.map((e) => (e?['rcsb_entity_source_organism'] as List?)
                ?.map((f) => (f?['rcsb_gene_name'] as List?)
                  ?.map((g) => g?['provenance_source'] as String?)
                  .toList())
                .toList())
              .toList(),
        geneName: polyEnts
              ?.map((e) => (e?['rcsb_entity_source_organism'] as List?)
                ?.map((f) => (f?['rcsb_gene_name'] as List?)
                  ?.map((g) => g?['value'] as String?)
                  .toList())
                .toList())
              .toList(),
      );
    } catch (e) {
      throw FormatException('Invalid JSON format: $e');
    }
  }
}

class PolyFeat {
  final List<String?>? sequence;
  final List<String?>? entPolyType;
  final List<num?>? numTotal;
  final List<num?>? sequenceLen;
  final List<String?>? macromolecType;
  final List<List<String?>?>? plasmidName;
  final List<List<num?>?>? clusterID;
  final List<List<num?>?>? clusterIDThresh;
  final List<num?>? molecWeight;
  final List<String?>? macromolecName; // description
  final List<List<String?>?>? macromolecNameList; // combined [list]
  final List<List<String?>?>? ecNum;
  final List<List<String?>?>? ecProvSrc;
  final List<List<String?>?>? provCodeECO;
  final List<List<String?>?>? provSrc;
  final List<List<String?>?>? annotID;
  final List<List<List<String?>?>?>? annotLineage;
  final List<List<String?>?>? annotType;
  final List<List<String?>?>? accessCode;
  final List<List<String?>?>? dbName;
  final List<List<String?>?>? provCode;
  final List<List<String?>?>? value;
  
  PolyFeat({
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

  factory PolyFeat.fromJson(Map<String, dynamic> entry) {

    try {
      List<Map<String, dynamic>?>? polyEnts = entry['polymer_entities']?.cast<Map<String, dynamic>?>();
      return PolyFeat(  
        sequence: 
              polyEnts
                ?.map((e) => e?['entity_poly']?['pdbx_seq_one_letter_code_can'] as String?)
                .toList(),
        entPolyType: 
              polyEnts
                ?.map((e) => e?['entity_poly']?['rcsb_entity_polymer_type'] as String?)
                .toList(),
        numTotal: 
              polyEnts
                ?.map((e) => e?['rcsb_polymer_entity']?['pdbx_number_of_molecules'] as num?)
                .toList(),
        sequenceLen: 
              polyEnts
                ?.map((e) => e?['entity_poly']?['rcsb_sample_sequence_length'] as num?)
                .toList(),
        macromolecType: 
              polyEnts
                ?.map((e) => e?['entity_poly']?['type'] as String?)
                .toList(),
        plasmidName: 
              polyEnts
                ?.map((e) => (e?['entity_src_gen'] as List?)
                  ?.map((f) => f?['plasmid_name'] as String?)
                  .toList())
                .toList(),
        clusterID: 
              polyEnts
                ?.map((e) => (e?['rcsb_cluster_membership'] as List?)
                  ?.map((f) => f?['cluster_id'] as num?)
                  .toList())
                .toList(),
        clusterIDThresh: 
              polyEnts
                ?.map((e) => (e?['rcsb_cluster_membership'] as List?)
                  ?.map((f) => f?['identity'] as num?)
                  .toList())
                .toList(),
        molecWeight: 
              polyEnts
                ?.map((e) => e?['rcsb_polymer_entity']?['formula_weight'] as num?)
                .toList(),
        macromolecName: 
              polyEnts
                ?.map((e) => e?['rcsb_polymer_entity']?['pdbx_description'] as String?)
                .toList(),
        macromolecNameList: 
              polyEnts
                ?.map((e) => (e?['rcsb_polymer_entity']?['rcsb_macromolecular_names_combined'] as List?)
                  ?.map((f) => (f?['name'] as String?))
                  .toList())
                .toList(),
        ecNum: 
              polyEnts
                ?.map((e) => (e?['rcsb_polymer_entity']?['rcsb_enzyme_class_combined'] as List?)
                  ?.map((f) => f?['ec'] as String?)
                  .toList())
                .toList(),
        ecProvSrc: 
              polyEnts
                ?.map((e) => (e?['rcsb_polymer_entity']?['rcsb_enzyme_class_combined'] as List?)
                  ?.map((f) => f?['provenance_source'] as String?)
                  .toList())
                .toList(),
        provCodeECO: 
              polyEnts
                ?.map((e) => (e?['rcsb_polymer_entity']?['rcsb_macromolecular_names_combined'] as List?)
                  ?.map((f) => f?['provenance_code'] as String?)
                  .toList())
                .toList(),
        provSrc: 
              polyEnts
                ?.map((e) => (e?['rcsb_polymer_entity']?['rcsb_macromolecular_names_combined'] as List?)
                  ?.map((f) => f['provenance_source'] as String?)
                  .toList())
                .toList(),
        annotID: 
              polyEnts
                ?.map((e) => (e?['rcsb_polymer_entity_annotation'] as List?)
                  ?.map((f) => f?['annotation_id'] as String?)
                  .toList())
                .toList(),
        annotLineage: 
              polyEnts
                ?.map((e) => (e?['rcsb_polymer_entity_annotation'] as List?)
                  ?.map((f) => (f?['annotation_lineage'] as List?)
                    ?.map((g) => g?['name'] as String?)
                    .toList())
                  .toList())
                .toList(),
        annotType: 
              polyEnts
                ?.map((e) => (e?['rcsb_polymer_entity_annotation'] as List?)
                  ?.map((f) => f?['type'] as String?)
                  .toList())
                .toList(),
        accessCode: 
              polyEnts
                ?.map((e) => (e?['rcsb_polymer_entity_container_identifiers']?['reference_sequence_identifiers'] as List?)
                  ?.map((f) => f?['database_accession'] as String?)
                  .toList())
                .toList(),
        dbName: 
              polyEnts
                ?.map((e) => (e?['rcsb_polymer_entity_container_identifiers']?['reference_sequence_identifiers'] as List?)
                  ?.map((f) => f?['database_name'] as String?)
                  .toList())
                .toList(),
        provCode: 
              polyEnts
                ?.map((e) => (e?['uniprots'] as List?)
                  ?.map((f) => f?['rcsb_uniprot_protein']?['name']?['provenance_code'] as String?)
                  .toList())
                .toList(),
        value: 
              polyEnts
                ?.map((e) => (e?['uniprots'] as List?)
                  ?.map((f) => f?['rcsb_uniprot_protein']?['name']?['value'] as String?)
                  .toList())
                .toList(),
      );
    } catch (e) {
      throw FormatException('Invalid JSON format: $e');
    }
  }
}



class AssemData {
  final List<String?>? assemID;
  final AssemFeat assemFeat;

  AssemData({
    required this.assemID,
    required this.assemFeat,
  });

  factory AssemData.fromJson(Map<String, dynamic> entry) {
    return AssemData(
      assemID: _getAssemID(entry),
      assemFeat: AssemFeat.fromJson(entry),
    );
  }
}

List<String?>? _getAssemID(Map<String, dynamic> entry) {
  try {
    return (entry['assemblies'] as List?)
          ?.map((e) => e?['rcsb_assembly_container_identifiers']?['assembly_id'] as String?)
          .toList();
  } catch (e) {
    throw FormatException('Invalid JSON format: $e');
  }
}

class AssemFeat {
  final List<num?>? totalPolyChains;
  final List<num?>? totalPolyRes;
  final List<num?>? oligoCount;
  final List<List<String?>?>? kind;
  final List<List<String?>?>? oligoState;
  final List<List<List<String?>?>?>? stoich;
  final List<List<String?>?>? symbol;
  final List<List<String?>?>? type;

  AssemFeat({
    required this.totalPolyChains,
    required this.totalPolyRes,
    required this.oligoCount,
    required this.kind,
    required this.oligoState,
    required this.stoich,
    required this.symbol,
    required this.type,
  });

  factory AssemFeat.fromJson(Map<String, dynamic> entry) {    
    try {
      List<Map<String, dynamic>?>? assemblies = entry['assemblies']?.cast<Map<String, dynamic>?>();
      return AssemFeat(
        totalPolyChains: assemblies
              ?.map((e) => e?['rcsb_assembly_info']?['polymer_entity_instance_count'] as num?)
              .toList(),
        totalPolyRes: assemblies
              ?.map((e) => e?['rcsb_assembly_info']?['polymer_monomer_count'] as num?)
              .toList(),
        oligoCount: assemblies
              ?.map((e) => e?['pdbx_struct_assembly']?['oligomeric_count'] as num?)
              .toList(),
        kind: assemblies
              ?.map((e) => (e?['rcsb_struct_symmetry'] as List?)
                ?.map((f) => f?['kind'] as String?)
                .toList())
              .toList(),
        oligoState: assemblies
              ?.map((e) => (e?['rcsb_struct_symmetry'] as List?)
                ?.map((f) => f?['oligomeric_state'] as String?)
                .toList())
              .toList(),
        stoich: assemblies
              ?.map((e) => (e?['rcsb_struct_symmetry'] as List?)
                ?.map((f) => (f?['stoichiometry'] as List?)
                  ?.map((g) => g as String?)
                  .toList())
                .toList())
              .toList(),
        symbol: assemblies
              ?.map((e) => (e?['rcsb_struct_symmetry'] as List?)
                ?.map((f) => f?['symbol'] as String?)
                .toList())
              .toList(),
        type: assemblies
              ?.map((e) => (e?['rcsb_struct_symmetry'] as List?)
                ?.map((f) => f?['type'] as String?)
                .toList())
              .toList(),
      );
    } catch (e) {
      throw FormatException('Invalid JSON format: $e');
    }
  }
}



class NonPolyData {
  final NonPolyIDs ids;
  final NonPolyFeat nonPolyFeat;

  NonPolyData({
    required this.ids,
    required this.nonPolyFeat,
  });

  factory NonPolyData.fromJson(Map<String, dynamic> entry) {
    return NonPolyData(
      ids: NonPolyIDs.fromJson(entry),
      nonPolyFeat: NonPolyFeat.fromJson(entry),
    );
  }
}

class NonPolyIDs {
  final List<String?>? entityID;
  final List<List<String?>?>? asymID;
  final List<List<String?>?>? authAsymID;

  NonPolyIDs({
    required this.entityID,
    required this.asymID,
    required this.authAsymID,
  });

  factory NonPolyIDs.fromJson(Map<String, dynamic> entry) {
    
    try {
      List<Map<String, dynamic>?>? nonPolyEnts = entry['nonpolymer_entity_instances'];
      return NonPolyIDs(
        entityID: nonPolyEnts
              ?.map((e) => e?['nonpolymer_entity_instance_container_identifiers']?['entity_id'] as String?)
              .toList(),
        asymID: 
              nonPolyEnts?.map((e) => (e?['nonpolymer_entity_instances'] as List?)
                ?.map((f) => f?['rcsb_nonpolymer_instance_container_identifiers']?['asym_id'] as String?)
                .toList())
              .toList(),
        authAsymID: nonPolyEnts
              ?.map((e) => (e?['nonpolymer_entity_instances'] as List?)
                ?.map((f) => f?['rcsb_nonpolymer_instance_container_identifiers']?['auth_asym_id'] as String?)
                .toList())
              .toList(),
      );
    } catch (e) {
      throw FormatException('Invalid JSON format: $e');
    }
  }
}

class NonPolyFeat {
  final List<String?>? ligandFormula;
  final List<num?>? ligandMW;
  final List<String?>? ligandID;
  final List<String?>? ligandName;
  final List<String?>? inChI;
  final List<String?>? inChIKey;
  final List<String?>? ligandSmiles;
  final List<List<String?>?>? relatedCode;
  final List<List<String?>?>? relatedName;
  final List<List<String?>?>? ligandInterest;

  NonPolyFeat({
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

  factory NonPolyFeat.fromJson(Map<String, dynamic> entry) {
    try {
      List<Map<String, dynamic>?>? npe = entry['nonpolymer_entities']?.cast<Map<String, dynamic>?>();
      return NonPolyFeat(  
        ligandFormula: npe
              ?.map((e) => e?['nonpolymer_comp']?['chem_comp']?['formula'] as String?)
              .toList(),
        ligandMW: npe
              ?.map((e) => e?['nonpolymer_comp']?['chem_comp']?['formula_weight'] as num?)
              .toList(),
        ligandID: npe
              ?.map((e) => e?['nonpolymer_comp']?['chem_comp']?['id'] as String?)
              .toList(),
        ligandName: npe
              ?.map((e) => e?['nonpolymer_comp']?['chem_comp']?['name'] as String?)
              .toList(),
        inChI: npe
              ?.map((e) => e?['nonpolymer_comp']?['rcsb_chem_comp_descriptor']?['InChI'] as String?)
              .toList(),
        inChIKey: npe
              ?.map((e) => e?['nonpolymer_comp']?['rcsb_chem_comp_descriptor']?['InChIKey'] as String?)
              .toList(),
        ligandSmiles: npe
              ?.map((e) => e?['nonpolymer_comp']?['rcsb_chem_comp_descriptor']?['SMILES_stereo'] as String?)
              .toList(),
        relatedCode: npe
              ?.map((e) => (e?['nonpolymer_comp']?['rcsb_chem_comp_related'] as List?)
                ?.map((f) => f?['resource_accession_code'] as String?)
                .toList())
              .toList(),
        relatedName: npe
              ?.map((e) => (e?['nonpolymer_comp']?['rcsb_chem_comp_related'] as List?)
                ?.map((f) => f?['resource_name'] as String?)
                .toList())
              .toList(),
        ligandInterest: npe
              ?.map((e) => (e?['rcsb_nonpolymer_entity_annotation'] as List?)
                ?.map((f) => f?['type'] as String?)
                .toList())
              .toList(),
      );
    } catch (e) {
      throw FormatException('Invalid JSON format: $e');
    }
  }
}



class OligoData {
  final OligoIDs ids;
  final OligoFeat oligoFeat;

  OligoData({
    required this.ids,
    required this.oligoFeat,
  });

  factory OligoData.fromJson(Map<String, dynamic> entry) {
    return OligoData(
      ids: OligoIDs.fromJson(entry),
      oligoFeat: OligoFeat.fromJson(entry),
    );
  }
}

class OligoIDs {
  final List<String?>? entityID;
  final List<List<String?>?>? asymID;
  final List<List<String?>?>? authAsymID;

  OligoIDs({
    required this.entityID,
    required this.asymID,
    required this.authAsymID,
  });

  factory OligoIDs.fromJson(Map<String, dynamic> entry) {
    try {
        List<Map<String, dynamic>?>? branchEnts = entry['branched_entities']?.cast<Map<String, dynamic>?>();
      return OligoIDs(
        entityID: branchEnts
              ?.map((e) => e?['rcsb_branched_entity_container_identifiers']?['rcsb_id'] as String?)
              .toList(),
        asymID: branchEnts
              ?.map((e) => (e?['rcsb_branched_entity_container_identifiers']?['asym_ids'] as List?)
                ?.map((f) => f as String?)
                .toList())
              .toList(),
        authAsymID: branchEnts
              ?.map((e) => (e?['rcsb_branched_entity_container_identifiers']?['auth_asym_ids'] as List?)
                ?.map((f) => f as String?)
                .toList())
              .toList(),
      );
    } catch (e) {
      throw FormatException('Invalid JSON format: $e');
    }
  }
}

class OligoFeat {
  final List<num?>? chainLength;
  final List<List<String?>?>? linDescType;
  final List<List<String?>?>? linDesc;
  final List<String?>? molecName;
  final List<List<String?>?>? monosacc;
  final List<List<List<String?>?>?>? glycosylation;

  OligoFeat({
    required this.chainLength,
    required this.linDescType,
    required this.linDesc,
    required this.molecName,
    required this.monosacc,
    required this.glycosylation,
  });

  factory OligoFeat.fromJson(Map<String, dynamic> entry) {    
    try {
        List<Map<String, dynamic>?>? branchEnts = entry['branched_entities']?.cast<Map<String, dynamic>?>();
      return OligoFeat(
        chainLength: 
              branchEnts
                ?.map((e) => e?['pdbx_entity_branch']?['rcsb_branched_component_count'] as num?)
                .toList(),
        linDescType: 
              branchEnts
                ?.map((e) => (e?['pdbx_entity_branch_descriptor'] as List?)
                  ?.map((f) => f?['type'] as String?)
                  .toList())
                .toList(),
        linDesc: 
              branchEnts
                ?.map((e) => (e?['pdbx_entity_branch_descriptor'] as List?)
                  ?.map((f) => f?['descriptor'] as String?)
                  .toList())
                .toList(),
        molecName: 
              branchEnts
                ?.map((e) => e?['rcsb_branched_entity']?['pdbx_description'] as String?)
                .toList(),
        monosacc: 
              branchEnts
                ?.map((e) => (e?['rcsb_branched_entity_container_identifiers']?['chem_comp_monomers'] as List?)
                  ?.map((f) => f as String?)
                  .toList())
                .toList(),
        glycosylation: 
              branchEnts
                ?.map((e) => (e?['branched_entity_instances'] as List?)
                  ?.map((f) => (f?['rcsb_branched_struct_conn'] as List?)
                    ?.map((g) => g?['role'] as String?)
                    .toList())
                  .toList())
                .toList(),
      );
    } catch (e) {
      throw FormatException('Invalid JSON format: $e');
    }
  }
}