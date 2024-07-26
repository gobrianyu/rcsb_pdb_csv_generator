import 'package:rcsb_pdb_json2csv_flex/models/json_write_object.dart';

final need = [OptionKey.s6o0, OptionKey.s6o1, OptionKey.s6o2, OptionKey.s6o3, OptionKey.s6o4, OptionKey.s6o5, OptionKey.s7o0, OptionKey.s7o1, OptionKey.s7o2, OptionKey.s7o3, 
                  OptionKey.s7o4, OptionKey.s7o5, OptionKey.s9o0, OptionKey.s9o1, OptionKey.s9o2, OptionKey.s9o3, OptionKey.s9o4, OptionKey.s9o6, OptionKey.s9o7, OptionKey.s9o8, 
                  OptionKey.s9o10, OptionKey.s10o0, OptionKey.s10o1, OptionKey.s10o2, OptionKey.s10o3, OptionKey.s10o4, OptionKey.s10o5, OptionKey.s10o6, OptionKey.s10o7, 
                  OptionKey.s10o8, OptionKey.s11o0, OptionKey.s11o1, OptionKey.s11o2, OptionKey.s11o5, OptionKey.s11o6, OptionKey.s11o7, OptionKey.s11o8, OptionKey.s11o9, 
                  OptionKey.s11o10, OptionKey.s11o11, OptionKey.s12o4, OptionKey.s12o5, OptionKey.s12o6, OptionKey.s12o7, OptionKey.s12o8, OptionKey.s12o9, OptionKey.s12o10, 
                  OptionKey.s12o13, OptionKey.s12o14, OptionKey.s12o15, OptionKey.s12o16, OptionKey.s12o17, OptionKey.s12o18, OptionKey.s12o19, OptionKey.s12o20, 
                  OptionKey.s12o21, OptionKey.p0o2, OptionKey.p0o3, OptionKey.p1o0, OptionKey.p1o1, OptionKey.p1o2, OptionKey.p1o3, OptionKey.p1o4, OptionKey.p2o0, OptionKey.p2o1, 
                  OptionKey.p2o2, OptionKey.p2o3, OptionKey.p2o4, OptionKey.p2o5, OptionKey.p2o6, OptionKey.p2o7, OptionKey.p2o8, OptionKey.p2o9, OptionKey.p2o10, OptionKey.p2o11, 
                  OptionKey.p2o12, OptionKey.p2o13, OptionKey.p2o14, OptionKey.p2o15, OptionKey.p2o16, OptionKey.p2o17, OptionKey.p2o18, OptionKey.p2o19, OptionKey.p2o20, 
                  OptionKey.p2o21, OptionKey.a0o0, OptionKey.a1o0, OptionKey.a1o1, OptionKey.a1o2, OptionKey.a1o3, OptionKey.a1o4, OptionKey.a1o5, OptionKey.a1o6, OptionKey.a1o7, 
                  OptionKey.n0o0, OptionKey.n0o1, OptionKey.n0o2, OptionKey.n1o1, OptionKey.n1o2, OptionKey.n1o3, OptionKey.n1o4, OptionKey.n1o5, OptionKey.n1o6, OptionKey.n1o7, OptionKey.n1o8, 
                  OptionKey.n1o9, OptionKey.o0o0, OptionKey.o0o1, OptionKey.o0o2, OptionKey.o1o0, OptionKey.o1o1, OptionKey.o1o2, OptionKey.o1o3, OptionKey.o1o4, OptionKey.o1o5];

enum OptionKey {

