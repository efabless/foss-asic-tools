# -*- coding: utf-8 -*-
# ========================================================================
# SPDX-FileCopyrightText: 2023 Jakob Ratschenberger
# Johannes Kepler University, Institute for Integrated Circuits
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# SPDX-License-Identifier: Apache-2.0
#
# This script generates the ALIGN .sp format, from a spice netlist.
#
# The following devices are supported:
#    -sky130_fd_pr__nfet_01v8
#    -sky130_fd_pr__pfet_01v8
#
# A subcircuit component must start with the component identifier "x".
# ========================================================================

import sys 
import argparse

debug = False #debug mode


class Parser:
    def __init__(self, src) -> None:
        """
        Class to parse a ngspice netlist.

        Parameters
        ----------
        src : str
            File containing the ngspice netlist.

        Raises
        ------
        ValueError
            If file not found.

        Returns
        -------
        None
            The netlist can be accessed via the get_netlist() method.

        """
        self._src = src
        
        if src is not None:
            with open(str(src),'r') as f:
                lines = f.readlines()
        else:
            raise ValueError
        
        self.spc_netlist = self._merge_lines(lines)
        self.spc_netlist = self._delete_empty_lines(self.spc_netlist)
        self.spc_netlist = self._delete_start_end_whitespace(self.spc_netlist)
        self.spc_netlist = self._delete_comments(self.spc_netlist)
    
    
    def _merge_lines(self, lines):
        """
        Merges broken lines.

        Parameters
        ----------
        lines : list (str)
            Raw netlist.

        Returns
        -------
        merged_lines : list (str)
            Raw netlist with merged lines.

        """
        merged_lines = []
        for l in lines:
            if l.startswith("+ "):
                last = merged_lines.pop(-1)
                last = last + l[1:-1]
                merged_lines.append(last)
            else:
                merged_lines.append(l)
        return merged_lines     
    
    
    def _delete_start_end_whitespace(self, net):
        """
        Removes whitespaces at the beginning and at the end

        Parameters
        ----------
        net : list (str)
            Netlist.

        Returns
        -------
        new_net : list (str)
            Netlist.

        """
        new_net = []
        for l in net:
            new_net.append(l.strip())
        return new_net
            
    def _delete_empty_lines(self, net):
        """
        Removes empty lines from the netlist.

        Parameters
        ----------
        net : list (str)
            Netlist.

        Returns
        -------
        new_net : list (str)
            Netlist without empty lines.

        """
        new_net = []
        for l in net:
            if l.strip():
                new_net.append(l)
        
        return new_net
    
    def _delete_comments(self, net):
        """
        Deletes all comments in a netlist.
        Line comments: *
        End-of-Line comments: $ , ; , //

        Parameters
        ----------
        net : list (str)
            Netlist.

        Returns
        -------
        new_net : list (str)
            Netlist without comments.

        """
        new_net = []
        
        end_of_line_comment = ["$ ", "; ", "//"]
        
        for l in net:
            if l.startswith("*"): #comment line
                continue
            
            indx = -1
            for c in end_of_line_comment:
                indx = l.find(c)
                if not (indx == -1):
                    break
            
            if not (indx == -1):
                new_net.append(l[0:indx].rstrip())
                continue
            
            new_net.append(l)
        
        return new_net
            
        
        
    def get_netlist(self):
        return self.spc_netlist

