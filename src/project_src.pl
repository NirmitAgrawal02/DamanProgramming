% DCG - Definite Clause Grammar
:- use_rendering(svgtree).
:- table t/3,t2/3, identifier/3,num/3.
program(t_p(Tb)) --> block(Tb),['.'].
block(t_b(Td,Tc)) --> ['start'],declaration(Td),[';'],command(Tc),['finish'].
declaration(t_ass_decl(A,D)) --> ass_variable(A),[';'],declaration(D).
declaration(t_decl_decl(A,D)) --> decl_variable(A),[';'],declaration(D).
declaration(t_ass_decl(A)) --> ass_variable(A).
declaration(t_decl_decl(A)) --> decl_variable(A).

% ASS_VARIABLE ::= int I = N | bool I = BOOL_VAL | st I = STRING


ass_variable(t_ass_variable_int(Tid,Tnum)) --> ['int'],identifier(Tid),['='],num(Tnum).
ass_variable(t_ass_variable_bool(Tid,Tbval)) --> ['bool'],identifier(Tid),['='],bool_val(Tbval).
ass_variable(t_ass_variable_st(Tid,Tstr)) --> ['st'],identifier(Tid),['='],str(Tstr).

% DECL_VARIABLE ::= int I | bool I | st I

decl_variable(t_decl_variable_int(Tid)) --> ['int'],identifier(Tid).
decl_variable(t_decl_variable_bool(Tid)) --> ['bool'],identifier(Tid).
decl_variable(t_decl_variable_st(Tid)) --> ['st'],identifier(Tid).

% CMD ::= NC; CMD | NC

command(t_cmd(Tnc,Tcmd)) --> new_command(Tnc),[';'], command(Tcmd).
command(t_cmd(Tnc)) --> new_command(Tnc).

% NC ::= I = AE | if BE then CMD else CMD fi | while BE begin CMD end | for( int I = AE; BE ; AE) begin CMD end | for I in range(N,N) begin CMD end | BE? CMD : CMD | print (EXP) 

new_command(t_ncmd(Tid,Tae)) --> identifier(Tid),['='],ae(Tae).
new_command(t_ncmd_if(Tbe,Tcmd,Tcmd1)) --> ['if'],be(Tbe),['then'],command(Tcmd),['else'],command(Tcmd1),['fi'].
new_command(t_ncmd_while(Tbe,Tcmd)) --> ['while'],be(Tbe),['begin'],command(Tcmd),['end'].
new_command(t_ncmd_for(Tid,Tae,Tbe,Tae1,Tcmd)) --> ['for'],['('],['int'],identifier(Tid),['='],ae(Tae),[';'],be(Tbe),[';'],ae(Tae1),[')'],['begin'],command(Tcmd),['end'].
new_command(t_ncmd_for_range(Tid,Tnum1,Tnum2,Tcmd)) --> ['for'],identifier(Tid),['in'],['range'],['('],num(Tnum1),[','],num(Tnum2),[')'],['begin'],command(Tcmd),['end'].
new_command(t_ncmd_ternary(Tbe,Tcmd,Tcmd1)) --> be(Tbe),['?'],command(Tcmd),[':'],command(Tcmd1).
new_command(t_ncmd_print(Texp)) --> ['print'],['('],exp(Texp),[')'].

% BE ::= SUB and BE | SUB or BE | SUB
be(t_be_and(Sub,BE))--> sub(Sub),['and'],be(BE).
be(t_be_or(Sub,BE))--> sub(Sub),['or'],be(BE).
be(t_be(Sub))--> sub(Sub).

