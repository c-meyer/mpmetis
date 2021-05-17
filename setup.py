from setuptools import Extension, setup
from Cython.Build import cythonize

macros = ("NPY_NO_DEPRECATED_API", "NPY_1_7_API_VERSION")

extensions = [
    Extension("mpmetis.mod_part_mesh_nodal",
              ["src/mpmetis/mod_part_mesh_nodal.pyx"],
              include_dirs=["metis-5.1.0/include"],
              libraries=["metis"],
              library_dirs=["lib/lib"],
              define_macros=[macros]),
]
setup(
    ext_modules=cythonize(extensions),
)