class Netlist:
    """
        Class to store parts of a raw ngspice netlist.
        The following parts are stored:
            - raw netlist
            - subcircuits (netlists and names)
            - top netlist
            - parameters of the top netlist
            - title
            
    """
    def __init__(self, raw_netlist):
        self._raw_netlist = raw_netlist
        self._subnets = []
        self._subnet_names = []
        self._net = []
        self._title = []
        self._params = {}
    
    
    def build_Net(self):
        """
        Build the net from the raw netlist
        
        Returns
        -------
        None.

        """
        (self._subnet_names, self._subnets) = self._get_subnets(self._raw_netlist)
        self._get_top_net()
    
    def get_net(self):
        return self._net
    
    def get_title(self):
        return self._title
    
    def get_params(self):
        return self._params
    
    def get_subnets(self):
        return self._subnets
    
    def get_subnet_names(self):
        return self._subnet_names
    
    def _get_top_net(self):
        """
            Sets the top netlist in self._net.
        
        Raises
        ------
            ValueError if netlist contains unsupported line. 
            

        Returns
        -------
        None.

        """
       
        in_subckt = False
        for line in self._raw_netlist:
            if line.startswith(".subckt"):
                in_subckt = True
                continue
            
            if line.startswith(".ends"):
                in_subckt = False
                continue
            
            if not in_subckt:
                if line.startswith("."):
                    if line.startswith(".param"):
                        splitted = line.split()
                        self._append_params(splitted[1:])
                        continue
                    elif line.startswith(".title"):
                        self._title = line[len(".title")+1:]
                        continue
                    elif line == ".end":
                        break
                    else:
                        raise  ValueError(f"Statement: {line} not supported!")
                else:
                    self._net.append(line)
        
            
    def _get_subnets(self, net):
        """
        
        Returns the subnets and their name of the netlist net.

        Parameters
        ----------
        net : list (str)
            Netlist.

        Returns
        -------
        identns : list (str)
            List of subcircuit names.
        sub_nets_class : list (SubNetlist)
            List of the sub-netlists.

        """
        identns = []
        sub_nets = []
        sub_nets_class = []
        for l in net:
            if l.startswith(".subckt"):
                identns.append(l.split()[1])
            
        for i in identns:
            sub_net = self._get_subcir_net(i, net)
            sub_nets.append(sub_net)
        
        for n in sub_nets:
            sub_nets_class.append(SubNetlist(n))
        
        
        return (identns, sub_nets_class)
    
    
    def _get_subcir_net(self, identn, netlist):
        """
        
        Returns the netlist of the subckt identn.

        Parameters
        ----------
        identn : str 
            Descriptor of the subcircuit.
        netlist : list (str)
            Netlist.

        Raises
        ------
        ValueError
            If subcircuit isn't part of the netlist.

        Returns
        -------
        subcirc : list (str)
            Netlist of the subcircuit, starting with .subckt ...,
            ending with .ends.

        """
        subcirc = []
        in_subcirc = False
        found = False
        for l in netlist:
            splitted = l.split()
            if splitted[0] == ".subckt" and splitted[1] == identn:
                in_subcirc = True
                found = True
                subcirc.append(l)
                continue
            if l.startswith(".ends") and in_subcirc:
                in_subcirc = False
                subcirc.append(l)
                break
            if in_subcirc:
                subcirc.append(l)

        if found:
            return subcirc
        else:
            raise ValueError
            
    def _append_params(self, params):
        """
        Append circuit parameters to the self._params dict.

        Parameters
        ----------
        params : list (str)
            List of parameters in form:
                [<identn>=<expr>, ...].

        Returns
        -------
        None.

        """
        for p in params:
            indx = p.find("=")
            ident = p[:indx]
            expr = p[indx+1:]
            self._params[ident] = expr
        
class SubNetlist(Netlist):
    def __init__(self, raw_netlist) -> None:
        """
        Class to store the netlist of a subcircuit.

        Parameters
        ----------
        raw_netlist : list (str)
            Raw netlist of the subcircuit starting with 
            .subckt and ending with .ends

        Returns
        -------
        None
            DESCRIPTION.

        """
        super().__init__(raw_netlist)
        first_line = self._raw_netlist[0]
        last_line = self._raw_netlist[-1]
        
        self._ports = first_line.split()[2:]
        self._title = first_line.split()[1]
        self._raw_netlist[0] = f".title {self._title}"
        self._raw_netlist[-1] = ".end"
        self._get_top_net()
        self._raw_netlist[0] = first_line
        self._raw_netlist[-1] = last_line
        
    def get_nodes(self):
        """

        Returns
        -------
        list (str)
            Nodes of the subcircuit.

        """
        return self._ports
        
        
