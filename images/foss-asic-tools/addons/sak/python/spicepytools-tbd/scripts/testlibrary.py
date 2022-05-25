#!/usr/bin/python2.7
# vim: ts=4 : et : sw=4 :

import sys, re, string, os
import shutil
import popen2
import StringIO
import ConfigParser
import numpy
import md5          ##Do not use hashlib.md5 as RedHat is stuck on python 2.4

import spice_read
from plotutils import plotter

from spicelibconf import *

#################### SETUP VARS
TEMPLATE_FILE = "testcircuits/index_template.html"
BASE_DIR = os.path.join(os.path.dirname(__file__), '../')

#################### GLOBAL DEFINITIONS
ROW_TEMPLATES = {
        'base': """
<tr><td rowspan="2">$partname</td>
    <td rowspan="2">$value</td>
    <td bgcolor="$model_url_color" rowspan="2">$model_url</td>
    <td rowspan="2">$symbol</td>
    <td bgcolor="$checksum_test_color" rowspan="2">$checksum_test</td>
    $sim_test_columns
    <td rowspan="2">$description $documentation</td>
    </tr> <tr>
    $sim_status_columns
</tr> """,
'model_test': """
<td bgcolor="$model_test_color">$model_test</td>""",
'model_status': """
<td bgcolor="$model_status_color">$model_status</td>"""
}


TESTDEFS = {"npn.sym": { "dir" : BASE_DIR + "testcircuits/npn_bipolar/",
                         "schematics" : ["dc_current_gain.sch",
                                         "saturation_voltages.sch"],
                         "htmltemplate": "index.html",
                         "files": ["simulate.gnucap"]},
            "pnp.sym": { "dir" : BASE_DIR + "testcircuits/pnp_bipolar/",
                         "schematics" : ["dc_current_gain.sch",
                                         "saturation_voltages.sch"],
                         "htmltemplate": "index.html",
                         "files": ["simulate.gnucap"]},
            "npn_darlington.sym": { "dir" : BASE_DIR + "testcircuits/npn_darlington/",
                                    "schematics" : ["dc_current_gain.sch",
                                                    "saturation_voltages.sch"],
                                    "htmltemplate": "index.html",
                                    "files": ["simulate.gnucap"]},
            "pnp_darlington.sym": { "dir" : BASE_DIR + "testcircuits/pnp_darlington/",
                                    "schematics" : ["dc_current_gain.sch",
                                                    "saturation_voltages.sch"],
                                    "htmltemplate": "index.html",
                                    "files": ["simulate.gnucap"]},
            "npn_bin.sym": { "dir" : BASE_DIR + "testcircuits/npn_bin/",
                                    "schematics" : ["dc_current.sch"],
                                    "htmltemplate": "index.html",
                                    "files": ["simulate.gnucap"]},
            "pnp_bin.sym": { "dir" : BASE_DIR + "testcircuits/pnp_bin/",
                                    "schematics" : ["dc_current.sch"],
                                    "htmltemplate": "index.html",
                                    "files": ["simulate.gnucap"]},
            "npn_rbase.sym": { "dir" : BASE_DIR + "testcircuits/npn_rbase/",
                                    "schematics" : ["dc_current.sch"],
                                    "htmltemplate": "index.html",
                                    "files": ["simulate.gnucap"]},
            "pnp_rbase.sym": { "dir" : BASE_DIR + "testcircuits/pnp_rbase/",
                                    "schematics" : ["dc_current.sch"],
                                    "htmltemplate": "index.html",
                                    "files": ["simulate.gnucap"]},
            "diode.sym": { "dir" : BASE_DIR + "testcircuits/diode/",
                                    "schematics" : ["dc_current.sch"],
                                    "htmltemplate": "index.html",
                                    "files": ["simulate.ngspice"]},
            "zener_diode.sym": { "dir" : BASE_DIR + "testcircuits/zener_diode/",
                                    "schematics" : ["dc_current.sch"],
                                    "htmltemplate": "index.html",
                                    "files": ["simulate.ngspice"]},
            "zener_bidirectional.sym": { "dir" : BASE_DIR + "testcircuits/zener_bidirectional/",
                                    "schematics" : ["dc_current.sch"],
                                    "htmltemplate": "index.html",
                                    "files": ["simulate.ngspice"]},
            "opamp.sym": { "dir" : BASE_DIR + "testcircuits/opamp/",
                                    "schematics" : ["ac_amplifier.sch"],
                                    "htmltemplate": "index.html",
                                    "files": ["simulate.ngspice"]},
            "comparator.sym": { "dir" : BASE_DIR + "testcircuits/comparator/",
                                    "schematics" : ["switching.sch"],
                                    "htmltemplate": "index.html",
                                    "files": ["simulate.ngspice"]},
            "cfa.sym": { "dir" : BASE_DIR + "testcircuits/cfa/",
                                    "schematics" : ["ac_amplifier.sch"],
                                    "htmltemplate": "index.html",
                                    "files": ["simulate.ngspice"]}
            }


#################### EXCEPTIONS

class SimulatorError(Exception):
    #module-specific exception for problems with simulators
    pass

#################### CLASSES

class MyConfigParser(ConfigParser.SafeConfigParser):
    def __init__(self):
        ConfigParser.SafeConfigParser.__init__(self)

    def write(self, fp):
        """create my own write function as the config parser
        adds whitespices around the delimiter"""
        for section in self._sections:
            fp.write("[%s]\n" % section)
            for key, value in self._sections[section].items():
                if key == '__name__':
                    continue
                if value is None:
                    value = ""
                fp.write("%s=%s\n" %(key, value))
            fp.write("\n\n")
            

class modelpart(object):
    def __new__(cls, name, testdir, modeldir, properties):
        d = dict(properties)
        section = os.path.splitext(d['symbol'])[0]

        class_ = {'diode': modelDiode,
                  'zener_diode': modelZenerDiode,
                  'zener_bidirectional': modelZenerBidirectional,
                  'npn': modelNPNBipolar,
                  'pnp': modelPNPBipolar,
                  'pnp_rbase': modelPNPRbase,
                  'npn_rbase': modelNPNRbase,
                  'pnp_bin': modelPNPBin,
                  'npn_bin': modelNPNBin,
                  'npn_darlington': modelNPNDarlington,
                  'pnp_darlington': modelPNPDarlington,
                  'opamp': modelOpamp,
                  'comparator': modelComparator,
                  'cfa': modelCFA}.get(section, modelpartBase)

        return class_(name, testdir, modeldir, properties)


