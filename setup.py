import sys
from setuptools import Extension, setup


macros = ("NPY_NO_DEPRECATED_API", "NPY_1_7_API_VERSION")

args = sys.argv[1:]
if 'sdist' in args:
    IS_SDIST = True
    from Cython.Build import cythonize
    srcfile = "src/mpmetis/mod_part_mesh_nodal.pyx"
else:
    IS_SDIST = False
    srcfile = "src/mpmetis/mod_part_mesh_nodal.c"

extensions = [Extension("mpmetis.mod_part_mesh_nodal",
                        [srcfile],
                        include_dirs=["metis-5.1.0/include"],
                        libraries=["metis"],
                        library_dirs=["lib/lib"],
                        define_macros=[macros])]

if IS_SDIST:
    ext_modules = cythonize(extensions)
else:
    ext_modules = extensions

setup(
    ext_modules=ext_modules
)