  // STRUCTURE DATA:
  // ids and keywords
  s0o0(77, 'Structure Data', 'IDs and Keywords', 'PDB ID', 'Entry identifier for the container.', '%0Arcsb_entry_container_identifiers%7Bentry_id%7D'),
  s0o1(76, 'Structure Data', 'IDs and Keywords', 'EMDB Map', 'List of EMDB identifiers for the 3D electron microscopy density maps used in the production of the structure model.', '%0Arcsb_entry_container_identifiers%7Bemdb_ids%7D'),
  s0o2(37, 'Structure Data', 'IDs and Keywords', 'Additional Map', 'Identifying code in the related database', '%0Apdbx_database_related%7Bdb_id%7D'),
  s0o3(64, 'Structure Data', 'IDs and Keywords', 'PubMed Central ID', '', '%0Apubmed%7Brcsb_pubmed_central_id%7D'),
  s0o4(65, 'Structure Data', 'IDs and Keywords', 'PubMed ID', '', '%0Apubmed%7Brcsb_pubmed_container_identifiers%7Bpubmed_id%7D%7D'),
  s0o5(66, 'Structure Data', 'IDs and Keywords', 'DOI', '', '%0Apubmed%7Brcsb_pubmed_doi%7D'),
  s0o6(117, 'Structure Data', 'IDs and Keywords', 'Structure Keywords', 'Terms characterising the macromolecular structure.', '%0Astruct_keywords%7Bpdbx_keywords%7D'),
  // deposition
  s1o0(0, 'Structure Data', 'Deposition', 'Structure Author', 'Name of the author(s) of this data block. Family name(s), followed by a comma and including any dynastic components, precedes the first name(s) or initial(s).', '%0Aaudit_author%7Bname%7D'),
  s1o1(116, 'Structure Data', 'Deposition', 'Structure Title', 'Title for the data block. Represents the essence of the structure archived in the CIF to distinguish the structural result from others.', '%0Astruct%7Btitle%7D'),
  s1o2(67, 'Structure Data', 'Deposition', 'Deposition Date', '', '%0Arcsb_accession_info%7Bdeposit_date%7D'),
  s1o3(68, 'Structure Data', 'Deposition', 'Release Date', '', '%0Arcsb_accession_info%7Binitial_release_date%7D'),
  s1o4(34, 'Structure Data', 'Deposition', 'Structural Genomics Project Center Name', '', '%0Apdbx_SG_project%7Bfull_name_of_center%7D'),
  s1o5(35, 'Structure Data', 'Deposition', 'Structural Genomics Project Center Initials', '', '%0Apdbx_SG_project%7Binitial_of_center%7D'),
  s1o6(36, 'Structure Data', 'Deposition', 'Structural Genomics Project Name', '', '%0Apdbx_SG_project%7Bproject_name%7D'),
  // entry features
  s2o0(78, 'Structure Data', 'Entry Features', 'Number of Non-Hydrogen Atoms per Deposited Model', 'Number of heavy atom coordinates records per deposited structure model.', '%0Arcsb_entry_info%7Bdeposited_atom_count%7D'),
  s2o1(79, 'Structure Data', 'Entry Features', 'Number of Deposited Models', 'Number of model structures deposited.', '%0Arcsb_entry_info%7Bdeposited_model_count%7D'),
  s2o2(80, 'Structure Data', 'Entry Features', 'Number of Non-Polymer Instances', 'Number of non-polymer instances in the deposited data set (total count of polymer entity instances reported per deposited structure model).', '%0Arcsb_entry_info%7Bdeposited_nonpolymer_entity_instance_count%7D'),
  s2o3(81, 'Structure Data', 'Entry Features', 'Number of Polymer Instances (Chains)', 'Number of polymer instances in the deposited data set (total count of polymer entity instances reported per deposited structure model).', '%0Arcsb_entry_info%7Bdeposited_polymer_entity_instance_count%7D'),
  s2o4(82, 'Structure Data', 'Entry Features', 'Number of Polymer Residues per Deposited Model', 'Number of polymer monomers in sample entity instances in the deposited data set (total count of monomers for all polymer entity instances reported per deposited structure model).', '%0Arcsb_entry_info%7Bdeposited_polymer_monomer_count%7D'),
  s2o5(83, 'Structure Data', 'Entry Features', 'Number of Water Molecules per Deposited Model', 'Number of heavy solvent atom coordinates records per deposited structure model.', '%0Arcsb_entry_info%7Bdeposited_solvent_atom_count%7D'),
  s2o6(84, 'Structure Data', 'Entry Features', 'Number of Disulfide Bonds per Deposited Model', 'Number of disulfide bonds per deposited structure model.', '%0Arcsb_entry_info%7Bdisulfide_bond_count%7D'),
  s2o7(85, 'Structure Data', 'Entry Features', 'Number of Distinct Molecular Entities', 'Number of distinct polymer, non-polymer, branched molecular, and solvent entities per deposited structure model.', '%0Arcsb_entry_info%7Bentity_count%7D'),
  s2o8(86, 'Structure Data', 'Entry Features', 'Molecular Weight per Deposited Model', 'Molecular mass of polymer and non-polymer entities (exclusive of solvent) in the deposited structure entry in kDa.', '%0Arcsb_entry_info%7Bmolecular_weight%7D'),
  s2o9(87, 'Structure Data', 'Entry Features', 'Number of Distinct Non-Polymer Entities', 'Number of distinct non-polymer entities in the structure entry exclusive of solvent.', '%0Arcsb_entry_info%7Bnonpolymer_entity_count%7D'),
  s2o10(88, 'Structure Data', 'Entry Features', 'Entry Polymer Composition', 'Categories describing the polymer entity composition for the entry.', '%0Arcsb_entry_info%7Bpolymer_composition%7D'),
  s2o11(89, 'Structure Data', 'Entry Features', 'Number of Distinct DNA Entities', 'Number of distinct DNA polymer entities', '%0Arcsb_entry_info%7Bpolymer_entity_count_DNA%7D'),
  s2o12(90, 'Structure Data', 'Entry Features', 'Number of Distinct NA Hybrid Entities', 'Number of distinct hybrid nucleic acid polymer entities', '%0Arcsb_entry_info%7Bpolymer_entity_count_nucleic_acid_hybrid%7D'),
  s2o13(91, 'Structure Data', 'Entry Features', 'Number of Distinct Protein Entities', 'Number of distinct protein polymer entities.', '%0Arcsb_entry_info%7Bpolymer_entity_count_protein%7D'),
  s2o14(92, 'Structure Data', 'Entry Features', 'Number of Distinct RNA Entities', 'Number of distinct RNA polymer entities', '%0Arcsb_entry_info%7Bpolymer_entity_count_RNA%7D'),
  s2o15(93, 'Structure Data', 'Entry Features', 'Refinement Resolution', 'Combined estimates of experimental resolution contributing to the refined stuctural model. Multiple values are reported only if multiple methods are used in the structure determination.', '%0Arcsb_entry_info%7Bresolution_combined%7D'),
  s2o16(94, 'Structure Data', 'Entry Features', 'Entry Polymer Types', 'Selected polymer entity type categories describing the entry.', '%0Arcsb_entry_info%7Bselected_polymer_entity_types%7D'),
  // group deposition
  s3o0(38, 'Structure Data', 'Group Deposition', 'Group ID', 'Unique identifier for a group of entries deposited as a collection.', '%0Apdbx_deposit_group%7Bgroup_id%7D'),
  s3o1(39, 'Structure Data', 'Group Deposition', 'Group Description', 'Description of the contents of entries in the collection.', '%0Apdbx_deposit_group%7Bgroup_description%7D'),
  s3o2(40, 'Structure Data', 'Group Deposition', 'Group Title', 'Title to describe the group of entries deposited in the collection.', '%0Apdbx_deposit_group%7Bgroup_title%7D'),
  s3o3(41, 'Structure Data', 'Group Deposition', 'Group Type', 'Text to describe a grouping of entries in multiple collections.', '%0Apdbx_deposit_group%7Bgroup_type%7D'),
  // cell dimensions and space group
  s4o0(1, 'Structure Data', 'Cell Dimensions and Space Group', 'Z-Number', 'Number of polymeric chains in a unit cell. In the case of heteropolymers, Z is the number of occurrences of the most populous chain.', '%0Acell%7BZ_PDB%7D'),
  s4o1(2, 'Structure Data', 'Cell Dimensions and Space Group', 'Angle alpha', 'Unit-cell angle alpha of the reported structure in degrees.', '%0Acell%7Bangle_alpha%7D'),
  s4o2(3, 'Structure Data', 'Cell Dimensions and Space Group', 'Angle beta', 'Unit-cell angle beta of the reported structure in degrees.', '%0Acell%7Bangle_beta%7D'),
  s4o3(4, 'Structure Data', 'Cell Dimensions and Space Group', 'Angle gamma', 'Unit-cell angle gamma of the reported structure in degrees.', '%0Acell%7Bangle_gamma%7D'),
  s4o4(5, 'Structure Data', 'Cell Dimensions and Space Group', 'Length a', 'Unit-cell length a corresponding to the structure reported in angstroms.', '%0Acell%7Blength_a%7D'),
  s4o5(6, 'Structure Data', 'Cell Dimensions and Space Group', 'Length b', 'Unit-cell length b corresponding to the structure reported in angstroms.', '%0Acell%7Blength_b%7D'),
  s4o6(7, 'Structure Data', 'Cell Dimensions and Space Group', 'Length c', 'Unit-cell length c corresponding to the structure reported in angstroms.', '%0Acell%7Blength_c%7D'),
  s4o7(118, 'Structure Data', 'Cell Dimensions and Space Group', 'Space Group', 'Hermann-Mauguin space-group symbol.', '%0Asymmetry%7Bspace_group_name_H_M%7D'),
  // chemical components
  s5o0(69, 'Structure Data', 'Chemical Components', 'Ligand', 'Ligand identifier.', '%0Arcsb_binding_affinity%7Bcomp_id%7D'),
  // binding affinity
  s6o0(70, 'Structure Data', 'Binding Affinity', 'Value', 'Binding affinity value between a ligand and its target molecule.', '%0Arcsb_binding_affinity%7Bvalue%7D'),
  s6o1(71, 'Structure Data', 'Binding Affinity', 'Provenance Code', 'Resource name for the related binding affinity reference.', '%0Arcsb_binding_affinity%7Bprovenance_code%7D'),
  s6o2(72, 'Structure Data', 'Binding Affinity', 'Reference Sequence Identity', 'Percent identity between PDB sequence and reference sequence (data point provided by BindingDB).', '%0Arcsb_binding_affinity%7Breference_sequence_identity%7D'),
  s6o3(73, 'Structure Data', 'Binding Affinity', 'Symbol', 'Binding affinity symbol indicating approximate or precise strength of the binding.', '%0Arcsb_binding_affinity%7Bsymbol%7D'),
  s6o4(74, 'Structure Data', 'Binding Affinity', 'Type', 'Binding affinity measurement given in one of the following types: The concentration constants: IC50, EC50; The binding constant: Kd: dissociation constant; Ka, Ki; The thermodynamic parameters: ΔG, ΔH, ΔS.', '%0Arcsb_binding_affinity%7Btype%7D'),
  s6o5(75, 'Structure Data', 'Binding Affinity', 'Unit', 'Binding affinity unit. Dissociation constant Kd is normally in molar units (or millimolar, micromolar, nanomolar, etc.). Association constant Ka is normally expressed in inverse molar units (e.g. M-1)', '%0Arcsb_binding_affinity%7Bunit%7D'),
  // crystal properties
  s7o0(28, 'Structure Data', 'Crystal Properties', 'Matthews Coefficient', 'Density of the crystal, expressed as the ratio of the volume of the asymmetric unit to the molecular mass of a monomer of the structure, in units of angstroms cubed per dalton.', '%0Aexptl_crystal%7Bdensity_Matthews%7D'),
  s7o1(29, 'Structure Data', 'Crystal Properties', 'Percent Solvent Content', 'Density value P calculated from the crystal cell and contents expressed as percent solvent.', '%0Aexptl_crystal%7Bdensity_percent_sol%7D'),
  s7o2(30, 'Structure Data', 'Crystal Properties', 'Crystallisaton Method', 'Method used to grow the crystals.', '%0Aexptl_crystal_grow%7Bmethod%7D'),
  s7o3(31, 'Structure Data', 'Crystal Properties', 'pH', 'Final pH at which the crystal was grown.', '%0Aexptl_crystal_grow%7BpH%7D'),
  s7o4(32, 'Structure Data', 'Crystal Properties', 'Crystal Growth Procedure', 'Text description of the crystal growth procedure.', '%0Aexptl_crystal_grow%7Bpdbx_details%7D'),
  s7o5(33, 'Structure Data', 'Crystal Properties', 'Temperature', 'Final temperature in kelvins at which the crystal was grown.', '%0Aexptl_crystal_grow%7Btemp%7D'),
  // methods
  s8o0(27, 'Structure Data', 'Methods', 'Experimental Method', 'Method used in the experiment', '%0Aexptl%7Bmethod%7D'),
  s8o1(95, 'Structure Data', 'Methods', 'Structure Determination Methodology', 'Indicates if the structure was determined using experimental or computational methods.', '%0Arcsb_entry_info%7Bstructure_determination_methodology%7D'),
  // x-ray data collection details
  s9o0(8, 'Structure Data', 'X-Ray Data Collection Details', 'Collection Temperature', 'Mean temperature in kelvins at which the intensities were measured.', '%0Adiffrn%7Bambient_temp%7D'),
  s9o1(9, 'Structure Data', 'X-Ray Data Collection Details', 'Detector', 'General class of the radiation detector.', '%0Adiffrn_detector%7Bdetector%7D'),
  s9o2(10, 'Structure Data', 'X-Ray Data Collection Details', 'Collection Date', 'Date of data collection', '%0Adiffrn_detector%7Bpdbx_collection_date%7D'),
  s9o3(11, 'Structure Data', 'X-Ray Data Collection Details', 'Diffraction Source General Class', 'General class of the radiation source.', '%0Adiffrn_source%7Bsource%7D'),
  s9o4(12, 'Structure Data', 'X-Ray Data Collection Details', 'Diffraction Source Make, Model, or Name', 'Make, model, or name of the source of radiation.', '%0Adiffrn_source%7Btype%7D'),
  s9o5(96, 'Structure Data', 'X-Ray Data Collection Details', 'Data Collection Resolution', 'High resolution limit of data collection', '%0Arcsb_entry_info%7Bdiffrn_resolution_high%7Bvalue%7D%7D'),
  s9o6(119, 'Structure Data', 'X-Ray Data Collection Details', 'B Wilson Estimate', 'Value of the overall isotropic displacement parameter estimated from the slope of the Wilson plot.', '%0Areflns%7BB_iso_Wilson_estimate%7D'),
  s9o7(120, 'Structure Data', 'X-Ray Data Collection Details', 'Overall Redundancy', 'Overall redundancy for this data set.', '%0Areflns%7Bpdbx_redundancy%7D'),
  s9o8(121, 'Structure Data', 'X-Ray Data Collection Details', 'Percentage of Possible Reflections', 'Percentage of geometrically possible reflections.', '%0Areflns%7Bpercent_possible_obs%7D'),
  s9o9(122, 'Structure Data', 'X-Ray Data Collection Details', 'R Value for Merging Intensities (Observed)', 'R value for merging intensities satisfying the observed criteria in this data set.', '%0Areflns%7Bpdbx_Rmerge_I_obs%7D'),
  s9o10(13, 'Structure Data', 'X-Ray Data Collection Details', 'Diffraction Source Synchrotron Site', '', '%0Adiffrn_source%7Bpdbx_synchrotron_site%7D'),
  s9o11(14, 'Structure Data', 'X-Ray Data Collection Details', 'Diffraction Source Synchrotron Beamline', '', '%0Adiffrn_source%7Bpdbx_synchrotron_beamline%7D'),
  s9o12(97, 'Structure Data', 'X-Ray Data Collection Details', 'Minimum Diffraction Wavelength', 'Minimum radiation wavelength in angstroms.', '%0Arcsb_entry_info%7Bdiffrn_radiation_wavelength_minimum%7D'),
  s9o13(98, 'Structure Data', 'X-Ray Data Collection Details', 'Maximum Diffraction Wavelength', 'Maximum radiation wavelength in angstroms.', '%0Arcsb_entry_info%7Bdiffrn_radiation_wavelength_maximum%7D'),
  // x-ray method details
  s10o0(107, 'Structure Data', 'X-Ray Method Details', 'Average B Factor', 'Mean isotropic displacement parameter (B value) for the coordinate set', '%0Arefine%7BB_iso_mean%7D'),
  s10o1(108, 'Structure Data', 'X-Ray Method Details', 'R Free', 'Residual factor R for reflections that satisfy the resolution and observation limits, and that were used as the test reflections (i.e. were excluded from the refinement) when the refinement included the calculation of a \'free\' R factor.', '%0Arefine%7Bls_R_factor_R_free%7D'),
  s10o2(109, 'Structure Data', 'X-Ray Method Details', 'R Work', 'Residual factor R for reflections that satisfy the resolution and observation limits, and that were used as the working reflections (i.e. were included in the refinement) when the refinement included the calculation of a \'free\' R factor', '%0Arefine%7Bls_R_factor_R_work%7D'),
  s10o3(110, 'Structure Data', 'X-Ray Method Details', 'R All', 'Residual factor R for all reflections that satisfy the resolution limits.', '%0Arefine%7Bls_R_factor_all%7D'),
  s10o4(111, 'Structure Data', 'X-Ray Method Details', 'R Observed', 'Residual factor R for reflections that satisfy the resolution and observation limits.', '%0Arefine%7Bls_R_factor_obs%7D'),
  s10o5(112, 'Structure Data', 'X-Ray Method Details', 'High Resolution Limit', 'Smallest value for the interplanar spacings for the reflection data used in the refinement in angstroms.', '%0Arefine%7Bls_d_res_high%7D'),
  s10o6(113, 'Structure Data', 'X-Ray Method Details', 'Reflections for Refinement', 'Number of reflections that satisfy the resolution and observation limits.', '%0Arefine%7Bls_number_reflns_obs%7D'),
  s10o7(114, 'Structure Data', 'X-Ray Method Details', 'Structure Determination Method', 'Method(s) used to determine the structure.', '%0Arefine%7Bpdbx_method_to_determine_struct%7D'),
  s10o8(115, 'Structure Data', 'X-Ray Method Details', 'Refine ID', 'Unique identifier for a refinement within an entry.', '%0Arefine%7Bpdbx_refine_id%7D'),
  // em method details
  s11o0(15, 'Structure Data', 'EM Method Details', 'EM Resolution', 'Final resolution of the 3D reconstruction in angstroms.', '%0Aem_3d_reconstruction%7Bresolution%7D'),
  s11o1(16, 'Structure Data', 'EM Method Details', 'Symmetry Type', 'Type of symmetry applied to the reconstruction.', '%0Aem_3d_reconstruction%7Bsymmetry_type%7D'),
  s11o2(17, 'Structure Data', 'EM Method Details', 'EM Diffraction Resolution', 'High resolution limit of the structure factor data in angstroms.', '%0Aem_diffraction_stats%7Bhigh_resolution%7D'),
  s11o3(18, 'Structure Data', 'EM Method Details', 'Aggregation State', 'Aggregation or assembly state of the imaged specimen.', '%0Aem_experiment%7Baggregation_state%7D'),
  s11o4(19, 'Structure Data', 'EM Method Details', 'Reconstruction Method', 'Reconstruction method used in the EM experiment.', '%0Aem_experiment%7Breconstruction_method%7D'),
  s11o5(22, 'Structure Data', 'EM Method Details', 'Film or Detector Model', 'Detector type used for recording images. Usually film, CCD camera, or direct electron detector.', '%0Aem_image_recording%7Bfilm_or_detector_model%7D'),
  s11o6(21, 'Structure Data', 'EM Method Details', 'Microscope Model', 'Name of the model of microscope.', '%0Aem_imaging%7Bmicroscope_model%7D'),
  s11o7(23, 'Structure Data', 'EM Method Details', 'Point Symmetry', 'Point symmetry symbol, either Cn, Dn, T, O, or I.', '%0Aem_single_particle_entity%7Bpoint_symmetry%7D'),
  s11o8(24, 'Structure Data', 'EM Method Details', 'Embedding', 'Indicates whether the specimen has been embedded.', '%0Aem_specimen%7Bembedding_applied%7D'),
  s11o9(25, 'Structure Data', 'EM Method Details', 'Staining', 'Indicates whether the specimen has been stained.', '%0Aem_specimen%7Bstaining_applied%7D'),
  s11o10(26, 'Structure Data', 'EM Method Details', 'Vitrification', 'Indicates whether the specimen was vitrified by cryopreservation.', '%0Aem_specimen%7Bvitrification_applied%7D'),
  s11o11(20, 'Structure Data', 'EM Method Details', 'Accelerating Voltage', 'Value of accelerating voltage used for imaging in kV.', '%0Aem_imaging%7Baccelerating_voltage%7D'),
  // nmr method details
  s12o0(42, 'Structure Data', 'NMR Method Details', 'Conformer Selection Criteria', 'Describes how the submitted conformer (models) were selected.', '%0Apdbx_nmr_ensemble%7Bconformer_selection_criteria%7D'),
  s12o1(43, 'Structure Data', 'NMR Method Details', 'Total Conformers Calculated', 'Total number of conformer (models) that were calculated in the final round.', '%0Apdbx_nmr_ensemble%7Bconformers_calculated_total_number%7D'),
  s12o2(44, 'Structure Data', 'NMR Method Details', 'Total Conformers Submitted', 'Total number of conformer (models) that were submitted for the ensemble.', '%0Apdbx_nmr_ensemble%7Bconformers_submitted_total_number%7D'),
  s12o3(45, 'Structure Data', 'NMR Method Details', 'Experiment Type', 'Type of NMR experiment.', '%0Apdbx_nmr_exptl%7Btype%7D'),
  s12o4(46, 'Structure Data', 'NMR Method Details', 'Sample Ionic Strength', 'Ionic strength at which the NMR data was collected.', '%0Apdbx_nmr_exptl_sample_conditions%7Bionic_strength%7D'),
  s12o5(47, 'Structure Data', 'NMR Method Details', 'Sample pH', 'pH at which the NMR data was collected.', '%0Apdbx_nmr_exptl_sample_conditions%7BpH%7D'),
  s12o6(48, 'Structure Data', 'NMR Method Details', 'Sample Pressure', 'Pressure at which NMR data was collected.', '%0Apdbx_nmr_exptl_sample_conditions%7Bpressure%7D'),
  s12o7(49, 'Structure Data', 'NMR Method Details', 'Sample Pressure Units', 'Units of pressure at which NMR data was collected.', '%0Apdbx_nmr_exptl_sample_conditions%7Bpressure_units%7D'),
  s12o8(50, 'Structure Data', 'NMR Method Details', 'Sample Temperature', 'Temperature at which NMR data was collected in kelvin.', '%0Apdbx_nmr_exptl_sample_conditions%7Btemperature%7D'),
  s12o9(51, 'Structure Data', 'NMR Method Details', 'Details', 'Additional details about the NMR refinement.', '%0Apdbx_nmr_refine%7Bdetails%7D'),
  s12o10(52, 'Structure Data', 'NMR Method Details', 'Method', 'Method used to determine the structure.', '%0Apdbx_nmr_refine%7Bmethod%7D'),
  s12o11(53, 'Structure Data', 'NMR Method Details', 'Representative Conformer ID', 'Model number identifier of the representative structure.', '%0Apdbx_nmr_representative%7Bconformer_id%7D'),
  s12o12(54, 'Structure Data', 'NMR Method Details', 'Selection Criteria', 'Criteria used to select the representative structure.', '%0Apdbx_nmr_representative%7Bselection_criteria%7D'),
  s12o13(55, 'Structure Data', 'NMR Method Details', 'Contents', 'Complete description of each NMR sample.', '%0Apdbx_nmr_sample_details%7Bcontents%7D'),
  s12o14(56, 'Structure Data', 'NMR Method Details', 'Solvent System', 'Solvent system used for this sample.', '%0Apdbx_nmr_sample_details%7Bsolvent_system%7D'),
  s12o15(57, 'Structure Data', 'NMR Method Details', 'Software Author', 'Name of the authors of the software used in this procedure.', '%0Apdbx_nmr_software%7Bauthors%7D'),
  s12o16(58, 'Structure Data', 'NMR Method Details', 'Software Classification', 'Purpose of the software.', '%0Apdbx_nmr_software%7Bclassification%7D'),
  s12o17(59, 'Structure Data', 'NMR Method Details', 'Software Name', 'Name of the software used for the task.', '%0Apdbx_nmr_software%7Bname%7D'),
  s12o18(60, 'Structure Data', 'NMR Method Details', 'Software Version', 'Version of the software.', '%0Apdbx_nmr_software%7Bversion%7D'),
  s12o19(61, 'Structure Data', 'NMR Method Details', 'Spectrometer Field Strength', 'Field strength of the spectrometer in MHz.', '%0Apdbx_nmr_spectrometer%7Bfield_strength%7D'),
  s12o20(62, 'Structure Data', 'NMR Method Details', 'Spectrometer Manufacturer', 'Name of the manufacturer of the spectrometer.', '%0Apdbx_nmr_spectrometer%7Bmanufacturer%7D'),
  s12o21(63, 'Structure Data', 'NMR Method Details', 'Spectrometer Model', 'Model of the NMR spectrometer.', '%0Apdbx_nmr_spectrometer%7Bmodel%7D'),
  // publications primary
  s13o0(103, 'Structure Data', 'Publications Primary', 'Citation Author', 'Names of the authors of the citation. Family name(s), followed by a comma and including any dynastic components, precedes the first name(s) or initial(s).', '%0Arcsb_primary_citation%7Brcsb_authors%7D'),
  s13o1(105,'Structure Data', 'Publications Primary', 'Title', 'Title of the citation.', '%0Arcsb_primary_citation%7Btitle%7D'),
  s13o2(106, 'Structure Data', 'Publications Primary', 'Publication Year', 'Year of the citation.', '%0Arcsb_primary_citation%7Byear%7D'),
  s13o3(104, 'Structure Data', 'Publications Primary', 'Journal Name', 'Normalised journal abbreviation.', '%0Arcsb_primary_citation%7Brcsb_journal_abbrev%7D'),
  s13o4(99, 'Structure Data', 'Publications Primary', 'Journal Volume', 'Volume number of the journal cited.', '%0Arcsb_primary_citation%7Bjournal_volume%7D'),
  s13o5(100, 'Structure Data', 'Publications Primary', 'First Page', 'First page of the citation.', '%0Arcsb_primary_citation%7Bpage_first%7D'),
  s13o6(101, 'Structure Data', 'Publications Primary', 'Last Page', 'Last page of the citation.', '%0Arcsb_primary_citation%7Bpage_last%7D'),
  s13o7(102, 'Structure Data', 'Publications Primary', 'DOI', 'Document object identifier used by doi.org to uniquely specify bibliographic entry.', '%0Arcsb_primary_citation%7Bpdbx_database_id_DOI%7D'),
  
