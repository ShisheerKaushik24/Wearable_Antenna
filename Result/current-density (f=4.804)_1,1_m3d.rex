<?xml version="1.0" encoding="UTF-8"?>
<MetaResultFile version="20200629" creator="Solver HFTD - Field 3DFD Monitor">
  <MetaGeometryFile filename="model.gex" lod="1"/>
  <SimulationProperties fieldname="current-density (f=4.804) [1]" fieldtype="Conduction Current Density" frequency="4.8039999008178711" encoded_unit="&amp;U:A^1.:m^-2" fieldscaling="PEAK" dB_Amplitude="20"/>
  <ResultDataType vector="1" complex="1" timedomain="0"/>
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
      <FieldResultFile filename="current-density (f=4.804)_1,1.m3d" type="m3d"/>
    </Frame>
  </ResultGroups>
</MetaResultFile>
