import depthai as dai

for device in dai.Device.getAllAvailableDevices():
    print(f"{device.getMxId()} {device.state}")
