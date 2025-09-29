list(APPEND fortran_src
  ensstat.f90
  init_parm.f90
  printinfr.f90
  isrchne.f90
  EPDF.f
  SORTMM.f
)

set(exe_name ensstat.x)
add_executable(${exe_name} ${fortran_src})
target_link_libraries(${exe_name} PRIVATE bacio::bacio_4
                                          w3emc::w3emc_4
                                          g2::g2_d)

install(TARGETS ${exe_name} RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR})
