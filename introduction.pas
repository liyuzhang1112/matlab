
Program intro;

Uses crt;

Procedure introduction;
Begin
    clrscr;
    writeln('Welcome to the snake game!');
    writeln(
          'This game has two mode which are one person mode and two peoson mode'
    );
    writeln(
        'For one person mode you can choose the difficulties easy and difficult'
    );
    writeln('To control the snake');
    writeln('Press z to turn left');
    writeln('Press d to turn right');
    writeln('Press w to turn up');
    writeln('Press s to turn down');
    writeln('You are not allowed to touch the wall which will be shown as #');
    writeln(
       'You should also try to eat as many beans as you can which is shown as $'
    );
End;

Function createfile():   file;

Const 
    path =   'D:\France\STPI2 S3\projet info\code\rank\';
    //the path of create a file

Var o:   string;

Var fichier:   file;

Begin
    assign(fichier,'rank.txt');
    rewrite(fichier);
    assign(fichier,'rank.txt');
    rewrite(fichier);
    o := path+'rank.txt';
    assign(fichier,o);
    rewrite(fichier);
    close(fichier);

End;

Procedure RecordTheScore(Var fichier:File);

Const m =   100;

Type classement =   Record
    name:   string;
    score:   array[1..m] Of integer;
End;

Var role:   array[1..m] Of classement;

Var i,j:   integer;
Begin
    assign(fichier,'rank.txt');
    rewrite(fichier);
    For i:=1 To m Do
        Begin
            writeln('Entez votre nom');
            readln(role[i].name);
            For j:=i To m Do
                read(role[i],score[j]);
            readln;
            write(fichier,role[i]);
        End;
    close(fichier);
    writeln;
    writeln;
End;

Procedure GiveTheRank(fichier:File);

Const m =   100;

Type classement =   Record
    name:   string;
    score:   array[1..m] Of integer;
End;

Var role:   array[1..m] Of classement;

Var i,j:   integer;






Var score:   integer;

Var fichier:   file;
Begin
    introduction();

End.