% SUB ::= AE==AE | AE>AE | AE<AE | AE>= AE | AE<=AE | AE!= AE | not SUB | BOOL_VAL 
sub(t_sub_eq(AE1,AE2))--> ae(AE1),['=='],ae(AE2).
sub(t_sub_greaterthan(AE1,AE2))--> ae(AE1),['>'],ae(AE2).
sub(t_sub_lessthan(AE1,AE2))--> ae(AE1),['<'],ae(AE2).
sub(t_sub_gteqto(AE1,AE2))--> ae(AE1),['>='],ae(AE2).
sub(t_sub_lteqto(AE1,AE2))--> ae(AE1),['<='],ae(AE2).
sub(t_sub_noteq(AE1,AE2))--> ae(AE1),['!='],ae(AE2).
sub(t_sub_not(Sub))--> ['not'],sub(Sub).
sub(t_sub_bool(Bool))--> bool_val(Bool).

% AE ::= I:=T|T
ae(t_ae(ID,T))--> identifier(ID),['='],t(T).
ae(t_ae(T))--> t(T).

% T::=T + T2 | T – T2 | T2
t(t_term_plus(T,T2))--> t(T),['+'],t2(T2).
t(t_term_min(T,T2))--> t(T),['-'],t2(T2).
t(t_term(T2))--> t2(T2).

% T2::= T2 * T3 | T2 / T3 | T3
t2(t_t2_prod(T2,T3))--> t2(T2),['*'],t3(T3).
t2(t_t2_div(T2,T3))--> t2(T2),['/'],t3(T3).
t2(t_t2(T3))--> t3(T3).

% T3 ::= (AE)| I |N
t3(t_t3_par(AE))--> ['('],ae(AE),[')'].
t3(t_t3(ID))--> identifier(ID).
t3(t_t3(Num))--> num(Num).

% EXP ::= AE;EXP | BE;EXP | STRING; EXP | N ; EXP | I; EXP|AE | BE | STRING | N | I 
exp(t_exp(AE,Exp))--> ae(AE),[';'],exp(Exp).
exp(t_exp(BE,Exp))--> be(BE),[';'],exp(Exp).
exp(t_exp(Str,Exp))--> str(Str),[';'],exp(Exp).
exp(t_exp(Num,Exp))--> num(Num),[';'],exp(Exp).
exp(t_exp(ID,Exp))--> identifier(ID),[';'],exp(Exp).
exp(t_exp(AE))--> ae(AE).
exp(t_exp(BE))--> be(BE).
exp(t_exp(Str))--> str(Str).
exp(t_exp(Num))--> num(Num).
exp(t_exp(ID))--> identifier(ID).

% STRING ::= "TEMP"
str(t_str(Temp))-->['"'],temp(Temp),['"'].

% TEMP ::= CH TEMP | N TEMP | CH | N
temp(t_temp(CH))--> ch(CH).
temp(t_temp(Num))--> num(Num).
temp(t_temp(CH,Temp))--> ch(CH),temp(Temp).
temp(t_temp(Num,Temp))--> num(Num),temp(Temp).


% BOOL_VAL ::= true|false 
bool_val(true)--> ['true'].
bool_val(false)--> ['false'].

% I ::= CH I | CH
identifier(t_id(CH))--> ch(CH).
identifier(t_id(CH,ID))--> ch(CH),identifier(ID).


% CH ::= a | b | c | d | e | f | g | h | i | j | k | l | m | n | o | p | q | r | s | t | u | v | w | x | y | z
ch(a)--> [a].
ch(b)--> [b].
ch(c)--> [c].
ch(d)--> [d].
ch(e)--> [e].
ch(f)--> [f].
ch(g)--> [g].
ch(h)--> [h].
ch(i)--> [i].
ch(j)--> [j].
ch(k)--> [k].
ch(l)--> [l].
ch(m)--> [m].
ch(n)--> [n].
ch(o)--> [o].
ch(p)--> [p].
ch(q)--> [q].
ch(r)--> [r].
ch(s)--> [s].
ch(t)--> [t].
ch(u)--> [u].
ch(v)--> [v].
ch(w)--> [w].
ch(x)--> [x].
ch(y)--> [y].
ch(z)--> [z].

% N := DIG N | DIG)

