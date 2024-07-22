select * from concurent_proba cp
join concurent c on c.id_concurent=cp.id_concurent
join proba p on p.id_proba=cp.id_proba;

select c.nume, c.prenume, avg(p.punctaj_maxim-cp.punctaj)
from concurent_proba cp
join concurent c on c.id_concurent=cp.id_concurent
join proba p on p.id_proba=cp.id_proba
where extract(year from p.data_proba) in (2021,2022)
group by c.nume, c.prenume;

select * from competitie c
join proba p on p.id_proba=c.id_competitie
join concurent_proba cp on cp.id_proba=p.id_proba;


select p.id_competitie, sum(cp.punctaj), count(distinct cp.id_concurent)
from competitie c
join proba p on p.id_competitie=c.id_competitie
join concurent_proba cp on cp.id_proba=p.id_proba
group by p.id_competitie
having count(distinct cp.id_concurent)<3;


select * from concurent c
join concurent_proba cp on cp.id_concurent=c.id_concurent
join proba p on p.id_proba=cp.id_proba
join competitie cmp on cmp.id_competitie=p.id_competitie;
--3
select c.nume, c.prenume, count(distinct decode(to_char (p.data_proba,'yyyy'), '2021' , p.id_competitie, null)) nr_com_21,
count(distinct decode(to_char(p.data_proba,'yyyy'), '2022', p.id_competitie, null)) nr_com_22,
count(distinct decode(to_char(p.data_proba,'yyyy'),'2023',p.id_competitie,null)) nr_com_23
from concurent c
join concurent_proba cp on cp.id_concurent=c.id_concurent
join proba p on p.id_proba=cp.id_proba
group by c.nume, c.prenume;

select* from concurent_proba;
--4
select c.denumire, max(p.data_proba)-min(p.data_proba)+1
from proba p
join competitie c on c.id_competitie=p.id_competitie
where c.denumire like '%fmi%'
group by c.denumire;


--5
with total as(
    select cp.id_concurent, id_competitie, sum(punctaj) suma
    from concurent_proba cp 
    join proba p on cp.id_proba=p.id_proba
    group by cp.id_concurent, id_competitie
    having sum(punctaj)>0)
select * from total t
where 2>= 
    ( select count(*) 
        from total
        where id_competitie=t.id_competitie
        and suma>=t.suma
        and t.id_concurent <> id_concurent)
order by t.id_competitie,suma;


--6
with concurenti_probe as (
    select cp.id_concurent, cp.id_proba, c.nume, c.prenume
    from concurent_proba cp join concurent c on c.id_concurent=cp.id_concurent
    where cp.id_proba in   
        (select id_proba
        from proba
        where id_competitie = ( select id_competitie
                                from competitie
                                where denumire ='fmi no stress 8'
                                )
        )
)
select id_concurent, nume, prenume
from concurenti_probe
group by id_concurent, nume, prenume
having count(*) = (select count(id_proba)
                    from proba
                    where id_competitie = ( select id_competitie
                                from competitie
                                where denumire = 'fmi no stress 8')
                    );
                    
    
--7 
select c.id_concurent, c.nume, c.prenume, avg(cp.punctaj)
from concurent c join concurent_proba cp on cp.id_concurent=c.id_concurent
group by c.id_concurent, c.nume, c.prenume
having avg(cp.punctaj)> (
    select avg(punctaj)
    from concurent_proba);
    
    
--8
with concurenti_max as(
    select c.id_concurent, c.nume, c.prenume, cp.punctaj
    from concurent c
    join concurent_proba cp on cp.id_concurent=c.id_concurent
    join proba p on cp.id_proba=p.id_proba
    where cp.punctaj=p.punctaj_maxim
    group by c.id_concurent, c.nume, c.prenume, cp.punctaj)
select c.id_concurent, c.nume, c.prenume
from concurent c
join concurenti_max cm on cm.id_concurent=c.id_concurent
group by c.id_concurent, c.nume, c.prenume
order by c.id_concurent;
select * from proba;
--9
with punctaj_maxim as (
    select p.id_proba, p.id_competitie, max(cp.punctaj) pmax
    from concurent_proba cp join proba p on cp.id_proba=p.id_proba
    group by p.id_proba, p.id_competitie
    )
select pm.id_proba, c.denumire
from punctaj_maxim pm 
join concurent_proba cp on (cp.id_proba=pm.id_proba
            and cp.punctaj=pm.pmax)
join competitie c on c.id_competitie=pm.id_competitie;



--tema 2 an 2






