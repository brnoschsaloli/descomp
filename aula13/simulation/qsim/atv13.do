onerror {exit -code 1}
vlib work
vcom -work work atv13.vho
vcom -work work Waveform.vwf.vht
vsim -c -t 1ps -L cyclonev -L altera -L altera_mf -L 220model -L sgate -L altera_lnsim work.atv13_vhd_vec_tst
vcd file -direction atv13.msim.vcd
vcd add -internal atv13_vhd_vec_tst/*
vcd add -internal atv13_vhd_vec_tst/i1/*
proc simTimestamp {} {
    echo "Simulation time: $::now ps"
    if { [string equal running [runStatus]] } {
        after 2500 simTimestamp
    }
}
after 2500 simTimestamp
run -all
quit -f


