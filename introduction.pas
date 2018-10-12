program intro;

uses crt;

procedure introduction;
begin
clrscr;
writeln('Welcome to the snake game!');
writeln('This game has two mode which are one person mode and two peoson mode');
writeln('For one person mode you can choose the difficulties easy and difficult');
writeln('To control the snake');
writeln('Press z to turn left');
writeln('Press d to turn right');
writeln('Press w to turn up');
writeln('Press s to turn down');
writeln('You are not allowed to touch the wall which will be shown as #');
writeln('You should also try to eat as many beans as you can which is shown as $');
end;

function createfile():file;
const
path='D:\France\STPI2 S3\projet info\code\rank\';//the path of create a file
var o:string;
var fichier:file;

begin
assign(fichier,'rank.txt'); 
rewrite(fichier);
assign(fichier,'rank.txt'); 
rewrite(fichier);
o:=path+'rank.txt';
assign(fichier,o);
rewrite(fichier);
close(fichier);

end;

procedure RecordTheScore(var fichier:file);
const m=100;
type classement= record
name:string;
score:array[1..m] of integer;
end;
var role:array[1..m] of classement;
var i,j:integer;
begin
assign(fichier,'rank.txt');
rewrite(fichier);
for i:=1 to m do
begin
	writeln('Entez votre nom');
	readln(role[i].name);
	for j:=i to m do
		read(role[i],score[j]);
		readln;
		write(fichier,role[i]);
end;
close(fichier);
writeln;
writeln;
end;

procedure GiveTheRank(fichier:file);
const m=100;
type classement= record
name:string;
score:array[1..m] of integer;
end;
var role:array[1..m] of classement;
var i,j:integer;

  




var score:integer;
var fichier:file;
BEGIN
introduction();

end.
