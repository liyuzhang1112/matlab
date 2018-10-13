
Program test;
// HERE IS BUILD BRANCH

Uses crt;

Const n =   40;

Type a =   array[1..n,1..n] Of char;
    //x vertical y horizontal
    b =   array[1..n,1..n] Of longint;
    //cell's status: 0blank 1wall 2body 3head 4bean
    c =   array[1..5] Of integer;
    //reserved for vanishing food

Procedure wallf(Var tab:b);

Var i:   integer;
Begin
    For i:=1 To n Do
        Begin
            tab[i,1] := 1;
            tab[1,i] := 1;
            tab[n,i] := 1;
            tab[i,n] := 1;
        End;
End;


Procedure walld(Var tab:b);
//difficile

Var i:   integer;
Begin
    For i:=1 To n Do
        Begin
            tab[i,1] := 1;
            tab[1,i] := 1;
            tab[n,i] := 1;
            tab[i,n] := 1;
        End;
    For i:=2 To 10 Do
        Begin
            tab[i,5] := 1;
        End;
    For i:=15 To 25 Do
        Begin
            tab[15,i] := 1;
        End;
    For i:=15 To 25 Do
        Begin
            tab[15,i] := 1;
        End

End;


Procedure position(Var x,y,leng:integer;Var tab:b;Var r:char);
//player controle the direction of snake 
Begin
    If (r='z') And (tab[x-1][y]<>leng-1) Then
        x := x-1;
    If (r='d') And (tab[x][y+1]<>leng-1)Then
        y := y+1;
    If (r='q') And (tab[x][y-1]<>leng-1)Then
        y := y-1;
    If (r='s') And (tab[x+1][y]<>leng-1)Then
        x := x+1;
End;


Procedure change(Var x,y,leng:integer;Var tab1,tab2:b);
//transformation between two tables 

Var i,j:   integer;
Begin
    For i:=1 To n Do
        For j:=1 To n Do
            Begin
                If (tab2[i][j]<>0) Then
                    Begin
                        tab1[i][j] := 2;
                        tab2[x][y] := leng;
                        tab1[x][y] := 3;
                    End;
            End;
End;


Procedure serp(Var x,y,leng:integer;Var tab1,tab2:b);
//the snake moves 

Var i,j:   integer;
Begin
    For i:=1 To n Do
        For j:=1 To n Do
            Begin
                If (tab2[i][j]=1) Then
                    tab1[i][j] := 0;
                If (tab2[i][j]<>0) Then
                    tab2[i][j] := tab2[i][j]-1;
                change(x,y,leng,tab1,tab2);
            End;
End;


Procedure foodf(Var tab,tab3:b;Var nf:integer;n:integer);
//randomize the food 

Var i,j:   integer;
Begin
    Repeat
        randomize;
        Repeat;
            i := random(n)+1;
            j := random(n)+1;
        Until tab[i,j]=0;
        tab[i][j] := 4;
        tab3[i][j] := 1;
        nf := nf+1;
    Until nf=5;
End;


Procedure foodd(Var tab1,tab3:b;Var nf:integer;n:integer;tp:c);

Var i,j,r,s,randomfood:   integer;
Begin
    For s:=nf To 5 Do
        Begin
            randomize;
            Repeat;
                i := random(n)+1;
                j := random(n)+1;
            Until tab1[i,j]=0;
            tab1[i][j] := 4;
            r := random(50)+1;
            Case r Of 
                46:   randomfood := 2;
                47:   randomfood := 3;
                48:   randomfood := 4;
                49:   randomfood := 5;
                50:   randomfood := 6;
                Else
                    randomfood := 1;
            End;
            tab3[i][j] := randomfood;
            If (tab3[i][j]=3) Or (tab3[i][j]=4) Or (tab3[i][j]=5) Then
                tp[s] := 1;
            If (tab3[i][j]=2) Then
                tp[s] := 1;
            nf := nf+1;
        End;
End;



//1 pomme : fait gagner 1 points et fait gagner en taille le serpent d’une case.
//2 bombe : fait perdre une vie, disparaît après 10 secondes.
//3 cœur : fait gagner une vie, disparaît après 5 secondes
//4 fraise : fait gagner 10 points, disparaît après 5 secondes
//5 diamant : écran rempli de pommes, disparaît après 5 secondes
//6 shadow: speed increases for 5 seconds.


Procedure eat(d:char;Var x,y,leng,nf,score,speed,live:integer;Var tab1,tab2,tab3
              :b;Var tp:c);
