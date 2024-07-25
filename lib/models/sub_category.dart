import 'package:rcsb_pdb_json2csv_flex/models/option_key.dart';

enum SubCategory {

  // STRUCTURE DATA:
  // ids and keywords
  s_0(
    'IDs and Keywords', [
      OptionKey.s0o0,
      OptionKey.s0o1,
      OptionKey.s0o2,
      OptionKey.s0o3,
      OptionKey.s0o4,
      OptionKey.s0o5,
      OptionKey.s0o6,
    ],
    'Structure Data'
  ),

  // deposition
  s_1(
    'Deposition', [
      OptionKey.s1o0,
      OptionKey.s1o1,
      OptionKey.s1o2,
      OptionKey.s1o3,
      OptionKey.s1o4,
      OptionKey.s1o5,
      OptionKey.s1o6,
    ],
    'Structure Data'
  ),
  // entry features
  s_2(
    'Entry Features', [
      OptionKey.s2o0,
      OptionKey.s2o1,
      OptionKey.s2o2,
      OptionKey.s2o3,
      OptionKey.s2o4,
      OptionKey.s2o5,
      OptionKey.s2o6,
      OptionKey.s2o7,
      OptionKey.s2o8,
      OptionKey.s2o9,
      OptionKey.s2o10,
      OptionKey.s2o11,
      OptionKey.s2o12,
      OptionKey.s2o13,
      OptionKey.s2o14,
      OptionKey.s2o15,
      OptionKey.s2o16,
    ],
    'Structure Data'
  ),
  
  
  // group deposition
  s_3(
    'Group Deposition', [
      OptionKey.s3o0,
      OptionKey.s3o1,
      OptionKey.s3o2,
      OptionKey.s3o3,
    ],
    'Structure Data'
  ),
  // cell dimensions and space group
  s_4(
    'Cell Dimensions and Space Group', [
      OptionKey.s4o0,
      OptionKey.s4o1,
      OptionKey.s4o2,
      OptionKey.s4o3,
      OptionKey.s4o4,
      OptionKey.s4o5,
      OptionKey.s4o6,
      OptionKey.s4o7,
    ],
    'Structure Data'
  ),

  // chemical components
  s_5(
    'Chemical Components', [
      OptionKey.s5o0,
    ],
    'Structure Data'
  ),

  // binding affinity
  s_6(
    'Binding Affinity', [
      OptionKey.s6o0,
      OptionKey.s6o1,
      OptionKey.s6o2,
      OptionKey.s6o3,
      OptionKey.s6o4,
      OptionKey.s6o5,
    ],
    'Structure Data'
  ), 

  // crystal properties
  s_7(
    'Crystal Properties', [
      OptionKey.s7o0,
      OptionKey.s7o1,
      OptionKey.s7o2,
      OptionKey.s7o3,
      OptionKey.s7o4,
      OptionKey.s7o5,
    ],
    'Structure Data'
  ),
  
  // methods
  s_8(
    'Methods', [
      OptionKey.s8o0,
      OptionKey.s8o1,
    ],
    'Structure Data'
  ),
  
  // x-ray data collection details
  s_9(
    'X-Ray Data Collection Details', [
      OptionKey.s9o0,
      OptionKey.s9o1,
      OptionKey.s9o2,
      OptionKey.s9o3,
      OptionKey.s9o4,
      OptionKey.s9o5,
      OptionKey.s9o6,
      OptionKey.s9o7,
      OptionKey.s9o8,
      OptionKey.s9o9,
      OptionKey.s9o10,
      OptionKey.s9o11,
      OptionKey.s9o12,
      OptionKey.s9o13,
    ],
    'Structure Data'
  ),
  
  // x-ray method details
  s_10(
    'X-Ray Method Details', [
      OptionKey.s10o0,
      OptionKey.s10o1,
      OptionKey.s10o2,
      OptionKey.s10o3,
      OptionKey.s10o4,
      OptionKey.s10o5,
      OptionKey.s10o6,
      OptionKey.s10o7,
      OptionKey.s10o8,
    ],
    'Structure Data'
  ),

  // em method details
  s_11(
    'EM Method Details', [
      OptionKey.s11o0,
      OptionKey.s11o1,
      OptionKey.s11o2,
      OptionKey.s11o3,
      OptionKey.s11o4,
      OptionKey.s11o5,
      OptionKey.s11o6,
      OptionKey.s11o7,
      OptionKey.s11o8,
      OptionKey.s11o9,
      OptionKey.s11o10,
      OptionKey.s11o11,
    ],
    'Structure Data'
  ),

