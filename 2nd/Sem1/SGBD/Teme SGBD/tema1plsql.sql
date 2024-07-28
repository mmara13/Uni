select * from rental r
join member e on e.member_id = r.member_id;
select table_name from user_tables;
select * from title;
select * from member_sma;

declare 
    nume_membru member.last_name%type;
    nume member.last_name%type;
    numar_aparitii_nume number(5):=0;
    numar_titluri_distincte number(5) := 0;
    numar_titluri number(5):=0;
    numar_total_titluri number(5):=0;
begin 
    nume := '&nume';
    nume_membru := nume;
    
    --vedem daca aruncam sau nu exceptii
     --nr aparitii nune
    select count(*)
    into numar_aparitii_nume
    from member
    where upper(last_name)=upper(nume_membru);
    
    --aruncare exceptii
    if numar_aparitii_nume = 0 then raise no_data_found;
    elsif numar_aparitii_nume > 1 then raise too_many_rows;
    end if;
    
    
    --daca nu aruncam exceptii continuam logica programului
    
    --nr total titluri
    select count(distinct(title_id))
    into numar_total_titluri
    from title;
    -- doar de verificare:dbms_output.put_line('NUMAR TOTAL TITLURI ' || numar_total_titluri);    
     --calculare titluri(nu distincte neaparat) ptc nu mentioneaza cerinta
    select count(r.title_id)
    into numar_titluri
    from rental r
    join member m on m.member_id = r.member_id
    where upper(m.last_name)=upper(nume_membru);
    
    --afisare nr titluri
    dbms_output.put_line('Membrul cu numele ' || nume_membru || ' a inchiriat '|| numar_titluri || ' titluri');
    
    select count(distinct(r.title_id))
    into numar_titluri_distincte
    from rental r
    join member m on m.member_id = r.member_id
    where upper(m.last_name)=upper(nume_membru);
    
    --afisare nr titluri distincte
    dbms_output.put_line('dintre care '|| numar_titluri_distincte || ' titluri distincte');
    
    --verificare din ce categorie face parte
    if numar_titluri_distincte > 0.75*(numar_total_titluri) then --categoria 1 75%
        dbms_output.put_line('Membrul face parte din Categoria 1');
    elsif numar_titluri_distincte > 0.5*(numar_total_titluri) then --categoria 2 50%
        dbms_output.put_line('Membrul face parte din Categoria 2');
    elsif numar_titluri_distincte > 0.25*(numar_total_titluri) then --categoria 3 25%
        dbms_output.put_line('Membrul face parte din Categoria 3');
    else dbms_output.put_line('Membrul face parte din Categoria 4'); --categoria 4 altfel
    end if;
    
    --tratare exceptii
    exception
        when no_data_found then dbms_output.put_line('Nu a fost gasit niciun membru cu acest nume');
        when too_many_rows then dbms_output.put_line('Mai multi membri au acelasi nume');
end;
/


create table member_sma as (select * from member);
alter table member_sma add discount number;
select * from member_sma;

--ex 4 pastram doar ce trb din ex 3 si adaugam restul
declare 
    categorie number(2):=0;
    numar_titluri_distincte number(4) :=0;
    numar_total_titluri number (4) :=0;
    v_id member_sma.member_id%type;
begin 
    v_id := '&v_id';
    --nr total titluri ca sa stabilim categoria
    select count(distinct(title_id))
    into numar_total_titluri
    from title;
        
        --vedem care e categoria folosind codul de la ex 3
        --vedem cate titluri distincte a inchiriat
        select count(distinct r.title_id)
        into numar_titluri_distincte
        from rental r
        join member m on m.member_id = r.member_id
        where m.member_id = v_id;
        
        --verificare din ce categorie face parte
        if numar_titluri_distincte > 0.75*(numar_total_titluri) then --categoria 1 75%
            categorie := 1;
        elsif numar_titluri_distincte > 0.5*(numar_total_titluri) then --categoria 2 50%
            categorie :=2;
        elsif numar_titluri_distincte > 0.25*(numar_total_titluri) then --categoria 3 25%
            categorie := 3;
        else categorie := 4; --categoria 4 altfel
        end if;
        
        --actualizare tabel cu discountul aferent
        update member_sma
        set discount = 
            case
                when categorie = 1 then 0.10
                when categorie = 2 then 0.05
                when categorie = 3 then 0.03
                else 0
            end
        where member_sma.member_id = v_id;
        
    
    --verificare update
    if sql%rowcount = 0 then
        dbms_output.put_line('Atentie! Update-ul nu s-a realizat.');
    else dbms_output.put_line('Update realizat cu succes pentru membrul cu id-ul ' || v_id);
    end if;
end;
/
        
select * from member_sma;
        rollback;
        commit;
        
        
    --aruncare exceptii
    if numar_aparitii_nume = 0 then raise no_data_found;
    elsif numar_aparitii_nume > 1 then raise too_many_rows;
    end if;
    
    
    --daca nu aruncam exceptii continuam logica programului
    
    
    -- doar de verificare:dbms_output.put_line('NUMAR TOTAL TITLURI ' || numar_total_titluri);    
     --calculare titluri(nu distincte neaparat) ptc nu mentioneaza cerinta
    select count(r.title_id)
    into numar_titluri
    from rental r
    join member m on m.member_id = r.member_id
    where upper(m.last_name)=upper(nume_membru);
    
    --afisare nr titluri
    dbms_output.put_line('Membrul cu numele ' || nume_membru || ' a inchiriat '|| numar_titluri || ' titluri');
    
    select count(distinct(r.title_id))
    into numar_titluri_distincte
    from rental r
    join member m on m.member_id = r.member_id
    where upper(m.last_name)=upper(nume_membru);
    
    --afisare nr titluri distincte
    dbms_output.put_line('dintre care '|| numar_titluri_distincte || ' titluri distincte');
    
    
    
    --tratare exceptii
    exception
        when no_data_found then dbms_output.put_line('Nu a fost gasit niciun membru cu acest nume');
        when too_many_rows then dbms_output.put_line('Mai multi membri au acelasi nume');
end;
/

