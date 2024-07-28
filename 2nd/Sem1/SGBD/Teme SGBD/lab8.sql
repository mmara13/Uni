declare
    i number(4) := 0;
    cursor c_jobs is
        select distinct job_id
        from employees;

    v_job_id employees.job_id%type;

begin
    for job_rec in c_jobs loop
        v_job_id := job_rec.job_id;

        dbms_output.put_line(i || ' '  || 'Job: ' || v_job_id);
        i :=i+1;

        declare
            cursor c_employees is
                select employee_id, first_name, last_name, salary
                from employees
                where hire_date <= sysdate
                  and job_id = v_job_id;

            emp_rec c_employees%rowtype;
            v_employee_count number := 0;
        begin
            open c_employees;
            fetch c_employees into emp_rec;

            while c_employees%found loop
                v_employee_count := v_employee_count + 1;

                dbms_output.put_line('   Angajat: ' || emp_rec.first_name || ' ' || emp_rec.last_name || ', Salariu: ' || emp_rec.salary);
                fetch c_employees into emp_rec;
            end loop;

            close c_employees;

            if v_employee_count = 0 then
                dbms_output.put_line('   Niciun angajat nu lucreaza acum in acest departament');
            else
                dbms_output.put_line('   Numarul de angajati: ' || v_employee_count);
            end if;
        end;
    end loop;
end;
/

--acelasi ex de la prof
DECLARE
    numar_angajati number(10) := 0;
    val_totala_venituri number(10) :=0;
    val_medie_venituri number(10) :=0;
  CURSOR c_jobs
  IS
    (SELECT j.job_id,MAX(j.job_title) den_job, COUNT(employee_id) NR
    FROM JOBS j,employees e
    WHERE j.job_id=e.job_id(+)
    GROUP BY j.job_id
    );
  CURSOR c_emp(id jobs.job_id%type)
  IS
    (SELECT last_name,
      salary+NVL(commission_pct,0)*salary sal
    FROM employees
    WHERE job_id=id
    );
  contor  NUMBER;
  salariu NUMBER;
BEGIN
  FOR j IN c_jobs
  LOOP
    DBMS_OUTPUT.PUT_LINE('----------------------------');
    DBMS_OUTPUT.PUT_LINE('JOBUL '||j.job_id || ': ' ||j.den_job );
    DBMS_OUTPUT.PUT_LINE('----------------------------');
    IF J.NR = 0 THEN
      DBMS_OUTPUT.PUT_LINE('NU lucreaza nimeni pe acest job');
    ELSE
      contor :=1;
      salariu:=0;
      numar_angajati := numar_angajati + j.nr;
      DBMS_OUTPUT.PUT_LINE('Lucreaza '||j.nr||' angajati pe acest job.');
      FOR e IN c_emp(j.job_id)
      LOOP
        DBMS_OUTPUT.PUT_LINE(contor||'. '||E.LAST_NAME||' '||E.sal);
        contor := contor+1;
        salariu:=salariu+e.sal;
        val_totala_venituri := val_totala_venituri + nvl(e.sal,0);
      END LOOP;
     
      DBMS_OUTPUT.PUT_LINE('Salariul total al angajatilor care lucreaza pe acest job: '||salariu);
      salariu := round(salariu/j.nr);
      DBMS_OUTPUT.PUT_LINE('Salariul mediu al jobului: '||salariu);
     
       DBMS_OUTPUT.NEW_LINE;

    END IF;
  END LOOP;
--  select count(employee_id) numar_angajati, sum(salary+nvl(commission_pct,0)*salary) val_totala_venituri,sum(salary+nvl(commission_pct,0)*salary)/count(employee_id) val_medie_venituri
--  into numar_angajati, val_totala_venituri, val_medie_venituri
--  from employees;
dbms_output.put_line('Numarul total de angajati este: ' || numar_angajati);
dbms_output.put_line('Valoarea totala a veniturilor angajatilor: ' || val_totala_venituri);
dbms_output.put_line('Valoarea medie a veniturilor angajatilor: ' || round(val_totala_venituri/numar_angajati));
END;
/

desc employees;

--  select count(employee_id) numar_angajati, sum(salary+nvl(commission_pct,0)*salary) val_totala_venituri,sum(salary+nvl(commission_pct,0)*salary)/count(employee_id) val_medie_venituri
--  into numar_angajati, val_totala_venituri, val_medie_venituri
--  from employees;

select count(employee_id) numar_angajati, sum(salary+nvl(commission_pct,0)*salary) val_totala_venituri,sum(salary+nvl(commission_pct,0)*salary)/count(employee_id) val_medie_venituri
from employees;