num(t_num(Dig))--> dig(Dig).
num(t_num(Dig,Num))--> dig(Dig),num(Num).


%DIG := 0|1|2|3|4|5|6|7|8|9
dig(0)--> [0].
dig(1)--> [1].
dig(2)--> [2].
dig(3)--> [3].
dig(4)--> [4].
dig(5)--> [5].
dig(6)--> [6].
dig(7)--> [7].
dig(8)--> [8].
dig(9)--> [9].

% Evaluator

% Lookup 

lookup(I,[],_) :- nl,fail.
lookup(I,[(I,Val)|_],Val).
lookup(I,[H|T],Val) :- lookup(I,T,Val).

% Update 

update(I,[],NewVal,[(I,NewVal)]).
update(I,[(I,_)|T],NewVal,[(I,NewVal)|T]).
update(I,[H|T],NewVal,[H|NewEnv]) :- H\=(I,_),update(I,T,NewVal,NewEnv).



char_eval(I,Env,Val) :- lookup(I,Env,Val).
digit_eval(Dig,Dig).

ae_eval(t_ae(I,T),Env,NewEnv,Val) :- ae_eval(T,Env,InterEnv,Val),update(I,InterEnv,Val,NewEnv).
ae_eval(t_term_plus(A,B),Env,NewEnv,Val) :- ae_eval(A,Env,InterEnv,Val1),ae_eval(B,InterEnv,NewEnv,Val2), Val is Val1+Val2.
ae_eval(t_term_min(A,B),Env,NewEnv,Val) :- ae_eval(A,Env,InterEnv,Val1),ae_eval(B,InterEnv,NewEnv,Val2), Val is Val1-Val2.
ae_eval(t_t2_prod(A,B),Env,NewEnv,Val) :- ae_eval(A,Env,InterEnv,Val1),ae_eval(B,InterEnv,NewEnv,Val2), Val is Val1*Val2.
ae_eval(t_t2_div(A,B),Env,NewEnv,Val) :- ae_eval(A,Env,InterEnv,Val1),ae_eval(B,InterEnv,NewEnv,Val2), Val is Val1/Val2.

% block(t_b(Td,Tc)) --> ['start'],declaration(Td),[';'],command(Tc),['finish'].

block_eval(t_b(Td,Tc),Env,Env1) :- declaration_eval(Td,Env,ImdEnv),command(Tc,ImdEnv,Env1). 

% declaration(t_ass_decl(A,D)) --> ass_variable(A),[';'],declaration(D).
% declaration(t_decl_decl(A,D)) --> decl_variable(A),[';'],declaration(D).
% declaration(t_ass_decl(A)) --> ass_variable(A).
% declaration(t_decl_decl(A)) --> decl_variable(A).

declaration_eval(t_ass_decl(A,D),Env,Env1):- ass_variable_eval(A,Env,ImdEnv),declaration(B,ImdEnv,Env1).
declaration_eval(t_decl_decl(A,D),Env,Env1) :- decl_variable_eval(A,Env,ImdEnv),declaration(B,ImdEnv,Env1).
declaration_eval(t_ass_decl(A),Env,Env1):- ass_variable_eval(A,Env,Env1).
declaration_eval(t_decl_decl(A),Env,Env1) :- decl_variable_eval(A,Env, Env1).

% ass_variable(t_ass_variable_int(Tid,Tnum)) --> ['int'],identifier(Tid),['='],num(Tnum).
% ass_variable(t_ass_variable_bool(Tid,Tbval)) --> ['bool'],identifier(Tid),['='],bool_val(Tbval).
% ass_variable(t_ass_variable_st(Tid,Tstr)) --> ['st'],identifier(Tid),['='],str(Tstr).

ass_variable_eval(t_ass_variable_int(Tid,Tnum),Env,Env1):- digit_eval(N, Val), ,update(I,ImdEnv,Val,Env1).
ass_variable_eval(t_ass_variable_bool(Tid,Tbval),Env,Env1):-