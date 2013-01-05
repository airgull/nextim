%%%----------------------------------------------------------------------
%%% File    : nextim_sup.erl
%%% Author  : Ery Lee <ery.lee@gmail.com>
%%% Purpose : nextim supervisor.
%%% Created : 19 Jan. 2009
%%% Updated : 01 Sept. 2009
%%% License : http://www.webim20.com/
%%%
%%% Copyright www.webim20.cn 2010 
%%%----------------------------------------------------------------------
-module(nextim_sup).

-author('ery.lee@gmail.com').

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

%% Helper macro for declaring children of supervisor
-define(CHILD(I, Type), {I, {I, start_link, []}, permanent, 5000, Type, [I]}).

%% ===================================================================
%% API functions
%% ===================================================================

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%% ===================================================================
%% Supervisor callbacks
%% ===================================================================

init([]) ->
    {ok, { {one_for_one, 5, 10}, []} }.

