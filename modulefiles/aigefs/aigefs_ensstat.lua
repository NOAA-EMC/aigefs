help([[
Build environment for GFS utilities on WCOSS2
]])

local PrgEnv_intel_ver=os.getenv("PrgEnv_intel_ver") or "8.1.0"
local intel_ver=os.getenv("intel_ver") or "19.1.3.304"
local craype_ver=os.getenv("craype_ver") or "2.7.10"
local cray_mpich_ver=os.getenv("cray_mpich_ver") or "8.1.9"
local cmake_ver= os.getenv("cmake_ver") or "3.20.2"

local jasper_ver=os.getenv("jasper_ver") or "2.0.25"
local zlib_ver=os.getenv("zlib_ver") or "1.2.11"
local libpng_ver=os.getenv("libpng_ver") or "1.6.37"
local libjpeg_ver=os.getenv("libjpeg_ver") or "9c"
local hdf5_ver=os.getenv("hdf5_ver") or "1.14.0"
local pnetcdf_ver=os.getenv("pnetcdf_ver") or "1.12.2"
local netcdf_ver=os.getenv("netcdf_ver") or "4.9.2"

local bufr_ver=os.getenv("bufr_ver") or "12.1.0"
local bacio_ver=os.getenv("bacio_ver") or "2.4.1"
local w3emc_ver=os.getenv("w3emc_ver") or "2.12.0"
local ip_ver=os.getenv("ip_ver") or "5.2.0"
local sigio_ver=os.getenv("sigio_ver") or "2.3.2"
local nemsio_ver=os.getenv("nemsio_ver") or "2.5.2"
local nemsiogfs_ver=os.getenv("nemsiogfs_ver") or "2.5.3"
local wrf_io_ver=os.getenv("wrf_io_ver") or "1.2.0"
local g2_ver=os.getenv("g2_ver") or "3.5.1"
local landsfcutil_ver=os.getenv("landsfcutil_ver") or "2.4.1"
local wgrib2_ver=os.getenv("wgrib2_ver") or "2.0.8"
local ncio_ver=os.getenv("ncio_ver") or "1.1.2"

load(pathJoin("PrgEnv-intel", PrgEnv_intel_ver))
load(pathJoin("intel", intel_ver))
load(pathJoin("craype", craype_ver))
load(pathJoin("cray-mpich", cray_mpich_ver))
load(pathJoin("cmake", cmake_ver))

load(pathJoin("jasper", jasper_ver))
load(pathJoin("zlib", zlib_ver))
load(pathJoin("libpng", libpng_ver))
load(pathJoin("libjpeg", libjpeg_ver))

--load(pathJoin("hdf5-D", hdf5_ver))
--load(pathJoin("pnetcdf-D", pnetcdf_ver))
--load(pathJoin("netcdf-D", netcdf_ver))

load(pathJoin("bufr", bufr_ver))
load(pathJoin("bacio", bacio_ver))
load(pathJoin("w3emc", w3emc_ver))
load(pathJoin("ip", ip_ver))
load(pathJoin("sigio", sigio_ver))
load(pathJoin("sfcio", sfcio_ver))
load(pathJoin("nemsio", nemsio_ver))
load(pathJoin("wrf_io", wrf_io_ver))
load(pathJoin("g2", g2_ver))
load(pathJoin("landsfcutil", landsfcutil_ver))
load(pathJoin("wgrib2", wgrib2_ver))
--load(pathJoin("ncio-A", ncio_ver))

setenv("FCMP","ftn")
setenv("LDFLAGSM","")
setenv("OMPFLAGM","")

whatis("Description: aigefs_ensstat build environment")
