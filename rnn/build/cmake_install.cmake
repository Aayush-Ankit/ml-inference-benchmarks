# Install script for directory: /home/aa/dpe_isca/workloads/rnn

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/home/aa/torch/install")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Release")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/luarocks/rocks/rnn/scm-1/lua/rnn" TYPE FILE FILES
    "/home/aa/dpe_isca/workloads/rnn/SeqLSTMP.lua"
    "/home/aa/dpe_isca/workloads/rnn/Recursor.lua"
    "/home/aa/dpe_isca/workloads/rnn/Padding.lua"
    "/home/aa/dpe_isca/workloads/rnn/Dropout.lua"
    "/home/aa/dpe_isca/workloads/rnn/RepeaterCriterion.lua"
    "/home/aa/dpe_isca/workloads/rnn/recursiveUtils.lua"
    "/home/aa/dpe_isca/workloads/rnn/BiSequencer.lua"
    "/home/aa/dpe_isca/workloads/rnn/LinearNoBias.lua"
    "/home/aa/dpe_isca/workloads/rnn/BiSequencerLM.lua"
    "/home/aa/dpe_isca/workloads/rnn/LSTM.lua"
    "/home/aa/dpe_isca/workloads/rnn/ExpandAs.lua"
    "/home/aa/dpe_isca/workloads/rnn/MaskZeroCriterion.lua"
    "/home/aa/dpe_isca/workloads/rnn/FastLSTM.lua"
    "/home/aa/dpe_isca/workloads/rnn/TrimZero.lua"
    "/home/aa/dpe_isca/workloads/rnn/LookupTableMaskZero.lua"
    "/home/aa/dpe_isca/workloads/rnn/init.lua"
    "/home/aa/dpe_isca/workloads/rnn/Recurrence.lua"
    "/home/aa/dpe_isca/workloads/rnn/Repeater.lua"
    "/home/aa/dpe_isca/workloads/rnn/GRU.lua"
    "/home/aa/dpe_isca/workloads/rnn/SAdd.lua"
    "/home/aa/dpe_isca/workloads/rnn/SeqReverseSequence.lua"
    "/home/aa/dpe_isca/workloads/rnn/CopyGrad.lua"
    "/home/aa/dpe_isca/workloads/rnn/MaskZero.lua"
    "/home/aa/dpe_isca/workloads/rnn/Module.lua"
    "/home/aa/dpe_isca/workloads/rnn/Sequencer.lua"
    "/home/aa/dpe_isca/workloads/rnn/Mufuru.lua"
    "/home/aa/dpe_isca/workloads/rnn/ZeroGrad.lua"
    "/home/aa/dpe_isca/workloads/rnn/RecurrentAttention.lua"
    "/home/aa/dpe_isca/workloads/rnn/SeqBRNN.lua"
    "/home/aa/dpe_isca/workloads/rnn/NormStabilizer.lua"
    "/home/aa/dpe_isca/workloads/rnn/SequencerCriterion.lua"
    "/home/aa/dpe_isca/workloads/rnn/Recurrent.lua"
    "/home/aa/dpe_isca/workloads/rnn/AbstractSequencer.lua"
    "/home/aa/dpe_isca/workloads/rnn/SeqLSTM.lua"
    "/home/aa/dpe_isca/workloads/rnn/AbstractRecurrent.lua"
    "/home/aa/dpe_isca/workloads/rnn/SeqGRU.lua"
    )
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  include("/home/aa/dpe_isca/workloads/rnn/build/test/cmake_install.cmake")

endif()

if(CMAKE_INSTALL_COMPONENT)
  set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INSTALL_COMPONENT}.txt")
else()
  set(CMAKE_INSTALL_MANIFEST "install_manifest.txt")
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
file(WRITE "/home/aa/dpe_isca/workloads/rnn/build/${CMAKE_INSTALL_MANIFEST}"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