class modelpartBase(object):
    section = 'undefined'

    def __init__(self, name, testdir, modeldir, properties):
        self.name = name
        self.testdir = testdir
        self.modeldir = modeldir
        self.properties = dict(properties)
        if not 'model_status_good' in self.properties:
            self.properties['model_status_good'] = ""
        if not 'model_status_broken' in self.properties:
            self.properties['model_status_broken'] = ""

        self.golden_checksum = None
        self.current_checksum = None
        self.checksum_status = None
        self.test_status = {}

    def simulate_cmd(self, sim_family):
        """Returns the string to be passed to the simulator"""
        return os.linesep.join(['*'] + self.simulate_cmd_lines(sim_family))

    def test(self):
        ignore_status = ['undefined', 'new']
        for sim in SIMULATORS:
            if self.model_status(sim) not in ignore_status:
                self.test_simulator(sim)

    def test_simulator(self, simulator):
        """Test self with the given simulator"""
        if TESTDEFS.has_key(self.properties["symbol"]):
            test = TESTDEFS[self.properties["symbol"]]
            ## copy all test files and the controller to dest
            # TODO: do not copy files unneeded for this simulator
            testdir = os.path.join(self.testdir, SIMULATORS[simulator]['folder'])
            if not os.path.isdir(testdir):
                os.makedirs(testdir)
            repl = {}
            repl.update(self.properties)
            repl['partname'] = self.name

            ## apply the properties to all schematic files
            for f in test["schematics"]:
                sch = string.Template(open(test["dir"] + f,"rt").read())
                open(os.path.join(testdir, f), "wt").write(sch.safe_substitute(repl))

            ## run the tests
            self.test_message, result = self.plot_all(testdir, simulator)

            if result == 0:
                self.test_status[simulator] = 'succeeded'
            else:
                self.test_status[simulator] = 'failed'

            ## create the html file with the test results
            repl['test_result'] = self.test_message
            repl['modelpath'] = os.path.join('../../../../../', self.modeldir, self.properties['file'])
            make_doc_hyperlink(repl)
            html = string.Template(open(test["dir"] + test["htmltemplate"], "rt").read())
            open(os.path.join(testdir, "index.html"),"wt").write(html.safe_substitute(repl))
            #TODO: use the return value, or eliminate it
            return True, self.test_message

        else:
            self.test_message = "no test definition available"
            return False, self.test_message

    def update_checksum(self):
        golden = self.golden_checksum

        modelpath = os.path.join(self.modeldir, self.properties['file'])
        if os.path.exists(modelpath):
            m = md5.new()
            m.update(open(modelpath).read())
            current = m.hexdigest()
        else:
            current = False

        if golden == False and current == False:
            checksum_status = 'neither'
        elif golden != False and current == False:
            checksum_status = 'missing1'
        elif golden == False and current != False:
            checksum_status = 'missing2'
        elif golden == current:
            checksum_status = 'good'
        else:
            checksum_status = 'failed'

        self.current_checksum = current
        self.checksum_status = checksum_status

    def cfg_status(self):
        self.update_checksum()
        status = MyConfigParser()
        status.add_section('checksum')
        status.set('checksum','checksum',self.checksum_status)
        status.add_section('simulators')
        for sim in SIMULATORS:
            status.set('simulators', sim, self.test_status.get(sim, 'None'))
        if not os.path.isdir(self.testdir):
            os.makedirs(self.testdir)
        fid = open(os.path.join(self.testdir, 'status.cfg'), 'wb')
        status.write(fid)
        fid.close()

    def html_status(self):
        repl = {}
        repl.update(self.properties)
        repl["partname"] = self.name

        make_doc_hyperlink(repl, docname='(d) ')

        self.update_checksum()
                     
        repl["model_url"] = '<a href="../../../' + self.modeldir +'/'+repl["file"]+'">'+repl["file"]+'</a>'
        repl["model_url_color"] = color(os.path.exists(os.path.join(self.modeldir,repl["file"])))
        repl["checksum_test"] = self.checksum_status
        repl["checksum_test_color"] = color(self.checksum_status)

        status = MyConfigParser()
        statusfile = os.path.join(self.testdir, 'status.cfg')
        if os.path.exists(statusfile):
            status.read(statusfile)
        
        base_tmpl = string.Template(ROW_TEMPLATES['base'])
        test_tmpl = string.Template(ROW_TEMPLATES['model_test'])
        status_tmpl = string.Template(ROW_TEMPLATES['model_status'])
        sim_test_columns = ""
        sim_status_columns = ""
        for sim in SIMULATORS:
            testdir = os.path.join(self.testdir, SIMULATORS[sim]['folder'])
            if os.path.exists(os.path.join(testdir, 'index.html')) and \
                    status.has_option('simulators', sim):
                sim_status = status.get('simulators', sim)
                test_repl = {'model_test_color': color(sim_status)}
                test_repl['model_test'] = '<a href="%s">%s</a>' % \
                        (os.path.join(self.name, SIMULATORS[sim]['folder'],
                                'index.html'), sim_status)
            else:
                test_repl = {'model_test': 'None',
                             'model_test_color': color('default')}
            model_status = self.model_status(sim)
            status_repl = {'model_status_color': color(model_status),
                'model_status': model_status}
            sim_test_columns += test_tmpl.safe_substitute(test_repl)
            sim_status_columns += status_tmpl.safe_substitute(status_repl)

        repl['sim_status_columns'] = sim_status_columns
        repl['sim_test_columns'] = sim_test_columns

        return base_tmpl.safe_substitute(repl)


    def plot_all(self, dir, simulator):
        """Generate all plots in directory dir, based on simulator"""
        ME = os.path.split(__file__)[1]
        longmsg = StringIO.StringIO()
        result = 0

        for sch in TESTDEFS[self.properties['symbol']]['schematics']:
            net = os.path.splitext(sch)[0] + '.net'
            gedaparts = os.path.abspath(os.path.join(BASE_DIR, 'scripts/geda-parts.scm'))
            command="gnetlist -g spice-sdb -l "+ gedaparts +" -o %(netfile)s %(schfile)s" \
                    % {'netfile': os.path.join(dir, net), 
                       'schfile': os.path.join(dir, sch)}
            print >>longmsg, ME, "creating netlist: ", command
            pop = popen2.Popen4(command)
            ret_gnetlist = pop.wait()
            print >>longmsg, pop.fromchild.read()
            if ret_gnetlist != 0:
                print >>longmsg, ME, "netlist creation failed with errorcode:", ret_gnetlist
            else:
                print >>longmsg, ME, "netlist creation was successful"

        sim_family = SIMULATORS[simulator]['simulator']
        simfile = 'simulate.' + sim_family
        try:
            f = open(os.path.join(dir, simfile), 'w').write(self.simulate_cmd(sim_family))
        except SimulatorError: 
            print >>longmsg, ME, "Error: no test definitions for %s" % sim_family
            result = 3
        else:
            command = "cd %s ; %s %s %s" % (dir,
                                            SIMULATORS[simulator]['command'],
                                            SIMULATORS[simulator]['options'],
                                            simfile)
            print >>longmsg, ME, "running simulation: ", command
            pop = popen2.Popen4(command)
            print >>longmsg, pop.fromchild.read()
            ret_simulation = pop.wait()
            if ret_simulation != 0:
                print >>longmsg, ME, "simulation failed with errorcode:", ret_simulation
            else:
                print >>longmsg, ME, "simulation run was successful"
      
            print >>longmsg, ME, "testing and plotting"
            for meth in self.plot_methods:
                try:
                    ret_plot = getattr(self, meth)(dir, longmsg)
                except Exception, data:
                    print >>longmsg, ME, "plotting function died:"
                    print >>longmsg, data
                    result = 1
                else:
                    if ret_plot != 0:
                        print >>longmsg, ME, "testing or plotting failed"
                        result = 2
            if result == 0:
                print >>longmsg, ME, "finished testing and plotting successfully"
        return longmsg.getvalue(), result
  
    def model_status(self, simulator):
        """Return the status of the part for the given simulator"""
        sim_family = SIMULATORS[simulator]['simulator']
        if simulator in self.properties['model_status_good'].split() and \
                simulator in self.properties['model_status_broken'].split():
            raise ValueError, "%s status listed as both good and bad for %s" % \
                    (simulator, self.name)
        if 'model_status_undefined' in self.properties:
            return 'undefined'
        elif sim_family in self.properties['model_status_good']:
            return 'good'
        elif sim_family in self.properties['model_status_broken']:
            return 'broken'
        else:
            return 'test'


