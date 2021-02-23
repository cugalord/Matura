create role Operator;

grant select, insert, update on table Member to role Operator;
grant select, insert, update on table Event to role Operator;
grant select, insert, update on table Product to role Operator;

grant select on table Staff to role Operator;
grant select on table Ptype to role Operator;

grant execute on procedure show_basket to role Operator; 
grant execute on procedure input_product to role Operator; 
grant execute on procedure input_event to Operator;
grant execute on procedure gen_mem to role Operator; 
grant execute on procedure Out_flow to role Operator;
grant execute on procedure Ptype_out to role Operator;
grant execute on procedure Find_staff to role Operator;
grant execute on procedure Find_product to role Operator;
grant execute on procedure I_Staff to role Operator;

grant usage on exception event_busy to role Operator;
