program test;

uses crt;
const n=40;
      
type a=array[1..n,1..n]of char;//x vertical y horizontal
     b=array[1..n,1..n]of longint;//0blank 1wall 2body 3head 4bean
     c=array[1..5]of integer;

procedure wallf(var tab:b);
var i:integer;
begin
for i:=1 to n do
begin
	tab[i,1]:=1;
	tab[1,i]:=1;
	tab[n,i]:=1;
	tab[i,n]:=1;
end;
end;


procedure walld(var tab:b);//difficile
var i:integer;
begin
for i:=1 to n do
begin
	tab[i,1]:=1;
	tab[1,i]:=1;
	tab[n,i]:=1;
	tab[i,n]:=1;
end;
for i:=2 to 10 do
begin
tab[i,5]:=1;
end;
for i:=15 to 25 do
begin
tab[15,i]:=1;
end;
for i:=15 to 25 do
begin
tab[15,i]:=1;
end;

end;


procedure position(var x,y,leng:integer;var tab:b;var r:char);//player controle the direction of snake 
begin
if (r='z') and (tab[x-1][y]<>leng-1) then
x:=x-1;
if (r='d') and (tab[x][y+1]<>leng-1)then
y:=y+1;
if (r='q') and (tab[x][y-1]<>leng-1)then
y:=y-1;
if (r='s') and (tab[x+1][y]<>leng-1)then
x:=x+1;
end;


procedure change(var x,y,leng:integer;var tab1,tab2:b);//transformation between two tables 
var i,j:integer;
begin
for i:=1 to n do
for j:=1 to n do
begin
if (tab2[i][j]<>0) then
begin
tab1[i][j]:=2;
tab2[x][y]:=leng;
tab1[x][y]:=3;
end;
end;
end;


procedure serp(var x,y,leng:integer;var tab1,tab2:b);//the snake moves 
var i,j:integer;
begin
for i:=1 to n do
for j:=1 to n do
begin
if (tab2[i][j]=1) then
tab1[i][j]:=0;
if (tab2[i][j]<>0) then
tab2[i][j]:=tab2[i][j]-1;
change(x,y,leng,tab1,tab2);
end;
end;


procedure foodf(var tab,tab3:b;var nf:integer;n:integer);//randomize the food 
var i,j:integer;
begin
repeat
randomize;
repeat;
i:=random(n)+1;
j:=random(n)+1;
until tab[i,j]=0;
tab[i][j]:=4;
tab3[i][j]:=1;
nf:=nf+1;
until nf=5;
end;


procedure foodd(var tab1,tab3:b;var nf:integer;n:integer;tp:c);
var i,j,r,s,randomfood:integer;
begin
for s:=nf to 5 do 
begin
randomize;
repeat;
i:=random(n)+1;
j:=random(n)+1;
until tab1[i,j]=0;
tab1[i][j]:=4;
r:=random(50)+1;
case r of
46:randomfood:=2;
47:randomfood:=3;
48:randomfood:=4;
49:randomfood:=5;
50:randomfood:=6;
else
randomfood:=1;
end;
tab3[i][j]:=randomfood;
if (tab3[i][j]=3) or (tab3[i][j]=4) or (tab3[i][j]=5) then
tp[s]:=1;
if (tab3[i][j]=2) then
tp[s]:=1;
nf:=nf+1;
end;
end;


//1 pomme : fait gagner 1 points et fait gagner en taille le serpent d’une case.
//2 bombe : fait perdre une vie, disparaît après 10 secondes.
//3 cœur : fait gagner une vie, disparaît après 5 secondes
//4 fraise : fait gagner 10 points, disparaît après 5 secondes
//5 diamant : écran rempli de pommes, disparaît après 5 secondes
//6 shadow: speed increases for 5 seconds.