class modelDiode(modelpartBase):
    section = 'diode'
    plot_methods = ['plot_forward_voltage', 'plot_reverse_voltage']
    simulator = 'ngspice'

    def forward_voltage_ok(self, If, Uf, longmsg):
        if numpy.any(Uf<0.0) or numpy.any(Uf>3.0):
            print >>longmsg, "forward voltage out of expected range [0.0, 3.0]"
            return False
        else:
            return True

    def plot_forward_voltage(self, dir, longmsg):
        pp = plotter()
        labels = ["0C", "25C", "50C", "75C", "100C"]
        ret = 0
        plots = spice_read.auto_read(
                os.path.join(dir, "forward_voltage.data")).get_plots()
        for n,pl in enumerate(plots):
            If = -pl.get_scalevector().get_data()
            Uf = pl.get_datavectors()[0].get_data()
            if not self.forward_voltage_ok(If, Uf, longmsg):
                ret = 1
            if not numpy.any(numpy.isnan(If)) and not numpy.any(numpy.isnan(Uf)):
                pp.semilogy(Uf, If*1000.0,label = labels[n])
        pp.ylabel("If [mA]")
        pp.xlabel("Uf [V]")
        pp.grid()
        pp.legend(loc="best")
        pp.savefig(os.path.join(dir, "dc_forward_voltage.png"),dpi=80)
        pp.close()
        return ret
  
    def plot_reverse_voltage(self, dir, longmsg):
        #Basic diode has no reverse voltage plot
        return 0

    def simulate_cmd_lines(self, sim_family):
        """Returns a list of lines that form the simulator command"""
        if sim_family == 'ngspice':
            return ['.include dc_current.net',
                    '.control',
                    'foreach t 0 25 50 75 100',
                    '  set temp =  $t',
                    '  dc i1 -10uA -1A -1mA',
                    'end',
                    'write forward_voltage.data dc1.V(in) dc2.V(in) dc3.V(in) dc4.V(in) dc5.V(in)',
                    '.endc']
        elif sim_family == 'gnucap':
            return ['.include dc_current.net',
                    '.print dc V(in)',
                    '.dc i1 -10uA -1A -1mA temp 0 > forward_voltage.data',
                    '.dc i1 -10uA -1A -1mA temp 25 >> forward_voltage.data',
                    '.dc i1 -10uA -1A -1mA temp 50 >> forward_voltage.data',
                    '.dc i1 -10uA -1A -1mA temp 75 >> forward_voltage.data',
                    '.dc i1 -10uA -1A -1mA temp 100 >> forward_voltage.data']

        else:
            raise SimulatorError