class Circuit:
    """
        Class to build a circuit from a Netlist object.
    """
    def __init__(self, netlist: Netlist) -> None:
        self._netlist = netlist
        self._top_net = netlist.get_net()
        self._sub_nets = netlist.get_subnets()
        self._devices = []
        self._param = netlist.get_params()
        self._title = netlist.get_title()
        self._sub_circs = []
        self._sub_circ_names = netlist.get_subnet_names()  
        
        if netlist.get_net():
            self._only_sub_circs = False
        else:
            self._only_sub_circs = True
        
     
    def _build_subcircuits(self):
        """
        Build the circuits of all subcircuits.

        Returns
        -------
        Appends the subcircuits to the self._sub_circs list.

        """
        self._sub_nets.reverse()
        self._sub_circ_names.reverse()
        
        for sub in self._sub_nets:
            self._sub_circs.append(SubCircuit(sub))
    
    def _build_circuit(self):
        """
        Build the top circuit.

        Raises
        ------
        ValueError
            If the netlist contains a unsupported device.

        Returns
        -------
        Appends the devices to the self._devices list.

        """
        for l in self._top_net:
            #MOSFET
            if l.startswith("M") or l.startswith("XM"):
                device = MOSFET(l)
                device.set_circ_param_dict(self._param)
                self._devices.append(device)
                continue
            #Capacitor
            elif l.startswith("C") or l.startswith("XC"):
                device = Capacitor(l)
                device.set_circ_param_dict(self._param)
                self._devices.append(device)
                continue
            #Resistor
            elif l.startswith("XR") or l.startswith("R"):
                device = Resistor(l)
                device.set_circ_param_dict(self._param)
                self._devices.append(device) 
                #raise ValueError(f"Device {l.split()[0]}, not supported!")
            #Subcircuit    
            elif l.startswith("X") or l.startswith("x"):
                identn = self._get_identn(l)
                #if not identn in self._sub_circ_names:
                #    raise ValueError(f"Subcircuit {identn} not given!")
                device = SubCircuitDevice(l, identn)
                device.set_circ_param_dict(self._param)
                #indx = self._sub_circ_names.index(identn)
                #sub_circ = self.sub_circs[indx]
                self._devices.append(device)
            #Raise error if device isn't supported!
            else:
                raise ValueError(f"Device {l.split()[0]}, not supported!")
            
                
    def build_circuit(self):
        """
        Builds the circuit for the Netlist.

        Returns
        -------
        None.

        """
        self._build_subcircuits()
        self._build_circuit()
    
    def insert_params(self):
        """
        Inserts the parameters of the circuit into the devices parameters.

        Returns
        -------
        None.

        """
        for d in self._devices:
            d.update_params()
        
        for s in self._sub_circs:
            s.insert_params()
    
    def eval_params(self):
        """
        Evaluates the inserted circuit parameters.

        Returns
        -------
        None.

        """
        
        self.insert_params()
        
        for d in self._devices:
            d.eval_params()
        
        for s in self._sub_circs:
            s.eval_params()
    
    def update_params_for_align(self):
        """
        Updates the device parameters to the align format.

        Returns
        -------
        None.

        """
        for d in self._devices:
            d.update_params_align()
            
        for s in self._sub_circs:
            s.update_params_for_align()       
   
    def _get_identn(self, line):
        """
        Returns the name of the subcircuit device

        Parameters
        ----------
        line : str
            Subcircuit device line, starting with XYYYY.

        Returns
        -------
        splitted[-1] : str
            Name of the subcircuit.

        """
        splitted = line.split()
        return splitted[-1]
    
    def _print_param(self):
        """
        Prints all parameters of the circuit.

        Returns
        -------
        None.

        """
        if self._param:
            print(".param", end="")
            for (key, value) in self._param.items():
                print(f" {key}={value}", end="")
            print("",end="\n")
        
    def _print_devices(self):
        """
        Prints all devices of the circuit.

        Returns
        -------
        None.

        """
        for d in self._devices:
            d.print()
            
    def _print_devices_align(self):
        """
        Prints the devices in the align format.

        Returns
        -------
        None.

        """
        for d in self._devices:
            d.print_align()
            
    def _print_subcirc(self):
        """
        Prints all subcircuits of the circuit.

        Returns
        -------
        None.

        """
        for s in self._sub_circs:
            s.print()
            
    def _print_subcirc_align(self):
        """
        Prints all subcircuits in the align format.

        Returns
        -------
        None.

        """
        for s in self._sub_circs:
            s.print(style="align")
            
    
    def print(self, style="default"):
        """
        Prints the circuit.

        Returns
        -------
        None.

        """
        
        if not self._only_sub_circs:
            if self._title is not None:
                print(f".title {self._title}")
                
        self._print_param()
        
        if style == "default":
            self._print_devices()
            self._print_subcirc()
        elif style == "align":
            self._print_devices_align()
            self._print_subcirc_align()
        else:
            raise ValueError
        
        if not self._only_sub_circs:
            print(".end")
     
    def _param_to_str(self):
        param = ""
        if self._param:
            param += ".param"
            for (key, value) in self._param.items():
                param += f" {key}={value}"
            
        if param:
            param += "\n"
        return param
    
    def _devices_to_str(self):
        devices = ""
        for d in self._devices:
            line = d.get_device_line()
            devices += line
        return devices
    
    def _align_devices_to_str(self):
        devices = ""
        for d in self._devices:
            line = d.get_align_device_line()
            devices += line
        return devices
    
    def _subckts_to_str(self):
        subckts = ""
        for s in self._sub_circs:
            line = s.get_netlist()
            subckts += line
        
        return subckts
    
    def _align_subckts_to_str(self):
        subckts = ""
        for s in self._sub_circs:
            line = s.get_netlist(style="align")
            subckts += line
        
        return subckts
    
    def get_netlist(self, style = "default"):
        
        netlist = ""
        if not self._only_sub_circs:
            if self._title is not None:
                netlist += f".title {self._title}\n"
                
        
        
        if style == "default":
            line_param = self._param_to_str()
            line_devices = self._devices_to_str()
            line_subckts = self._subckts_to_str()
        elif style == "align":
            line_param = self._param_to_str()
            line_devices = self._align_devices_to_str()
            line_subckts = self._align_subckts_to_str()
        else:
            raise ValueError
            
        netlist += line_param
        netlist += line_devices
        netlist += line_subckts
        
        if not self._only_sub_circs:
            netlist += ".end"
        
        return netlist
        
        
        
                
