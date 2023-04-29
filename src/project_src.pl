% DCG - Definite Clause Grammar
%:- use_rendering(svgtree).
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
new_command(t_cmdblk(Tbl)) --> block(Tbl).

% BE ::= SUB and BE | SUB or BE | not BE | SUB
be(t_be_and(Sub,BE))--> sub(Sub),['and'],be(BE).
be(t_be_or(Sub,BE))--> sub(Sub),['or'],be(BE).
be(t_sub_not(Sub))--> ['not'],be(Sub).
be(Sub)--> sub(Sub).

% SUB ::= AE==AE | AE>AE | AE<AE | AE>= AE | AE<=AE | AE!= AE  | BOOL_VAL 
sub(t_sub_eq(AE1,AE2))--> ae(AE1),['=='],ae(AE2).
sub(t_sub_greaterthan(AE1,AE2))--> ae(AE1),['>'],ae(AE2).
sub(t_sub_lessthan(AE1,AE2))--> ae(AE1),['<'],ae(AE2).
sub(t_sub_gteqto(AE1,AE2))--> ae(AE1),['>='],ae(AE2).
sub(t_sub_lteqto(AE1,AE2))--> ae(AE1),['<='],ae(AE2).
sub(t_sub_noteq(AE1,AE2))--> ae(AE1),['!='],ae(AE2).
sub(t_sub_bool(Bool))--> bool_val(Bool).

% AE ::= I:=T|T
ae(t_ae(ID,T))--> identifier(ID),['='],t(T).
ae(T)--> t(T).

% T::=T + T2 | T – T2 | T2
t(t_term_plus(T,T2))--> t(T),['+'],t2(T2).
t(t_term_min(T,T2))--> t(T),['-'],t2(T2).
t(T2)--> t2(T2).

% T2::= T2 * T3 | T2 / T3 | T3
t2(t_t2_prod(T2,T3))--> t2(T2),['*'],t3(T3).
t2(t_t2_div(T2,T3))--> t2(T2),['/'],t3(T3).
t2(T3)--> t3(T3).

% T3 ::= (AE)| I |N
t3(t_t3_par(AE))--> ['('],ae(AE),[')'].
t3(t_identifier(ID))--> identifier(ID).
t3(t_num(Num))--> num(Num).

% EXP ::= AE;EXP | BE;EXP | STRING; EXP | AE | BE | STRING
exp(t_exp(AE,Exp))--> ae(AE),[';'],exp(Exp).
exp(t_exp(BE,Exp))--> be(BE),[';'],exp(Exp).
exp(t_exp(Str,Exp))--> str(Str),[';'],exp(Exp).
exp(t_exp(AE))--> ae(AE).
exp(t_exp(BE))--> be(BE).
exp(t_exp(Str))--> str(Str).

% STRING ::= "TEMP"
str(t_str(Temp))-->['"'],temp(Temp),['"'].

% TEMP ::= I TEMP | N TEMP | I | N
temp(t_temp(CH))--> identifier(CH).
temp(t_temp(Num))--> num(Num).
temp(t_temp(CH,Temp))--> identifier(CH),temp(Temp).
temp(t_temp(Num,Temp))--> num(Num),temp(Temp).
% atom_num(AN) --> atom(A), num(N), {atom_number(A, N), AN =.. [A, N]}.


% BOOL_VAL ::= true|false 
bool_val(true)--> ['true'].
bool_val(false)--> ['false'].


% I ::= x | y | z | u | v
identifier(I) --> [I], {atom(I)}.

% N ::= 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9
num(N) --> [N], {integer(N)}.



% Evaluator

% Lookup 

lookup(I,[],_) :- nl,fail.
lookup(I,[(I,Val)|_],Val).
lookup(I,[H|T],Val) :- lookup(I,T,Val).

% Update 

