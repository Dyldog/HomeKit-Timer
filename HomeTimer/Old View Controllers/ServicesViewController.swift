//
//  ServicesViewController.swift
//  HomeTimer
//
//  Created by ELLIOTT, Dylan on 27/4/18.
//  Copyright © 2018 Dylan Elliott. All rights reserved.
//

import UIKit
import HomeKit
class ServicesViewController: UITableViewController {
    let serviceTypeNames = [
        HMServiceTypeLabel: "Label",
        HMServiceTypeLightbulb: "Lightbulb",
        HMServiceTypeSwitch: "Switch",
        HMServiceTypeThermostat: "Thermostat",
        HMServiceTypeGarageDoorOpener: "Garage Door Opener",
        HMServiceTypeAccessoryInformation: "Accessory Information",
        HMServiceTypeFan: "Fan",
        HMServiceTypeOutlet: "Outlet",
        HMServiceTypeLockMechanism: "Lock Mechanism",
        HMServiceTypeLockManagement: "Lock Management",
        HMServiceTypeFaucet: "Faucet",
        HMServiceTypeIrrigationSystem: "Irrigation System"
    ]
    
    let characteristicTypeNames = [
        HMCharacteristicTypePowerState: "Power State",
        HMCharacteristicTypeHue: "Hue",
        HMCharacteristicTypeSaturation: "Saturation",
        HMCharacteristicTypeBrightness: "Brightness",
        HMCharacteristicTypeTemperatureUnits: "Temperature Units",
        HMCharacteristicTypeCurrentTemperature: "Current Temperature",
        HMCharacteristicTypeTargetTemperature: "Target Temperature",
        HMCharacteristicTypeCurrentHeatingCooling: "Current Heating Cooling",
        HMCharacteristicTypeTargetHeatingCooling: "Target Heating Cooling",
        HMCharacteristicTypeCoolingThreshold: "Cooling Threshold",
        HMCharacteristicTypeHeatingThreshold: "Heating Threshold",
        HMCharacteristicTypeCurrentRelativeHumidity: "Current Relative Humidity",
        HMCharacteristicTypeTargetRelativeHumidity: "Target Relative Humidity",
        HMCharacteristicTypeCurrentDoorState: "Current Door State",
        HMCharacteristicTypeTargetDoorState: "Target Door State",
        HMCharacteristicTypeObstructionDetected: "Obstruction Detected",
        HMCharacteristicTypeName: "Name",
        HMCharacteristicTypeManufacturer: "Manufacturer",
        HMCharacteristicTypeModel: "Model",
        HMCharacteristicTypeSerialNumber: "Serial Number",
        HMCharacteristicTypeIdentify: "Identify",
        HMCharacteristicTypeRotationDirection: "Rotation Direction",
        HMCharacteristicTypeRotationSpeed: "Rotation Speed",
        HMCharacteristicTypeOutletInUse: "Outlet In Use",
        HMCharacteristicTypeVersion: "Version",
        HMCharacteristicTypeLogs: "Logs",
        HMCharacteristicTypeAudioFeedback: "Audio Feedback",
        HMCharacteristicTypeAdminOnlyAccess: "Admin Only Access",
        HMCharacteristicTypeSecuritySystemAlarmType: "Security System Alarm Type",
        HMCharacteristicTypeMotionDetected: "Motion Detected",
        HMCharacteristicTypeCurrentLockMechanismState: "Current Lock Mechanism State",
        HMCharacteristicTypeTargetLockMechanismState: "Target Lock Mechanism State",
        HMCharacteristicTypeLockMechanismLastKnownAction: "Lock Mechanism Last Known Action",
        HMCharacteristicTypeLockManagementControlPoint: "Lock Management Control Point",
        HMCharacteristicTypeLockManagementAutoSecureTimeout: "Lock Management Auto Secure Timeout",
        HMCharacteristicTypeAirParticulateDensity: "Air Particulate Density",
        HMCharacteristicTypeAirParticulateSize: "Air Particulate Size",
        HMCharacteristicTypeAirQuality: "Air Quality",
        HMCharacteristicTypeBatteryLevel: "Battery Level",
        HMCharacteristicTypeCarbonDioxideDetected: "Carbon Dioxide Detected",
        HMCharacteristicTypeCarbonDioxideLevel: "Carbon Dioxide Level",
        HMCharacteristicTypeCarbonDioxidePeakLevel: "Carbon Dioxide Peak Level",
        HMCharacteristicTypeCarbonMonoxideDetected: "Carbon Monoxide Detected",
        HMCharacteristicTypeCarbonMonoxideLevel: "Carbon Monoxide Level",
        HMCharacteristicTypeCarbonMonoxidePeakLevel: "Carbon Monoxide Peak Level",
        HMCharacteristicTypeChargingState: "Charging State",
        HMCharacteristicTypeContactState: "Contact State",
        HMCharacteristicTypeCurrentHorizontalTilt: "Current Horizontal Tilt",
        HMCharacteristicTypeCurrentLightLevel: "Current Light Level",
        HMCharacteristicTypeCurrentPosition: "Current Position",
        HMCharacteristicTypeCurrentSecuritySystemState: "Current Security System State",
        HMCharacteristicTypeCurrentVerticalTilt: "Current Vertical Tilt",
        HMCharacteristicTypeFirmwareVersion: "Firmware Version",
        HMCharacteristicTypeHardwareVersion: "Hardware Version",
        HMCharacteristicTypeHoldPosition: "Hold Position",
        HMCharacteristicTypeInputEvent: "Input Event",
        HMCharacteristicTypeLeakDetected: "Leak Detected",
        HMCharacteristicTypeOccupancyDetected: "Occupancy Detected",
        HMCharacteristicTypeOutputState: "Output State",
        HMCharacteristicTypePositionState: "Position State",
        HMCharacteristicTypeSmokeDetected: "Smoke Detected",
        HMCharacteristicTypeSoftwareVersion: "Software Version",
        HMCharacteristicTypeStatusActive: "Status Active",
        HMCharacteristicTypeStatusFault: "Status Fault",
        HMCharacteristicTypeStatusJammed: "Status Jammed",
        HMCharacteristicTypeStatusLowBattery: "Status Low Battery",
        HMCharacteristicTypeStatusTampered: "Status Tampered",
        HMCharacteristicTypeTargetHorizontalTilt: "Target Horizontal Tilt",
        HMCharacteristicTypeTargetSecuritySystemState: "Target Security System State",
        HMCharacteristicTypeTargetPosition: "Target Position",
        HMCharacteristicTypeTargetVerticalTilt: "Target Vertical Tilt",
        HMCharacteristicTypeStreamingStatus: "Streaming Status",
        HMCharacteristicTypeSetupStreamEndpoint: "Setup Stream Endpoint",
        HMCharacteristicTypeSupportedVideoStreamConfiguration: "Supported Video Stream Configuration",
        HMCharacteristicTypeSupportedAudioStreamConfiguration: "Supported Audio Stream Configuration",
        HMCharacteristicTypeSupportedRTPConfiguration: "Supported R T P Configuration",
        HMCharacteristicTypeSelectedStreamConfiguration: "Selected Stream Configuration",
        HMCharacteristicTypeVolume: "Volume",
        HMCharacteristicTypeMute: "Mute",
        HMCharacteristicTypeNightVision: "Night Vision",
        HMCharacteristicTypeOpticalZoom: "Optical Zoom",
        HMCharacteristicTypeDigitalZoom: "Digital Zoom",
        HMCharacteristicTypeImageRotation: "Image Rotation",
        HMCharacteristicTypeImageMirroring: "Image Mirroring",
        HMCharacteristicTypeLabelNamespace: "Label Namespace",
        HMCharacteristicTypeLabelIndex: "Label Index",
        HMCharacteristicTypeActive: "Active",
        HMCharacteristicTypeCurrentAirPurifierState: "Current Air Purifier State",
        HMCharacteristicTypeTargetAirPurifierState: "Target Air Purifier State",
        HMCharacteristicTypeCurrentFanState: "Current Fan State",
        HMCharacteristicTypeCurrentHeaterCoolerState: "Current Heater Cooler State",
        HMCharacteristicTypeCurrentHumidifierDehumidifierState: "Current Humidifier Dehumidifier State",
        HMCharacteristicTypeCurrentSlatState: "Current Slat State",
        HMCharacteristicTypeWaterLevel: "Water Level",
        HMCharacteristicTypeFilterChangeIndication: "Filter Change Indication",
        HMCharacteristicTypeFilterLifeLevel: "Filter Life Level",
        HMCharacteristicTypeFilterResetChangeIndication: "Filter Reset Change Indication",
        HMCharacteristicTypeLockPhysicalControls: "Lock Physical Controls",
        HMCharacteristicTypeSwingMode: "Swing Mode",
        HMCharacteristicTypeTargetHeaterCoolerState: "Target Heater Cooler State",
        HMCharacteristicTypeTargetHumidifierDehumidifierState: "Target Humidifier Dehumidifier State",
        HMCharacteristicTypeTargetFanState: "Target Fan State",
        HMCharacteristicTypeSlatType: "Slat Type",
        HMCharacteristicTypeCurrentTilt: "Current Tilt",
        HMCharacteristicTypeTargetTilt: "Target Tilt",
        HMCharacteristicTypeOzoneDensity: "Ozone Density",
        HMCharacteristicTypeNitrogenDioxideDensity: "Nitrogen Dioxide Density",
        HMCharacteristicTypeSulphurDioxideDensity: "Sulphur Dioxide Density",
        HMCharacteristicTypePM2_5Density: "P M2_5 Density",
        HMCharacteristicTypePM10Density: "P M10 Density",
        HMCharacteristicTypeVolatileOrganicCompoundDensity: "Volatile Organic Compound Density",
        HMCharacteristicTypeDehumidifierThreshold: "Dehumidifier Threshold",
        HMCharacteristicTypeHumidifierThreshold: "Humidifier Threshold",
        HMCharacteristicTypeColorTemperature: "Color Temperature",
        HMCharacteristicTypeProgramMode: "Program Mode",
        HMCharacteristicTypeInUse: "In Use",
        HMCharacteristicTypeSetDuration: "Set Duration",
        HMCharacteristicTypeRemainingDuration: "Remaining Duration",
        HMCharacteristicTypeValveType: "Valve Type",
        HMCharacteristicTypeIsConfigured: "Is Configured",
    ]
    
    let accessory: HMAccessory
    
    init(accessory: HMAccessory) {
        self.accessory = accessory
        super.init(style: .grouped)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return accessory.services.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let service = accessory.services[section]
        return "\(service.name) - \(serviceTypeNames[service.serviceType] ?? "Unknown")"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accessory.services[section].characteristics.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        
        let characteristic = accessory.services[indexPath.section].characteristics[indexPath.row]
        
        cell.textLabel?.text = "\(characteristic.localizedDescription): \(characteristic.value ?? "NO VALUE")"
        cell.detailTextLabel?.text = characteristicTypeNames[characteristic.characteristicType]
        
        return cell
    }
}