class SubCircuit(Circuit):
    def __init__(self, netlist: Netlist) -> None:
        super().__init__(netlist)
        self._nodes = netlist.get_nodes()
        self._param_dict = {} #Todo
        self._build_circuit()
            
    def get_netlist(self, style = "default"):
        netlist = f"\n.subckt {self._title}"
        for n in self._nodes:
            netlist += f" {n}"
        netlist += "\n"
        
        if style == "default":
            line_param = self._param_to_str()
            line_devices = self._devices_to_str()
            line_subckts = self._subckts_to_str()
        elif style == "align":
            line_param = self._param_to_str()
            line_devices = self._align_devices_to_str()
            line_subckts = self._align_subckts_to_str()
        else:
            raise ValueError
            
        netlist += line_param
        netlist += line_devices
        netlist += line_subckts
        
        
        netlist += ".ends\n"
        
        return netlist
        
    def print(self, style = "default"):
        print(f"\n.subckt {self._title}", end="")
        for n in self._nodes:
            print(f" {n}", end="")
        print("",end="\n")
        
        self._print_param()
        if style=="default":
            self._print_devices()
        elif style=="align":
            self._print_devices_align()
        print(".ends\n")

class Device:
    """ 
        Class of a device like R, C , M, X, ...
    
        Args:
            line (str): spice description of the device
    
    """
    
    def __init__(self, line) -> None:
        if line is not None:
            self._splitted = line.split()
            self._line = line
            self._instance_name = self._splitted[0]
            self._device_param_dict = {}
            self._align_device_param_dict = {}
            self._circ_param_dict = {}
            self._nodes = []
        else:
            raise ValueError("No device line given!")
    
    def set_circ_param_dict(self, params):
        self._circ_param_dict = params
        
    def set_device_param_dict(self, params):
        self._device_param_dict = params
        
    def _param_to_dict(self, params):
        """
        Stores the parameters definded in param_dict 
        with the values given in params.
        
        Parameters
        ----------
        param_dict : dict (str)
            dictionary of the devices parameters
        params : list (str)
            list of device parameters

        Returns
        -------
        None.

        """
        for p in params:
            param = p[:p.find("=")].lower()
            value = p[p.find("=")+1:]
            if param in self._device_param_dict:
                self._device_param_dict[param] = value
                
    def _get_params(self,line):
        """
        Parameters
        ----------
        line : str
            spice description of a device

        Returns
        -------
        params : list (str)
            list of the parameters of a spice device

        """
        params = []
        last_space = 0
        param = False
        ignore_space = False
        for n in range(len(line)):
            l = line[n]
            if l == " " and not param:
                last_space = n
                continue
            
            if l == "=" and not param:
                param = True
                continue
                
            if l=="'" and not ignore_space and param:
                ignore_space = True
                continue
                
            if l=="'" and ignore_space and param:
                params.append(line[last_space+1:n+1])
                ignore_space = False
                param = False
                continue
            
            if l==" " and not ignore_space and param:
                params.append(line[last_space+1:n])
                last_space = n
                ignore_space = False
                param = False
                continue
        if param:
            params.append(line[last_space+1:])
        return params
    
    def update_params(self):
        """
        Inserts the parameters defined in self._circ_param_dict
        into self._device_param_dict.

        Returns
        -------
        None.

        """
        if self._circ_param_dict and self._device_param_dict:
            for (k, v) in self._circ_param_dict.items():
                for (key, value) in self._device_param_dict.items():
                   new_value = value.replace(k, str(v))
                   self._device_param_dict[key] = new_value
           
    def eval_params(self):
        """
            Evaluates the updated parameters. E.g. "5*3" = "15"
        """
        if self._device_param_dict:
            for (key, value) in self._device_param_dict.items():
                value = str(value)
                if value[0]=="'" and value[-1]=="'": #value has to be updated
                    value = eval(value[1:-1])
                    self._device_param_dict[key] = str(round(value,2))
            
    def update_params_align(self):
        """
        Uptdates the parameters for align.

        Returns
        -------
        None.

        """
        self._align_device_param_dict = self._device_param_dict.copy()
    
            
    def print(self, style="default"):
        print(self._instance_name, end="")
        pass
        
    
    def _dev_param_dict_to_str(self):
        line = ""
        if self._device_param_dict:
            for (k,v) in self._device_param_dict.items():
                line += " " + k + "=" + v
        return line
    
    def _align_dev_param_dict_to_str(self):
        line = ""
        for (k,v) in self._align_device_param_dict.items():
            line += " " + k + "=" + v
        return line
    
    def _nodes_to_str(self):
        nodes = ""
        for n in self._nodes:
            nodes += f" {n}"
        return nodes
        
    def get_device_line(self):
        pass
        
    
    def get_align_device_line(self):
        pass
        