update(I,[],NewVal,[(I,NewVal)]).
update(I,[(I,_)|T],NewVal,[(I,NewVal)|T]).
update(I,[H|T],NewVal,[H|NewEnv]) :- H\=(I,_),update(I,T,NewVal,NewEnv).

% Program Evaluator

program_eval(t_p(A),EnvOut) :- block_eval(A,[],EnvOut).

% block(t_b(Td,Tc)) --> ['start'],declaration(Td),[';'],command(Tc),['finish'].

block_eval(t_b(Td,Tc),Env,Env1) :- declaration_eval(Td,Env,ImdEnv),command_eval(Tc,ImdEnv,Env1). 


% declaration(t_ass_decl(A,D)) --> ass_variable(A),[';'],declaration(D).
% declaration(t_decl_decl(A,D)) --> decl_variable(A),[';'],declaration(D).
% declaration(t_ass_decl(A)) --> ass_variable(A).
% declaration(t_decl_decl(A)) --> decl_variable(A).

declaration_eval(t_ass_decl(A,D),Env,Env1):- ass_variable_eval(A,Env,ImdEnv),declaration(D,ImdEnv,Env1).
declaration_eval(t_decl_decl(A,D),Env,Env1) :- decl_variable_eval(A,Env,ImdEnv),declaration_eval(D,ImdEnv,Env1).
declaration_eval(t_ass_decl(A),Env,Env1):- ass_variable_eval(A,Env,Env1).
declaration_eval(t_decl_decl(A),Env,Env1) :- decl_variable_eval(A,Env, Env1).

% ass_variable(t_ass_variable_int(Tid,Tnum)) --> ['int'],identifier(Tid),['='],num(Tnum).
% ass_variable(t_ass_variable_bool(Tid,Tbval)) --> ['bool'],identifier(Tid),['='],bool_val(Tbval).
% ass_variable(t_ass_variable_st(Tid,Tstr)) --> ['st'],identifier(Tid),['='],str(Tstr).

ass_variable_eval(t_ass_variable_int(Tid,Tnum),Env,Env1):- num_eval(Tnum, Val),update(Tid,Env,Val,Env1).
ass_variable_eval(t_ass_variable_bool(Tid,Tbval),Env,Env1):- boolval_eval(Tbval,Val),update(Tid,Env,Val,Env1).
ass_variable_eval(t_ass_variable_st(Tid,Tstr),Env,Env1):-str_eval(Tstr,Env,Val),update(Tid,Env,Val,Env1).

% decl_variable(t_decl_variable_int(Tid)) --> ['int'],identifier(Tid).
% decl_variable(t_decl_variable_bool(Tid)) --> ['bool'],identifier(Tid).
% decl_variable(t_decl_variable_st(Tid)) --> ['st'],identifier(Tid).

decl_variable_eval(t_decl_variable_int(_Tid),Env,Env).
decl_variable_eval(t_decl_variable_bool(_Tid),Env,Env).
decl_variable_eval(t_decl_variable_st(_Tid),Env,Env).

% command(t_cmd(Tnc,Tcmd)) --> new_command(Tnc),[';'], command(Tcmd).
% command(t_cmd(Tnc)) --> new_command(Tnc).

command_eval(t_cmd(Tnc,Tcmd),Env,Env1):- new_command_eval(Tnc,Env,ImdEnv),command_eval(Tcmd,ImdEnv,Env1).
command_eval(t_cmd(Tnc),Env,Env1) :- new_command_eval(Tnc,Env,Env1).


