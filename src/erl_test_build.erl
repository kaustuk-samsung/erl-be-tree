-module(erl_test_build).

- export([hello_world/0]).

hello_world() ->
        Domains = [[{exchange, int, disallow_undefined},
                {member_id, int, disallow_undefined},
                {latitude, float, allow_undefined},
                {longitude, float, allow_undefined}],
               [{width, int, disallow_undefined},
                {height, int, disallow_undefined},
                {types, int_list, disallow_undefined}]],
                
    {ok, Betree} = erl_betree:betree_make(Domains),
        Expr1 = <<"(((width = 100) and (height = 200) " 
              "and (1 in types) and true and true)) and (((exchange = 1) " 
              "and (member_id = 0) and true))">>,
    {ok, Sub} = erl_betree:betree_make_sub(Betree, 1, [], Expr1),
    ok = erl_betree:betree_insert_sub(Betree, Sub),
    Expr2 = <<"(((width = 100) and (height = 200) " 
              "and (1 in types) and true and true)) and (((exchange = 1) " 
              "and (member_id = 0) and true)) and geo_within_radius(100.0, 100.0, 10.0)">>,
    {ok, Sub2} = erl_betree:betree_make_sub(Betree, 2, [], Expr2),
    ok = erl_betree:betree_insert_sub(Betree, Sub2),

    Expr3 = <<"(((width = 100) and (height = 200) " 
              "and (1 in types) and true and true)) and (((exchange = 2) " 
              "and (member_id = 1) and true)) and geo_within_radius(100.0, 100.0, 10.0)">>,
    {ok, Sub3} = erl_betree:betree_make_sub(Betree, 3, [], Expr3),
    ok = erl_betree:betree_insert_sub(Betree, Sub3),
    
    Expr4 = <<"(((width = 100) and (height = 200) " 
              "and (1 in types) and true and true)) and (((exchange = 1) " 
              "and (member_id = 1) and true)) and geo_within_radius(100.0, 100.0, 10.0)">>,
    {ok, Sub4} = erl_betree:betree_make_sub(Betree, 4, [], Expr4),
    ok = erl_betree:betree_insert_sub(Betree, Sub4),
    erl_betree:print_betree(Betree).