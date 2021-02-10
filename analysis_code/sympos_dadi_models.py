#!/usr/bin/env python2.7
# note that this is in python 2.7! (sorry)

'''
Made by Ethan Gyllenhaal (egyllenhaal@unm.edu)
Last updated 9 February 2021

Script outlining dadi models, HEAVILY borrowed from dadi twoPop specifications.
I only include the models used in the paper.
'''

"""
Two population demographic models.
"""
import numpy
import dadi
from dadi import Numerics, PhiManip, Integration
from dadi.Spectrum_mod import Spectrum

def split_mig(params, ns, pts):
    """
    params = (nu1,nu2,T,m12,m21)
    ns = (n1,n2)

    Split into two populations of specified size, with migration.

    nu1: Size of population 1 after split.
    nu2: Size of population 2 after split.
    T: Time in the past of split (in units of 2*Na generations) 
    m12: Migration rate for 2>>1 (2*Na*m)
    m21: Migration rate for 1>>2 (2*Na*m)
    n1,n2: Sample sizes of resulting Spectrum
    pts: Number of grid points to use in integration.
    """
    nu1,nu2,T,m12,m21 = params
    xx = Numerics.default_grid(pts)
    phi = PhiManip.phi_1D(xx)
    phi = PhiManip.phi_1D_to_2D(xx, phi)
    phi = Integration.two_pops(phi, xx, T, nu1, nu2, m12=m12, m21=m21)
    fs = Spectrum.from_phi(phi, ns, (xx,xx))
    return fs

def split_m12(params, ns, pts):
    """
    params = (nu1,nu2,T,m12)
    ns = (n1,n2)

    Split into two populations of specified size, with bidirectional migration.

    nu1: Size of population 1 after split.
    nu2: Size of population 2 after split.
    T: Time in the past of split (in units of 2*Na generations)
    m12: Migration rate 2>>1
    n1,n2: Sample sizes of resulting Spectrum
    pts: Number of grid points to use in integration.
    """
    nu1,nu2,T,m12 = params
    return split_mig([nu1, nu2, T, m12, 0], ns, pts)


def split_m21(params, ns, pts):

    """
    params = (nu1,nu2,T,m21)
    ns = (n1,n2)

    Split into two populations of specified size, with bidirectional migration.

    nu1: Size of population 1 after split.
    nu2: Size of population 2 after split.
    T: Time in the past of split (in units of 2*Na generations)
    m21: Migration rate 1>>2
    n1,n2: Sample sizes of resulting Spectrum
    pts: Number of grid points to use in integration.
    """
    nu1,nu2,T,m21 = params
    return split_mig([nu1, nu2, T, 0, m21], ns, pts)

def split_nomig(params, ns, pts):

    """
    params = (nu1,nu2,T)
    ns = (n1,n2)
    Split into two populations of specified size, with no migration.

    nu1: Size of population 1 after split.
    nu2: Size of population 2 after split.
    T: Time in the past of split (in units of 2*Na generations)
    n1,n2: Sample sizes of resulting Spectrum
    pts: Number of grid points to use in integration.
    """
    nu1,nu2,T= params
    return split_mig([nu1, nu2, T, 0, 0], ns, pts)
    
def admix12(params, ns, pts):
    """
    params = (nu1, nu2, T1, T2, f)
    ns = (n1,n2)

    Split into two populations of specifed size, with migration.

    nu1: Size of population 1 after split.
    nu2: Size of population 2 after split.
    T1: Time in the past of from split to admixture (in units of 2*Na generations) 
    T2: time in past from admixture to present
    f: proportion admixed (1>>2)
    n1,n2: Sample sizes of resulting Spectrum
    pts: Number of grid points to use in integration.
    """
    nu1,nu2,T1,T2,f = params
    xx = Numerics.default_grid(pts)
    phi = PhiManip.phi_1D(xx)
    phi = PhiManip.phi_1D_to_2D(xx, phi)
    phi = Integration.two_pops(phi, xx, T1, nu1, nu2, m12=0, m21=0)
    phi = dadi.PhiManip.phi_2D_admix_1_into_2(phi, f, xx, xx)
    phi = Integration.two_pops(phi, xx, T2, nu1, nu2, m12=0, m21=0)
    fs = Spectrum.from_phi(phi, ns, (xx,xx))
    return fs
    
def admix21(params, ns, pts):
    """
    params = (nu1, nu2, T1, T2, f)
    ns = (n1,n2)

    Split into two populations of specifed size, with migration.

    nu1: Size of population 1 after split.
    nu2: Size of population 2 after split.
    T1: Time in the past of from split to admixture (in units of 2*Na generations) 
    T2: time in past from admixture to present
    f: proportion admixed (2>>1)
    n1,n2: Sample sizes of resulting Spectrum
    pts: Number of grid points to use in integration.
    """
    nu1,nu2,T1,T2,f = params
    xx = Numerics.default_grid(pts)
    phi = PhiManip.phi_1D(xx)
    phi = PhiManip.phi_1D_to_2D(xx, phi)
    phi = Integration.two_pops(phi, xx, T1, nu1, nu2, m12=0, m21=0)
    phi = dadi.PhiManip.phi_2D_admix_2_into_1(phi, f, xx, xx)
    phi = Integration.two_pops(phi, xx, T2, nu1, nu2, m12=0, m21=0)
    fs = Spectrum.from_phi(phi, ns, (xx,xx))
    return fs

    