% new_command(t_ncmd(Tid,Tae)) --> identifier(Tid),['='],ae(Tae).
% new_command(t_ncmd_if(Tbe,Tcmd,Tcmd1)) --> ['if'],be(Tbe),['then'],command(Tcmd),['else'],command(Tcmd1),['fi'].
% new_command(t_ncmd_while(Tbe,Tcmd)) --> ['while'],be(Tbe),['begin'],command(Tcmd),['end'].
% new_command(t_ncmd_for(Tid,Tae,Tbe,Tae1,Tcmd)) --> ['for'],['('],['int'],identifier(Tid),['='],ae(Tae),[';'],be(Tbe),[';'],ae(Tae1),[')'],['begin'],command(Tcmd),['end'].
% new_command(t_ncmd_for_range(Tid,Tnum1,Tnum2,Tcmd)) --> ['for'],identifier(Tid),['in'],['range'],['('],num(Tnum1),[','],num(Tnum2),[')'],['begin'],command(Tcmd),['end'].
% new_command(t_ncmd_ternary(Tbe,Tcmd,Tcmd1)) --> be(Tbe),['?'],command(Tcmd),[':'],command(Tcmd1).
% new_command(t_ncmd_print(Texp)) --> ['print'],['('],exp(Texp),[')'].

new_command_eval(t_ncmd(Tid,Tae),Env,Env1):- ae_eval(Tae,Env,ImdEnv,Val),update(Tid,ImdEnv,Val,Env1).
new_command_eval(t_ncmd_if(Tbe,Tcmd,_),Env,Env1):-booleanexpression_eval(Tbe,true,Env,ImdEnv),command_eval(Tcmd,ImdEnv,Env1).
new_command_eval(t_ncmd_if(Tbe,_,Tcmd1),Env,Env1):-booleanexpression_eval(Tbe,false,Env,ImdEnv),command_eval(Tcmd1,ImdEnv,Env1).
new_command_eval(t_ncmd_while(Tbe,_Tcmd),Env,Env1):-booleanexpression_eval(Tbe,false,Env,Env1).
new_command_eval(t_ncmd_while(Tbe,Tcmd),Env,Env1):- booleanexpression_eval(Tbe,true,Env,ImdEnv),command_eval(Tcmd,ImdEnv,ImdEnv1),new_command_eval(t_ncmd_while(Tbe,Tcmd),ImdEnv1,Env1).

new_command_eval(t_ncmd_for(Tid,Tae,Tbe,_Tae1,_Tcmd),Env,Env1):-ae_eval(Tae,Env,ImdEnv,Val),update(Tid,ImdEnv,Val,ImdEnv2),booleanexpression_eval(Tbe,false,ImdEnv2,Env1).
new_command_eval(t_ncmd_for(Tid,Tae,Tbe,Tae1,Tcmd),Env,Env1):-ae_eval(Tae,Env,ImdEnv,Val),update(Tid,ImdEnv,Val,ImdEnv2),booleanexpression_eval(Tbe,true,ImdEnv2,ImdEnv3),command_eval(Tcmd,ImdEnv3,ImdEnv4),ae_eval(Tae1,ImdEnv4,ImdEnv5,Val1),update(Tid,ImdEnv5,Val1,ImdEnv6),new_command_eval(t_ncmd_for(Tid,Tbe,Tae1,Tcmd),ImdEnv6,Env1).
new_command_eval(t_ncmd_for(_,Tbe,_,_),Env,Env1):- booleanexpression_eval(Tbe,false,Env,Env1).
new_command_eval(t_ncmd_for(Tid,Tbe,Tae1,Tcmd),Env,Env1):- booleanexpression_eval(Tbe,true,Env,ImdEnv),command_eval(Tcmd,ImdEnv,ImdEnv4),ae_eval(Tae1,ImdEnv4,ImdEnv5,Val1),update(Tid,ImdEnv5,Val1,ImdEnv6),new_command_eval(t_ncmd_for(Tid,Tae1,Tbe,Tae1,Tcmd),ImdEnv6,Env1).


