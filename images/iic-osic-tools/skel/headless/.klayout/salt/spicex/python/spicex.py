import pya
from PySpice.Spice.Netlist import Circuit as SpiceCircuit, SubCircuit as SpiceSubCircuit, Netlist as SpiceNetlist
from PySpice.Unit import *
from itertools import count
from typing import Dict, Optional, Union

import logging

logger = logging.getLogger(__name__)


def netlist_to_spice(netlist: pya.Netlist,
                     device_class_name_to_model_mapping: Optional[Dict[str, str]] = None,
                     default_bulk_net: Union[str, Dict[str, str]] = 'floating') -> SpiceNetlist:
    """
    Convert a KLayout netlist to a PySpice netlist.
    :param netlist:
    :param device_class_name_to_model_mapping: A dict mapping device class names to model names.
        This is used to have the right transistor model in the spice netlist.
        Default: {'NMOS': 'nmos', 'PMOS': 'pmos'}
    :param default_bulk_net: 'floating' or {'NMOS': 'SomeNet1', 'PMOS': 'SomeNet2'}
        Define a default net for bulk contacts if they are not present in the layout.
        'floating': The bulk contact will not be connected to anything.
        {'NMOS': 'SomeNet1', 'PMOS': 'SomeNet2'}: Set a fixed net for bulk contacts of NMOS and PMOS tranistors.
        Default: 'floating'
    :return: PySpice netlist.
    """

    if device_class_name_to_model_mapping is None:
        device_class_name_to_model_mapping = {'NMOS': 'nmos', 'PMOS': 'pmos'}

    assert netlist.top_circuit_count() == 1, "A well formed netlist should have exactly one top circuit."

    spice_netlist = SpiceNetlist()

    # Create a counter for unique net names.
    _name_counter = count()

    def temp_net_name() -> str:
        """
        Create a unique net name. This is used for naming floating nets of transistor bodies.
        :return: New unique net name.
        """
        return "__tmp_net_{}".format(next(_name_counter))

    def get_net_name(net: pya.Net) -> str:
        name = net.expanded_name()
        name = name.replace('$', '')
        return name

    def register_device(circuit: SpiceCircuit, d: pya.Device):
        """
        Create a SPICE instance of the device `d` and add it to the `circuit`.
        :param circuit: PySpice circuit to add the device.
        :param d: KLayout device.
        :return:
        """
        device_class = d.device_class()

        # Map terminal names to nets
        terminal_map = {
            tdef.name: d.net_for_terminal(tdef.id())
            for tdef in device_class.terminal_definitions()
        }

        # Get net names at terminals
        ds1, gate, ds2 = [get_net_name(terminal_map[terminal_name])
                          for terminal_name in ['S', 'G', 'D']]

        # parameter_defs = device_class.parameter_definitions()

        assert device_class.name() in device_class_name_to_model_mapping, "Unknown device class name: {}".format(
            device_class.name())

        model = device_class_name_to_model_mapping[device_class.name()]

        length = d.parameter('L')
        width = d.parameter('W')
        area_drain = d.parameter('AD')
        area_source = d.parameter('AS')

        # Get net of body if defined. Otherwise create a new floating net.
        bulk = terminal_map.get('B', None)

        if bulk is None:
            if default_bulk_net == 'floating':
                bulk = temp_net_name()
            elif isinstance(default_bulk_net, dict):
                bulk = default_bulk_net[device_class.name()]

        # TODO: parameters AS, AD
        circuit.M("{}".format(d.id()), ds1, gate, ds2, bulk,
                  model=model,
                  width=width @ u_um,
                  length=length @ u_um,
                  )

    def register_subcircuit_instance(circuit: SpiceCircuit, inst: pya.Circuit):
        """
        Create a SPICE instance of the KLayout subcircuit instance `inst`.
        :param circuit: PySpice circuit to add the subcircuit instance ('X').
        :param inst: KLayout circuit instance.
        :return:
        """
        ref = inst.circuit_ref()
        name = ref.name
        num_pins = ref.pin_count()
        pin_nets = [inst.net_for_pin(i) for i in range(num_pins)]
        pin_names = [get_net_name(pin_net) for pin_net in pin_nets]
        circuit.X('{}'.format(inst.id()), name, *pin_names)

    def register_subcircuit(circuit: SpiceCircuit, sc: pya.SubCircuit):
        """
        Convert the KLayout subcircuit into a PySpice subcircuit and attach it to `circuit`.
        :param circuit: PySpice circuit to add the subcircuit.
        :param sc: KLayout subcircuit to be added to `circuit`.
        :return:
        """
        num_pins = sc.pin_count()
        pin_nets = [sc.net_for_pin(i) for i in range(num_pins)]
        pin_names = [get_net_name(pin_net) for pin_net in pin_nets]

        subcircuit = SpiceSubCircuit(sc.name, *pin_names)

        for d in sc.each_device():
            if isinstance(d, pya.Circuit):
                logger.warning('Skipping circuit: ', d.name)
            else:
                register_device(subcircuit, d)

        # Loop through sub circuits.
        for subc in c.each_subcircuit():
            register_subcircuit_instance(subcircuit, subc)

        circuit.subcircuit(subcircuit)

    for c in netlist.each_circuit_bottom_up():
        register_subcircuit(spice_netlist, c)

    return spice_netlist
