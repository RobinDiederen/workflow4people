alter table field_type_item change item_position position int(11);
alter table field change field_position position int(11);
drop table field_list;
alter table field drop column field_list_id;
alter table field drop column child_field_list_id;
