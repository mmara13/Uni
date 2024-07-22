-- Nume: Spataru Mara-Andreea, grupa 141, examen numarul 167 subiectul 1

--1 a
select c.data_plecare, e.denumire, a.nr_inmatriculare
from calendar c
join excursie e on e.id_excursie=c.id_excursie
join autocar a on a.id_autocar=c.id_autocar
where extract(year from c.data_plecare)=2023 and extract(month from c.data_plecare)=8;
--extragere an si luna pt a verifica daca excursia a fost planificata
--in august 2023

--1 b
select e.denumire, count(c.id_calendar) numar_planificari
from excursie e
join calendar c on c.id_excursie=e.id_excursie
where (
    select count(c.data_plecare) --numaram de cate ori e planificata excursia
    from calendar c
    where c.id_excursie=e.id_excursie and extract(year from c.data_plecare)=2023
    --extragem anul ca sa verificam ca excursia e planificata in 2023
    )>=2 --verificam sa existe macar 2 planificari ale acesteia
group by e.denumire;


--2
select t.nume, t.prenume, nvl(sum(c.pret),0)
--folosim nvl ca sa afisam si turistul 
--care nu plateste la excursii
from turist t 
left join rezervare r on r.id_turist=t.id_turist 
left join calendar c on c.id_calendar=r.id_calendar
--facem left join-uri ca sa il includem si pe cel care a platit 0 pt excursii
group by t.id_turist, t.nume, t.prenume
order by t.id_turist; --ordonam dupa turist ca sa fie usor pt verificare dupa id

--3
select e.denumire, c.data_plecare, count(distinct t.id_turist) as "numar_turisti"
from excursie e
join calendar c on c.id_excursie=e.id_excursie
join rezervare r on r.id_calendar=c.id_calendar
join turist t on t.id_turist=r.id_turist
join autocar a on a.id_autocar=c.id_autocar
join program_ghid p on p.id_calendar=c.id_calendar
where a.capacitate>30 --verificam ca autocarul sa aiba capacitate mai mare de 30
group by e.denumire, c.data_plecare --grupam din cauza count-ului
having count(distinct p.id_ghid)<=2; --verificam sa aiba sub 3 ghizi (<=2)