new_command_eval(t_ncmd_for_range(Tid,Tnum1,Tnum2,_),Env,Env1):- update(Tid,Env,Tnum1,ImdEnv),check_boolean_expresson_for(Tid,Tnum2,false,ImdEnv,Env1).
new_command_eval(t_ncmd_for_range(Tid,Tnum1,Tnum2,Tcmd),Env,Env1):- update(Tid,Env,Tnum1,ImdEnv),check_boolean_expresson_for(Tid,Tnum2,true,ImdEnv,ImdEnv1),command_eval(Tcmd,ImdEnv1,ImdEnv2),increment_expression_for(Tid,ImdEnv2,ImdEnv3),new_command_eval(t_ncmd_for_range(Tid,Tnum2,Tcmd),ImdEnv3,Env1).
new_command_eval(t_ncmd_for_range(Tid,Tnum2,_),Env,Env1):-check_boolean_expresson_for(Tid,Tnum2,false,Env,Env1).
new_command_eval(t_ncmd_for_range(Tid,Tnum2,Tcmd),ImdEnv,Env1):-check_boolean_expresson_for(Tid,Tnum2,true,ImdEnv,ImdEnv1),command_eval(Tcmd,ImdEnv1,ImdEnv2),increment_expression_for(Tid,ImdEnv2,ImdEnv3),new_command_eval(t_ncmd_for_range(Tid,Tnum2,Tcmd),ImdEnv3,Env1).
new_command_eval(t_ncmd_ternary(Tbe,Tcmd,_Tcmd1),Env,Env1):- booleanexpression_eval(Tbe,true,Env,ImdEnv),command_eval(Tcmd,ImdEnv,Env1).
new_command_eval(t_ncmd_ternary(Tbe,_Tcmd,Tcmd1),Env,Env1):- booleanexpression_eval(Tbe,false,Env,ImdEnv),command_eval(Tcmd1,ImdEnv,Env1).
new_command_eval(t_ncmd_print(Texp),Env,Env1):-exp_eval(Texp,Env,Env1).
new_command_eval(t_cmdblk(Tb1),Env,Env1):-block_eval(Tb1,Env,Env1).

% Check Boolean Expression for i in range

check_boolean_expresson_for(A,B,true,Env,Env):- lookup(A,Env,Val),Val < B.
check_boolean_expresson_for(A,B,false,Env,Env):- lookup(A,Env,Val),Val > B.

increment_expression_for(A,Env,Env1):- lookup(A,Env,Val1),Val is Val1 + 1,update(A,Env,Val,Env1).

% % EXP ::= AE;EXP | BE;EXP | STRING; EXP | AE | BE | STRING 
% exp(t_exp(AE,Exp))--> ae(AE),[';'],exp(Exp).
% exp(t_exp(BE,Exp))--> be(BE),[';'],exp(Exp).
% exp(t_exp(Str,Exp))--> str(Str),[';'],exp(Exp).
% exp(t_exp(AE))--> ae(AE).
% exp(t_exp(BE))--> be(BE).
% exp(t_exp(Str))--> str(Str).

exp_eval(t_exp(AE, Exp), Env,Env1) :- ae_eval(AE,Env,ImdEnv,Val), exp_eval(Exp,ImdEnv,Env1),write(Val),nl.
exp_eval(t_exp(BE, Exp), Env,Env1) :- booleanexpression_eval(BE,Val,Env,ImdEnv), exp_eval(Exp,ImdEnv,Env1),write(Val),nl.
exp_eval(t_exp(Str, Exp), Env,Env1) :- str_eval(Str, Env, Val), exp_eval(Exp, Env, Env1),write(Val),nl.
exp_eval(t_exp(AE), Env,Env1) :- ae_eval(AE,Env,Env1,Val),write(Val),nl.
exp_eval(t_exp(BE),Env,Env1) :- booleanexpression_eval(BE,Val,Env,Env1),write(Val),nl.
exp_eval(t_exp(Str), Env, Env ) :- str_eval(Str, Env, Val),write(Val),nl.


