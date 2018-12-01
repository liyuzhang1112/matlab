(*******************************************************************************
INSA ROUEN NORMANDIE
DEPARTEMENT STPI - PROJET INFO

Liyu ZHANG, Tonglin Yan, XXXXX
Superviseur: Jean-Baptiste LOUVET

20 December 2018
*******************************************************************************)

//!  编 程 规 范
(******************************************************************************
- 不！要！改！文！件！名！：要改文件直接更改即可，不要建立文件副本，然后重命名为 "v1, v2, new
    version, old version"这样
- 以下是在VS code里可以不同颜色区分的注释符：
    //! 表示重要注释
    //? 表示你们有疑问，不懂的地方
    //TODO 表示待完成的工作
    //* 其它任何你们想要和普通注释区分开的地方
- 代码宽度不要超过80列（VS Code左下角 setting -> 搜关键字“Word Wrap Column”然后设置成80）
- function名和procedure名用：minusculeMajusculeMajuscule 首单词小写，后续单词的首字母大
  写
- variable名用：全部小写字母，如有必要，单词间以“_”下划线区分
- constant名用：全部大写字母
*******************************************************************************)
program serpent;

uses crt,math;



//! ----------------------------------------------------------------------------
//!                              VARIABLE DECLARATION
//! ----------------------------------------------------------------------------
var i,j,len,bombx,bomby,l,dir,dirnew:byte;
    //? 问题：
    //? 回复：整个蛇是由一个2维数组来表示的，这个数组记载了蛇每一截所在的坐标（x,y）。行数代表
    //? 蛇的长度，第一行是蛇头。第一列是横坐标x，第二列是纵坐标y——如果我没记错的话
	body:array[1..255,1..2] of byte; // coordinates of each segment of snake
	d:smallint;
	k:char;
	score:integer;



//! ----------------------------------------------------------------------------
//!                                   FUNCTION
//! ----------------------------------------------------------------------------
//* when snake meets wall
function snakeCollision():boolean;
var tmp:integer;
begin
	snakeCollision := false;
	for tmp:=1 to len do
	begin
		if (body[tmp,1] < 2) or (body[tmp,1] >= 80) then
			snakeCollision := true;
			break;
		if (body[tmp,2] < 4) or (body[tmp,2] >= 24) then
			snakeCollision := true;
			break;
	end;
end;

function snake_contains(x,y:integer):boolean;
var tmp:integer;
begin
	snake_contains := false;
	for tmp:=1 to len do
	begin
		if (body[tmp,1] = x) and (body[tmp,2] = y) then snake_contains := true;
	end;
end;



//! ----------------------------------------------------------------------------
//!                                   PROCEDURE
//! ----------------------------------------------------------------------------
//* draw perimeter
procedure drawbox(x0,y0,width,height:integer; title:string);
var i1,i2:integer;
begin
	for i2:=1 to height do
	begin
		GotoXY(x0,y0+i2-1);
		for i1:=1 to width do
		begin
			if (i2 = 1) or (i2 = height) then
				if (i1 = 1) or (i1 = width) then
					Write('+')
				else
					Write('-')
			else if (i1 = 1) or (i1 = width) then
					Write('|')
				else
					Write(' ')
		end;
	end;
	if (title <> '') then
	begin
		i1 := y0+floor((height-1)/2);
		i2 := x0+floor(width/2-length(title)/2);
		GotoXY(i2,i1);
		write(title);
	end;
end;

//* draw snake
procedure drawsnake;
var tmp:integer;
begin
	for tmp:=1 to len do
	begin
		GotoXY(body[tmp,1], body[tmp,2]);
		if (tmp = 1) then write('o')
		else write('x');
	end;
end;

//* Game over pop-up window
procedure snakeDeath;
begin
	textcolor(lightblue);
	drawbox(1,11,80,3,'');
	GotoXY(37,12);
	textcolor(lightred);
	write('Game Over');
	// textcolor(lightgray);
	GotoXY(20,20);
	halt;
