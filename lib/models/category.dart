import 'package:rcsb_pdb_json2csv_flex/models/sub_category.dart';

enum Category {

  // STRUCTURE DATA:
  struct(
    'Structure Data', [
      SubCategory.s_0,
      SubCategory.s_1,
      SubCategory.s_2,
      SubCategory.s_3,
      SubCategory.s_4,
      SubCategory.s_5,
      SubCategory.s_6,
      SubCategory.s_7,
      SubCategory.s_8,
      SubCategory.s_9,
      SubCategory.s_10,
      SubCategory.s_11,
      SubCategory.s_12,
      SubCategory.s_13,
    ],
  ),
   
  // POLYMER ENTITY DATA
  poly(
    'Polymer Entity Data', [
      SubCategory.p_0,
      SubCategory.p_1,
      SubCategory.p_2,
    ],
  ),
  
  // ASSEMBLY DATA
  assem(
    'Assembly Data', [
      SubCategory.a_0,
      SubCategory.a_1,
    ],
  ),
  
  // NON-POLYMER ENTITY DATA
  nonpoly(
    'Non-Polymer Entity Data', [
      SubCategory.n_0,
      SubCategory.n_1,
    ],
  ),

  // OLIGOSACCHARIDE DATA
  oligo(
    'Oligosaccharide Data', [
      SubCategory.o_0,
      SubCategory.o_1,
    ],
  );

  const Category(this.title, this.catKeys);
  final String title;
  final List<SubCategory> catKeys;
}