class modelZenerDiode(modelDiode):
    section = 'zener_diode'

    def forward_voltage_ok(self, If, Uf, longmsg):
        ind = numpy.where(If < 0.2)[0]
        if numpy.any(Uf[ind] < 0.0) or numpy.any(Uf[ind] > 2.0):
            print >>longmsg, "forward voltage out of expected range [0.0, 2.0]"
            return False
        else:
            return True

    def reverse_voltage_ok(self, Ir, Ur, longmsg):
        if numpy.any(-Ur < 0.0) or numpy.any(-Ur > 200.0):
            print >>longmsg, "reverse voltage out of expected range [0.0, 200.0]"
            return False
        else:
            return True

    def plot_reverse_voltage(self, dir, longmsg):
        pp = plotter()
        labels = ["0C", "25C", "50C", "75C", "100C"]
        ret = 0
        plots = spice_read.auto_read(
                os.path.join(dir, "reverse_voltage.data")).get_plots()
        for n,pl in enumerate(plots):
            Ir = pl.get_scalevector().get_data()
            Ur = pl.get_datavectors()[0].get_data()
            if not self.reverse_voltage_ok(Ir, Ur, longmsg):
                ret = 2
            if not numpy.any(numpy.isnan(Ir)) and not numpy.any(numpy.isnan(Ur)):
                pp.semilogy(-Ur, Ir * 1000.0, label = labels[n])
        pp.ylabel("Ir [mA]")
        pp.xlabel("Ur [V]")
        pp.grid()
        pp.legend(loc="best")
        pp.savefig(os.path.join(dir, "dc_reverse_voltage.png"),dpi=80)
        pp.close()
        return ret

    def simulate_cmd_lines(self, sim_family):
        """Returns a list of lines that form the simulator command"""
        if sim_family == 'ngspice':
            return ['.include dc_current.net',
                    '.control',
                    'foreach t 0 25 50 75 100',
                    '  set temp =  $t',
                    '  dc i1 -10uA -1A -1mA',
                    'end',
                    'write forward_voltage.data dc1.V(in) dc2.V(in) dc3.V(in) dc4.V(in) dc5.V(in)',
                    'foreach t 0 25 50 75 100',
                    '  set temp =  $t',
                    '  dc i1 10uA 1A 1mA',
                    'end',
                    'write reverse_voltage.data dc6.V(in) dc7.V(in) dc8.V(in) dc9.V(in) dc10.V(in)',
                    '.endc']
        elif sim_family == 'gnucap':
            return ['.include dc_current.net',
                    '.print dc V(in)',
                    '.dc i1 -10uA -1A -1mA temp 0 > forward_voltage.data',
                    '.dc i1 -10uA -1A -1mA temp 25 >> forward_voltage.data',
                    '.dc i1 -10uA -1A -1mA temp 50 >> forward_voltage.data',
                    '.dc i1 -10uA -1A -1mA temp 75 >> forward_voltage.data',
                    '.dc i1 -10uA -1A -1mA temp 100 >> forward_voltage.data',
                    '.dc i1 10uA 1A 1mA temp 0 > reverse_voltage.data',
                    '.dc i1 10uA 1A 1mA temp 25 >> reverse_voltage.data',
                    '.dc i1 10uA 1A 1mA temp 50 >> reverse_voltage.data',
                    '.dc i1 10uA 1A 1mA temp 75 >> reverse_voltage.data',
                    '.dc i1 10uA 1A 1mA temp 100 >> reverse_voltage.data' ]

        else:
            raise SimulatorError


class modelZenerBidirectional(modelZenerDiode):
    section = 'zener_bidirectional'

    def forward_voltage_ok(self, If, Uf, longmsg):
        if numpy.any(Uf < 0.5) or numpy.any(Uf > 200.0):
            print >>longmsg, "forward voltage out of expected range [0.5, 200.0]"
            return False
        else:
            return True

    def reverse_voltage_ok(self, Ir, Ur, longmsg):
        if numpy.any(Ur < -200.) or numpy.any(Ur > -0.5):
            print >>longmsg, "reverse voltage out of expected range [0.5, 200]"
            return False
        else:
          return True


class modelTransistor(modelpartBase):
    pass


class modelBipolar(modelTransistor):
    plot_methods = ['plot_dc_current_gain', 'plot_saturation_voltages']
    simulator = 'gnucap'

    def plot_dc_current_gain(self, dir, longmsg):
        pp = plotter()
        plots = spice_read.auto_read(
                os.path.join(dir, "dc_current_gain.data")).get_plots()
        for n, pl in enumerate(plots):
            #TODO: DRY.  Move this table as far up the object hierarchy as 
            #possible
            t = {0: '0 C', 1: '25 C', 2: '50 C', 3: '75 C', 4: '100 C'}[n]
            Ib = pl.get_scalevector().get_data()
            Ic = -pl.get_datavector(0).get_data()
            hfe = -Ic / Ib
            pp.semilogx(Ic * 1000, hfe, label=t)

        pp.xlabel("Ic [mA]")
        pp.ylabel("hfe")
        pp.grid()
        pp.legend(loc="best")
        pp.savefig(os.path.join(dir, "dc_current_gain.png"),dpi=80)
        pp.close()

        for n, pl in enumerate(plots):
            t = {0: '0 C', 1: '25 C', 2: '50 C', 3: '75 C', 4: '100 C'}[n]
            Ic = -pl.get_datavector(0).get_data()
            Vbe = pl.get_datavector(1).get_data()
            pp.semilogx(Ic * 1000, self.icc_sign * Vbe * 1000, label = t)
        pp.xlabel("Ic [mA]")
        pp.ylabel("V BE [mV]")
        pp.grid()
        pp.legend(loc='best')
        pp.savefig(os.path.join(dir, "base_emitter_voltage.png"),dpi=80)
        pp.close()
        return 0

    def plot_saturation_voltages(self, dir, longmsg):
        pp = plotter()
        plots = spice_read.auto_read(
                os.path.join(dir, "saturation_voltages.data")).get_plots()

        for n, pl in enumerate(plots):
            t = {0: '0 C', 1: '25 C', 2: '50 C', 3: '75 C', 4: '100 C'}[n]
            Ic = -pl.get_datavector(0).get_data()
            Vbe = pl.get_datavector(1).get_data()
            Vce = pl.get_datavector(2).get_data()
            ## only plot the values where Vce sat is smaller than a limit
            firstind = numpy.where(self.icc_sign * Vce < self.VCEsat_plot_limit)[0][0]
            Ic_plot = Ic
            pp.loglog(Ic[firstind:] * 1000, self.icc_sign * Vce[firstind:]*1000, label=t)
        pp.xlabel("Ic [mA]")
        pp.ylabel("VCE sat [mV]")
        pp.grid()
        pp.legend(loc='best')
        pp.savefig(os.path.join(dir, "vce_saturation_voltage.png"),dpi=80)
        pp.close()

        for n, pl in enumerate(plots):
            t = {0: '0 C', 1: '25 C', 2: '50 C', 3: '75 C', 4: '100 C'}[n]
            Ic = -pl.get_datavector(0).get_data()
            Vbe = pl.get_datavector(1).get_data()
            Vce = pl.get_datavector(2).get_data()
            pp.semilogx(Ic * 1000, self.icc_sign * Vbe * 1000, label = t)
        pp.xlabel("Ic [mA]")
        pp.ylabel("V BE sat [mV]")
        pp.grid()
        pp.legend(loc='best')
        pp.savefig(os.path.join(dir, "vbe_saturation_voltage.png"),dpi=80)
        pp.close()
        return 0

    def simulate_cmd_lines(self, sim_family):
        """Returns a list of lines that form the simulator command"""
        if sim_family == 'ngspice':
            return [ '.include dc_current_gain.net',
                '.control',
                'foreach t 0 25 50 75 100',
                '  set temp = $t',
                '  dc i1 -1m -10n 1u',
                'end',
                'write dc_current_gain.data dc1.I(V1) dc1.V(in) dc2.I(V1) dc2.V(in) dc3.I(V1) dc3.V(in) dc4.I(V1) dc4.V(in) dc5.I(V1) dc5.V(in)',
                '.endc',
                '.control',
                'source saturation_voltages.net',
                'foreach t 0 25 50 75 100',
                '  set temp = $t',
                '  dc V2 0.45 1.0 0.05',
                'end',
                'write saturation_voltages.data dc6.I(V1) dc6.V(in) dc6.V(out)  dc7.I(V1) dc7.V(in) dc7.V(out)  dc8.I(V1) dc8.V(in) dc8.V(out)  dc9.I(V1) dc9.V(in) dc9.V(out)  dc10.I(V1) dc10.V(in) dc10.V(out)',
                '.endc']
        elif sim_family == 'gnucap':
            return ['.get dc_current_gain.net',
                '.pr dc I(V1) V(in)',
                '.dc i1 -1m -10n * 0.8 temp=0 > dc_current_gain.data',
                '.dc i1 -1m -10n * 0.8 temp=25 >> dc_current_gain.data',
                '.dc i1 -1m -10n * 0.8 temp=50 >> dc_current_gain.data',
                '.dc i1 -1m -10n * 0.8 temp=75 >> dc_current_gain.data',
                '.dc i1 -1m -10n * 0.8 temp=100 >> dc_current_gain.data',
                '.get saturation_voltages.net',
                '.pr dc I(V1) V(in) V(out)',
                '.dc V2 0.45 1.0 by 0.05 temp=0 > saturation_voltages.data',
                '.dc V2 0.45 1.0 by 0.05 temp=25 >> saturation_voltages.data',
                '.dc V2 0.45 1.0 by 0.05 temp=50 >> saturation_voltages.data',
                '.dc V2 0.45 1.0 by 0.05 temp=75 >> saturation_voltages.data',
                '.dc V2 0.45 1.0 by 0.05 temp=100 >> saturation_voltages.data']
        else:
            raise SimulatorError


