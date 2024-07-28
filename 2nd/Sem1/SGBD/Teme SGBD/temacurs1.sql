----primu ex naty
--declare --bloc 1
--    variabila1 varchar2(50) := 'variabila din bloc 1';
--begin --incep bloc 1
--    
--    declare --bloc 2
--        variabila2 varchar2(50) := 'variabila din bloc 2';
--    begin --incep bloc 2
--        
--        declare --bloc 3
--            variabila3 varchar(50) :='variabila din bloc 3';
--        begin --incep bloc 3
--            
--            declare --bloc 4
--                variabila4 varchar2(50) := 'variabila din bloc 4';
--            begin --incep bloc 4
--                --afisare bloc si variabile
--                dbms_output.put_line('<<Al 4-lea bloc>>');
--                dbms_output.put_line('Folosesc ' || variabila1);
--                dbms_output.put_line('Folosesc ' || variabila2);
--                dbms_output.put_line('Folosesc ' || variabila3);
--                dbms_output.put_line('Folosesc ' || variabila4);
--                --modificam variabilele adaugand .4 la final
--                variabila4 := variabila4 || '.4';
--                variabila3 := variabila3 || '.4';
--                variabila2 := variabila2 || '.4';
--                variabila1 := variabila1 || '.4';
--                dbms_output.put_line('');
--                dbms_output.put_line('*Modificari in blocul 4');
--                dbms_output.put_line('v1 dupa: ' || variabila1);
--                dbms_output.put_line('v2 dupa: ' || variabila2);
--                dbms_output.put_line('v3 dupa: ' || variabila3);
--                dbms_output.put_line('v4 dupa: ' || variabila4);
--            end; --termin bloc 4 si ma intorc in bloc 3
--            dbms_output.put_line('');
--            dbms_output.put_line('');--doua linii ca sa se diferentieze blocurile
--            dbms_output.put_line('<<Al 3-lea bloc>>');
--            dbms_output.put_line('Folosesc ' || variabila1);
--            dbms_output.put_line('Folosesc ' || variabila2);
--            dbms_output.put_line('Folosesc ' || variabila3);
--            --dbms_output.put_line('Folosesc ' || variabila4);
--            dbms_output.put_line('!!variabila4 exista doar in blocul 4');
--            --modificam variabilele adaugand .3 la final
--            --variabila4 := variabila4 || '.3'; --ea nu mai exista aici
--            variabila3 := variabila3 || '.3';
--            variabila2 := variabila2 || '.3';
--            variabila1 := variabila1 || '.3';
--            dbms_output.put_line('');
--            dbms_output.put_line('*Modificari in blocul 3');
--            dbms_output.put_line('v1 dupa: ' || variabila1);
--            dbms_output.put_line('v2 dupa: ' || variabila2);
--            dbms_output.put_line('v3 dupa: ' || variabila3);
--            --dbms_output.put_line('v4 dupa: ' || variabila4);
--            dbms_output.put_line('!!variabila4 exista doar in blocul 4');
--        end;--termin bloc 3 si reintru in bloc 2
--        --BLOC 2
--        dbms_output.put_line('');
--        dbms_output.put_line('');
--        dbms_output.put_line('<<Al 2-lea bloc>>');
--        dbms_output.put_line('Folosesc ' || variabila1);
--        dbms_output.put_line('Folosesc ' || variabila2);
--        --dbms_output.put_line('Folosesc ' || variabila3);
--        dbms_output.put_line('!!variabila3 exista doar in blocul 3 si 4');
--        --dbms_output.put_line('Folosesc ' || variabila4);
--        dbms_output.put_line('!!variabila4 exista doar in blocul 4');
--        --modificam variabilele adaugand .2 la final
--        --variabila4 := variabila4 || '.2'; --ea nu mai exista aici
--        --variabila3 := variabila3 || '.2'; --ea nu mai exista aici
--        variabila2 := variabila2 || '.2';
--        variabila1 := variabila1 || '.2';
--        dbms_output.put_line('');
--        dbms_output.put_line('*Modificari in blocul 2');
--        dbms_output.put_line('v1 dupa: ' || variabila1);
--        dbms_output.put_line('v2 dupa: ' || variabila2);
--        --dbms_output.put_line('v3 dupa: ' || variabila3);
--        dbms_output.put_line('!!variabila3 exista doar in blocul 3 si 4');
--        --dbms_output.put_line('v4 dupa: ' || variabila4);
--        dbms_output.put_line('!!variabila4 exista doar in blocul 4');
--    end;--termin bloc 2 si reintru in primul bloc
--    --BLOC 1
--    dbms_output.put_line('');
--    dbms_output.put_line('');
--    dbms_output.put_line('<<Primul bloc>>');
--    dbms_output.put_line('Folosesc ' || variabila1);
--    --dbms_output.put_line('Folosesc ' || variabila2);
--    dbms_output.put_line('!!variabila2 exista doar in blocul 2,3 si 4');
--    --dbms_output.put_line('Folosesc ' || variabila3);
--    dbms_output.put_line('!!variabila3 exista doar in blocul 3 si 4');
--    --dbms_output.put_line('Folosesc ' || variabila4);
--    dbms_output.put_line('!!variabila4 exista doar in blocul 4');
--    --modificam variabilele adaugand .1 la final
--    --variabila4 := variabila4 || '.1'; --ea nu mai exista aici
--    --variabila3 := variabila3 || '.1'; --ea nu mai exista aici
--    --variabila2 := variabila2 || '.1'; --ea nu mai exista aici
--    variabila1 := variabila1 || '.1';
--    dbms_output.put_line('');
--    dbms_output.put_line('*Modificari in blocul 1');
--    dbms_output.put_line('v1 dupa: ' || variabila1);
--    --dbms_output.put_line('v2 dupa: ' || variabila2);
--    dbms_output.put_line('!!variabila2 exista doar in blocul 2,3 si 4');
--    --dbms_output.put_line('v3 dupa: ' || variabila3);
--    dbms_output.put_line('!!variabila3 exista doar in blocul 3 si 4');
--    --dbms_output.put_line('v4 dupa: ' || variabila4);
--    dbms_output.put_line('!!variabila4 exista doar in blocul 4');
--end;
--            

