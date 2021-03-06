local common = common;
local tcp    = require "common.tcp"

-- client sessions manager.
local LSessions = {

}

-- create session.
function LSessions:create(session)
    if self[session] then return end

    -- get session info.
    local ip, port = common.get_session_info(session);
    local sess = { -- new session.
        session   = session,
        ip        = ip,
        port      = port,
        
        -- Send, GetIP, GetPort, GetSession function.
        Send      = function(self, msgid, data)
            tcp:ClientTo(self.session, msgid, data);
        end,
        GetIP     = function(self) return self.ip end,
        GetPort   = function(self) return self.port end,
        GetSession= function(self) return self.session end,
    };
    self[session] = sess;
    return sess;
end

-- get session.
function LSessions:get(session)
    return self[session];
end

-- remove.
function LSessions:remove(session)
    self[session] = nil;
end

return LSessions;