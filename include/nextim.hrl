%%%----------------------------------------------------------------------
%%% File    : nextim.hrl
%%% Author  : Ery Lee <ery.lee@gmail.com>
%%% Purpose : nextim header file
%%% Created : 28 Jan 2009 by Ery Lee
%%% License : http://www.webim20.cn/license
%%%
%%% Copyright  www.webim20.cn 2010
%%%----------------------------------------------------------------------
-define(VERSION, "3.2").

-define(IDLE_TIMEOUT, 8000). 

-define(POLL_TIMEOUT, 28000).

-record(jid, {node, domain, resource}).

-record(subscriber, {sid, spid, ref, mon, packets=[]}).

%show: ['available', 'away', 'chat', 'dnd', 'invisible']
-record(client, {jid, name, nick, domain, show = available, status = <<"">>}).

-record(buddy, {jid, fid}).

-record(room, {rid, total = 0}).

-record(in_room, {jid, nick, rid}).

-record(route, {jid, pid, mon, domain}).

-record(site, {domain, apikey, status = pending, max_users = 0, expired = 0}).

-record(domain_meter, {domain, counter=0, binds= 0, unbinds= 0, messages = 0, statuses = 0}).

-record(status, {from, nick, to, show}).

-record(presence, {type, from, to, nick, show, status}).

-record(message, {from, nick, to, timestamp, type = <<"unicast">>, body = <<"">>, style = <<"">>}).

%% ---------------------------------
%% Logging mechanism

-define(PRINT(Format, Args),
    io:format(Format, Args)).

-define(PRINT_MSG(Msg),
    io:format(Msg)).

-define(DEBUG(Format, Args),
    lager:debug(Format, Args)).

-define(DEBUG_TRACE(Dest, Format, Args),
    lager:debug(Dest, Format, Args)).

-define(DEBUG_MSG(Msg),
    lager:debug(Msg)).

-define(INFO(Format, Args),
    lager:info(Format, Args)).

-define(INFO_TRACE(Dest, Format, Args),
    lager:info(Dest, Format, Args)).

-define(INFO_MSG(Msg),
    lager:info(Msg)).

-define(WARN(Format, Args),
    lager:warning(Format, Args)).

-define(WARN_TRACE(Dest, Format, Args),
    lager:warning(Dest, Format, Args)).

-define(WARN_MSG(Msg),
    lager:warning(Msg)).
			      
-define(WARNING(Format, Args),
    lager:warning(Format, Args)).

-define(WARNING_TRACE(Dest, Format, Args),
    lager:warning(Dest, Format, Args)).

-define(WARNING_MSG(Msg),
    lager:warning(Msg)).

-define(ERROR(Format, Args),
    lager:error(Format, Args)).

-define(ERROR_TRACE(Dest, Format, Args),
    lager:error(Dest, Format, Args)).

-define(ERROR_MSG(Msg),
    lager:error(Msg)).

-define(CRITICAL(Format, Args),
    lager:critical(Format, Args)).

-define(CRITICAL_TRACE(Dest, Format, Args),
    lager:critical(Dest, Format, Args)).

-define(CRITICAL_MSG(Msg),
    lager:critical(Msg)).