class modelDarlington(modelBipolar):
    VCEsat_plot_limit = 2.0  #amps
    def simulate_cmd_lines(self, sim_family):
        """Returns a list of lines that form the simulator command"""
        if sim_family == 'ngspice':
            return ['.include dc_current_gain.net',
                '.control',
                'foreach t 0 25 50 75 100',
                '  set temp = $t',
                '  dc i1 -10u -100p 10n',
                'end',
                'write dc_current_gain.data dc1.I(V1) dc1.V(in) dc2.I(V1) dc2.V(in) dc3.I(V1) dc3.V(in) dc4.I(V1) dc4.V(in) dc5.I(V1) dc5.V(in)',
                '.endc',
                '.control',
                'source saturation_voltages.net',
                'foreach t 0 25 50 75 100',
                '  set temp = $t',
                '  dc V2 0.9 2.0 0.1',
                'end',
                'write saturation_voltages.data dc6.I(V1) dc6.V(in) dc6.V(out) dc7.I(V1) dc7.V(in) dc7.V(out) dc8.I(V1) dc8.V(in) dc8.V(out) dc9.I(V1) dc9.V(in) dc9.V(out) dc10.I(V1) dc10.V(in) dc10.V(out)',
                '.endc']
        elif sim_family == 'gnucap':
            return ['.get dc_current_gain.net',
                '.pr dc I(V1) V(in)',
                '.dc i1 -10u -100p * 0.8 temp=0 > dc_current_gain.data',
                '.dc i1 -10u -100p * 0.8 temp=25 >> dc_current_gain.data',
                '.dc i1 -10u -100p * 0.8 temp=50 >> dc_current_gain.data',
                '.dc i1 -10u -100p * 0.8 temp=75 >> dc_current_gain.data',
                '.dc i1 -10u -100p * 0.8 temp=100 >> dc_current_gain.data',
                '.get saturation_voltages.net',
                '.pr dc I(V1) V(in) V(out)',
                '.dc V2 0.9 2.0 by 0.1 temp=0 > saturation_voltages.data',
                '.dc V2 0.9 2.0 by 0.1 temp=25 >> saturation_voltages.data',
                '.dc V2 0.9 2.0 by 0.1 temp=50 >> saturation_voltages.data',
                '.dc V2 0.9 2.0 by 0.1 temp=75 >> saturation_voltages.data',
                '.dc V2 0.9 2.0 by 0.1 temp=100 >> saturation_voltages.data']
        else:
            raise SimulatorError

class modelNPNBipolar(modelBipolar):
    VCEsat_plot_limit = 1.0  #amps
    section = 'npn_bipolar'
    icc_sign = 1. #Sign of the collector current


class modelNPNDarlington(modelDarlington):
    section = 'npn_darlington'
    icc_sign = 1. #Sign of the collector current


class modelPNPBipolar(modelBipolar):
    VCEsat_plot_limit = 1.0  #amps
    section = 'pnp_bipolar'
    icc_sign = -1. #Sign of the collector current


class modelPNPDarlington(modelDarlington):
    section = 'pnp_darlington'
    icc_sign = -1. #Sign of the collector current


