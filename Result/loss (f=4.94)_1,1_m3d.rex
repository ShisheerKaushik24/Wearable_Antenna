<?xml version="1.0" encoding="UTF-8"?>
<MetaResultFile version="20200629" creator="Solver HFTD - Field 3DFD Monitor">
  <MetaGeometryFile filename="model.gex" lod="1"/>
  <SimulationProperties fieldname="loss (f=4.94) [1]" fieldtype="Power Loss Density" frequency="4.940000057220459" encoded_unit="&amp;U:W^1.:m^-3" fieldscaling="RMS" dB_Amplitude="10"/>
  <ResultDataType vector="0" complex="0" timedomain="0"/>
  <SimulationDomain min="-57.7587929 -59.026329 -59.48703" max="59.7152672 58.447731 20.2370281"/>
  <PlotSettings Plot="4" ignore_symmetry="0" deformation="0" enforce_culling="0" default_arrow_type="ARROWS"/>
  <Source type="SOLVER"/>
  <SpecialMaterials>
    <Background type="FIELDFREE"/>
    <Material name="$NFSMaterial$" type="FIELDFREE_HIDESURFACE"/>
    <Material name="$PortFaceMaterial$" type="FIELDFREE_HIDESURFACE"/>
    <Material name="$PortMaterial$" type="FIELDFREE_HIDESURFACE"/>
    <Material name="air_0" type="FIELDFREE_HIDESURFACE"/>
  </SpecialMaterials>
  <AuxGeometryFile/>
  <AuxResultFile/>
  <FieldFreeNodes/>
  <SurfaceFieldCoefficients/>
  <UnitCell/>
  <SubVolume/>
  <Units/>
  <ResultGroups num_steps="1" transformation="1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1">
    <Frame index="0">
      <FieldResultFile filename="loss (f=4.94)_1,1.m3d" type="m3d"/>
    </Frame>
  </ResultGroups>
</MetaResultFile>