  // POLYMER ENTITY DATA
  // ids
  p0o0(148, 'Polymer Entity Data', 'IDs', 'Entity ID', 'Entity identifier for the container.', '%0Apolymer_entities%7Brcsb_polymer_entity_container_identifiers%7Bentity_id%7D%7D'),
  p0o1(149, 'Polymer Entity Data', 'IDs', 'Entry ID', 'Entry identifier for the container.', '%0Apolymer_entities%7Brcsb_polymer_entity_container_identifiers%7Bentry_id%7D%7D'),
  p0o2(136, 'Polymer Entity Data', 'IDs', 'Asym ID', '', '%0Apolymer_entities%7Bpolymer_entity_instances%7Brcsb_polymer_entity_instance_container_identifiers%7Basym_id%7D%7D%7D'),
  p0o3(137, 'Polymer Entity Data', 'IDs', 'Auth Asym ID', '', '%0Apolymer_entities%7Bpolymer_entity_instances%7Brcsb_polymer_entity_instance_container_identifiers%7Bauth_asym_id%7D%7D%7D'),
  // entity source organism
  p1o0(140, 'Polymer Entity Data', 'Entity Source Organism', 'Expression Host', '', '%0Apolymer_entities%7Brcsb_entity_host_organism%7Bncbi_scientific_name%7D%7D'),
  p1o1(141, 'Polymer Entity Data', 'Entity Source Organism', 'Source Organism', '', '%0Apolymer_entities%7Brcsb_entity_source_organism%7Bncbi_scientific_name%7D%7D'),
  p1o2(142, 'Polymer Entity Data', 'Entity Source Organism', 'Taxonomy ID', '%0ANCBI taxonomy identifier for the gene source organism assigned by the PDB depositor.', 'polymer_entities%7Brcsb_entity_source_organism%7Bncbi_taxonomy_id%7D%7D'),
  p1o3(143, 'Polymer Entity Data', 'Entity Source Organism', 'Provenance Source', '%0ACode indicating the provenance of the source organism details for the entity.', 'polymer_entities%7Brcsb_entity_source_organism%7Brcsb_gene_name%7Bprovenance_source%7D%7D%7D'),
  p1o4(144, 'Polymer Entity Data', 'Entity Source Organism', 'Gene Name', '', '%0Apolymer_entities%7Brcsb_entity_source_organism%7Brcsb_gene_name%7Bvalue%7D%7D%7D'),
  // polymer features
  p2o0(123, 'Polymer Entity Data', 'Polymer Features', 'Sequence', 'Canonical sequence of protein or nucleic acid polymer in standard one-letter codes of amino acids or nucleotides.', '%0Apolymer_entities%7Bentity_poly%7Bpdbx_seq_one_letter_code_can%7D%7D'),
  p2o1(124, 'Polymer Entity Data', 'Polymer Features', 'Entity Polymer Type', 'Coarse-grained polymer entity type.', '%0Apolymer_entities%7Bentity_poly%7Brcsb_entity_polymer_type%7D%7D'),
  p2o2(127, 'Polymer Entity Data', 'Polymer Features', 'Number of Polymer Entity Instances (Chains) per Entity', 'Number of molecules of the entity in the entry.', '%0Apolymer_entities%7Brcsb_polymer_entity%7Bpdbx_number_of_molecules%7D%7D'),
  p2o3(125, 'Polymer Entity Data', 'Polymer Features', 'Polymer Entity Sequence Length', 'Monomer length of the sample sequence.', '%0Apolymer_entities%7Bentity_poly%7Brcsb_sample_sequence_length%7D%7D'),
  p2o4(126, 'Polymer Entity Data', 'Polymer Features', 'Entity Macromolecule Type', 'Type of the polymer.', '%0Apolymer_entities%7Bentity_poly%7Btype%7D%7D'),
  p2o5(135, 'Polymer Entity Data', 'Polymer Features', 'Plasmid Name', 'Name of the plasmid that produced the entity in the host organism.', '%0Apolymer_entities%7Bentity_src_gen%7Bplasmid_name%7D%7D'),
  p2o6(138, 'Polymer Entity Data', 'Polymer Features', 'Sequence Cluster ID', 'Identifier for a cluster at the specified level of sequence identity within the cluster data set.', '%0Apolymer_entities%7Brcsb_cluster_membership%7Bcluster_id%7D%7D'),
  p2o7(139, 'Polymer Entity Data', 'Polymer Features', 'Sequence Cluster ID Threshold', 'Sequence identity expressed as an integer percent value.', '%0Apolymer_entities%7Brcsb_cluster_membership%7Bidentity%7D%7D'),
  p2o8(128, 'Polymer Entity Data', 'Polymer Features', 'Molecular Weight', 'Formula mass of the entity in kDa.', '%0Apolymer_entities%7Brcsb_polymer_entity%7Bformula_weight%7D%7D'),
  p2o9(129, 'Polymer Entity Data', 'Polymer Features', 'Macromolecule Name', 'Description of the polymer entity.', '%0Apolymer_entities%7Brcsb_polymer_entity%7Bpdbx_description%7D%7D'),
  p2o10(130, 'Polymer Entity Data', 'Polymer Features', 'EC Number', 'Combined list of enzyme class assignments.', '%0Apolymer_entities%7Brcsb_polymer_entity%7Brcsb_enzyme_class_combined%7Bec%7D%7D%7D'),
  p2o11(131, 'Polymer Entity Data', 'Polymer Features', 'EC Provenance Source', 'Combined list of enzyme class associated provenance sources.', '%0Apolymer_entities%7Brcsb_polymer_entity%7Brcsb_enzyme_class_combined%7Bprovenance_source%7D%7D%7D'),
  p2o12(132, 'Polymer Entity Data', 'Polymer Features', 'List of Macromolecule Names', 'Combined list of macromolecular names.', '%0Apolymer_entities%7Brcsb_polymer_entity%7Brcsb_macromolecular_names_combined%7Bname%7D%7D%7D'),
  p2o13(133, 'Polymer Entity Data', 'Polymer Features', 'List of Provenance Codes', 'Combined list of macromolecular names assocated provenance code.', '%0Apolymer_entities%7Brcsb_polymer_entity%7Brcsb_macromolecular_names_combined%7Bprovenance_code%7D%7D%7D'),
  p2o14(134, 'Polymer Entity Data', 'Polymer Features', 'List of Provenance Sources', 'Combined list of macromolecular names associated name source.', '%0Apolymer_entities%7Brcsb_polymer_entity%7Brcsb_macromolecular_names_combined%7Bprovenance_source%7D%7D%7D'),
  p2o15(145, 'Polymer Entity Data', 'Polymer Features', 'Annotation ID', 'Identifier for the annotation.', '%0Apolymer_entities%7Brcsb_polymer_entity_annotation%7Bannotation_id%7D%7D'),
  p2o16(146, 'Polymer Entity Data', 'Polymer Features', 'Annotation Lineage Name', 'Members of the annotation lineage as parent class names.', '%0Apolymer_entities%7Brcsb_polymer_entity_annotation%7Bannotation_lineage%7Bname%7D%7D%7D'),
  p2o17(147, 'Polymer Entity Data', 'Polymer Features', 'Annotation Type', 'Type or category of the annotation.', '%0Apolymer_entities%7Brcsb_polymer_entity_annotation%7Btype%7D%7D'),
  p2o18(150, 'Polymer Entity Data', 'Polymer Features', 'Accession Code(s)', 'Reference database accession code.', '%0Apolymer_entities%7Brcsb_polymer_entity_container_identifiers%7Breference_sequence_identifiers%7Bdatabase_accession%7D%7D%7D'),
  p2o19(151, 'Polymer Entity Data', 'Polymer Features', 'Database Name', 'Reference database name.', '%0Apolymer_entities%7Brcsb_polymer_entity_container_identifiers%7Breference_sequence_identifiers%7Bdatabase_name%7D%7D%7D'),
  p2o20(152, 'Polymer Entity Data', 'Polymer Features', 'Provenance Code', '', '%0Apolymer_entities%7Buniprots%7Brcsb_uniprot_protein%7Bname%7Bprovenance_code%7D%7D%7D%7D'),
  p2o21(153, 'Polymer Entity Data', 'Polymer Features', 'Value', '', '%0Apolymer_entities%7Buniprots%7Brcsb_uniprot_protein%7Bname%7Bvalue%7D%7D%7D%7D'),
  