class SubCircuitDevice(Device):
    def __init__(self, line, identn) -> None:
        """
        Device class for a subcircuit call, starting with X or x.

        Parameters
        ----------
        line : str
            Device descriptor line.
        identn : TYPE
            Name of the subcircuit.

        Raises
        ------
        ValueError
            If device isn't a subcircuit device.

        Returns
        -------
        None
            DESCRIPTION.

        """
        super().__init__(line)
        self._identn = identn
        self._nodes = None
        
        if self._instance_name.startswith("X") or self._instance_name.startswith("x"):
            self._nodes = self._get_nodes(line, identn)
            self._device_param_dict = self.set_device_param_dict(self._get_params(line))
        else:
            raise ValueError(f"Device {self._instance_name} not a valid subcircuit device.")

    def _get_nodes(self, line, identn):
        """
        Returns the nodes of the subcircuit device.

        Parameters
        ----------
        line : str
            Device descriptor line.
        identn : str
            Name of the device.

        Returns
        -------
        nodes : list (str)
            List of the devices nodes.

        """
        nodes = []
        splitted = line.split()[1:]

        for i in splitted:
            if i == identn:
                break
            else:
                nodes.append(i)
        
        return nodes
    
    def update_params_align(self):
        return
    
    def print(self, style="default"):
        super().print(style)
        for n in self._nodes:
            print(f" {n}", end="")
        print(f" {self._identn}",end="\n")
        
    def get_device_line(self):
        super().get_device_line()
        return self._instance_name  + self._nodes_to_str() +f" {self._identn}" + self._dev_param_dict_to_str() + "\n"
    
    def get_align_device_line(self):
        return self.get_device_line()