end;

//* after snake eating a bean
procedure snakeGrow(x,y:integer);
begin
	inc(score,len); // i.e. score = score + len
	inc(len);
	body[len,1] := x;
	body[len,2] := y;
	GotoXY(x,y);
	write('x');
	GotoXY(2,2); // move cursor back to score panel
	textcolor(white);
	write(score);
	textcolor(lightred);
end;

//* Initiate a new snake
procedure generate_new;
var x,y:integer;
begin
	repeat
		x := random(78)+1;
		y := random(19)+4;
	until not snake_contains(x,y);
	bombx := x;
	bomby := y;
	GotoXY(x,y);
	inc(l);
	textcolor(lightgreen);
	write(chr(l));
	textcolor(lightred);
end;

//* Control snake to move
procedure movesnake;
var x,y,wasx,wasy,tmp:integer;
	died:boolean;
begin
	case dir of
		1: begin x :=  1; y := 0; end;
		2: begin x :=  0; y := 1; end;
		3: begin x := -1; y := 0; end;
		4: begin x :=  0; y :=-1; end;
	end;
	GotoXY(body[1,1], body[1,2]); write('x');
	GotoXY(body[len,1], body[len,2]); write(' ');
	wasx:=body[len,1];
	wasy:=body[len,2];
	died := false;
	if (snake_contains(body[1,1] + x, body[1,2] + y)) then
		died := true;
	for tmp:=2 to len do
	begin
		body[len-tmp+2,1] := body[len-tmp+1,1];
		body[len-tmp+2,2] := body[len-tmp+1,2];
	end;
	body[1,1] := body[1,1] + x;
	body[1,2] := body[1,2] + y;
	GotoXY(body[1,1], body[1,2]); write('o');
	if (died) then snakeDeath;
	if (snake_contains(bombx,bomby)) then
	begin
		snakeGrow(wasx,wasy);
		generate_new;
	end;
	if (snakeCollision) then snakeDeath; // meets wall
end;


//! ----------------------------------------------------------------------------
//!                                  MAIN PROGRAM
//! ----------------------------------------------------------------------------
begin
	// ***** Initiation *****
	ClrScr;
	Randomize;
	len:=1; // initial length of snake
	d:=200; //? time to delay
	l:=64; //? 回复：这个我也忘了 我设的是啥了……我再仔细看看
	score:=0;
	dir:=1; // default direction {1=east,2=south;3=west,4=north}
	// initiate snake body
	for i:=1 to 255 do
		for j:=1 to 2 do
			body[i,j] := 0; //? 回复： 初始化数组（蛇神），让数组里面所有的值都=0
	body[1,1] := 2;
	body[1,2] := 12;
	// print perimeter on screen
	textcolor(lightblue);
	drawbox(1,1,80,24,''); //?
	drawbox(1,1,80,3,'Jeu de Serpent (c) 2018');
	// print initial snake on screen
	textcolor(lightred);
	generate_new;
	drawsnake;
	GotoXY(2,2);
	// ***** Start Game *****
	repeat
		delay(d);
		if (keypressed) then
		begin
			k:=readkey;
			if (k = #0) then
			begin
				k:=readkey;
				case k of
					#77: dirnew := 1;
					#80: dirnew := 2;
					#75: dirnew := 3;
					#72: dirnew := 4;
				end;
				if (dir = 1) and (dirnew <> 3) then dir := dirnew;
				if (dir = 2) and (dirnew <> 4) then dir := dirnew;
				if (dir = 3) and (dirnew <> 1) then dir := dirnew;
				if (dir = 4) and (dirnew <> 2) then dir := dirnew;
			end;
			if (k = #27) then snakeDeath; // press ESC button
		end;
		movesnake;
		GotoXY(2,2);
	until false;
	textcolor(lightgray);
	GotoXY(1,25);
end.