procedure eat(d:char;var x,y,leng,nf,score,speed,live:integer;var tab1,tab2,tab3:b;var tp:c);//after eat the food
begin
case tab3[x][y] of
1:begin//ok
leng:=leng+1;
tab2[x][y]:=leng;
tab3[x][y]:=0;
nf:=nf-1;
score:=score+1;
speed:=speed-5;
live:=live;
case d of
'f':foodf(tab1,tab3,nf,n);
'd':foodd(tab1,tab3,nf,n,tp);
end;
change(x,y,leng,tab1,tab2);
end;
2:begin//
leng:=leng+1;
tab2[x][y]:=leng;
tab3[x][y]:=0;
nf:=nf-1;
score:=score+1;
speed:=speed-5;
live:=live;
case d of
'f':foodf(tab1,tab3,nf,n);
'd':foodd(tab1,tab3,nf,n,tp);
end;
change(x,y,leng,tab1,tab2);
end;
3:begin//ok
tab3[x][y]:=0;
nf:=nf-1;
live:=live+1;
case d of
'f':foodf(tab1,tab3,nf,n);
'd':foodd(tab1,tab3,nf,n,tp);
end;
serp(x,y,leng,tab1,tab2);
end;
4:begin//ok
leng:=leng+1;
tab2[x][y]:=leng;
tab3[x][y]:=0;
nf:=nf-1;
score:=score+10;
speed:=speed-5;
live:=live;
case d of
'f':foodf(tab1,tab3,nf,n);
'd':foodd(tab1,tab3,nf,n,tp);
end;
change(x,y,leng,tab1,tab2);
end;
5:begin//
leng:=leng+1;
tab2[x][y]:=leng;
tab3[x][y]:=0;
nf:=nf-1;
score:=score+1;
speed:=speed-5;
live:=live;
case d of
'f':foodf(tab1,tab3,nf,n);
'd':foodd(tab1,tab3,nf,n,tp);
end;
change(x,y,leng,tab1,tab2);
end;
6:begin//
leng:=leng+1;
tab2[x][y]:=leng;
tab3[x][y]:=0;
nf:=nf-1;
score:=score+10;
speed:=speed-5;
live:=live;
case d of
'f':foodf(tab1,tab3,nf,n);
'd':foodd(tab1,tab3,nf,n,tp);
end;
change(x,y,leng,tab1,tab2);
end;
end;
end;


procedure disappear(var tab3:b;var tp:c;var nf:integer);
var i,j:integer;
begin
begin
for i:=1 to 5 do
if tp[i]>5000 then
begin
tp[i]:=0;
nf:=nf-1;
end;
end;
for i:=1 to n do
for j:=1 to n do
case tab3[i,j] of
2:tab3[i,j]:=0;
3:tab3[i,j]:=0;
4:tab3[i,j]:=0;
5:tab3[i,j]:=0;
end;
end;


procedure afficher(tab1,tab3:b;n,score,live:integer);
var i,j:integer;tab:a;
begin
for i:=1 to n do
for j:=1 to n do
case tab1[i,j] of
0:tab[i,j]:=' ';
1:tab[i,j]:='*';//wall
2:tab[i,j]:='o';//body
3:tab[i,j]:='@';//head
4:case tab3[i,j] of
1:tab[i,j]:='a';
2:tab[i,j]:='b';
3:tab[i,j]:='c';
4:tab[i,j]:='d';
5:tab[i,j]:='e';
end;//head
end;
for i:=1 to n do
for j:=1 to n do
begin
write(tab[i,j],' ');
end;
writeln('score=',score);
writeln('live=',live);
end;


procedure introduction;
begin
clrscr;

end;


procedure quitter;
begin
exit;
end;


var tab1,tab2,tab3:b;
tp:c;
x,y,leng,i,nf,score,speed,live:integer;
k:boolean;
r,d,e:char;
begin
writeln('welcome to the game snake');
writeln('introduction of the game, entre i');
writeln('start the game, entre s');
writeln('exit the game, entre e');
e:=readkey;
if (e='s') then
begin
writeln('choisissez-vous la difficulté');
writeln('facile, entrez f');
writeln('difficile, entrez d');
d:=readkey;
fillchar(tab1,sizeof(tab1),0);
fillchar(tab2,sizeof(tab2),0);
fillchar(tab3,sizeof(tab3),0);
fillchar(tp,sizeof(tp),0);
case d of
'f':wallf(tab1);
'd':walld(tab1);
end;
leng:=5;
nf:=0;//number of food
r:='d';
score:=0;
speed:=500;
live:=1;

//initial state
for i:=1 to leng do
tab2[n div 2][i+1]:=i;
x:=n div 2;
y:=6;
change(x,y,leng,tab1,tab2);
case d of
'f':foodf(tab1,tab3,nf,n);
'd':foodd(tab1,tab3,nf,n,tp);
end;
afficher(tab1,tab3,n,score,live);
clrscr;

repeat//main procedure
k:=keypressed;
if (k=true) then
r:=readkey;
position(x,y,leng,tab2,r);

if (tab1[x][y]=1) or (tab1[x][y]=2) then
exit;//
if (tab1[x][y]=4) then
eat(d,x,y,leng,nf,score,speed,live,tab1,tab2,tab3,tp)
else
serp(x,y,leng,tab1,tab2);
disappear(tab3,tp,nf);
afficher(tab1,tab3,n,score,live);
delay(speed);
clrscr;
for i:=1 to 5 do
begin
if (tp[i]<>0) then
tp[i]:=tp[i]+speed;
end;
until (tab1[x][y]=1) or (tab1[x][y]=2);
end;
end.