//after eat the food
Begin
    Case tab3[x][y] Of 
        1:
             Begin
                 //ok
                 leng := leng+1;
                 tab2[x][y] := leng;
                 tab3[x][y] := 0;
                 nf := nf-1;
                 score := score+1;
                 speed := speed-5;
                 live := live;
                 Case d Of 
                     'f':   foodf(tab1,tab3,nf,n);
                     'd':   foodd(tab1,tab3,nf,n,tp);
                 End;
                 change(x,y,leng,tab1,tab2);
             End;
        2:
             Begin
                 //
                 leng := leng+1;
                 tab2[x][y] := leng;
                 tab3[x][y] := 0;
                 nf := nf-1;
                 score := score+1;
                 speed := speed-5;
                 live := live;
                 Case d Of 
                     'f':   foodf(tab1,tab3,nf,n);
                     'd':   foodd(tab1,tab3,nf,n,tp);
                 End;
                 change(x,y,leng,tab1,tab2);
             End;
        3:
             Begin
                 //ok
                 tab3[x][y] := 0;
                 nf := nf-1;
                 live := live+1;
                 Case d Of 
                     'f':   foodf(tab1,tab3,nf,n);
                     'd':   foodd(tab1,tab3,nf,n,tp);
                 End;
                 serp(x,y,leng,tab1,tab2);
             End;
        4:
             Begin
                 //ok
                 leng := leng+1;
                 tab2[x][y] := leng;
                 tab3[x][y] := 0;
                 nf := nf-1;
                 score := score+10;
                 speed := speed-5;
                 live := live;
                 Case d Of 
                     'f':   foodf(tab1,tab3,nf,n);
                     'd':   foodd(tab1,tab3,nf,n,tp);
                 End;
                 change(x,y,leng,tab1,tab2);
             End;
        5:
             Begin
                 //
                 leng := leng+1;
                 tab2[x][y] := leng;
                 tab3[x][y] := 0;
                 nf := nf-1;
                 score := score+1;
                 speed := speed-5;
                 live := live;
                 Case d Of 
                     'f':   foodf(tab1,tab3,nf,n);
                     'd':   foodd(tab1,tab3,nf,n,tp);
                 End;
                 change(x,y,leng,tab1,tab2);
             End;
        6:
             Begin
                 //
                 leng := leng+1;
                 tab2[x][y] := leng;
                 tab3[x][y] := 0;
                 nf := nf-1;
                 score := score+10;
                 speed := speed-5;
                 live := live;
                 Case d Of 
                     'f':   foodf(tab1,tab3,nf,n);
                     'd':   foodd(tab1,tab3,nf,n,tp);
                 End;
                 change(x,y,leng,tab1,tab2);
             End;
    End;
End;


Procedure disappear(Var tab3:b;Var tp:c;Var nf:integer);
//reserved for vanishing

Var i,j:   integer;
Begin
    Begin
        For i:=1 To 5 Do
            If tp[i]>5000 Then
                Begin
                    tp[i] := 0;
                    nf := nf-1;
                End;
    End;
    For i:=1 To n Do
        For j:=1 To n Do
            Case tab3[i,j] Of 
                2:   tab3[i,j] := 0;
                3:   tab3[i,j] := 0;
                4:   tab3[i,j] := 0;
                5:   tab3[i,j] := 0;
            End;
End;


Procedure afficher(tab1,tab3:b;n,score,live:integer);

Var i,j:   integer;
    tab:   a;
Begin
    For i:=1 To n Do
        For j:=1 To n Do
            Case tab1[i,j] Of 
                0:   tab[i,j] := ' ';
                1:   tab[i,j] := '*';
                //wall
                2:   tab[i,j] := 'o';
                //body
                3:   tab[i,j] := '@';
                //head
                4:   Case tab3[i,j] Of 
                         //table of bean
                         1:   tab[i,j] := 'a';
                         2:   tab[i,j] := 'b';
                         3:   tab[i,j] := 'c';
                         4:   tab[i,j] := 'd';
                         5:   tab[i,j] := 'e';
                     End;
                //head
            End;
    For i:=1 To n Do
        For j:=1 To n Do
            Begin
                write(tab[i,j],' ');
            End;
    writeln('score=',score);
    writeln('live=',live);
End;


Procedure introduction;
Begin
    clrscr;

End;


Procedure quitter;
Begin
    exit;
End;


Var tab1,tab2,tab3:   b;
    tp:   c;
    x,y,leng,i,nf,score,speed,live:   integer;
    k:   boolean;
    r,d,e:   char;
Begin
    writeln('welcome to the game snake');
    writeln('introduction of the game, entre i');
    writeln('start the game, entre s');
    writeln('exit the game, entre e');
    e := readkey;
    If (e='s') Then
        Begin
            writeln('choisissez-vous la difficulté');
            writeln('facile, entrez f');
            writeln('difficile, entrez d');
            d := readkey;
            fillchar(tab1,sizeof(tab1),0);
            fillchar(tab2,sizeof(tab2),0);
            fillchar(tab3,sizeof(tab3),0);
            fillchar(tp,sizeof(tp),0);
            Case d Of 
                'f':   wallf(tab1);
                'd':   walld(tab1);
            End;
            leng := 5;
            nf := 0;
            //number of food
            r := 'd';
            score := 0;
            speed := 500;
            live := 1;

            //initial state
            For i:=1 To leng Do
                tab2[n div 2][i+1] := i;
            x := n Div 2;
            y := 6;
            change(x,y,leng,tab1,tab2);
            Case d Of 
                'f':   foodf(tab1,tab3,nf,n);
                'd':   foodd(tab1,tab3,nf,n,tp);
            End;
            afficher(tab1,tab3,n,score,live);
            clrscr;

            Repeat
                //main procedure
                k := keypressed;
                If (k=true) Then
                    r := readkey;
                position(x,y,leng,tab2,r);

                If (tab1[x][y]=1) Or (tab1[x][y]=2) Then
                    exit;
                //
                If (tab1[x][y]=4) Then
                    eat(d,x,y,leng,nf,score,speed,live,tab1,tab2,tab3,tp)
                Else
                    serp(x,y,leng,tab1,tab2);
                disappear(tab3,tp,nf);
                afficher(tab1,tab3,n,score,live);
                delay(speed);
                clrscr;
                For i:=1 To 5 Do
                    Begin
                        If (tp[i]<>0) Then
                            tp[i] := tp[i]+speed;
                    End;
            Until (tab1[x][y]=1) Or (tab1[x][y]=2);
        End;
End.