--daca mi zice de ala nasol
declare --bloc 1
    variabila1 varchar2(50) := 'variabila din bloc 1';
begin --incep bloc 1
    
    declare --bloc 2
        variabila2 varchar2(50) := 'variabila din bloc 2';
    begin --incep bloc 2
        
        declare --bloc 3
            variabila3 varchar(50) :='variabila din bloc 3';
        begin --incep bloc 3
            
            declare --bloc 4
                variabila4 varchar2(50) := 'variabila din bloc 4';
            begin --incep bloc 4
                
                declare --bloc 5
                    variabila5 varchar2(50) := 'variabila din bloc 5';
                begin --incep bloc 5
                    --afisare bloc si variabile
                    dbms_output.put_line('<<Al 5-lea bloc>>');
                    dbms_output.put_line('Folosesc ' || variabila1);
                    dbms_output.put_line('Folosesc ' || variabila2);
                    dbms_output.put_line('Folosesc ' || variabila3);
                    dbms_output.put_line('Folosesc ' || variabila4);
                    dbms_output.put_line('Folosesc ' || variabila5);
                    --modificam variabilele adaugand .5 la final
                    variabila5 := variabila5 || '.5';
                    variabila4 := variabila4 || '.5';
                    variabila3 := variabila3 || '.5';
                    variabila2 := variabila2 || '.5';
                    variabila1 := variabila1 || '.5';
                    dbms_output.put_line('');
                    dbms_output.put_line('*Modificari in blocul 5');
                    dbms_output.put_line('v1 dupa: ' || variabila1);
                    dbms_output.put_line('v2 dupa: ' || variabila2);
                    dbms_output.put_line('v3 dupa: ' || variabila3);
                    dbms_output.put_line('v4 dupa: ' || variabila4);
                    dbms_output.put_line('v5 dupa: ' || variabila5);
                    end;
                    --BLOC 4
                    dbms_output.put_line('');
                    dbms_output.put_line('');
                    dbms_output.put_line('<<Al 4-lea bloc>>');
                    dbms_output.put_line('Folosesc ' || variabila1);
                    dbms_output.put_line('Folosesc ' || variabila2);
                    dbms_output.put_line('Folosesc ' || variabila3);
                    dbms_output.put_line('Folosesc ' || variabila4);
                    --dbms_output.put_line('Folosesc ' || variabila5);
                    dbms_output.put_line('!!var5 exista doar in blocul 5');
                    --modificam variabilele adaugand .4 la final
                    --variabila5 := variabila5 || '.4'; --nu mai exista aici
                    variabila4 := variabila4 || '.4';
                    variabila3 := variabila3 || '.4';
                    variabila2 := variabila2 || '.4';
                    variabila1 := variabila1 || '.4';
                    dbms_output.put_line('');
                    dbms_output.put_line('*Modificari in blocul 4');
                    dbms_output.put_line('v1 dupa: ' || variabila1);
                    dbms_output.put_line('v2 dupa: ' || variabila2);
                    dbms_output.put_line('v3 dupa: ' || variabila3);
                    dbms_output.put_line('v4 dupa: ' || variabila4);
                    dbms_output.put_line('!!var5 exista doar in blocul 5');
                    --dbms_output.put_line('v5 dupa: ' || variabila5);
            end; --termin bloc 4 si ma intorc in bloc 3
            dbms_output.put_line('');
            dbms_output.put_line('');--doua linii ca sa se diferentieze blocurile
            dbms_output.put_line('<<Al 3-lea bloc>>');
            dbms_output.put_line('Folosesc ' || variabila1);
            dbms_output.put_line('Folosesc ' || variabila2);
            dbms_output.put_line('Folosesc ' || variabila3);
            --dbms_output.put_line('Folosesc ' || variabila4);
            dbms_output.put_line('!!variabila4 exista doar in blocul 4 si 5');
            --dbms_output.put_line('Folosesc ' || variabila5);
                dbms_output.put_line('!!var5 exista doar in blocul 5');
            --modificam variabilele adaugand .3 la final
            --variabila5 := variabila5 || '.3'; --ea nu mai exista aici
            --variabila4 := variabila4 || '.3'; --ea nu mai exista aici
            variabila3 := variabila3 || '.3';
            variabila2 := variabila2 || '.3';
            variabila1 := variabila1 || '.3';
            dbms_output.put_line('');
            dbms_output.put_line('*Modificari in blocul 3');
            dbms_output.put_line('v1 dupa: ' || variabila1);
            dbms_output.put_line('v2 dupa: ' || variabila2);
            dbms_output.put_line('v3 dupa: ' || variabila3);
            --dbms_output.put_line('v4 dupa: ' || variabila4);
            dbms_output.put_line('!!variabila4 exista doar in blocul 4 si 5');
            dbms_output.put_line('!!var5 exista doar in blocul 5');
            --dbms_output.put_line('v5 dupa: ' || variabila5);
        end;--termin bloc 3 si reintru in bloc 2
        --BLOC 2
        dbms_output.put_line('');
        dbms_output.put_line('');
        dbms_output.put_line('<<Al 2-lea bloc>>');
        dbms_output.put_line('Folosesc ' || variabila1);
        dbms_output.put_line('Folosesc ' || variabila2);
        --dbms_output.put_line('Folosesc ' || variabila3);
        dbms_output.put_line('!!variabila3 exista doar in blocul 3,4 si 5');
        --dbms_output.put_line('Folosesc ' || variabila4);
        dbms_output.put_line('!!variabila4 exista doar in blocul 4 si 5');
        --dbms_output.put_line('Folosesc ' || variabila5);
        dbms_output.put_line('!!var5 exista doar in blocul 5');
        --modificam variabilele adaugand .2 la final
        --variabila5 := variabila5 || '.2'; --ea nu mai exista aici
        --variabila4 := variabila4 || '.2'; --ea nu mai exista aici
        --variabila3 := variabila3 || '.2'; --ea nu mai exista aici
        variabila2 := variabila2 || '.2';
        variabila1 := variabila1 || '.2';
        dbms_output.put_line('');
        dbms_output.put_line('*Modificari in blocul 2');
        dbms_output.put_line('v1 dupa: ' || variabila1);
        dbms_output.put_line('v2 dupa: ' || variabila2);
        --dbms_output.put_line('v3 dupa: ' || variabila3);
        dbms_output.put_line('!!variabila3 exista doar in blocul 3,4 si 5');
        --dbms_output.put_line('v4 dupa: ' || variabila4);
        dbms_output.put_line('!!variabila4 exista doar in blocul 4 si 5');
        dbms_output.put_line('!!var5 exista doar in blocul 5');
        --dbms_output.put_line('v5 dupa: ' || variabila5);
    end;--termin bloc 2 si reintru in primul bloc
    --BLOC 1
    dbms_output.put_line('');
    dbms_output.put_line('');
    dbms_output.put_line('<<Primul bloc>>');
    dbms_output.put_line('Folosesc ' || variabila1);
    --dbms_output.put_line('Folosesc ' || variabila2);
    dbms_output.put_line('!!variabila2 exista doar in blocul 2,3,4 si 5');
    --dbms_output.put_line('Folosesc ' || variabila3);
    dbms_output.put_line('!!variabila3 exista doar in blocul 3,4 si 5');
    --dbms_output.put_line('Folosesc ' || variabila4);
    dbms_output.put_line('!!variabila4 exista doar in blocul 4 si 5');
     --dbms_output.put_line('Folosesc ' || variabila5);
    dbms_output.put_line('!!var5 exista doar in blocul 5');
    --modificam variabilele adaugand .1 la final
    --variabila5 := variabila5 || '.1'; --ea nu mai exista aici
    --variabila4 := variabila4 || '.1'; --ea nu mai exista aici
    --variabila3 := variabila3 || '.1'; --ea nu mai exista aici
    --variabila2 := variabila2 || '.1'; --ea nu mai exista aici
    variabila1 := variabila1 || '.1';
    dbms_output.put_line('');
    dbms_output.put_line('*Modificari in blocul 1');
    dbms_output.put_line('v1 dupa: ' || variabila1);
    --dbms_output.put_line('v2 dupa: ' || variabila2);
    dbms_output.put_line('!!variabila2 exista doar in blocul 2,3,4 si 5');
    --dbms_output.put_line('v3 dupa: ' || variabila3);
    dbms_output.put_line('!!variabila3 exista doar in blocul 3,4 si 5');
    --dbms_output.put_line('v4 dupa: ' || variabila4);
    dbms_output.put_line('!!variabila4 exista doar in blocul 4 si 5');
    dbms_output.put_line('!!var5 exista doar in blocul 5');
    --dbms_output.put_line('v5 dupa: ' || variabila5);
end;