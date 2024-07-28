--fctii grup se abilca asupra unei multimi si intorc un sg rezultat

--cati angajati lucreaza in fiecare departament

select e.department_id, max(department_name), count(e.employee_id)
from employees e, departments d
where e.department_id=d.department_id
group by e.department_id;
--fiecarui dept_id ii corespunde un singur dept_name


--cati subordonati are fiecare manager
select e1.manager_id, count(e.employee_id), max(e.last_name || ' ' || e.first_name)
from employees e, employees e1
where e.employee_id=e1.manager_id
group by e1.manager_id;

with manageri as
(select e.manager_id idul, count(e.employee_id) nr
        from employees e
        group by e.manager_id)
select idul e.last_name || ' ' || e.first_name, nr
from employees e, manageri e1
where e1.idul= e.employee_id;

--cati angajati lucreaza in dep respectiv
select e.department_id, count(employee_id), count(*), count(department_id)
from employees e
group by e.department_id;

--nr maxim de angajati dintr un dep
select max(count(e.employee_id))
from employees e
group by department_id;

--pt a afisa si id-ul dep cu nr maxim de angajati
select department_id, (count(employee_id))
from employees 
group by department_id
having count(employee_id) = (select max(count(e.employee_id))
from employees e
group by department_id);

--sau
select *
from (select department_id, count(employee_id)
    from employees
    group by department_id
    order by 2 desc) aux
where rownum=1;