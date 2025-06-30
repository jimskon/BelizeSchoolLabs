-- Seed script for form_fields table for moe_school_info

INSERT INTO form_fields (table_name, field_name, prompt, type, valuelist, field_width, required, visible) VALUES
  ('moe_school_info', 'name', 'School Name', 'text', NULL, 6, 1, 1),
  ('moe_school_info', 'code', 'MOE School Code', 'text', NULL, 6, 1, 1),
  ('moe_school_info', 'address', 'School Address', 'text', NULL, 12, 1, 1),
  ('moe_school_info', 'contact_person', 'Contact Person', 'text', NULL, 6, 1, 1),
  ('moe_school_info', 'telephone', 'Telephone', 'phone', NULL, 6, 1, 1),
  ('moe_school_info', 'telephone_alt1', 'Alternate Telephone 1', 'phone', NULL, 6, 0, 1),
  ('moe_school_info', 'telephone_alt2', 'Alternate Telephone 2', 'phone', NULL, 6, 0, 1),
  ('moe_school_info', 'email', 'Email', 'email', NULL, 6, 1, 1),
  ('moe_school_info', 'website', 'Website', 'text', NULL, 6, 0, 1),
  ('moe_school_info', 'year_opened', 'Year Opened', 'num(1800-2050)', NULL, 6, 0, 1),
  ('moe_school_info', 'longitude', 'Longitude', 'text', NULL, 6, 0, 1),
  ('moe_school_info', 'latitude', 'Latitude', 'text', NULL, 6, 0, 1),
  ('moe_school_info', 'district', 'District', 'dropdown', 'Belize,Cayo,Corozal,Orange Walk,Stann Creek,Toledo', 6, 1, 1),
  ('moe_school_info', 'locality', 'Locality', 'dropdown', 'Rural,Urban', 6, 1, 1),
  ('moe_school_info', 'type', 'School Type', 'dropdown', 'Preschool,Primary,Secondary,Tertiary,Vocational,Adult and Continuing,University', 6, 1, 1),
  ('moe_school_info', 'ownership', 'Ownership', 'dropdown', 'Advantist Schools,Anglican Schools,Assemblies Of God Schools,Baptist,Catholic Schools,Government Schools,Mennonite Schools - Church Group,Mennonite Schools - H&B,Mennonite Schools - Spanish Lookout,Methodist Schools,Nazarene Schools,Presbyterian Schools,Private Schools,U.E.C.B Schools,Other', 6, 0, 1),
  ('moe_school_info', 'sector', 'Sector', 'dropdown', 'Government,Government Aided,Private,Specially Assisted', 6, 1, 1),
  ('moe_school_info', 'school_administrator_1', 'School Administrator 1', 'text', NULL, 6, 0, 1),
  ('moe_school_info', 'school_administrator_2', 'School Administrator 2', 'text', NULL, 6, 0, 1),
  ('moe_school_info', 'comments', 'Comments', 'text', NULL, 12, 0, 1)
ON DUPLICATE KEY UPDATE
  prompt = VALUES(prompt),
  type = VALUES(type),
  valuelist = VALUES(valuelist),
  field_width = VALUES(field_width),
  required = VALUES(required),
  visible = VALUES(visible);