  // ASSEMBLY DATA
  // ids
  a0o0(157, 'Assembly Data', 'IDs', 'Assembly ID', 'Assembly identifier for the container.', '%0Aassemblies%7Brcsb_assembly_container_identifiers%7Bassembly_id%7D%7D'),
  // assembly features
  a1o0(155, 'Assembly Data', 'Assembly Features', 'Number of Polymer Instances (Chains) per Assembly', 'Number of polymer instances in the generated assembly data set (total count of polymer entity instances generated in the assembly coordinate data).', '%0Aassemblies%7Brcsb_assembly_info%7Bpolymer_entity_instance_count%7D%7D'),
  a1o1(154, 'Assembly Data', 'Assembly Features', 'Number of Polymer Residues per Assembly', 'Number of polymer monomers in sample entity instances comprising the assembly data set (total count of monomers for all polymer entity instances generated in the assembly coordinate data).', '%0Aassemblies%7Brcsb_assembly_info%7Bpolymer_monomer_count%7D%7D'),
  a1o2(156, 'Assembly Data', 'Assembly Features', 'Oligomeric Count', 'Number of polymer molecules in the assembly.', '%0Aassemblies%7Bpdbx_struct_assembly%7Boligomeric_count%7D%7D'),
  a1o3(159, 'Assembly Data', 'Assembly Features', 'Oligomeric State', 'Composition of polymeric subunits in quarteneray structure.', '%0Aassemblies%7Brcsb_struct_symmetry%7Boligomeric_state%7D%7D'),
  a1o4(160, 'Assembly Data', 'Assembly Features', 'Stoichiometry', '', '%0Aassemblies%7Brcsb_struct_symmetry%7Bstoichiometry%7D%7D'),
  a1o5(158, 'Assembly Data', 'Assembly Features', 'Symmetry Granularity', 'Granularity at which the symmetry calculation is performed.', '%0Aassemblies%7Brcsb_struct_symmetry%7Bkind%7D%7D'),
  a1o6(161, 'Assembly Data', 'Assembly Features', 'Symmetry Symbol', 'Point group or helical symmetry of identical polymeric subunits in Schönflies notation.', '%0Aassemblies%7Brcsb_struct_symmetry%7Bsymbol%7D%7D'),
  a1o7(162, 'Assembly Data', 'Assembly Features', 'Symmetry Type', 'Point group or helical symmetry of identical polymeric subunits.', '%0Aassemblies%7Brcsb_struct_symmetry%7Btype%7D%7D'),
 
