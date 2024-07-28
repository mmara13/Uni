--begin
--    for t in(select table_name from user_tables) loop
--        for c in (select constraint_name from user_constraints where constraint_type='R' AND table_name=t.table_name) LOOp
--            execute immediate 'ALTER TABLE ' || t.table_name || ' DROP CONSTRAINT ' || c.constraint_name;
--        end loop;
--        
--        execute immediate 'DROP TABLE ' || t.table_name;
--    end loop;
--end;

create table DEPARTMENTS (
    department_id number(4) primary key,
    department_name varchar(50),
    manager_id number(4),
    location_id number(4)
    );
select * from departments;


begin
    for i in 1..5 loop
        insert into departments (department_id, department_name, manager_id, location_id)
        values(i, 'Departamentul ' || i, i-1, i*25);
    end loop;
end;

--rollback;


