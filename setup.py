import sys
from os.path import join, isdir, exists
import fileinput
import subprocess
from setuptools import Extension, setup


def metis_update_header():
    # Replace real data type to 64 bit (double)
    metis_h_fname = join('metis-5.1.0', 'include', 'metis.h')
    for line in fileinput.input(metis_h_fname, inplace=True):
        if line.startswith('#define REALTYPEWIDTH'):
            line = line.replace('32', '64')
        print('{}'.format(line), end='')


BUILD_METIS = False


args = sys.argv[1:]
build_commands = ('develop', 'build', 'build_ext', 'build_py',
                  'build_clib', 'build_scripts', 'bdist_wheel', 'bdist_rpm',
                  'bdist_wininst', 'bdist_msi', 'bdist_mpkg', 'install')

for command in build_commands:
    if command in args:
        BUILD_METIS = True

if BUILD_METIS:
    if sys.platform.startswith('linux'):
        if not isdir('metis-5.1.0'):
            subprocess.run(['sh', 'get_metis.sh'], check=True)
        metis_update_header()
        subprocess.run(['sh', 'build.sh'], check=True)
    elif sys.platform.startswith('darwin'):
        if not isdir('metis-5.1.0'):
            subprocess.run(['sh', 'get_metis.sh'], check=True)
        metis_update_header()
        subprocess.run(['sh', 'build.sh'], check=True)
    else:
        raise NotImplementedError('Your operating system is not supported'
                                  'by setup.py. Try to build the package'
                                  'by yourself.')

srcfile_extension = '.pyx'
srcfile_base = 'src/mpmetis/mod_part_mesh_nodal'

if 'sdist' in args:
    BUILD_CYTHON = True
    srcfile_extension = '.pyx'
else:
    BUILD_CYTHON = False
    srcfile_extension = '.c'
    if not exists(srcfile_base + srcfile_extension):
        print('Could not find {}. Try to cythonize .pyx'.format(srcfile_base + srcfile_extension))
        BUILD_CYTHON = True
        srcfile_extension = '.pyx'

macros = ("NPY_NO_DEPRECATED_API", "NPY_1_7_API_VERSION")
extensions = [Extension("mpmetis.mod_part_mesh_nodal",
                        [srcfile_base + srcfile_extension],
                        include_dirs=["metis-5.1.0/include"],
                        libraries=["metis"],
                        library_dirs=["lib/lib"],
                        define_macros=[macros])]

if BUILD_CYTHON:
    from Cython.Build import cythonize
    ext_modules = cythonize(extensions)
else:
    ext_modules = extensions

setup(
    ext_modules=ext_modules
)