  // NON-POLYMER ENTITY DATA
  // ids
  n0o0(173, 'Non-Polymer Entity Data', 'IDs', 'Entity ID', 'Entity identifier for the container.', '%0Anonpolymer_entities%7Brcsb_nonpolymer_entity_container_identifiers%7Bentity_id%7D%7D'),
  n0o1(174, 'Non-Polymer Entity Data', 'IDs', 'Asym ID', '', '%0Anonpolymer_entities%7Bnonpolymer_entity_instances%7Brcsb_nonpolymer_entity_instance_container_identifiers%7Basym_id%7D%7D%7D'),
  n0o2(175, 'Non-Polymer Entity Data', 'IDs', 'Auth Asym ID', '', '%0Anonpolymer_entities%7Bnonpolymer_entity_instances%7Brcsb_nonpolymer_entity_instance_container_identifiers%7Bauth_asym_id%7D%7D%7D'),
  // nonpolymer features
  n1o0(163, 'Non-Polymer Entity Data', 'Non-Polymer Features', 'Ligand Formula', '', '%0Anonpolymer_entities%7Bnonpolymer_comp%7Bchem_comp%7Bformula%7D%7D%7D'),
  n1o1(164, 'Non-Polymer Entity Data', 'Non-Polymer Features', 'Ligand MW', '', '%0Anonpolymer_entities%7Bnonpolymer_comp%7Bchem_comp%7Bformula_weight%7D%7D%7D'),
  n1o2(165, 'Non-Polymer Entity Data', 'Non-Polymer Features', 'Ligand ID', '', '%0Anonpolymer_entities%7Bnonpolymer_comp%7Bchem_comp%7Bid%0Aformula_weight%7D%0Arcsb_chem_comp_descriptor%7BSMILES_stereo%7D%7D%7D'),
  n1o3(166, 'Non-Polymer Entity Data', 'Non-Polymer Features', 'Ligand Name', '', '%0Anonpolymer_entities%7Bnonpolymer_comp%7Bchem_comp%7Bname%7D%7D%7D'),
  n1o4(167,'Non-Polymer Entity Data', 'Non-Polymer Features', 'InChI', '', '%0Anonpolymer_entities%7Bnonpolymer_comp%7Brcsb_chem_comp_descriptor%7BInChI%7D%7D%7D'),
  n1o5(168, 'Non-Polymer Entity Data', 'Non-Polymer Features', 'InChI Key', '', '%0Anonpolymer_entities%7Bnonpolymer_comp%7Brcsb_chem_comp_descriptor%7BInChIKey%7D%7D%7D'),
  n1o6(169, 'Non-Polymer Entity Data', 'Non-Polymer Features', 'Ligand SMILES Stereo', '', '%0Anonpolymer_entities%7Bnonpolymer_comp%7Bchem_comp%7Bid%0Aformula_weight%7D%0Arcsb_chem_comp_descriptor%7BSMILES_stereo%7D%7D%7D'),
  n1o7(170, 'Non-Polymer Entity Data', 'Non-Polymer Features', 'Related Resource ID Code', '', '%0Anonpolymer_entities%7Bnonpolymer_comp%7Brcsb_chem_comp_related%7Bresource_accession_code%7D%7D%7D'),
  n1o8(171, 'Non-Polymer Entity Data', 'Non-Polymer Features', 'Related Resource ID Name', '', '%0Anonpolymer_entities%7Bnonpolymer_comp%7Brcsb_chem_comp_related%7Bresource_name%7D%7D%7D'),
  n1o9(172, 'Non-Polymer Entity Data', 'Non-Polymer Features', 'Ligand of Interest', '', '%0Anonpolymer_entities%7Brcsb_nonpolymer_entity_annotation%7Btype%7D%7D'),

  // OLIGOSACCHARIDE DATA
  // ids
  o0o0(176, 'Oligosaccharide Data', 'IDs', 'Entity ID', 'Unique identifier for each object in this entity container.', '%0Abranched_entities%7Brcsb_branched_entity_container_identifiers%7Brcsb_id%7D%7D'),
  o0o1(177, 'Oligosaccharide Data', 'IDs', 'Asym ID', 'Instance identifiers corresponding to copies of the entity in this container.', '%0Abranched_entities%7Brcsb_branched_entity_container_identifiers%7Basym_ids%7D%7D'),
  o0o2(178, 'Oligosaccharide Data', 'IDs', 'Asym Auth ID', 'Author instance identifiers corresponding to copies of the entity in this container', '%0Abranched_entities%7Brcsb_branched_entity_container_identifiers%7Bauth_asym_ids%7D%7D'),
  // oligosaccharide features
  o1o0(180, 'Oligosaccharide Data', 'Oligosaccharide Features', 'Chain Length', 'Number of constituent chemical components in the branched entity.', '%0Abranched_entities%7Bpdbx_entity_branch%7Brcsb_branched_component_count%7D%7D'),
  o1o1(181, 'Oligosaccharide Data', 'Oligosaccharide Features', 'Linear Descriptor Type', '', '%0Abranched_entities%7Bpdbx_entity_branch_descriptor%7Btype%7D%7D'),
  o1o2(182, 'Oligosaccharide Data', 'Oligosaccharide Features', 'Linear Descriptors', 'Descriptor value for this entity.', '%0Abranched_entities%7Bpdbx_entity_branch_descriptor%7Bdescriptor%7D%7D'),
  o1o3(183, 'Oligosaccharide Data', 'Oligosaccharide Features', 'Molecule Name', 'Description of the branched entity.', '%0Abranched_entities%7Brcsb_branched_entity%7Bpdbx_description%7D%7D'),
  o1o4(179, 'Oligosaccharide Data', 'Oligosaccharide Features', 'List of Unique Monosaccharides', 'Unique list of monomer chemical component identifiers in the entity of this container.', '%0Abranched_entities%7Brcsb_branched_entity_container_identifiers%7Bchem_comp_monomers%7D%7D'),
  o1o5(184, 'Oligosaccharide Data', 'Oligosaccharide Features', 'Glycosylation Site', '', '%0Abranched_entities%7Bbranched_entity_instances%7Brcsb_branched_struct_conn%7Brole%7D%7D%7D');

  const OptionKey(this.key, this.catTitle, this.subCatTitle, this.optionTitle, this.description, this.address);
  final String catTitle;
  final String subCatTitle;
  final String optionTitle;
  final String description;
  final String address;
  final int key;