% BE ::= SUB and BE | SUB or BE | SUB
% be(t_be_and(Sub,BE))--> sub(Sub),['and'],be(BE).
% be(t_be_or(Sub,BE))--> sub(Sub),['or'],be(BE).
% be(t_sub_not(Sub))--> ['not'],BE(Sub).
% be(t_be(Sub))--> sub(Sub).
% % SUB ::= AE==AE | AE>AE | AE<AE | AE>= AE | AE<=AE | AE!= AE | not SUB | BOOL_VAL 
% sub(t_sub_eq(AE1,AE2))--> ae(AE1),['=='],ae(AE2).
% sub(t_sub_greaterthan(AE1,AE2))--> ae(AE1),['>'],ae(AE2).
% sub(t_sub_lessthan(AE1,AE2))--> ae(AE1),['<'],ae(AE2).
% sub(t_sub_gteqto(AE1,AE2))--> ae(AE1),['>='],ae(AE2).
% sub(t_sub_lteqto(AE1,AE2))--> ae(AE1),['<='],ae(AE2).
% sub(t_sub_noteq(AE1,AE2))--> ae(AE1),['!='],ae(AE2).
% sub(t_sub_bool(Bool))--> bool_val(Bool).



booleanexpression_eval(t_be_and(Sub, BE), Val,Env,Env1) :- booleanexpression_eval(Sub, Sub_Val,Env,ImdEnv), booleanexpression_eval(BE,BE_Val,ImdEnv,Env1), and_eval(Sub_Val,BE_Val,Val).
booleanexpression_eval(t_be_or(Sub,BE),Val,Env,Env1) :- booleanexpression_eval(Sub, Sub_Val,Env,ImdEnv), booleanexpression_eval(BE,BE_Val,ImdEnv,Env1), or_eval(Sub_Val,BE_Val,Val).
booleanexpression_eval(t_sub_not(Sub), Val,Env,Env1) :- booleanexpression_eval(Sub,Sub_Val,Env,Env1), opp_eval(Sub_Val,Val).
booleanexpression_eval(t_sub_eq(AE1, AE2), Val,Env,Env1) :- ae_eval(AE1,Env,ImdEnv,Val1), ae_eval(AE2, ImdEnv,Env1,Val2), check_bool_equal(Val1,Val2,Val).
booleanexpression_eval(t_sub_greaterthan(AE1, AE2), Val,Env,Env1) :- ae_eval(AE1, Env,ImdEnv,Val1), ae_eval(AE2, ImdEnv,Env1,Val2), check_bool_greater_than(Val1,Val2,Val).
booleanexpression_eval(t_sub_lessthan(AE1, AE2), Val,Env,Env1) :- ae_eval(AE1,Env,ImdEnv, Val1), ae_eval(AE2,ImdEnv,Env1, Val2), check_bool_less_than(Val1,Val2,Val).
booleanexpression_eval(t_sub_gteqto(AE1, AE2), Val,Env,Env1) :- ae_eval(AE1,Env,ImdEnv, Val1), ae_eval(AE2,ImdEnv,Env1, Val2), check_bool_gteq(Val1,Val2,Val).
booleanexpression_eval(t_sub_lteqto(AE1, AE2), Val,Env,Env1) :- ae_eval(AE1,Env,ImdEnv, Val1), ae_eval(AE2,ImdEnv,Env1, Val2), check_bool_lteq(Val1,Val2,Val).
booleanexpression_eval(t_sub_noteq(AE1, AE2), Val,Env,Env1) :- ae_eval(AE1,Env,ImdEnv, Val1), ae_eval(AE2,ImdEnv,Env1, Val2), check_bool_equal(Val1,Val2,Val3),opp_eval(Val3,Val).
booleanexpression_eval(t_sub_bool(true), true,Env,Env).
booleanexpression_eval(t_sub_bool(false), false,Env,Env).
and_eval(true,true,true).
and_eval(false,_,false).
and_eval(true,false,false).

or_eval(false,false,false).
or_eval(false,true,true).
or_eval(true,_,true).

opp_eval(true,false).
opp_eval(false,true).

check_bool_equal(A,B,true):-A = B.
check_bool_equal(A,B,false):-A\=B.

