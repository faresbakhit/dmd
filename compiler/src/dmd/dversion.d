/**
 * Defines a `Dsymbol` for `version = identifier` and `debug = identifier` statements.
 *
 * Specification: $(LINK2 https://dlang.org/spec/version.html#version-specification, Version Specification),
 *                $(LINK2 https://dlang.org/spec/version.html#debug_specification, Debug Specification).
 *
 * Copyright:   Copyright (C) 1999-2024 by The D Language Foundation, All Rights Reserved
 * Authors:     $(LINK2 https://www.digitalmars.com, Walter Bright)
 * License:     $(LINK2 https://www.boost.org/LICENSE_1_0.txt, Boost License 1.0)
 * Source:      $(LINK2 https://github.com/dlang/dmd/blob/master/src/dmd/dversion.d, _dversion.d)
 * Documentation:  https://dlang.org/phobos/dmd_dversion.html
 * Coverage:    https://codecov.io/gh/dlang/dmd/src/master/src/dmd/dversion.d
 */

module dmd.dversion;

import dmd.arraytypes;
import dmd.cond;
import dmd.dmodule;
import dmd.dscope;
import dmd.dsymbol;
import dmd.dsymbolsem;
import dmd.globals;
import dmd.identifier;
import dmd.location;
import dmd.common.outbuffer;
import dmd.visitor;

/***********************************************************
 * DebugSymbol's happen for statements like:
 *      debug = identifier;
 */
extern (C++) final class DebugSymbol : Dsymbol
{
    extern (D) this(const ref Loc loc, Identifier ident) @safe
    {
        super(loc, ident);
    }

    extern (D) this(const ref Loc loc) @safe
    {
        super(loc, null);
    }

    override DebugSymbol syntaxCopy(Dsymbol s)
    {
        assert(!s);
        auto ds = new DebugSymbol(loc, ident);
        ds.comment = comment;
        return ds;
    }

    override const(char)* kind() const nothrow
    {
        return "debug";
    }

    override inout(DebugSymbol) isDebugSymbol() inout
    {
        return this;
    }

    override void accept(Visitor v)
    {
        v.visit(this);
    }
}

/***********************************************************
 * VersionSymbol's happen for statements like:
 *      version = identifier;
 */
extern (C++) final class VersionSymbol : Dsymbol
{

    extern (D) this(const ref Loc loc, Identifier ident) @safe
    {
        super(loc, ident);
    }

    extern (D) this(const ref Loc loc) @safe
    {
        super(loc, null);
    }

    override VersionSymbol syntaxCopy(Dsymbol s)
    {
        assert(!s);
        auto ds = new VersionSymbol(loc, ident);
        ds.comment = comment;
        return ds;
    }

    override const(char)* kind() const nothrow
    {
        return "version";
    }

    override inout(VersionSymbol) isVersionSymbol() inout
    {
        return this;
    }

    override void accept(Visitor v)
    {
        v.visit(this);
    }
}