  dynamic contentW(Entry entry) {
    switch (this) {
      case s0o0: return entry.structData.key.pdbID;
      case s0o1: return entry.structData.key.emdbID?.asString();
      case s0o2: return entry.structData.key.dbID?.asString();
      case s0o3: return entry.structData.key.pmCentralID;
      case s0o4: return entry.structData.key.pmID;
      case s0o5: return entry.structData.key.doi;
      case s0o6: return entry.structData.key.structKeywords;
      case s1o0: return entry.structData.dep.author?.asString();
      case s1o1: return entry.structData.dep.title;
      case s1o2: return entry.structData.dep.depoDate?.trim().substring(0, 10);
      case s1o3: return entry.structData.dep.releaseDate?.trim().substring(0, 10);
      case s1o4: return entry.structData.dep.projCenterName?.asString();
      case s1o5: return entry.structData.dep.projCenterInitials?.asString();
      case s1o6: return entry.structData.dep.projName?.asString();
      case s2o0: return entry.structData.entFeat.numNHAtoms;
      case s2o1: return entry.structData.entFeat.depoCount;
      case s2o2: return entry.structData.entFeat.numNonPolyIn;
      case s2o3: return entry.structData.entFeat.numPolyIn;
      case s2o4: return entry.structData.entFeat.numPolyResi;
      case s2o5: return entry.structData.entFeat.numH2O;
      case s2o6: return entry.structData.entFeat.disulfBCount;
      case s2o7: return entry.structData.entFeat.numEnt;
      case s2o8: return entry.structData.entFeat.molecWeight;
      case s2o9: return entry.structData.entFeat.numNonPolyEnt;
      case s2o10: return entry.structData.entFeat.entryPolyComp;
      case s2o11: return entry.structData.entFeat.numDNAEnt;
      case s2o12: return entry.structData.entFeat.numNAHybridEnt;
      case s2o13: return entry.structData.entFeat.numProteinEnt;
      case s2o14: return entry.structData.entFeat.numRNAEnt;
      case s2o15: return entry.structData.entFeat.refRes?.asString();
      case s2o16: return entry.structData.entFeat.types;
      case s3o0: return entry.structData.groupDep.id?.asString();
      case s3o1: return entry.structData.groupDep.description?.asString();
      case s3o2: return entry.structData.groupDep.title?.asString();
      case s3o3: return entry.structData.groupDep.type?.asString();
      case s4o0: return entry.structData.dim.zNum;
      case s4o1: return entry.structData.dim.alpha;
      case s4o2: return entry.structData.dim.beta;
      case s4o3: return entry.structData.dim.gamma;
      case s4o4: return entry.structData.dim.lA;
      case s4o5: return entry.structData.dim.lB;
      case s4o6: return entry.structData.dim.lC;
      case s4o7: return entry.structData.dim.spaceGroup;
      case s5o0: return entry.structData.comp;
      case s6o0: return entry.structData.bindAff.value;
      case s6o1: return entry.structData.bindAff.provenanceCode;
      case s6o2: return entry.structData.bindAff.refSequenceID;
      case s6o3: return entry.structData.bindAff.symbol;
      case s6o4: return entry.structData.bindAff.type;
      case s6o5: return entry.structData.bindAff.unit;
      case s7o0: return entry.structData.crystProp.matthews;
      case s7o1: return entry.structData.crystProp.perSolvent;
      case s7o2: return entry.structData.crystProp.crystalMeth;
      case s7o3: return entry.structData.crystProp.ph;
      case s7o4: return entry.structData.crystProp.growthProc;
      case s7o5: return entry.structData.crystProp.temp;
      case s8o0: return entry.structData.meth.experimental?.asString();
      case s8o1: return entry.structData.meth.structDeter;
      case s9o0: return entry.structData.xData.collectionTemp;
      case s9o1: return entry.structData.xData.detector;
      case s9o2: return entry.structData.xData.collectionDate;
      case s9o3: return entry.structData.xData.diffSourceGen;
      case s9o4: return entry.structData.xData.diffSourceM;
      case s9o5: return entry.structData.xData.collectionRes;
      case s9o6: return entry.structData.xData.bWilsonEst;
      case s9o7: return entry.structData.xData.redundancy;
      case s9o8: return entry.structData.xData.perPossRefl;
      case s9o9: return entry.structData.xData.rValMergeInten;
      case s9o10: return entry.structData.xData.diffSourceSyncSite;
      case s9o11: return entry.structData.xData.diffSourceSyncBeam;
      case s9o12: return entry.structData.xData.minDiffWave;
      case s9o13: return entry.structData.xData.maxDiffWave;
      case s10o0: return entry.structData.xMeth.avgB;
      case s10o1: return entry.structData.xMeth.rFree;
      case s10o2: return entry.structData.xMeth.rWork;
      case s10o3: return entry.structData.xMeth.rAll;
      case s10o4: return entry.structData.xMeth.rObserved;
      case s10o5: return entry.structData.xMeth.highResLimit;
      case s10o6: return entry.structData.xMeth.reflectRefine;
      case s10o7: return entry.structData.xMeth.structDeter;
      case s10o8: return entry.structData.xMeth.refineID;
      case s11o0: return entry.structData.emMeth.emRes;
      case s11o1: return entry.structData.emMeth.symmType;
      case s11o2: return entry.structData.emMeth.emDiffRes;
      case s11o3: return entry.structData.emMeth.aggState;
      case s11o4: return entry.structData.emMeth.reconstrMethod;
      case s11o5: return entry.structData.emMeth.filmDetModel;
      case s11o6: return entry.structData.emMeth.microscopeModel;
      case s11o7: return entry.structData.emMeth.pointSymm;
      case s11o8: return entry.structData.emMeth.embed;
      case s11o9: return entry.structData.emMeth.stain;
      case s11o10: return entry.structData.emMeth.vitrify;
      case s11o11: return entry.structData.emMeth.accVolt;
      case s12o0: return entry.structData.nmrMeth.conformerCrit;
      case s12o1: return entry.structData.nmrMeth.conformerCalc;
      case s12o2: return entry.structData.nmrMeth.conformerSubm;
      case s12o3: return entry.structData.nmrMeth.type?.asString();
      case s12o4: return entry.structData.nmrMeth.ionicStr;
      case s12o5: return entry.structData.nmrMeth.ph;
      case s12o6: return entry.structData.nmrMeth.pressure;
      case s12o7: return entry.structData.nmrMeth.pressureUnit;
      case s12o8: return entry.structData.nmrMeth.temp;
      case s12o9: return entry.structData.nmrMeth.details;
      case s12o10: return entry.structData.nmrMeth.method;
      case s12o11: return entry.structData.nmrMeth.conformerID;
      case s12o12: return entry.structData.nmrMeth.selectionCrit;
      case s12o13: return entry.structData.nmrMeth.contents;
      case s12o14: return entry.structData.nmrMeth.solventSys;
      case s12o15: return entry.structData.nmrMeth.swAuthor;
      case s12o16: return entry.structData.nmrMeth.classification;
      case s12o17: return entry.structData.nmrMeth.name;
      case s12o18: return entry.structData.nmrMeth.version;
      case s12o19: return entry.structData.nmrMeth.fieldStr;
      case s12o20: return entry.structData.nmrMeth.manufacturer;
      case s12o21: return entry.structData.nmrMeth.model;
      case s13o0: return entry.structData.pubPrim.author?.asString();
      case s13o1: return entry.structData.pubPrim.title;
      case s13o2: return entry.structData.pubPrim.year;
      case s13o3: return entry.structData.pubPrim.journal;
      case s13o4: return entry.structData.pubPrim.vol;
      case s13o5: return entry.structData.pubPrim.firstPg;
      case s13o6: return entry.structData.pubPrim.lastPg;
      case s13o7: return entry.structData.pubPrim.doi;
      case p0o0: return entry.polyData.ids.entityID;
      case p0o1: return entry.polyData.ids.entryID;
      case p0o2: return entry.polyData.ids.asymID;
      case p0o3: return entry.polyData.ids.authAsymID;
      case p1o0: return _flattenOnceS(entry.polyData.entSourceOrg.expHost);
      case p1o1: return _flattenOnceS(entry.polyData.entSourceOrg.srcOrg);
      case p1o2: return _flattenOnceN(entry.polyData.entSourceOrg.taxID);
      case p1o3: return _flattenTwiceS(entry.polyData.entSourceOrg.provSrc);
      case p1o4: return _flattenTwiceS(entry.polyData.entSourceOrg.geneName);
      case p2o0: return entry.polyData.polyFeat.sequence;
      case p2o1: return entry.polyData.polyFeat.entPolyType;
      case p2o2: return entry.polyData.polyFeat.numTotal;
      case p2o3: return entry.polyData.polyFeat.sequenceLen;
      case p2o4: return entry.polyData.polyFeat.macromolecType;
      case p2o5: return _flattenOnceS(entry.polyData.polyFeat.plasmidName);
      case p2o6: return _flattenOnceN(entry.polyData.polyFeat.clusterID);
      case p2o7: return _flattenOnceN(entry.polyData.polyFeat.clusterIDThresh);
      case p2o8: return entry.polyData.polyFeat.molecWeight;
      case p2o9: return entry.polyData.polyFeat.macromolecName;
      case p2o10: return _flattenOnceS(entry.polyData.polyFeat.macromolecNameList);
      case p2o11: return _flattenOnceS(entry.polyData.polyFeat.ecNum);
      case p2o12: return _flattenOnceS(entry.polyData.polyFeat.ecProvSrc);
      case p2o13: return _flattenOnceS(entry.polyData.polyFeat.provCodeECO);
      case p2o14: return _flattenOnceS(entry.polyData.polyFeat.provSrc);
      case p2o15: return _flattenOnceS(entry.polyData.polyFeat.annotID);
      case p2o16: return _group2S(entry.polyData.polyFeat.annotLineage);
      case p2o17: return _flattenOnceS(entry.polyData.polyFeat.annotType);
      case p2o18: return _flattenOnceS(entry.polyData.polyFeat.accessCode);
      case p2o19: return _flattenOnceS(entry.polyData.polyFeat.dbName);
      case p2o20: return _flattenOnceS(entry.polyData.polyFeat.provCode);
      case p2o21: return _flattenOnceS(entry.polyData.polyFeat.value);
      case a0o0: return entry.assemData.assemID;
      case a1o0: return entry.assemData.assemFeat.totalPolyChains;
      case a1o1: return entry.assemData.assemFeat.totalPolyRes;
      case a1o2: return entry.assemData.assemFeat.oligoCount;
      case a1o3: return _flattenOnceS(entry.assemData.assemFeat.kind);
      case a1o4: return _flattenOnceS(entry.assemData.assemFeat.oligoState);
      case a1o5: return _flattenTwiceS(entry.assemData.assemFeat.stoich);
      case a1o6: return _flattenOnceS(entry.assemData.assemFeat.symbol);
      case a1o7: return _flattenOnceS(entry.assemData.assemFeat.type);
      case n0o0: return entry.nonPolyData.ids.entityID;
      case n0o1: return _flattenOnceS(entry.nonPolyData.ids.asymID);
      case n0o2: return _flattenOnceS(entry.nonPolyData.ids.authAsymID);
      case n1o0: return entry.nonPolyData.nonPolyFeat.ligandFormula;
      case n1o1: return entry.nonPolyData.nonPolyFeat.ligandMW;
      case n1o2: return entry.nonPolyData.nonPolyFeat.ligandID;
      case n1o3: return entry.nonPolyData.nonPolyFeat.ligandName;
      case n1o4: return entry.nonPolyData.nonPolyFeat.inChI;
      case n1o5: return entry.nonPolyData.nonPolyFeat.inChIKey;
      case n1o6: return entry.nonPolyData.nonPolyFeat.ligandSmiles;
      case n1o7: return _flattenOnceS(entry.nonPolyData.nonPolyFeat.relatedCode);
      case n1o8: return _flattenOnceS(entry.nonPolyData.nonPolyFeat.relatedName);
      case n1o9: return _flattenOnceS(entry.nonPolyData.nonPolyFeat.ligandInterest);
      case o0o0: return entry.oligoData.ids.entityID;
      case o0o1: return _flattenOnceS(entry.oligoData.ids.asymID);
      case o0o2: return _flattenOnceS(entry.oligoData.ids.authAsymID);
      case o1o0: return entry.oligoData.oligoFeat.chainLength;
      case o1o1: return _flattenOnceS(entry.oligoData.oligoFeat.linDescType);
      case o1o2: return _flattenOnceS(entry.oligoData.oligoFeat.linDesc);
      case o1o3: return entry.oligoData.oligoFeat.molecName;
      case o1o4: return _flattenOnceS(entry.oligoData.oligoFeat.monosacc);
      case o1o5: return _flattenTwiceS(entry.oligoData.oligoFeat.glycosylation);
    }
  }

