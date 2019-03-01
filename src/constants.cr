module MDMALua
    enum LUA_TYPE
        TNONE           = -1
        TNIL            = 0
        TLIGHTUSERDATA  = 2
        TNUMBER         = 3
        TSTRING         = 4
        TTABLE          = 5
        TFUNCTION       = 6
        TUSERDATA       = 7
        TTHREAD         = 8
    end

    enum LUA_OP
        ADD    = 0
        SUB    = 1
        MUL    = 2
        MOD    = 3
        POW    = 4
        DIV    = 5
        IDIV   = 6
        BAND   = 7
        BOR    = 8
        BXOR   = 9
        SHL    = 10
        SHR    = 11
        UNM    = 12
        BNOT   = 13
    end

    enum LUA_COMP
        EQ = 0
        LT = 1
        LE = 2
    end

    enum LUA_GC
        STOP       = 0
        RESTART    = 1
        COLLECT    = 2
        COUNT      = 3
        COUNTB     = 4
        STEP       = 5
        SETPAUSE   = 6
        SETSTEPMUL = 7
        ISRUNNING  = 9
    end

    enum LUA_HOOK
        CALL     = 0
        RET      = 1
        LINE     = 2
        COUNT    = 3
        TAILCALL = 4
    end

    enum LUA_MASK
        CALL  = 1 << LUA_HOOK::CALL
        RET   = 1 << LUA_HOOK::RET
        LINE  = 1 << LUA_HOOK::LINE
        COUNT = 1 << LUA_HOOK::COUNT
    end
end
