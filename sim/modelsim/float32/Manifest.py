action = "simulation"
sim_tool = "modelsim"
sim_top = "addition_float_tb"

sim_post_cmd = "vsim -voptargs=+acc -do wave.do -i addition_float_tb"

modules = {
  "local" : [ "../../../tb/addition_float_tb" ],
}