  dynamic contentP(Entry entry) {
    switch (this) {
      case s0o0: return entry.structData.key.pdbID;
      case s0o1: return entry.structData.key.emdbID?.asString();
      case s0o2: return entry.structData.key.dbID?.asString();
      case s0o3: return entry.structData.key.pmCentralID;
      case s0o4: return entry.structData.key.pmID;
      case s0o5: return entry.structData.key.doi;
      case s0o6: return entry.structData.key.structKeywords;
      case s1o0: return entry.structData.dep.author?.asString();
      case s1o1: return entry.structData.dep.title;
      case s1o2: return entry.structData.dep.depoDate?.trim().substring(0, 10);
      case s1o3: return entry.structData.dep.releaseDate?.trim().substring(0, 10);
      case s1o4: return entry.structData.dep.projCenterName?.asString();
      case s1o5: return entry.structData.dep.projCenterInitials?.asString();
      case s1o6: return entry.structData.dep.projName?.asString();
      case s2o0: return entry.structData.entFeat.numNHAtoms;
      case s2o1: return entry.structData.entFeat.depoCount;
      case s2o2: return entry.structData.entFeat.numNonPolyIn;
      case s2o3: return entry.structData.entFeat.numPolyIn;
      case s2o4: return entry.structData.entFeat.numPolyResi;
      case s2o5: return entry.structData.entFeat.numH2O;
      case s2o6: return entry.structData.entFeat.disulfBCount;
      case s2o7: return entry.structData.entFeat.numEnt;
      case s2o8: return entry.structData.entFeat.molecWeight;
      case s2o9: return entry.structData.entFeat.numNonPolyEnt;
      case s2o10: return entry.structData.entFeat.entryPolyComp;
      case s2o11: return entry.structData.entFeat.numDNAEnt;
      case s2o12: return entry.structData.entFeat.numNAHybridEnt;
      case s2o13: return entry.structData.entFeat.numProteinEnt;
      case s2o14: return entry.structData.entFeat.numRNAEnt;
      case s2o15: return entry.structData.entFeat.refRes?.asString();
      case s2o16: return entry.structData.entFeat.types;
      case s3o0: return entry.structData.groupDep.id?.asString();
      case s3o1: return entry.structData.groupDep.description?.asString();
      case s3o2: return entry.structData.groupDep.title?.asString();
      case s3o3: return entry.structData.groupDep.type?.asString();
      case s4o0: return entry.structData.dim.zNum;
      case s4o1: return entry.structData.dim.alpha;
      case s4o2: return entry.structData.dim.beta;
      case s4o3: return entry.structData.dim.gamma;
      case s4o4: return entry.structData.dim.lA;
      case s4o5: return entry.structData.dim.lB;
      case s4o6: return entry.structData.dim.lC;
      case s4o7: return entry.structData.dim.spaceGroup;
      case s5o0: return entry.structData.comp;
      case s6o0: return entry.structData.bindAff.value?.asString();
      case s6o1: return entry.structData.bindAff.provenanceCode?.asString();
      case s6o2: return entry.structData.bindAff.refSequenceID?.asString();
      case s6o3: return entry.structData.bindAff.symbol?.asString();
      case s6o4: return entry.structData.bindAff.type?.asString();
      case s6o5: return entry.structData.bindAff.unit?.asString();
      case s7o0: return entry.structData.crystProp.matthews?.asString();
      case s7o1: return entry.structData.crystProp.perSolvent?.asString();
      case s7o2: return entry.structData.crystProp.crystalMeth?.asString();
      case s7o3: return entry.structData.crystProp.ph?.asString();
      case s7o4: return entry.structData.crystProp.growthProc?.asString();
      case s7o5: return entry.structData.crystProp.temp?.asString();
      case s8o0: return entry.structData.meth.experimental?.asString();
      case s8o1: return entry.structData.meth.structDeter;
      case s9o0: return entry.structData.xData.collectionTemp?.asString();
      case s9o1: return entry.structData.xData.detector?.asString();
      case s9o2: return entry.structData.xData.collectionDate?.asString();
      case s9o3: return entry.structData.xData.diffSourceGen?.asString();
      case s9o4: return entry.structData.xData.diffSourceM?.asString();
      case s9o5: return entry.structData.xData.collectionRes;
      case s9o6: return entry.structData.xData.bWilsonEst?.asString();
      case s9o7: return entry.structData.xData.redundancy?.asString();
      case s9o8: return entry.structData.xData.perPossRefl?.asString();
      case s9o9: return entry.structData.xData.rValMergeInten?.asString();
      case s9o10: return entry.structData.xData.diffSourceSyncSite?.asString();
      case s9o11: return entry.structData.xData.diffSourceSyncBeam?.asString();
      case s9o12: return entry.structData.xData.minDiffWave;
      case s9o13: return entry.structData.xData.maxDiffWave;
      case s10o0: return entry.structData.xMeth.avgB?.asString();
      case s10o1: return entry.structData.xMeth.rFree?.asString();
      case s10o2: return entry.structData.xMeth.rWork?.asString();
      case s10o3: return entry.structData.xMeth.rAll?.asString();
      case s10o4: return entry.structData.xMeth.rObserved?.asString();
      case s10o5: return entry.structData.xMeth.highResLimit?.asString();
      case s10o6: return entry.structData.xMeth.reflectRefine?.asString();
      case s10o7: return entry.structData.xMeth.structDeter?.asString();
      case s10o8: return entry.structData.xMeth.refineID?.asString();
      case s11o0: return entry.structData.emMeth.emRes?.asString();
      case s11o1: return entry.structData.emMeth.symmType?.asString();
      case s11o2: return entry.structData.emMeth.emDiffRes?.asString();
      case s11o3: return entry.structData.emMeth.aggState;
      case s11o4: return entry.structData.emMeth.reconstrMethod;
      case s11o5: return entry.structData.emMeth.filmDetModel?.asString();
      case s11o6: return entry.structData.emMeth.microscopeModel?.asString();
      case s11o7: return entry.structData.emMeth.pointSymm?.asString();
      case s11o8: return entry.structData.emMeth.embed?.asString();
      case s11o9: return entry.structData.emMeth.stain?.asString();
      case s11o10: return entry.structData.emMeth.vitrify?.asString();
      case s11o11: return entry.structData.emMeth.accVolt?.asString();
      case s12o0: return entry.structData.nmrMeth.conformerCrit;
      case s12o1: return entry.structData.nmrMeth.conformerCalc;
      case s12o2: return entry.structData.nmrMeth.conformerSubm;
      case s12o3: return entry.structData.nmrMeth.type?.asString();
      case s12o4: return entry.structData.nmrMeth.ionicStr?.asString();
      case s12o5: return entry.structData.nmrMeth.ph?.asString();
      case s12o6: return entry.structData.nmrMeth.pressure?.asString();
      case s12o7: return entry.structData.nmrMeth.pressureUnit?.asString();
      case s12o8: return entry.structData.nmrMeth.temp?.asString();
      case s12o9: return entry.structData.nmrMeth.details?.asString();
      case s12o10: return entry.structData.nmrMeth.method?.asString();
      case s12o11: return entry.structData.nmrMeth.conformerID;
      case s12o12: return entry.structData.nmrMeth.selectionCrit;
      case s12o13: return entry.structData.nmrMeth.contents?.asString();
      case s12o14: return entry.structData.nmrMeth.solventSys?.asString();
      case s12o15: return entry.structData.nmrMeth.swAuthor?.asString();
      case s12o16: return entry.structData.nmrMeth.classification?.asString();
      case s12o17: return entry.structData.nmrMeth.name?.asString();
      case s12o18: return entry.structData.nmrMeth.version?.asString();
      case s12o19: return entry.structData.nmrMeth.fieldStr?.asString();
      case s12o20: return entry.structData.nmrMeth.manufacturer?.asString();
      case s12o21: return entry.structData.nmrMeth.model?.asString();
      case s13o0: return entry.structData.pubPrim.author?.asString();
      case s13o1: return entry.structData.pubPrim.title;
      case s13o2: return entry.structData.pubPrim.year;
      case s13o3: return entry.structData.pubPrim.journal;
      case s13o4: return entry.structData.pubPrim.vol;
      case s13o5: return entry.structData.pubPrim.firstPg;
      case s13o6: return entry.structData.pubPrim.lastPg;
      case s13o7: return entry.structData.pubPrim.doi;
      case p0o0: return entry.polyData.ids.entityID;
      case p0o1: return entry.polyData.ids.entryID;
      case p0o2: return entry.polyData.ids.asymID?.asString();
      case p0o3: return entry.polyData.ids.authAsymID?.asString();
      case p1o0: return entry.polyData.entSourceOrg.expHost?.asString();
      case p1o1: return entry.polyData.entSourceOrg.srcOrg?.asString();
      case p1o2: return entry.polyData.entSourceOrg.taxID?.asString();
      case p1o3: return entry.polyData.entSourceOrg.provSrc?.asString();
      case p1o4: return entry.polyData.entSourceOrg.geneName?.asString();
      case p2o0: return entry.polyData.polyFeat.sequence?.asString();
      case p2o1: return entry.polyData.polyFeat.entPolyType?.asString();
      case p2o2: return entry.polyData.polyFeat.numTotal?.asString();
      case p2o3: return entry.polyData.polyFeat.sequenceLen?.asString();
      case p2o4: return entry.polyData.polyFeat.macromolecType?.asString();
      case p2o5: return entry.polyData.polyFeat.plasmidName?.asString();
      case p2o6: return entry.polyData.polyFeat.clusterID?.asString();
      case p2o7: return entry.polyData.polyFeat.clusterIDThresh?.asString();
      case p2o8: return entry.polyData.polyFeat.molecWeight?.asString();
      case p2o9: return entry.polyData.polyFeat.macromolecName?.asString();
      case p2o10: return entry.polyData.polyFeat.macromolecNameList?.asString();
      case p2o11: return entry.polyData.polyFeat.ecNum?.asString();
      case p2o12: return entry.polyData.polyFeat.ecProvSrc?.asString();
      case p2o13: return entry.polyData.polyFeat.provCodeECO?.asString();
      case p2o14: return entry.polyData.polyFeat.provSrc?.asString();
      case p2o15: return entry.polyData.polyFeat.annotID?.asString();
      case p2o16: return entry.polyData.polyFeat.annotLineage?.asString();
      case p2o17: return entry.polyData.polyFeat.annotType?.asString();
      case p2o18: return _accessP(entry.polyData.polyFeat.accessCode);
      case p2o19: return entry.polyData.polyFeat.dbName?.asString();
      case p2o20: return entry.polyData.polyFeat.provCode?.asString();
      case p2o21: return entry.polyData.polyFeat.value?.asString();
      case a0o0: return entry.assemData.assemID?.asString();
      case a1o0: return entry.assemData.assemFeat.totalPolyChains?.asString();
      case a1o1: return entry.assemData.assemFeat.totalPolyRes?.asString();
      case a1o2: return entry.assemData.assemFeat.oligoCount?.asString();
      case a1o3: return entry.assemData.assemFeat.kind?.asString();
      case a1o4: return entry.assemData.assemFeat.oligoState?.asString();
      case a1o5: return entry.assemData.assemFeat.stoich?.asString();
      case a1o6: return entry.assemData.assemFeat.symbol?.asString();
      case a1o7: return entry.assemData.assemFeat.type?.asString();
      case n0o0: return entry.nonPolyData.ids.entityID?.asString();
      case n0o1: return entry.nonPolyData.ids.asymID?.asString();
      case n0o2: return entry.nonPolyData.ids.authAsymID?.asString();
      case n1o0: return entry.nonPolyData.nonPolyFeat.ligandFormula?.asString();
      case n1o1: return _ligP(entry.nonPolyData.nonPolyFeat.ligandSmiles,
                              entry.nonPolyData.nonPolyFeat.ligandMW,
                              entry.nonPolyData.nonPolyFeat.ligandID,
                              this);
      case n1o2: return _ligP(entry.nonPolyData.nonPolyFeat.ligandSmiles,
                              entry.nonPolyData.nonPolyFeat.ligandMW,
                              entry.nonPolyData.nonPolyFeat.ligandID,
                              this);
      case n1o3: return entry.nonPolyData.nonPolyFeat.ligandName?.asString();
      case n1o4: return entry.nonPolyData.nonPolyFeat.inChI?.asString();
      case n1o5: return entry.nonPolyData.nonPolyFeat.inChIKey?.asString();
      case n1o6: return _ligP(entry.nonPolyData.nonPolyFeat.ligandSmiles,
                              entry.nonPolyData.nonPolyFeat.ligandMW,
                              entry.nonPolyData.nonPolyFeat.ligandID,
                              this);
      case n1o7: return entry.nonPolyData.nonPolyFeat.relatedCode?.asString();
      case n1o8: return entry.nonPolyData.nonPolyFeat.relatedName?.asString();
      case n1o9: return entry.nonPolyData.nonPolyFeat.ligandInterest?.asString();
      case o0o0: return entry.oligoData.ids.entityID?.asString();
      case o0o1: return entry.oligoData.ids.asymID?.asString();
      case o0o2: return entry.oligoData.ids.authAsymID?.asString();
      case o1o0: return entry.oligoData.oligoFeat.chainLength?.asString();
      case o1o1: return entry.oligoData.oligoFeat.linDescType?.asString();
      case o1o2: return entry.oligoData.oligoFeat.linDesc?.asString();
      case o1o3: return entry.oligoData.oligoFeat.molecName?.asString();
      case o1o4: return entry.oligoData.oligoFeat.monosacc?.asString();
      case o1o5: return entry.oligoData.oligoFeat.glycosylation?.asString();
    }
  }

