# Note that this script can accept some limited command-line arguments, run
# `julia build_tarballs.jl --help` to see a usage message.
using BinaryBuilder

name = "StokesParticlesBuilder"
version = v"1.0.0"

# Collection of sources required to build StokesParticlesBuilder
sources = [
    "https://sourceforge.net/projects/figtree/files/figtree-0.9.3.zip" =>
    "f0b39cef8a0ab56075cce0c656b1b4327d9bd1acb31aad927241974ac4d10d82",

]

# Bash recipe for building across all platforms
script = raw"""
cd $WORKSPACE/srcdir
cd figtree-0.9.3/
make
cd lib
mv libann_figtree_version.so ../../../destdir/libann_figtree_version.so
mv libfigtree.so ../../../destdir/libfigtree.so

"""

# These are the platforms we will build for by default, unless further
# platforms are passed in on the command line
platforms = [
    Linux(:i686, libc=:glibc),
    Linux(:x86_64, libc=:glibc),
    Linux(:aarch64, libc=:glibc),
    Linux(:armv7l, libc=:glibc, call_abi=:eabihf),
    Linux(:powerpc64le, libc=:glibc),
    Linux(:i686, libc=:musl),
    Linux(:x86_64, libc=:musl),
    Linux(:aarch64, libc=:musl),
    Linux(:armv7l, libc=:musl, call_abi=:eabihf)
]

# The products that we will ensure are always built
products(prefix) = [
    LibraryProduct(prefix, "libfigtree", :libfigtree)
]

# Dependencies that must be installed before this package can be built
dependencies = [
    
]

# Build the tarballs, and possibly a `build.jl` as well.
build_tarballs(ARGS, name, version, sources, script, platforms, products, dependencies)

