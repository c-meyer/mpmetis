import sys
import subprocess
from setuptools import Extension, setup

BUILD_METIS = False


args = sys.argv[1:]
build_commands = ('develop', 'build', 'build_ext', 'build_py',
                  'build_clib', 'build_scripts', 'bdist_wheel', 'bdist_rpm',
                  'bdist_wininst', 'bdist_msi', 'bdist_mpkg')

for command in build_commands:
    if command in args:
        BUILD_METIS = True

if BUILD_METIS:
    if sys.platform.startswith('linux'):
        subprocess.run(['sh', 'build.sh'], check=True)
    elif sys.platform.startswith('darwin'):
        subprocess.run(['sh', 'build.sh'], check=True)
    else:
        raise NotImplementedError('Your operating system is not supported'
                                  'by setup.py. Try to build the package'
                                  'by yourself.')

if 'sdist' in args:
    IS_SDIST = True
    from Cython.Build import cythonize
    srcfile = "src/mpmetis/mod_part_mesh_nodal.pyx"
else:
    IS_SDIST = False
    srcfile = "src/mpmetis/mod_part_mesh_nodal.c"

macros = ("NPY_NO_DEPRECATED_API", "NPY_1_7_API_VERSION")
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
