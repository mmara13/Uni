select * from title;
select * from title_copy; 
select * from rental;
select * from reservation;
select * from member;
select * from member m, reservation r
where m.member_id=r.member_id;

--select (t1.title) from (
--    select category, count(r.res_date)
--    from reservation r, title t, member m
--    where r.member_id=m.member_id and r.title_id=t.title_id
--    group by category
--    order by count(r.res_date) desc), title t1
--where rownum<=1;
select t1.category, t2.title from (
    select t.category, count(distinct r.title_id)
    from rental r, title t
    where r.title_id=t.title_id
    group by t.category
    order by count(r.title_id) desc) t1, title t2
where t1.category=t2.category;

--select t1.category, count(d from title t1
--group by t1.category
--having t1.category in (
--                select * from 
--                    (select t.category "c", count(*) "nr"
--                    from rental r, title t
--                    where r.title_id=t.title_id
--                    group by t.category
--                    order by 2 desc)
--                where rownum=1
--                )
--;

select t.category, count(distinct r.title_id)
from title t
join rental r on r.title_id=t.title_id
having count(r.title_id) = (
    select max(count(r.title_id))
    from title t
    join rental r on r.title_id=t.title_id
    group by t.category)
group by t.category;


select * from rental;

select t.title, count(distinct tc.copy_id) as "Exemplare disponibile"
from title t
join rental r on r.title_id=t.title_id
join title_copy tc on tc.title_id=t.title_id
where r.act_ret_date is null-- or tc.copy_id not in (select r.copy_id from rental r)
group by t.title;
--union 
--select tc.copy_id
--from title_copy tc
--where tc.title_copy not in (select r.title_copy from rental r)

select title_id, count(copy_id)
from title_copy
group by title_id
minus
select title_id, copy_id
from rental
where act_ret_date is null 
group by title_id, copy_id
;