def admix12_mig(params, ns, pts):
    """
    params = (nu1,nu2,T1,T2,f,m12,m21)
    ns = (n1,n2)

    Split into two populations of specifed size, with migration.

    nu1: Size of population 1 after split.
    nu2: Size of population 2 after split.
    T1: Time in the past of from split to admixture (in units of 2*Na generations) 
    T2: time in past from admixture to present
    m12: Migration rate for 2>>1 (2*Na*m)
    m21: Migration rate for 1>>2 (2*Na*m)
    f: proportion admixed (1>>2)
    n1,n2: Sample sizes of resulting Spectrum
    pts: Number of grid points to use in integration.
    """
    nu1,nu2,T1,T2,f,m12,m21 = params
    xx = Numerics.default_grid(pts)
    phi = PhiManip.phi_1D(xx)
    phi = PhiManip.phi_1D_to_2D(xx, phi)
    phi = Integration.two_pops(phi, xx, T1, nu1, nu2, m12=m12, m21=m21)
    phi = dadi.PhiManip.phi_2D_admix_1_into_2(phi, f, xx, xx)
    phi = Integration.two_pops(phi, xx, T2, nu1, nu2, m12=m12, m21=m21)

    fs = Spectrum.from_phi(phi, ns, (xx,xx))
    return fs    
    
def admix21_mig(params, ns, pts):
    """
    params = (nu1,nu2,T1,T2,f,m12, m21)
    ns = (n1,n2)

    Split into two populations of specifed size, with migration.

    nu1: Size of population 1 after split.
    nu2: Size of population 2 after split.
    T1: Time in the past of from split to admixture (in units of 2*Na generations) 
    T2: time in past from admixture to present
    m12: Migration rate for 2>>1 (2*Na*m)
    m21: Migration rate for 1>>2 (2*Na*m)
    f: proportion admixed (2>>1)
    n1,n2: Sample sizes of resulting Spectrum
    pts: Number of grid points to use in integration.
    """
    nu1,nu2,T1,T2,f,m12,m21 = params
    xx = Numerics.default_grid(pts)
    phi = PhiManip.phi_1D(xx)
    phi = PhiManip.phi_1D_to_2D(xx, phi)
    phi = Integration.two_pops(phi, xx, T1, nu1, nu2, m12=m12, m21=m21)
    phi = dadi.PhiManip.phi_2D_admix_2_into_1(phi, f, xx, xx)
    phi = Integration.two_pops(phi, xx, T2, nu1, nu2, m12=m12, m21=m21)

    fs = Spectrum.from_phi(phi, ns, (xx,xx))
    return fs       

def admixBidir(params, ns, pts):
    """
    params = (nu1, nu2, T1, T2, f1, f2)
    ns = (n1,n2)

    Split into two populations of specifed size, with migration.

    nu1: Size of population 1 after split.
    nu2: Size of population 2 after split.
    T1: Time in the past of from split to admixture (in units of 2*Na generations) 
    T2: time in past from admixture to present
    f1: proportion admixed 1>>2
    f2: proportion admixed 2>>1
    n1,n2: Sample sizes of resulting Spectrum
    pts: Number of grid points to use in integration.
    """
    nu1,nu2,T1,T2,f1,f2 = params
    xx = Numerics.default_grid(pts)
    phi = PhiManip.phi_1D(xx)
    phi = PhiManip.phi_1D_to_2D(xx, phi)
    phi = Integration.two_pops(phi, xx, T1, nu1, nu2, m12=0, m21=0)
    phi = dadi.PhiManip.phi_2D_admix_1_into_2(phi, f1, xx, xx)
    phi = dadi.PhiManip.phi_2D_admix_2_into_1(phi, f2, xx, xx)
    phi = Integration.two_pops(phi, xx, T2, nu1, nu2, m12=0, m21=0)
    fs = Spectrum.from_phi(phi, ns, (xx,xx))
    return fs

def admixBidirMig(params, ns, pts):
    """
    params = (nu1,nu2,T1,T2,f,m12,m21)
    ns = (n1,n2)

    Split into two populations of specifed size, with migration.

    nu1: Size of population 1 after split.
    nu2: Size of population 2 after split.
    T1: Time in the past of from split to admixture (in units of 2*Na generations) 
    T2: time in past from admixture to present
    m12: Migration rate for 2>>1 (2*Na*m)
    m21: Migration rate for 1>>2 (2*Na*m)
    f1: proportion admixed 1>>2
    f2: proportion admixed 2>>1
    n1,n2: Sample sizes of resulting Spectrum
    pts: Number of grid points to use in integration.
    """
    nu1,nu2,T1,T2,f1,f2,m12,m21 = params
    xx = Numerics.default_grid(pts)
    phi = PhiManip.phi_1D(xx)
    phi = PhiManip.phi_1D_to_2D(xx, phi)
    phi = Integration.two_pops(phi, xx, T1, nu1, nu2, m12=m12, m21=m21)
    phi = dadi.PhiManip.phi_2D_admix_1_into_2(phi, f1, xx, xx)
    phi = dadi.PhiManip.phi_2D_admix_2_into_1(phi, f2, xx, xx)
    phi = Integration.two_pops(phi, xx, T2, nu1, nu2, m12=m12, m21=m21)
    fs = Spectrum.from_phi(phi, ns, (xx,xx))
    return fs 