class modelResistorEquippedTransistor(modelBipolar):
    """Base class transistors with base and/or collector resistors"""
    plot_methods = ['plot_dc_current']

    def base_current_ok(self, Uin, Iin, longmsg):
        if numpy.any(Iin < -.001) or numpy.any(Iin > 0.1):
            print >>longmsg, "input current out of expected range [-0.001, 1.0]"
            return False
        else:
            return True

    def collector_current_ok(self, Uin, Ic, longmsg):
        if numpy.any(Ic < -.001) or numpy.any(Ic > 100.0):
            print >>longmsg, "collector current out of expected range [-0.001, 100.0]"
            return False
        elif not numpy.any(Ic > 0.003):
            return False
        else:
            return True

    def plot_dc_current(self, dir, longmsg):
        ret = 0
        pp = plotter()
        plots = spice_read.auto_read(os.path.join(dir, "dc_current.data")
                ).get_plots()

        for n, pl in enumerate(plots):
            t = {0: '0 C', 1: '25 C', 2: '50 C', 3: '75 C', 4: '100 C'}[n]
            Vbe  = pl.get_scalevector().get_data()
            Ib = -pl.get_datavector(0).get_data()
            if not self.base_current_ok(Vbe, Ib, longmsg):
                ret = 1
            pp.plot(Vbe, Ib * 1000, label=t)

        pp.xlabel("Vin [V]")
        pp.ylabel("IB [mA]")
        pp.grid()
        pp.legend(loc="best")
        pp.savefig(os.path.join(dir, "dc_IB.png"), dpi=80)
        pp.close()

        for n, pl in enumerate(plots):
            t = {0: '0 C', 1: '25 C', 2: '50 C', 3: '75 C', 4: '100 C'}[n]
            Vbe  = pl.get_scalevector().get_data()
            Ib = pl.get_datavector(0).get_data()
            Ic = -pl.get_datavector(1).get_data()
            if not self.collector_current_ok(Vbe, Ic, longmsg):
                ret = 1
            pp.plot(Vbe, Ic * 1000,label=t)
        pp.xlabel("Vin [V]")
        pp.ylabel("IC [mA]")
        pp.grid()
        pp.legend(loc='best')
        pp.savefig(os.path.join(dir, "dc_IC.png"), dpi=80)
        pp.close()
        return ret

    def simulate_cmd_lines(self, sim_family):
        if sim_family == 'ngspice':
            return ['.include dc_current.net',
                '.control',
                'foreach t 0 25 50 75 100',
                '  set temp = $t',
                '  dc v1 0 5 0.1',
                'end',
                'write dc_current.data dc1.I(V1) dc1.I(V2) dc2.I(V1) dc2.I(V2) dc3.I(V1) dc3.I(V2) dc4.I(V1) dc4.I(V2) dc5.I(V1) dc5.I(V2)',
                '.endc', ]
        elif sim_family == 'gnucap':
            return ['.get dc_current.net',
                '.pr dc I(V1) I(V2)',
                '.dc v1 0 5 0.1 temp=0 > dc_current.data',
                '.dc v1 0 5 0.1 temp=25 >> dc_current.data',
                '.dc v1 0 5 0.1 temp=50 >> dc_current.data',
                '.dc v1 0 5 0.1 temp=75 >> dc_current.data',
                '.dc v1 0 5 0.1 temp=100 >> dc_current.data', ]
        else:
            raise SimulatorError


class modelPNPRbase(modelResistorEquippedTransistor):
    section = 'pnp_rbase'


class modelNPNRbase(modelResistorEquippedTransistor):
    section = 'npn_rbase'


class modelBipolarBin(modelResistorEquippedTransistor):
    plot_methods = ['plot_dc_current']
    simulator = 'gnucap'



class modelPNPBin(modelBipolarBin):
    section = 'pnp_bin'


class modelNPNBin(modelBipolarBin):
    section = 'npn_bin'


class modelOpamp(modelpartBase):
    section = 'opamp'
    plot_methods = ['plot_dc_amplifier', 'plot_ac_amplifier']
    simulator = 'ngspice'

    def plot_ac_amplifier(self, dir, longmsg):
        ret = 0
        pp = plotter()
        
        plots = spice_read.auto_read(
                os.path.join(dir, "ac_amplifier.data")).get_plots()
        x = plots[0].get_scalevector().get_data()
        vin = plots[0].get_datavectors()[0].get_data()
        vout = plots[0].get_datavectors()[1].get_data()
        
        pp.subplot(2,1,1)
        pp.loglog(x, numpy.abs(vout / vin), label="magnitude v(out)")
        pp.xlabel("Frequency [Hz]")
        pp.ylabel("U [V]")
        pp.grid()
        pp.subplot(2,1,2)
        pp.semilogx(x, 180. / numpy.pi * numpy.angle(vout), label="theta v(out)")
        pp.xlabel("Frequency [Hz]")
        pp.ylabel("theta (degrees)")
        pp.grid()
        pp.legend(loc="best")
        pp.savefig(os.path.join(dir, "ac_amplifier.png"), dpi=80)
        pp.close()
        return ret

    def plot_dc_amplifier(self, dir, longmsg):
        ret = 0
        pp = plotter()
        
        plots = spice_read.auto_read(
                os.path.join(dir, "dc_amplifier.data")).get_plots()
        x = plots[0].get_scalevector().get_data()
        vin = plots[0].get_datavector(0).get_data()
        vout = plots[0].get_datavector(1).get_data()
        if not self.voltage_ok(vin, vout, longmsg):
            ret = 1
        
        pp.subplot(1,1,1)
        pp.plot(x, vin, label="v(in)")
        pp.plot(x, vout, label="v(out)")
        pp.xlabel("Uin [V]")
        pp.ylabel("U [V]")
        pp.grid()
        pp.legend(loc="best")
        pp.savefig(os.path.join(dir, "dc_amplifier.png"), dpi=80)
        pp.close()
        return ret

    def simulate_cmd_lines(self, sim_family):
        """Returns a list of lines that form the simulator command"""
        vsupply = self.vsupply() / 2.
        vstart = - vsupply - 0.5
        vend = vsupply + 0.5
        vstep = (vend - vstart) / 200.
        if sim_family == 'ngspice':
            return ['.include ac_amplifier.net',
                    '.control',
                    "alter v2 %fV" % vsupply,
                    "alter v3 %fV" % vsupply,
                    "dc v1 %f %f %f" % (vstart, vend, vstep),
                    "write dc_amplifier.data dc1.V(in) dc1.V(out)",
                    '*.endc',
                    "*.source ac_amplifier.net",
                    '*.control',
                    'ac DEC 25 10 1000000000',
                    'write ac_amplifier.data ac1.V(in) ac1.V(out)',
                    '.endc']
        elif sim_family == 'gnucap':
            return ['.include ac_amplifier.net',
                    '.alter v2 2.500000V',
                    '.alter v3 2.500000V',
                    '.print dc V(in) V(out)',
                    '.dc v1 -3.000000 3.000000 0.030000 > dc_amplifier.data',
                    '.print ac Vr(in) Vi(in) Vr(out) Vi(out)',
                    '.op',
                    '.ac DEC 25 10 1000000000 > ac_amplifier.data']
        else:
            raise SimulatorError

    def voltage_ok(self, vin, vout, longmsg):
        success = True
        vs = self.vsupply() / 2.
        vmax = vs + 0.5
        vmin = -vs - 0.5
        vmargin = .1
        if numpy.any(numpy.isnan(vin)) or numpy.any(numpy.isnan(vout)):
            print >>longmsg, "NaN in data"
            success = False
        if numpy.any(vin > vmax + vmargin) or numpy.any(vin < vmin - vmargin):
            print >>longmsg, "input voltage out of expected range [%f, %f]" % (vmin, vmax)
            success = False
        if numpy.any(vout > vmax + vmargin) or numpy.any(vout < vmin - vmargin):
            print >>longmsg, "output voltage out of expected range [%f, %f]" % (vmin, vmax)
            success = False
        if max(vout) - min(vout) < vs / 100.:
            print >>longmsg, 'output voltage is not a function of input voltage'
            success = False
        t1 = len(vin) / 2 - 10
        t2 = len(vin) / 2 + 10
        if not numpy.allclose(2 * vin[t1:t2], vout[t1:t2], rtol=.01, atol=.1):
            #We can't have a very tight tolerance here because input offset 
            #voltages have a large effect when the voltage is near 0
            print >>longmsg, 'Circuit does not achieve correct amplification'
            success = False
        return success

    def vsupply(self):
        return float(self.properties.get('test_vsupply', 5))
          

