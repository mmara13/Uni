create table info_sma (
    utilizator varchar2(100),
    data date,
    comanda varchar2(100),
    nr_linii number(5),
    eroare varchar2(100)
);


--functie ex2 modificata
create or replace function f2_sma (
    v_nume employees.last_name%type default 'Bell'
)
return number is 
    salariu employees.salary%type;
    caz varchar2(100);
begin
    select salary into salariu
    from employees
    where last_name = v_nume;
    
    
    --verificare pe care caz suntem (cati angajati) si inserare
    select case
            when count(*) = 1 then 'Un singur angajat'
            when count(*) >1 then 'Mai multi angajati'
            else 'Niciun angajat'
           end
    into caz
    from employees 
    where last_name = v_nume;
    
    insert into info_sma (utilizator, data, comanda, nr_linii, eroare)
    values(user, sysdate, 'f2_sma', 1, caz);
    
    return salariu;
    
exception
    when no_data_found then
        insert into info_sma (utilizator, data, comanda, nr_linii, eroare)
        values(user, sysdate, 'f2_sma', 0, 'Nu exista angajati cu numele dat');
        --raise_application_error(-20000, 'nu exista angajati cu numele dat');
        return -1;
    when too_many_rows then
        insert into info_sma (utilizator, data, comanda, nr_linii, eroare)
        values(user, sysdate, 'f2_sma', 0, 'Exista mai multi angajati cu numele dat');
        --raise_application_error(-20001, 'exista mia multi angajati cu numele dat');
        return -1;
    when others then
        insert into info_sma (utilizator, data, comanda, nr_linii, eroare)
        values (user, sysdate, 'f2_sma', 0 ,'Alta eroare');
        --raise_application_error(-20002, 'Alta eroare');
        return -1;
end f2_sma;
/

--ex 4 procedura modificata
create or replace procedure p4_sma (
    v_nume employees.last_name%type
)
is 
    salariu employees.salary%type;
    caz varchar2(50);
begin
    select salary into salariu
    from employees
    where last_name = v_nume;
    
    --verificare caz + inserare
--    select case
--        when count(*) = 1 then 'Un singur angajat'
--        when count(*) > 1 then 'Mai multi angajati'
--        else 'Niciun angajat'
--      end
--    into caz
--    from employees
--    where last_name = v_nume;
    
    insert into info_sma (utilizator, data, comanda, nr_linii, eroare)
    values(user, sysdate, 'p4_sma', 1, salariu);
    
    dbms_output.put_line('Salariul este ' || salariu);

    
exception 
    when no_data_found then
        insert into info_sma (utilizator, data, comanda, nr_linii, eroare)
        values(user, sysdate, 'p4_sma', 0, 'Nu exista angajati cu acest nume');
        raise_application_error(-20000, 'Nu exista angajati cu numele dat');
        
    when too_many_rows then
        insert into info_sma (utilizator, data, comanda, nr_linii, eroare)
        values(user, sysdate, 'p4_sma', 0, 'Exista mai multi angajati cu acest nume');
        raise_application_error(-20001, 'Exista mai multi angajati cu acest nume');
    
    when others then
        insert into info_sma (utilizator, data, comanda, nr_linii, eroare)
        values(user, sysdate, 'p4_sma', 0, 'Alta eroare');
        raise_application_error(-20002, 'Alta eroare');
end p4_sma;
/

select * from info_sma;

declare
    result number;
begin
    result :=f2_sma('King');
    dbms_output.put_line('Rezultat: '  || result);
end;
/

select f2_sma('Abel') from dual;
select * from employees
order by last_name asc;
select * from departments;
select * from locations;
select city
from departments d, locations l
where d.location_id = l.location_id;

create or replace function e3_sma (
    oras locations.city%type;
)
return number
is
    numar_ang number(4);
    
    