exp-->ae,[';'],exp | be,[';'],exp | str,[';'],exp | num,[';'],exp | identifier,[';'],exp | ae | be | str | num | identifier.
str-->['"'],temp,['"'].
temp-->ch,temp | num,temp | ch | num.
be-->sub,['and'],be | sub,['or'],be | sub.
sub-->ae,['=='],ae | ae,['>'],ae | ae,['<'],ae | ae,['>='],ae | ae,['<='],ae | ae,['!='],ae | ['not'],sub | bool_val.
bool_val-->['true'] | ['false'].
ae-->identifier,[':='],t | t.
t-->t,'+',t2 | t,['-'],t2 | t2.
t2-->t2,['*'],t3 | t2,['/'],t3 | t3.
t3-->['('],ae,[')'] | identifier | num.
identifier-->ch,identifier | ch.
ch-->['a'] | ['b'] | ['c'] | ['d'] | ['e'] | ['f'] | ['g'] | ['h'] | ['i'] | ['j'] | ['k'] | ['l'] | ['m'] | ['n'] | ['o'] | ['p'] | ['q'] | ['r'] | ['s'] | ['t'] | ['u'] | ['v'] | ['w'] | ['x'] | ['y'] | ['z'].
num--> dig,num | dig.
dig-->['0'] | ['1'] | ['2'] | ['3'] | ['4'] | ['5'] | ['6'] | ['7'] | ['8'] | ['9'].