class modelComparator(modelOpamp):
    section = 'comparator'
    plot_methods = ['plot_transient']
    simulator='ngspice'

    def plot_transient(self, dir, longmsg):
        ret = 0
        pp = plotter()
        plots = spice_read.auto_read(
                os.path.join(dir, 'switching.data')).get_plots()
        x = plots[0].get_scalevector().get_data()
        vin = plots[0].get_datavectors()[0].get_data()
        vout = plots[0].get_datavectors()[1].get_data()
        if not self.trans_voltage_ok(vin, vout, longmsg):
            ret = 1
        pp.plot(x, vin, label="v(in)")
        pp.plot(x, vout, label="v(out)")
        pp.xlabel("Uin [V]")
        pp.ylabel("U [V]")
        pp.grid()
        pp.legend(loc="best")
        pp.savefig(os.path.join(dir, "dc_amplifier.png"), dpi=80)
        pp.close()
        return ret

    def simulate_cmd_lines(self, sim_family):
        vsupply = self.vsupply()
        vstart = -0.5
        vend = vsupply + 0.5
        twidth = 50e-6   #convenient value for typical comparator
        period = 10 * twidth
        trise = twidth / 2
        tfall = trise
        tstep = period / 200
        if sim_family == 'ngspice':
            return ['.include switching.net',
                '.control',
                'alter v2 %fV' % vsupply,
                #VPULSE parameters: V1 V2 TD TR TF PW PER
                #XXX: the alter command does not seem to work for PULSE sources
                #in ngspice
                'alter v1 [ %e %e 0 %e %e %e %e  ]' % (vstart, vend, trise, tfall, 1e-10, period),
                'tran %e %e' % (tstep, twidth),
                'write switching.data tran1.V(in) tran1.V(out) tran1.V(vsource)',
                '.endc']
        elif sim_family == 'gnucap':
            return  ['.include switching.net',
                '.alter v2 %fV' % vsupply,
                #VPULSE parameters: V1 V2 TD TR TF PW PER
                '.alter v1 [ %e %e 0 %e %e %e %e  ]' % 
                    (vstart, vend, trise, tfall, 1e-10, period),
                '.print tran V(in) V(out) V(vsource)',
                '.tran %e %e' % (tstep, twidth),
                ]

        else:
            raise SimulatorError

    def trans_voltage_ok(self, vin, vout, longmsg):
        success = True
        vss = 0
        vdd = self.vsupply()
        vmargin = 0.5
        if vout[0] > vss + vmargin or vout[-1] > vss + vmargin:
            print >>longmsg, "Circuit does not output low"
            success = False
        if max(vout) < vdd - vmargin:
            print >>longmsg, "Circuit does not output high"
            success = False
        return success


class modelCFA(modelOpamp):
    section = 'cfa'


