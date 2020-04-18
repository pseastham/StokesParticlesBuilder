# Note that this script can accept some limited command-line arguments, run
# `julia build_tarballs.jl --help` to see a usage message.
using BinaryBuilder, Pkg

name = "figtree"
version = v"1.0.0"

# Collection of sources required to complete build
sources = [
    ArchiveSource("https://sourceforge.net/projects/figtree/files/figtree-0.9.3.zip", "f0b39cef8a0ab56075cce0c656b1b4327d9bd1acb31aad927241974ac4d10d82")
]

# Bash recipe for building across all platforms
script = raw"""
cd $WORKSPACE/srcdir
mkdir ../destdir/lib64
cd figtree-0.9.3/
make
cd lib/
mv libann_figtree_version.so ../../../destdir/lib64/libann_figtree_version.so
mv libfigtree.so ../../../destdir/lib64/libfigtree.so
"""

# These are the platforms we will build for by default, unless further
# platforms are passed in on the command line
platforms = [
    Linux(:x86_64, libc=:glibc)
]

# The products that we will ensure are always built
products = [
    LibraryProduct("libfigtree", :libfigtree)
]

# Dependencies that must be installed before this package can be built
dependencies = Dependency[
]

# Build the tarballs, and possibly a `build.jl` as well.
build_tarballs(ARGS, name, version, sources, script, platforms, products, dependencies)