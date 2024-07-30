Locales = Locales or {}

Locales['en'] = {
  yes = "Yes",
  no = "No",
  garage = "Garage",
  jobGarage = "Job Garage",
  gangGarage = "Gang Garage",
  player = "Player",
  impound = "Impound",
  inGarage = "In garage",
  notInGarage = "Not in garage",
  car = "Car",
  air = "Air",
  sea = "Sea",
  fuel = "Fuel",
  engine = "Engine",
  body = "Body",
  day = "day",
  days = "days",
  hour = "hour",
  hours = "hours",
  mins = "mins",

  -- User Interface
  noVehicles = "There are no vehicles in this garage",
  noVehiclesAvailableToDrive = "There are no vehicles available to drive",
  vehicles = "vehicle(s)",
  vehiclePlate = "Vehicle Plate",
  vehicleNotInGarage = "Vehicle has been left out",
  vehicleTakeOut = "Drive",
  vehicleReturnAndTakeOut = "Return & Drive",
  vehicleReturnToOwnersGarage = "Return to Owner's Garage",
  transferToGarageOrPlayer = "Transfer to a Garage or Player",
  transferToGarage = "Transfer to a Garage",
  transferToPlayer = "Transfer to a Player",
  vehicleTransfer = "Transfer",
  noAvailableGarages = "No available garages",
  currentGarage = "Current garage",
  noPlayersOnline = "No players online",
  createPrivateGarage = "Create Private Garage",
  pgAlertHeadsUp = "Heads up!",
  pgAlertText = "The garage will be created and vehicles will spawn in the exact location and direction are you are currently standing.",
  garageName = "Garage Name",
  impoundInformation = "Impound Information",
  impoundedBy = "Impounded by",
  impoundedReason = "Reason",
  impoundPlayerCanCollect = "You can collect your vehicle from the impound.",
  impoundCollectionContact = "Please contact %{value} in order to collect your vehicle.",
  impoundNoVehicles = "There are no vehicles in the impound",
  impoundAvailable = "Available",
  impoundRetrievableByOwner = "Retrievable by owner",
  impoundNoReason = "No reason provided",
  impoundVehicle = "Impound Vehicle",
  impoundReasonField = "Reason (optional)",
  impoundTime = "Impound Time",
  impoundAvailableImmediately = "Available immediately",
  impoundCost = "Cost",
  changeVehiclePlate = "Change Vehicle Plate",
  newPlate = "New Plate",
  search = "Search by name or plate",
  noPrivateGarages = "No private garages",
  editPrivateGarage = "Edit Private Garage",
  owners = "Owner(s)",
  location = "Location",
  next = "Next",
  previous = "Previous",
  page = "Page",
  of = "of",
  show = "Show",
  save = "Save",
  edit = "Edit",
  delete = "Delete",
  garageDeleteConfirm = "Are you sure you want to delete this garage?",
  privGarageSearch = "Search by name",
  garageUpdatedSuccess = "Garage successfully updated!",
  getCurrentCoords = "Get current coordinates",
  identifier = "Identifier",
  name = "Name",
  noPlayers = "There are no players added",
  addPlayer = "Add player",
  loadingVehicle = "Loading vehicle...",
  vehicleSetup = "Vehicle Setup",
  extras = "Extras",
  extra = "Extra",
  liveries = "Liveries",
  livery = "Livery",
  noLiveries = "No liveries available",
  noExtras = "No extras available",
  none = "None",
  vehicleNeedsService = "Needs Service",
  type = "Type",
  goInside = "Go inside",

  -- Notifications
  insertVehicleTypeError = "You can only store %{value} vehicle types in this garage",
  insertVehiclePublicError = "You can't store job or gang vehicles in public garages",
  vehicleParkedSuccess = "Vehicle parked in garage",
  vehicleNotOwnedError = "You don't own this vehicle",
  vehicleNotOwnedByPlayerError = "Vehicle is not owned by a player",
  notEnoughMoneyError = "You don't have enough money in your bank",
  vehicleNotYoursError = "Vehicle does not belong to you",
  notJobOrGangVehicle = "This is not a %{value} vehicle",
  invalidGangError = "You have not provided a valid gang",
  invalidJobError = "You have not provided a valid job",
  notInsideVehicleError = "You are not sat in a vehicle",
  vehicleAddedToGangGarageSuccess = "Vehicle added to the %{value} gang garage!",
  vehicleAddedToJobGarageSuccess = "Vehicle added to the %{value} job garage!",
  moveCloserToVehicleError = "You need to move closer to the vehicle",
  noVehiclesNearbyError = "There are no vehicles nearby",
  commandPermissionsError = "You are not allowed to use this command",
  actionNotAllowedError = "You are not allowed to do this",
  garageNameExistsError = "Garage name already exists",
  vehiclePlateExistsError = "Vehicle plate is already in use",
  playerNotOnlineError = "Player is not online",
  vehicleTransferSuccess = "Vehicle transferred to %{value}",
  vehicleTransferSuccessGeneral = "Vehicle successfully transferred",
  vehicleReceived = "You recieved a vehicle with the plate %{value}",
  vehicleImpoundSuccess = "Vehicle successfully impounded",
  vehicleImpoundRemoveSuccess = "Vehicle removed from impound",
  vehicleImpoundReturnedToOwnerSuccess = "Vehicle returned to owner's garage",
  garageCreatedSuccess = "Garage successfully created!",
  vehiclePlateUpdateSuccess = "Vehicle plate set to %{value}",
  vehicleDeletedSuccess = "Vehicle deleted from database %{value}",
  playerIsDead = "You cannot do this while you are dead",
  vehicleStoreError = "You cannot store this vehicle here",

  -- Commands
  cmdSetGangVehicle = "Add current vehicle to a gang garage",
  cmdRemoveGangVehicle = "Set gang vehicle back to player owned",
  cmdSetJobVehicle = "Add current vehicle to a job garage",
  cmdRemoveJobVehicle = "Set job vehicle back to player owned",
  cmdArgGangName = "Gang name",
  cmdArgJobName = "Job name",
  cmgArgMinGangRank = "Minimum gang rank",
  cmgArgMinJobRank = "Minimum job rank",
  cmdArgPlayerId = "Player ID of new owner",
  cmdImpoundVehicle = "Impound a vehicle",
  cmdChangePlate = "Change vehicle plate (Admin only)",
  cmdDeleteVeh = "Delete vehicle from database (Admin only)",
  cmdCreatePrivGarage = "Create a private garage for a player",
}