  String? _ligP(List<String?>? smiles, List<num?>? mws, List<String?>? ids, OptionKey option) {
    if (smiles == null || mws == null || ids == null || 
        smiles.length != mws.length || mws.length != ids.length) {
      if (option == n1o2) {
        return ids?.asString();
      } else if (option == n1o6) {
        return smiles?.asString();
      } else if (option == n1o1) {
        return mws?.asString();
      }
      throw Exception('Incorrect option called on ligand processor method `_ligP` in class `option_key.dart`');
    }

    final List<String> filter1 = ['ARS', 'BEN', 'BR', 'CA', 'CAC', 'CD', 'CL', 'CO', 'CU', 'DVT', 'IOD', 'MG', 'MN', 
                                  'NA', 'NI', 'NO3', 'PO4', 'PT', 'SE', 'SO4', 'UNX', 'ZN', '1PE', '2HT', '2PE', '3TR', 
                                  '7PE', 'ACE', 'ACT', 'ACY', 'AKG', 'BAQ', 'BCT', 'BEF', 'BMA', 'BME', 'BOG', 'BU3', 
                                  'BUD', 'CIT', 'CME', 'CO3', 'DMS', 'DTT', 'DTU', 'DTV', 'EDO', 'EGL', 'EPE', 'FES', 
                                  'FMT', 'FS3', 'FS4', 'GBL', 'GLY', 'GOL', 'GSH', 'HEC', 'HED', 'HEM', 'HVB', 'IMD', 
                                  'IPA', 'MAN', 'MES', 'MG8', 'MGF', 'MLI', 'MO6', 'MPD', 'MYR', 'NAG', 'NCO', 'NH3', 
                                  'OCT', 'OGA', 'OPG', 'P2U', 'PE5', 'PEG', 'PG4', 'PGE', 'PGO', 'PHO', 'PLP', 'POP', 
                                  'PPI', 'PSE', 'PSU', 'PTL', 'SEO', 'SGM', 'SPD', 'SPM', 'SRT', 'SUC', 'SUL', 'SY8', 
                                  'TAM', 'TAR', 'TFA', 'TLA', 'TPP', 'TRS'];
    final List<String> filter2 = ['ADP', 'AMP', 'ATP', 'CMP', 'GDP', 'GNP', 'GTP', 'MTA', 'SAM', 'SAH', 'SFG', '5GP'];

    if (option != n1o2 && option != n1o6 && option != n1o1) {
      throw Exception('Incorrect option called on ligand processor method `_ligP` in class `option_key.dart`');
    }

    List<LigPObj> ligObjs = [];

    for (int i = 0; i < smiles.length; i++) {
      final mwCurr = mws[i];
      if (mwCurr != null) {
        ligObjs.add(LigPObj(id: ids[i], smile: smiles[i], mw: mwCurr));
      }
    }

    ligObjs.sort((a, b) => b.mw.compareTo(a.mw));

    List newLigList = List.from(ligObjs);

    for (LigPObj obj in ligObjs) {
      if (filter1.contains(obj.id)) {
        newLigList.remove(obj);
      } else if (!filter2.contains(obj.id)) {
        if (option == n1o2) { // case ligand ids
          return obj.id;
        } else if (option == n1o6) { // case ligand smiles (stereo)
          return obj.smile;
        } else {
          return obj.mw.toString();
        }
      }
    }

    // case nothing left
    if (newLigList.isEmpty) {
      return null;
    }

    // case filter2 ligand remaining
    if (option == n1o2) {
      return newLigList[0].id;
    } else if (option == n1o1) {
      return newLigList[0].mw.toString();
    }
    return newLigList[0].smile;
  }

  String _accessP(List<List<String?>?>? list) {
    final List<String> master = ['P11362','P21802','P22607','P22455','P07333','P51449','Q9NZQ7','P21589','P01116','P61073','P00533','P31153','O14744','Q07889','Q07890','P08581','P24941','P42336','P54750','Q01064','Q14123','O00408','Q14432','Q13370','P27815','Q07343','Q08493','Q08499','Q5VU43','O76074','P16499','P35913','P51160','O43924','P18545','Q13956','Q13946','Q9NP56','O60658','O95263','O76083','Q9Y233','Q9HCR9','Q6L8Q7','P01116-2','P28907','P04626','P51531','P11802','Q00534','Q13131','P54646','Q9Y478','O43741','P54619','Q9UGJ0','Q9UGI9','P80385','P54645','P40763','P42226','Q86W56','P51532',];
    if (list != null) {
      for (List<String?>? subList in list) {
        if (subList != null) {
          for (String? code in subList) {
            if (code != null && master.contains(code)) {
              return code;
            }
          }
        }
      }
    }
    return '';
  }
  
  bool needSpan() {
    return need.contains(this);
  }
}

List<String?>? groupS(List<List<String?>?>? list) {
  if (list == null) {
    return null;
  }

  List<String?> groupedList = [];
  for (var sub in list) {
    if (sub == null) {
      groupedList.add(null);
    } else {
      groupedList.add(sub.asString());
    }
  }
  return groupedList;
}

List<String?>? _group2S(List<List<List<String?>?>?>? list) {
  if (list == null) {
    return null;
  }

  List<String?> groupedList = [];
  for (var sub1 in list) {
    if (sub1 == null) {
      groupedList.add(null);
    } else {
      for (var sub2 in sub1) {
        if (sub2 == null) {
          groupedList.add(null);
        } else {
          groupedList.add(sub2.asString());
        }
      }
    }
  }
  return groupedList;
}

List<num?>? _flattenOnceN(List<List<num?>?>? list) {
  if (list == null) {
    return null;
  }

  List<num?> flattenedList = [];
  for (var sub1 in list) {
    if (sub1 == null) {
      flattenedList.add(null);
    } else {
      for (var sub2 in sub1) {
        flattenedList.add(sub2);
      }
    }
  }

  return flattenedList;
}

List<String?>? _flattenOnceS(List<List<String?>?>? list) {
  if (list == null) {
    return null;
  }

  List<String?> flattenedList = [];
  for (var sub1 in list) {
    if (sub1 == null) {
      flattenedList.add(null);
    } else {
      for (var sub2 in sub1) {
        flattenedList.add(sub2);
      }
    }
  }

  return flattenedList;
}

List<dynamic>? _flattenTwiceS(List<List<List<dynamic>?>?>? list) {
  if (list == null) {
    return null;
  }

  List<dynamic> flattenedList = [];
  for (var sub1 in list) {
    if (sub1 == null) {
      flattenedList.add(null);
    } else {
      for (var sub2 in sub1) {
        if (sub2 == null) {
          flattenedList.add(null);
        } else {
          for (var sub3 in sub2) {
            flattenedList.add(sub3);
          }
        }
      }
    }
  }

  return flattenedList;
}

List<num?>? flattenTwiceN(List<List<List<num?>?>?>? list) {
  if (list == null) {
    return null;
  }

  List<num?> flattenedList = [];
  for (var sub1 in list) {
    if (sub1 == null) {
      flattenedList.add(null);
    } else {
      for (var sub2 in sub1) {
        if (sub2 == null) {
          flattenedList.add(null);
        } else {
          for (var sub3 in sub2) {
            flattenedList.add(sub3);
          }
        }
      }
    }
  }

  return flattenedList;
}

extension ListExtensions on List {
  String asString() {
    if (isEmpty) {
      return '';
    }
    String toReturn = '';
    for (var entry in this) {
      toReturn = '$toReturn, ${entry.toString()}';
    }
    return toReturn.substring(1);
  }
}

class LigPObj {
  final String? id;
  final String? smile;
  final num mw;

  LigPObj({
    required this.id,
    required this.smile,
    required this.mw,
  });
}