class modellibrary(object):
    def __init__(self, indexfilename):
        self.indexfilename = indexfilename
        self.load_library_index()
        self.test_library_index()

    def load_library_index(self):
        self.index = MyConfigParser()
        if not os.path.exists(self.indexfilename):
            raise IOError('File "%s" does not exist' % self.indexfilename)
        self.index.read(self.indexfilename)
        self.testdir = self.index.get("GLOBAL","TESTDIR")
        self.modeldir = self.index.get("GLOBAL","MODELDIR")
        self.description = self.index.get("GLOBAL","DESCRIPTION")
        self.golden_md5 = self.load_md5sums(BASE_DIR + self.index.get("GLOBAL","GOLDEN_CHECKSUMS"))

        self.modelparts = {}

        for sec in self.index.sections():
            if sec == "GLOBAL":
                continue
            self.load_device(sec)

    def load_device(self, sec):
        modeltestdir = os.path.join(self.testdir, sec)
        part = modelpart(sec, modeltestdir, self.modeldir, self.index.items(sec))
        modelpath = os.path.join(self.modeldir, part.properties['file'])
        part.golden_checksum = self.golden_md5.get(modelpath, False)
        self.modelparts[part.name] = part

    def test_library_index(self):
        """
        test the used model files against the files in the index
        """
        files_index = set()
        self.modelfiles_used_twice = set()

        for sec in self.index.sections():
            if sec == "GLOBAL":
                continue
            modelfile = self.index.get(sec, 'file')
            if modelfile in files_index:
                self.modelfiles_used_twice.add(modelfile)
            else:
                files_index.add(modelfile)

        modeldir = self.index.get('GLOBAL', 'MODELDIR')
        files_directory = set(os.listdir(modeldir))
        self.modelfiles_unused = files_directory - files_index
        self.modelfiles_not_found = files_index - files_directory
            
    def load_md5sums(self, filename):
        try:
            lines = open(filename, "rt").readlines()
        except IOError:
            lines = []
        md5 = {}
        for l in lines:
            tok = string.split(string.strip(l),"  ")
            md5[tok[1]] = tok[0]
        return md5

    def save_md5sums(self):
        fid = open(BASE_DIR + self.index.get("GLOBAL","GOLDEN_CHECKSUMS"),'wb')
        for k,v in sorted(self.golden_md5.items()):
            fid.write(v + '  ' + k + '\n')

    def test(self, status=None, checksum=None):
        partnames = self.modelparts.keys()
        partnames.sort(sort_modelnumber)

        for partname in partnames:
            part = self.modelparts[partname]

            if status != None:
                if status != part.properties['model_status']:
                    continue
            if checksum != None:
                if checksum != part.checksum_status:
                    continue

            print "\n" + "*"*75
            print "Testing part: " + part.name + "  model: " + os.path.join(self.modeldir,part.properties["file"])
            part.test()
            part.cfg_status()
            print "Result: ", part.test_status

    def htmlindex(self):
        rows = []
        partnames = self.modelparts.keys()
        partnames.sort(sort_modelnumber)

        for part in partnames:
            rows.append(self.modelparts[part].html_status())
        
        lib = {"indexfile": self.indexfilename,
               "testdir": self.testdir,
               "modeldir": self.modeldir,
               "title": self.description,
               "model_rows": '\n'.join(rows),
               "modelfiles_not_found": ', '.join(list(self.modelfiles_not_found)),
               "modelfiles_used_twice": ', '.join([self.model_url(s) for s in self.modelfiles_used_twice]),
               "modelfiles_unused": ', '.join([self.model_url(s) for s in self.modelfiles_unused])}

        if not os.path.isdir(self.testdir):
            os.makedirs(self.testdir)

        html_template = string.Template(open(BASE_DIR + TEMPLATE_FILE).read())
        simulator_headers = ''
        for sim in SIMULATORS:
            simulator_headers += "<th>%s</th>\n" % sim
        lib['simulator_headers'] = simulator_headers
        open(os.path.join(self.testdir, "index.html"), "w").write(html_template.safe_substitute(lib))

    def model_url(self, modelname):
        modeldir = self.index.get('GLOBAL','MODELDIR')
        return '<a href="%s">%s</a>' % (os.path.join('../../../', modeldir, modelname), modelname)

    def test_single(self, partname):
        part = self.modelparts.get(partname, None)
        if part == None:
            raise KeyError

        print "Testing part: " + part.name + "  model: " + os.path.join(self.modeldir, part.properties["file"])
        part.test()
        part.cfg_status()
        print "Result: ", part.test_status, "\n"

    def get_devices(self):
        partnames = self.modelparts.keys()
        partnames.sort(sort_modelnumber)
        return partnames

    def get_devicetext(self, partname):
        items = self.index.items(partname)
        text = '\n'.join(['='.join([a,b]) for a,b in items])
        return text

    def set_devicetext(self, partname, text):
        opts = set(self.index.options(partname))
        for line in text.split('\n'):
            option, value = line.split('=',1)
            self.index.set(partname, option, value)
            if option in opts:
                opts.remove(option)
        for o in opts:
            self.index.remove_option(partname, o)
        self.load_device(partname)
        self.index.write(open(self.indexfilename, 'wb'))

    def get_modeltext(self, partname):
        filename = self.index.get(partname, 'file')
        return open(os.path.join(self.modeldir, filename)).read()

    def sign_checksum(self, partname):
        part = self.modelparts[partname]
        part.update_checksum()
        part.golden_checksum = part.current_checksum
        part.update_checksum()
        modelfile = os.path.join(part.modeldir, part.properties['file'])
        
        self.golden_md5[modelfile] = part.golden_checksum
        self.save_md5sums()

    def set_model_status(self, partname, sim, status):
        if status == 'good':
            if self.index.has_option(partname, 'model_status_good'):
                good = self.index.get(partname, 'model_status_good')
                if sim not in good:
                    self.index.set(partname,'model_status_good', good + ' ' + sim)
            else:
                self.index.set(partname,'model_status_good', sim)
            if self.index.has_option(partname, 'model_status_broken'):
                broken = self.index.get(partname, 'model_status_broken')
                if sim in broken:
                    broken_new = broken.replace(sim,'').strip()
                    if len(broken_new):
                        self.index.set(partname, 'model_status_broken', broken_new)
                    else:
                        self.index.remove_option(partname, 'model_status_broken')
        elif status == 'broken':
            if self.index.has_option(partname, 'model_status_broken'):
                broken = self.index.get(partname, 'model_status_broken')
                if sim not in broken:
                    self.index.set(partname,'model_status_broken', broken + ' ' + sim)
            else:
                self.index.set(partname,'model_status_broken', sim)
            if self.index.has_option(partname, 'model_status_good'):
                good = self.index.get(partname, 'model_status_good')
                if sim in good:
                    good_new = good.replace(sim,'').strip()
                    if len(good_new):
                        self.index.set(partname, 'model_status_good', good_new)
                    else:
                        self.index.remove_option(partname, 'model_status_good')

        if status in ['broken', 'good']:
            if self.index.has_option(partname, 'model_status_test'):
                self.index.remove_option(partname, 'model_status_test')
            if self.index.has_option(partname, 'model_status_undefined'):
                self.index.remove_option(partname, 'model_status_undefined')

        self.load_device(partname)
        self.index.write(open(self.indexfilename, 'wb'))

    def get_model_status(self, partname, sim):
        return self.modelparts[partname].model_status(sim)
        
        

#################### FUNCTIONS

def color(key):
    return COLORS.get(key, COLORS["default"])


def make_doc_hyperlink(repl, docname=None):
    if docname == None:
      docname = repl['documentation']
    if re.match('http://', repl.get('documentation', '')):
        repl["documentation"] = '<a href="'+ repl["documentation"] +'">' + docname + '</a>'


def sort_modelnumber(a,b):
    aa = string.split(a,"_")[-1]
    bb = string.split(b,"_")[-1]
    return cmp(aa,bb)


def usage():
    print "usage is:"
    print "  -i --index libraryname1 [libraryname2, ..]"
    print "  -t --test libraryname1 [libraryname2, ..]"
    print "  -p --part libraryname partname1 [partname2, ..]"
    print "  -s --status status: check/list only one given status"
    print "  -c --checksum checksum: check/list only one checksum status"


#################### MAIN

if __name__ == "__main__":
    import getopt

    try:
        opts, args = getopt.getopt(sys.argv[1:], "tips:c:",
                                   ["test","index","part","status=","checksum="])
    except getopt.GetoptError:
        # print help information and exit:
        usage()
        sys.exit(2)

    if len(args) < 1:
        usage()
        sys.exit(2)

    mode="undefined"
    status = None
    checksum = None

    for o, a in opts:
        if o in ("-i","--index"):
            mode = "index"
        if o in ("-t","--test"):
            mode = "test"
        if o in ("-p", "--part"):
            mode = "part"
        if o in ("-s", "--status"):
            status = a
        if o in ("-c", "--checksum"):
            checksum = a

    if mode == "undefined":
        usage()
        sys.exit(2)
    elif mode == "index":
        for arg in args:
            library = modellibrary(arg)
            library.htmlindex()
    elif mode == "test":
        for arg in args:
            library = modellibrary(arg)
            library.htmlindex()
            library.test(checksum=checksum, status=status)
            library.htmlindex()
    elif mode == "part":
        if len(args) < 2:
            usage()
            sys.exit(2)
        
        library = modellibrary(args[0])
        for arg in args[1:]:
            library.test_single(arg)
        library.htmlindex()
    
    
    

