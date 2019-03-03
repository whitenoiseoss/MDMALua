@[Link("lua")]
lib LUA_API
    # typedef struct lua_State
    type LState = Void*

    alias LCFunction = (LState -> LibC::Int)

    # #define LUA_NUMBER double
    alias LNumber = LibC::Double
    # #define LUA_INTEGER __int64
    alias LInteger = LibC::Long
    alias LUInteger = LibC::UInt

    alias PtrdiffT = LInteger

    alias LAlloc = (Void*, Void*, LibC::SizeT, LibC::SizeT -> Void*)
    alias LReader = (LState, Void*, LibC::SizeT* -> LibC::Char*)
    alias LWriter = (LState, Void*, LibC::SizeT, Void* -> LibC::Int)

    alias Hook = (LState, LDebug* -> Void)

    # typedef struct global_State
    # struct LGlobalState
    #     # struct lua_State *mainthread
    #     mainthread : LState
    #     currentthread
    # end

    struct LDebug
        event : LibC::Int
        name : LibC::Char*
        namewhat : LibC::Char*
        what : LibC::Char*
        source : LibC::Char*
        currentline : LibC::Int
        linedefined : LibC::Int
        lastlinedefined : LibC::Int
        nups : UInt8
        nparams : UInt8
        isvararg : LibC::Char
        istailcall : LibC::Char
        short_src : LibC::Char[60]
        i_ci : Void*
    end

    # state manipulation
    fun lua_newstate  = luaL_newstate : LState
    fun lua_close     = lua_close(l : LState)
    fun lua_newthread = lua_newthread(l : LState) : LState

    # basic stack manipulation
    fun lua_absindex   = lua_absindex(l : LState, idx : LibC::Int) : LibC::Int
    fun lua_gettop     = lua_gettop(l : LState) : LibC::Int
    fun lua_settop     = lua_settop(l : LState, idx : LibC::Int)
    fun lua_pushvalue  = lua_pushvalue(l : LState, idx : LibC::Int)
    fun lua_rotate     = lua_rotate(l : LState, idx : LibC::Int, n : LibC::Int)
    fun lua_copy       = lua_copy(l : LState, fromidx : LibC::Int, toidx : LibC::Int)
    fun lua_checkstack = lua_checkstack(l : LState, n : LibC::Int) : LibC::Int

    # access functions (stack -> C)
    fun lua_isnumber   = lua_isnumber(l : LState, idx : LibC::Int) : LibC::Int
    fun lua_isstring   = lua_isstring(l : LState, idx : LibC::Int) : LibC::Int
    fun lua_isfunction = lua_isfunction(l : LState, idx : LibC::Int) : LibC::Int
    fun lua_isinteger  = lua_isinteger(l : LState, idx : LibC::Int) : LibC::Int
    fun lua_isuserdata = lua_isuserdata(l : LState, idx : LibC::Int) : LibC::Int
    fun lua_type       = lua_type(l : LState, idx : LibC::Int) : LibC::Int
    fun lua_typename   = lua_typename(l : LState, tp : LibC::Int) : LibC::Char*

    fun lua_tonumberx   = lua_tonumberx(l : LState, idx : LibC::Int, isnum : LibC::Int*) : LNumber
    fun lua_tocfunction = lua_tocfunction(l : LState, idx : LibC::Int) : LCFunction
    fun lua_toboolean   = lua_toboolean(l : LState, idx : LibC::Int) : LibC::Int
    fun lua_tolstring   = lua_tolstring(l : LState, idx : LibC::Int, len : LibC::SizeT*) : LibC::Char*
    fun lua_rawlen      = lua_rawlen(l : LState, idx : LibC::Int) : LibC::SizeT
    fun lua_toCFunction = lua_toCFunction(l : LState, idx : LibC::Int) : LCFunction
    fun lua_touserdata  = lua_touserdata(l : LState, idx : LibC::Int)
    fun lua_tothread    = lua_tothread(l : LState, idx : LibC::Int) : LState
    fun lua_topointer   = lua_topointer(l : LState, idx : LibC::Int) : Void*

    # comparison and arithmetic functions
    fun lua_arith    = lua_arith(l : LState, op : LibC::Int)
    fun lua_rawequal = lua_rawequal(l : LState, idx1 : LibC::Int, idx2 : LibC::Int) : LibC::Int
    fun lua_compare  = lua_compare(l : LState, idx1 : LibC::Int, idx2 : LibC::Int) : LibC::Int

    # push functions (C -> stack)
    fun lua_pushnil           = lua_pushnil(l : LState)
    fun lua_pushnumber        = lua_pushnumber(l : LState, n : LNumber)
    fun lua_pushinteger       = lua_pushinteger(l : LState, n : LNumber)
    fun lua_pushlstring       = lua_pushlstring(l : LState, s : LibC::Char*, len : LibC::SizeT) : LibC::Char*
    fun lua_pushstring        = lua_pushstring(l : LState, s : LibC::Char*) : LibC::Char*
    fun lua_pushvfstring      = lua_pushvfstring(l : LState, fmt : LibC::Char*, argp : Void*) : LibC::Char*
    fun lua_pushfstring       = lua_pushfstring(l : LState, fmt : LibC::Char*) : LibC::Char*
    fun lua_pushcclosure      = lua_pushcclosure(l : LState, fn : LCFunction, n : LibC::Int)
    fun lua_pushboolean       = lua_pushboolean(l : LState, b : LibC::Int)
    fun lua_pushlightuserdata = lua_pushlightuserdata(l : LState, ptr : Void*)
    fun lua_pushthread        = lua_pushthread(l : LState) : LibC::Int

    # get functions (Lua -> stack)
    fun lua_getglobal    = lua_getglobal(l : LState, name : LibC::Char*) : LibC::Int
    fun lua_gettable     = lua_gettable(l : LState, idx : LibC::Int) : LibC::Int
    fun lua_getfield     = lua_getfield(l : LState, idx : LibC::Int, k : LibC::Char*) : LibC::Int
    fun lua_geti         = lua_geti(l : LState, idx : LibC::Int, n : LInteger) : LibC::Int
    fun lua_rawget       = lua_rawget(l : LState, idx : LibC::Int) : LibC::Int
    fun lua_rawgeti      = lua_rawgeti(l : LState, idx : LibC::Int, n : LInteger) :: LibC::Int
    fun lua_rawgetp      = lua_rawgetp(l : LState, idx : LibC::Int, ptr : Void*) LibC::Int

    fun lua_createtable  = lua_createtable(l : LState, narr : LibC::Int, nrec : LibC::Int)
    fun lua_newuserdata  = lua_newuserdata(l : LState, sz : LibC::SizeT)
    fun lua_getmetatable = lua_getmetatable(l : LState, objindex : LibC::Int) : LibC::Int
    fun lua_getuservalue = lua_getuservalue(l : LState, idx : LibC::Int) : LibC::Int

    # set functions (stack -> Lua)
    fun lua_setglobal    = lua_setglobal(l : LState, name : LibC::Char*)
    fun lua_settable         = lua_settable(l : LState, idx : LibC::Int)
    fun lua_setfield         = lua_setfield(l : LState, idx : LibC::Int, k : LibC::Char*)
    fun lua_seti             = lua_seti(l : LState, idx : LibC::Int, n : LInteger)
    fun lua_rawset           = lua_rawset(l : LState, idx : LibC::Int)
    fun lua_rawseti          = lua_rawseti(l : LState, idx : LibC::Int, n : LInteger)
    fun lua_rawsetp          = lua_rawsetp(l : LState, idx : LibC::Int, ptr : Void*)
    fun lua_setmetatable = lua_setmetatable(l : LState, objindex : LibC::Int) : LibC::Int
    fun lua_setuservalue = lua_setuservalue(l : LState, idx : LibC::Int)

    # load and call functions (load and run Lua code)
    fun callk    = lua_callk(l : State, nargs : LibC::Int, nresults : LibC::Int, ctx : LibC::Int, k : LCFunction)
    fun pcallk   = lua_pcallk(l : State, nargs : LibC::Int, nresults : LibC::Int, errfunc : LibC::Int, ctx : LibC::Int, k : LCFunction) : LibC::Int
    fun lua_load = lua_load(l : LState, reader : LReader, dt : Void*, chunkname : LibC::Char*, mode : LibC::Char*) : LibC::Int
    fun dump     = lua_dump(l : State, writer : Writer, data : Void*, strip : LibC::Int) : LibC::Int
end
