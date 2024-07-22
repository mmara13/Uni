--select 
--    e.denumire
--from excursie e
--join achizitioneaza a on a.cod_excursie=e.id_excursie
--where a.data_achizitie in (
--    select 
--        a1.data_achizitie
--    from achizitioneaza a1
--    order by a1.data_achizite desc
--    
--) and rownum=1;

select 
    e.denumire
from excursie e
join achizitioneaza a on a.cod_excursie=e.id_excursie
where a.data_achizitie = (
    select
        min(data_achizitie)
    from achizitioneaza
);

--2
select 
    ag.denumire, ag.oras, count(e.id_excursie) as nr_exc, avg(e.pret)
from excursie e
join agentie ag on ag.id_agentie= e.cod_agentie
group by ag.denumire, ag.oras;

--3
select
   distinct t.nume, t.prenume
from turist t
join achizitioneaza a on a.cod_turist=t.id_turist
where (
    select count(a.cod_excursie)
    from turist t
    join achizitioneaza a on a.cod_turist=t.id_turist
    where 
    ) >=2;
    
select t.nume, t.prenume
from turist t
join achizitioneaza a on a.cod_turist=t.id_turist
group by t.nume, t.prenume
having count(a.cod_excursie) >=2;

--4
select * from turist t
join achizitioneaza a on a.cod_turist=t.id_turist
join excursie e on e.id_excursie=a.cod_excursie;

select distinct t.nume, t.prenume
from turist t
where t.id_turist not in (
        select
            t2.id_turist
        from turist t2
        join achizitioneaza a2 on a2.cod_turist=t2.id_turist
        join excursie e2 on e2.id_excursie=a2.cod_excursie
        where e2.destinatie='Paris'
);

--5 
select t.id_turist, t.nume
from turist t
join achizitioneaza a on a.cod_turist=t.id_turist
join excursie e on e.id_excursie=a.cod_excursie
group by t.id_turist, t.nume
having count(distinct e.destinatie)>=2;

--6
select ag.denumire,
    sum(case
        when a.discount is null then e.pret
        when e.pret is not null then e.pret - (e.pret*a.discount)
        else 0
    end) as profit
from agentie ag
join excursie e on e.cod_agentie=ag.id_agentie
right join achizitioneaza a on a.cod_excursie=e.id_excursie
group by ag.denumire;


--7
select a.denumire, a.oras
from agentie a
join excursie e on e.cod_agentie=a.id_agentie
where e.pret<2000
group by a.denumire, a.oras
having count(distinct(e.id_excursie))>=3;

--8
select e.id_excursie,e.denumire
from excursie e
where e.pret >all(
    select  e1.pret
    from excursie e1
    join agentie ag on ag.id_agentie=e1.cod_agentie
    where upper(e1.denumire)='ORASUL LUMINILOR' and ag.id_agentie=10
    );

--9
select e.id_excursie, e.denumire, a.data_start, e.nr_locuri
from excursie e
join achizitioneaza a on a.cod_excursie=e.id_excursie
where a.data_start='14-AUG-11' and e.nr_locuri in (
    select t1.id_turist
    from turist t1
    join achizitioneaza a1 on a1.cod_turist=t1.id_turist
    join excursie e1 on e1.id_excursie=a1.cod_excursie
    where e.id_excursie = e1.id_excursie 
);