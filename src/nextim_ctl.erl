%%%----------------------------------------------------------------------
%%% File    : nextim_ctl.erl
%%% Author  : Ery Lee <ery.lee@gmail.com>
%%% Purpose : NextIM Server Controller.
%%% Created : 1 May. 2009
%%% Updated : 01 Sept. 2009
%%% License : http://www.webim20.cn
%%%
%%% Copyright www.webim20.cn 2010
%%%----------------------------------------------------------------------
-module(nextim_ctl).

-author('ery.lee@gmail.com').

-export([status/1, cluster/1, mnesia/1]).  

-define(STATUS_SUCCESS, 0).

-define(STATUS_ERROR,   1).

-define(STATUS_USAGE,   2).

-define(STATUS_BADRPC,  3).

status(_Args) ->
    {InternalStatus, ProvidedStatus} = init:get_status(),
    io:format("Status: ~p.~nNode ~p is ~p.~n",
              [ProvidedStatus, node(), InternalStatus]),
    io:format("Running applications: ~p ~n", [application:which_applications()]),
    ?STATUS_SUCCESS.

cluster([SNode]) ->
    case nextim:cluster(node_name(SNode)) of
    {error, Reason}-> 
        io:format("failed to cluster with ~p, reason: ~p", [SNode, Reason]),
        ?STATUS_ERROR;
    {ok, Nodes} ->
        io:format("cluster success, nodes: ~p~n", [Nodes]),
        ?STATUS_SUCCESS
    end.

mnesia([Arg]) ->
    io:format("~p ~n", [mnesia:info()]), 
    case catch mnesia:system_info(list_to_atom(Arg)) of
	{'EXIT', Error} -> io:format("Error: ~p~n", [Error]);
	Return -> io:format("~p~n", [Return])
    end,
    ?STATUS_SUCCESS.

node_name(SNode) ->
    SNode1 = 
    case string:tokens(SNode, "@") of
    [_Node, _Server] ->
        SNode;
    _ ->
        case net_kernel:longnames() of
         true ->
             SNode ++ "@" ++ inet_db:gethostname() ++
                  "." ++ inet_db:res_option(domain);
         false ->
             SNode ++ "@" ++ inet_db:gethostname();
         _ ->
             SNode
         end
    end,
    list_to_atom(SNode1).