  // nmr method details
  s_12(
    'NMR Method Details', [
      OptionKey.s12o0,
      OptionKey.s12o1,
      OptionKey.s12o2,
      OptionKey.s12o3,
      OptionKey.s12o4,
      OptionKey.s12o5,
      OptionKey.s12o6,
      OptionKey.s12o7,
      OptionKey.s12o8,
      OptionKey.s12o9,
      OptionKey.s12o10,
      OptionKey.s12o11,
      OptionKey.s12o12,
      OptionKey.s12o13,
      OptionKey.s12o14,
      OptionKey.s12o15,
      OptionKey.s12o16,
      OptionKey.s12o17,
      OptionKey.s12o18,
      OptionKey.s12o19,
      OptionKey.s12o20,
      OptionKey.s12o21,
    ],
    'Structure Data'
  ),

  // publications primary
  s_13(
    'Publications Primary', [
      OptionKey.s13o0,
      OptionKey.s13o1,
      OptionKey.s13o2,
      OptionKey.s13o3,
      OptionKey.s13o4,
      OptionKey.s13o5,
      OptionKey.s13o6,
      OptionKey.s13o7,
    ],
    'Structure Data'
  ),
   
  // POLYMER ENTITY DATA
  // ids
  p_0(
    'IDs', [
      OptionKey.p0o0,
      OptionKey.p0o1,
      OptionKey.p0o2,
      OptionKey.p0o3,
    ],
    'Polymer Entity Data'
  ),

  // entity source organism
  p_1(
    'Entry Features', [
      OptionKey.p1o0,
      OptionKey.p1o1,
      OptionKey.p1o2,
      OptionKey.p1o3,
      OptionKey.p1o4,
    ],
    'Polymer Entity Data'
  ),

  // polymer features
  p_2(
    'Polymer Features', [
      OptionKey.p2o0,
      OptionKey.p2o1,
      OptionKey.p2o2,
      OptionKey.p2o3,
      OptionKey.p2o4,
      OptionKey.p2o5,
      OptionKey.p2o6,
      OptionKey.p2o7,
      OptionKey.p2o8,
      OptionKey.p2o9,
      OptionKey.p2o10,
      OptionKey.p2o11,
      OptionKey.p2o12,
      OptionKey.p2o13,
      OptionKey.p2o14,
      OptionKey.p2o15,
      OptionKey.p2o16,
      OptionKey.p2o17,
      OptionKey.p2o18,
      OptionKey.p2o19,
      OptionKey.p2o20,
      OptionKey.p2o21,
    ],
    'Polymer Entity Data'
  ),
  
  // ASSEMBLY DATA
  // ids
  a_0(
    'IDs', [
      OptionKey.a0o0,
    ],
    'Assembly Data'
  ),

  // assembly features
  a_1(
    'Assembly Features', [
      OptionKey.a1o0,
      OptionKey.a1o1,
      OptionKey.a1o2,
      OptionKey.a1o3,
      OptionKey.a1o4,
      OptionKey.a1o5,
      OptionKey.a1o6,
      OptionKey.a1o7,
    ],
    'Assembly Data'
  ),
  
  // NON-POLYMER ENTITY DATA
  // ids
  n_0(
    'IDs', [
      OptionKey.n0o0,
      OptionKey.n0o1,
      OptionKey.n0o2,
    ],
    'Non-Polymer Entity Data'
  ),

  // nonpolymer features
  n_1(
    'Non-Polymer Features', [
      OptionKey.n1o0,
      OptionKey.n1o1,
      OptionKey.n1o2,
      OptionKey.n1o3,
      OptionKey.n1o4,
      OptionKey.n1o5,
      OptionKey.n1o6,
      OptionKey.n1o7,
      OptionKey.n1o8,
      OptionKey.n1o9,
    ],
    'Non-Polymer Entity Data'
  ),

  // OLIGOSACCHARIDE DATA
  // ids
  o_0(
    'IDs', [
      OptionKey.o0o0,
      OptionKey.o0o1,
      OptionKey.o0o2,
    ],
    'Oligosaccharide Data'
  ),
  
  // oligosaccharide features
  o_1(
    'Oligosaccharide Features', [
      OptionKey.o1o0,
      OptionKey.o1o1,
      OptionKey.o1o2,
      OptionKey.o1o3,
      OptionKey.o1o4,
      OptionKey.o1o5,
    ],
    'Oligosaccharide Data'
  );

  const SubCategory(this.title, this.optionKeys, this.superCat);
  final String title;
  final List<OptionKey> optionKeys;
  final String superCat;
}