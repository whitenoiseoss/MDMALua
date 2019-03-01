@[Link("lua")]
lib LUA_API
    type LState = Void*

    alias LCFunction = (LState -> LibC::Int)
    alias LNumber = LibC::Double

    alias Alloc = (Void*, Void*, LibC::SizeT, LibC::SizeT -> Void*)
    alias PtrdiffT = LibC::Long
    alias Integer = PtrdiffT
    alias Unsigned = LibC::UInt
    alias Reader = (LState, Void*, LibC::SizeT* -> LibC::Char*)
    alias Writer = (LState, Void*, LibC::SizeT, Void* -> LibC::Int)

    alias Hook = (LState, LDebug* -> Void)

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
end