check_bool_less_than(A,B,true):- A < B.
check_bool_less_than(A,B,false):- A > B.


check_bool_greater_than(A,B,true):- A > B.
check_bool_greater_than(A,B,false):- A < B.

check_bool_lteq(A,B,true):-A =< B.
check_bool_lteq(A,B,false):-A >= B.

check_bool_gteq(A,B,true):-A >= B.
check_bool_gteq(A,B,false):-A =< B.

% ae(t_ae(ID,T))--> identifier(ID),['='],t(T).
% ae(T)--> t(T).
% t(t_term_plus(T,T2))--> t(T),['+'],t2(T2).
% t(t_term_min(T,T2))--> t(T),['-'],t2(T2).
% t(T2)--> t2(T2).
% t2(t_t2_prod(T2,T3))--> t2(T2),['*'],t3(T3).
% t2(t_t2_div(T2,T3))--> t2(T2),['/'],t3(T3).
% t2(T3)--> t3(T3).
% t3(t_t3_par(AE))--> ['('],ae(AE),[')'].
% t3(t_t3(ID))--> identifier(ID).
% t3(t_t3(Num))--> num(Num).

ae_eval(t_ae(I,T),Env,NewEnv,Val) :- ae_eval(T,Env,InterEnv,Val),update(I,InterEnv,Val,NewEnv).
ae_eval(t_term_plus(A,B),Env,NewEnv,Val) :- ae_eval(A,Env,InterEnv,Val1),ae_eval(B,InterEnv,NewEnv,Val2), Val is Val1+Val2.
ae_eval(t_term_min(A,B),Env,NewEnv,Val) :- ae_eval(A,Env,InterEnv,Val1),ae_eval(B,InterEnv,NewEnv,Val2), Val is Val1-Val2.
ae_eval(t_t2_prod(A,B),Env,NewEnv,Val) :- ae_eval(A,Env,InterEnv,Val1),ae_eval(B,InterEnv,NewEnv,Val2), Val is Val1*Val2.
ae_eval(t_t2_div(A,B),Env,NewEnv,Val) :- ae_eval(A,Env,InterEnv,Val1),ae_eval(B,InterEnv,NewEnv,Val2), Val is Val1/Val2.
ae_eval(t_exprbrkt(A),Env,Env1,Val):-ae_eval(A,Env,Env1,Val).
ae_eval(t_identifier(I),Env,Env,Val):-identifier_eval(I,Env,Val).
ae_eval(t_num(N),Env,Env,Val):-num_eval(N,Val).


% % STRING ::= "TEMP"
% str(t_str(Temp))-->['"'],temp(Temp),['"'].

str_eval(t_str(Temp),Env,Val) :- temp_eval(Temp,Env,Val).

% % TEMP ::= CH TEMP | N TEMP | CH | N
% temp(t_temp(CH))--> ch(CH).
% temp(t_temp(Num))--> num(Num).
% temp(t_temp(CH,Temp))--> ch(CH),temp(Temp).
% temp(t_temp(Num,Temp))--> num(Num),temp(Temp).

temp_eval(t_temp(CH), Env, Val) :- identifier_eval(CH, Env, Val).
temp_eval(t_temp(Num), _, Val) :- num_eval(Num, Val).
temp_eval(t_temp(CH, Temp), Env, Val) :- identifier_eval(CH, Env, CH_Val), temp_eval(Temp, Env, Temp_Val), atomic_concat(CH_Val,Temp_Val, Val).
temp_eval(t_temp(Num, Temp), Env, Val) :- num_eval(Num, Num_Val), temp_eval(Temp, Env, Temp_Val), atomic_concat(Num_Val,Temp_Val, Val).


% bool_val(true)--> ['true'].
% bool_val(false)--> ['false'].

boolval_eval(true,true).
boolval_eval(false,false).

% identifier
identifier_eval(I,Env,Val) :- lookup(I,Env,Val).


% Digit Eval
num_eval(Dig,Dig).