class FourTermDevice(Device):
    def __init__(self, line) -> None:
        """
        Device class for four terminal devices like NMOS, PMOS, ... .

        Parameters
        ----------
        line : str
            Device descriptor line.

        Returns
        -------
        None
            DESCRIPTION.

        """
        super().__init__(line)
        self._node_A = self._splitted[1]
        self._node_B = self._splitted[2]
        self._node_C = self._splitted[3]
        self._node_D = self._splitted[4]
        self._nodes = [self._node_A, self._node_B, self._node_C, self._node_D]
        
    def print(self, style="default"):
        super().print(style)
        print(f" {str(self._node_A)} {self._node_B} {self._node_C} {self._node_D}", end="")

class TwoTermDevice(Device):
    def __init__(self, line) -> None:
        """
        Device class for two terminal devices like R, C, ... .

        Parameters
        ----------
        line : str
            Device descriptor line.

        Returns
        -------
        None
            DESCRIPTION.

        """
        super().__init__(line)
        self._node_A = self._splitted[1]
        self._node_B = self._splitted[2]
        self._nodes = [self._node_A, self._node_B]
           
    def print(self, style="default"):
        super().print(style)
        print(f" {str(self._node_A)} {self._node_B}", end="")
        
class MOSFET(FourTermDevice):
    def __init__(self, line) -> None:
        """
        Device class for MOSFET's.

        Parameters
        ----------
        line : str
            Device descriptor line.

        Raises
        ------
        ValueError
            If the device isn't a MOS (starting with M or XM).

        Returns
        -------
        None
            DESCRIPTION.

        """
        super().__init__(line)
        self.set_device_param_dict({
            "w" : [],
            "l" : [],
            "nf" : [],
            "m" : []
        })
        
        self._mname = None
        if self._instance_name.startswith("M") or self._instance_name.startswith("XM"):
            self._mname = self._splitted[5]
            self._param_to_dict(self._get_params(line))
        else:
            raise ValueError(f"Device: {self._instance_name} not a valid MOSFET!")
    
    def update_params_align(self):
        super().update_params_align()
        assert int(self._align_device_param_dict["nf"])%2==0, f"Error: nf odd not supported! [Device {self._instance_name}]"
        assert int(self._align_device_param_dict["m"])==1, f"Error: m > 1 not supported! [Device {self._instance_name}]"
        
        self._align_device_param_dict["w"] = str(round(float(self._align_device_param_dict["w"])/int(self._align_device_param_dict["nf"]),2))+"e-6"
        self._align_device_param_dict["l"] += "e-6" 
        self._align_device_param_dict["m"] = str(int(self._align_device_param_dict["nf"])//2)
        self._align_device_param_dict["nf"] = str(2)
          
     
    def print(self, style="default"):
        super().print(style)
        print(f" {self._mname}", end="")
        for key,value in self._device_param_dict.items():
            print(f" {key}={value}", end="")
        print("", end="\n")
    
    def get_device_line(self):
        super().get_device_line()
        return self._instance_name  + self._nodes_to_str() + " " + self._mname + self._dev_param_dict_to_str() + "\n"
    
    def get_align_device_line(self):
        super().get_device_line()
        return self._instance_name  + self._nodes_to_str() + " " + self._mname + self._align_dev_param_dict_to_str() + "\n"

class Capacitor(TwoTermDevice):
    """
        Device class for Capacitor's.

        Parameters
        ----------
        line : str
            Device descriptor line.

        Raises
        ------
        ValueError
            If the device isn't a Cap or a supported Cap (starting with C or XC).

        Returns
        -------
        None
            DESCRIPTION.

        """
    def __init__(self, line) -> None:
        super().__init__(line)
        splitted = line.split()
        self._subcirc_cap = False
        
        if self._instance_name.startswith("C") :
            self._value = splitted[3]
            self._param_to_dict(self._get_params(line))
        elif self._instance_name.startswith("XC"):
            self._subcirc_cap= True

            #define the supported capacitor models
            if splitted[3] == "sky130_fd_pr__cap_mim_m3_1":
                self.set_device_param_dict({
                    "w" : [],
                    "l" : [],
                    "mf" : [],
                    "m" : []
                })
                self._mname = splitted[3]
                self._param_to_dict(self._get_params(line))
            else:
                raise ValueError(f"Capacitor {self._mname} not supported!")
            
        else:
            raise ValueError(f"Device: {self._instance_name} not a valid Capacitor!")
    
    def update_params_align(self):
        super().update_params_align()
        if self._subcirc_cap:
            if self._mname == "sky130_fd_pr__cap_mim_m3_1":
                self._align_device_param_dict["w"] = self._align_device_param_dict["w"]+"e-6"
                self._align_device_param_dict["l"] = self._align_device_param_dict["l"]+"e-6"
            else:
                raise ValueError(f"Capacitor model {self._mname} not supported in align!")
        else:
            raise ValueError(f"Capacitor {self._instance_name} not supported in align!")
        
    def print(self, style="default"):
        super().print(style)
        print(f" {self._mname}", end="")
        for key,value in self._device_param_dict.items():
            print(f" {key}={value}", end="")
        print("", end="\n")
    
    def get_device_line(self):
        super().get_device_line()
        return self._instance_name  + self._nodes_to_str() + " " + self._value + self._dev_param_dict_to_str() + "\n"
    
    def get_align_device_line(self):
        super().get_device_line()
        if self._subcirc_cap:
            
            if self._mname == "sky130_fd_pr__cap_mim_m3_1":
                #exchange W and L
                W = self._align_device_param_dict["w"]
                L = self._align_device_param_dict["l"]
                self._align_device_param_dict["l"] = W
                self._align_device_param_dict["w"] = L
                mf = self._align_device_param_dict.pop("mf")
                m = self._align_device_param_dict.pop("m")
                
                #generate the model line
                line = self._instance_name[1:]  + self._nodes_to_str() + " " + self._mname + self._align_dev_param_dict_to_str() + "\n"
                
                #rechange W and L
                self._align_device_param_dict["l"] = L
                self._align_device_param_dict["w"] = W

            return line
        else:
            return self._instance_name  + self._nodes_to_str() + " " + self._value + "\n"
        
class Resistor(TwoTermDevice):
    """
        Device class for Resistor's.

        Parameters
        ----------
        line : str
            Device descriptor line.

        Raises
        ------
        ValueError
            If the device isn't a Resistor or a supported Resistor (starting with R or XR).

        Returns
        -------
        None
            DESCRIPTION.

        """
    def __init__(self, line) -> None:
        super().__init__(line)
        splitted = line.split()
        self._subcirc_res = False
        
        if self._instance_name.startswith("R"):
            self._value = splitted[3] #set the value of the resistor
            self._param_to_dict(self._get_params(line)) #set the parameters
        elif self._instance_name.startswith("XR"): #subcircuit resistor
            self._subcirc_res= True

            if splitted[4]=="sky130_fd_pr__res_xhigh_po":
                self.set_device_param_dict({ #set the parameter dict 
                    "w" : [],
                    "l" : [],
                    "mult" : [],
                    "m" : []
                })
                self._mname = splitted[4] #set the model name
                self._param_to_dict(self._get_params(line)) #get the parameters
            else:
                raise ValueError(f"Resistor {self._instance_name} not supported!")
        else:
            raise ValueError(f"Device: {self._instance_name} not a valid Resistor!")
    
    def update_params_align(self): #update the parameters for align
        super().update_params_align()
        if self._subcirc_res:   #only subcircuit resistors are supported
            if self._mname=="sky130_fd_pr__res_xhigh_po": #only this model is supported
                if self._align_device_param_dict["w"]=="0.35":
                    self._align_device_param_dict["r"] = str(round(int(self._align_device_param_dict["l"])*1e3*2000/350,0))
                    l = self._align_device_param_dict.pop("l")
                else:
                    raise ValueError(f"Resistor model {self._mname} not supported for align!")
        else:
            raise ValueError(f"Resistor model {self._mname} not supported for align!")
        
    def print(self, style="default"):
        super().print(style)
        print(f" {self._mname}", end="")
        for key,value in self._device_param_dict.items():
            print(f" {key}={value}", end="")
        print("", end="\n")
    
    def get_device_line(self):
        super().get_device_line()
        return self._instance_name  + self._nodes_to_str() + " " + self._value + self._dev_param_dict_to_str() + "\n"
    
    def get_align_device_line(self):
        super().get_device_line()
        if self._subcirc_res:
            if self._mname =="sky130_fd_pr__res_xhigh_po":
                m = self._align_device_param_dict.pop("m")
                mult = self._align_device_param_dict.pop("mult")
                w = self._align_device_param_dict.pop("w")
                line = self._instance_name[1:]  + self._nodes_to_str() + " " + self._mname + self._align_dev_param_dict_to_str() + "\n"
                return line
            else:
                raise ValueError
        else:
            return self._instance_name  + self._nodes_to_str() + " " + self._value + "\n"

def main():
    #use a parser to parse the cmd line variables
    parser = argparse.ArgumentParser(description="Converts a spice netlist to the ALIGN format.", formatter_class=argparse.ArgumentDefaultsHelpFormatter)
    parser.add_argument("src", help="Source file")
    parser.add_argument("-d","--dest", default="src", help="Destination file")
    parser.add_argument("-g","--ground", default="GND", help="Ground node")
    args = vars(parser.parse_args())

    src_file = args["src"] #get the name of the src file
    #set the destination file name
    dest_file = ""
    if args["dest"] != "src":
        dest_file = args["dest"]
    elif src_file.endswith(".sch.spc"):
        dest_file = src_file[0:-7]+"sp"
    else:
        src_type = src_file[src_file.find("."):]
        raise TypeError(f"File ending {src_type} not supported") 
         
    parser = Parser(src_file)
    netlist = parser.get_netlist()
    #print(netlist)
    myNetlist = Netlist(netlist)
    myNetlist.build_Net()
    
    circ = Circuit(myNetlist)
    circ.build_circuit()
    circ.insert_params()
    circ.eval_params()
    circ.update_params_for_align()
    
    #circ.print(style="align")
    
    align_netlist = circ.get_netlist(style="align")
    
    #wite destination file            
    with open(dest_file, 'w') as f:
        f.write(align_netlist)
    
if __name__ == "__main__":
    main()
