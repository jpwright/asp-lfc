function takePicture(f)
    e=actxserver('LabVIEW.Application');
    vipath = 'F:\pictures\dumdumfull.vi';
    vi = invoke(e, 'GetVIReference', vipath);
    vi.SetControlValue('Path', ['F:\' f '.bin']);
    vi.Run(1);
    vi.SetControlValue('stop', 1);
    pause(2);
    file = f;
    unpacker
    reassembler
end