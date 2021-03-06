create table producto(
  idc number(5),
  precio number(24,2),
  stockminimo number(10),
  stockactual number(10)
 );

--registros:

 insert into producto values(100,1000000,1000,200);
 insert into producto values(102,150000,20,5);
 insert into producto values(130,80000,100,0);
 insert into producto values(240,235000,50,20);
 insert into producto values(356,120000,100,250);
 insert into producto values(360,70500,100,102);
 insert into producto values(400,1810000,150,100);
 insert into producto values(150,110000,100,200);
 insert into producto values(122,190000,300,0);
 insert into producto values(139,840000,100,0);
 insert into producto values(250,2320000,0,0);
 insert into producto values(336,120000,100,250);
 insert into producto values(390,700000,100,10);
 insert into producto values(401,128000,160,0);
 
 
Drop table producto cascade constraint;



/*PUNTO 1*/
/* Cree una funci�n que reciba dos valores num�ricos correspondientes a
ambos stosks. Debe comparar ambos stocks y mostrar por pantalla un
mensaje indicando el estado de cada producto, si stock actual es:
 cero: "faltante"
 menor al stock m�nimo: "reponer",
 igual o superior al stock m�nimo: "normal"
 Ambos stock iguales: �No modificado stock�
*/
CREATE OR REPLACE PROCEDURE producto12
IS
CURSOR listas IS  SELECT idc,  stockminimo, stockactual   FROM producto;
idf number;
mini number;
actu number;

begin
open listas;
FETCH listas INTO idf,mini,actu;
LOOP
if actu < mini then
DBMS_OUTPUT.PUT_LINE('reponer');
end if;
if actu > mini then
DBMS_OUTPUT.PUT_LINE('normal');
end if;
if actu = mini then
DBMS_OUTPUT.PUT_LINE('No modificado stock');
end if;
if actu = 0 then
DBMS_OUTPUT.PUT_LINE('faltante');
end if;
FETCH listas INTO idf,mini,actu;
EXIT WHEN listas %NOTFOUND;
END LOOP;
CLOSE listas;
END;

BEGIN
 producto12;
 END;
/*PUNTO 2*/
/*Realice un "select" mostrando el c�digo del producto, ambos stocks y,
empleando la funci�n creada anteriormente, una columna que muestre el
estado del producto*/

CREATE OR REPLACE PROCEDURE producto12
IS
CURSOR listas IS  SELECT idc,  stockminimo, stockactual   FROM producto;
idf number;
mini number;
actu number;

begin
open listas;
FETCH listas INTO idf,mini,actu;
LOOP
DBMS_OUTPUT.PUT_LINE('identificacion' || idf ||'stock minimo' || mini ||'stock maximo' || actu);

FETCH listas INTO idf,mini,actu;
EXIT WHEN listas %NOTFOUND;
END LOOP;
CLOSE listas;
END;
