# Install script for directory: /home/aa/isca_workloads/rnn

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
    "/home/aa/isca_workloads/rnn/SeqLSTMP.lua"
    "/home/aa/isca_workloads/rnn/Recursor.lua"
    "/home/aa/isca_workloads/rnn/Padding.lua"
    "/home/aa/isca_workloads/rnn/Dropout.lua"
    "/home/aa/isca_workloads/rnn/RepeaterCriterion.lua"
    "/home/aa/isca_workloads/rnn/recursiveUtils.lua"
    "/home/aa/isca_workloads/rnn/BiSequencer.lua"
    "/home/aa/isca_workloads/rnn/LinearNoBias.lua"
    "/home/aa/isca_workloads/rnn/BiSequencerLM.lua"
    "/home/aa/isca_workloads/rnn/LSTM.lua"
    "/home/aa/isca_workloads/rnn/ExpandAs.lua"
    "/home/aa/isca_workloads/rnn/MaskZeroCriterion.lua"
    "/home/aa/isca_workloads/rnn/FastLSTM.lua"
    "/home/aa/isca_workloads/rnn/TrimZero.lua"
    "/home/aa/isca_workloads/rnn/LookupTableMaskZero.lua"
    "/home/aa/isca_workloads/rnn/init.lua"
    "/home/aa/isca_workloads/rnn/Recurrence.lua"
    "/home/aa/isca_workloads/rnn/Repeater.lua"
    "/home/aa/isca_workloads/rnn/GRU.lua"
    "/home/aa/isca_workloads/rnn/SAdd.lua"
    "/home/aa/isca_workloads/rnn/SeqReverseSequence.lua"
    "/home/aa/isca_workloads/rnn/CopyGrad.lua"
    "/home/aa/isca_workloads/rnn/MaskZero.lua"
    "/home/aa/isca_workloads/rnn/Module.lua"
    "/home/aa/isca_workloads/rnn/Sequencer.lua"
    "/home/aa/isca_workloads/rnn/Mufuru.lua"
    "/home/aa/isca_workloads/rnn/ZeroGrad.lua"
    "/home/aa/isca_workloads/rnn/RecurrentAttention.lua"
    "/home/aa/isca_workloads/rnn/SeqBRNN.lua"
    "/home/aa/isca_workloads/rnn/NormStabilizer.lua"
    "/home/aa/isca_workloads/rnn/SequencerCriterion.lua"
    "/home/aa/isca_workloads/rnn/Recurrent.lua"
    "/home/aa/isca_workloads/rnn/AbstractSequencer.lua"
    "/home/aa/isca_workloads/rnn/SeqLSTM.lua"
    "/home/aa/isca_workloads/rnn/AbstractRecurrent.lua"
    "/home/aa/isca_workloads/rnn/SeqGRU.lua"
    )
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  include("/home/aa/isca_workloads/rnn/build/test/cmake_install.cmake")

endif()

if(CMAKE_INSTALL_COMPONENT)
  set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INSTALL_COMPONENT}.txt")
else()
  set(CMAKE_INSTALL_MANIFEST "install_manifest.txt")
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
file(WRITE "/home/aa/isca_workloads/rnn/build/${CMAKE_INSTALL_MANIFEST}"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
