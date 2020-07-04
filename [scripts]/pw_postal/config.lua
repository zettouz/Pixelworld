Config              = {}

Config.PostalPoints = {
	['duty'] = {
		['coords'] = { ['x'] = 78.76, ['y'] = 111.94, ['z'] = 81.17, ['h'] = 354.05 },
		['dutyNeeded'] = false,
		['drawDistance'] = 2.0,
		['public'] = false,
		['blip'] = true
	},
	['startDeliver'] = {
		['coords'] = { ['x'] = 62.42, ['y'] = 125.81, ['z'] = 79.2, ['h'] = 173.73 },
		['dutyNeeded'] = true,
		['drawDistance'] = 2.0,
		['public'] = false
	},
	['garage'] = {
		['coords'] = { ['x'] = 72.94, ['y'] = 121.89, ['z'] = 79.09, ['h'] = 159.61 },
		['spawnCoords'] = { ['x'] = 69.07, ['y'] = 123.71, ['z'] = 79.17, ['h'] = 152.27 },
		['dutyNeeded'] = true,
		['drawDistance'] = 2.0,
		['public'] = false,
		['availableVehicle'] = 'boxville2'
	},
}

Config.Marker = {
	['postalPoints'] = {
		['markerType'] = 2,
		['markerSize']  = { ['x'] = 0.7, ['y'] = 0.7, ['z'] = 0.7 },
		['markerColor'] = { ['r'] = 255, ['g'] = 50, ['b'] = 50 }
	},
	['vanMarker'] = {
		['markerType'] = 2,
		['markerSize']  = { ['x'] = 0.9, ['y'] = 0.9, ['z'] = 0.9 },
		['markerColor'] = { ['r'] = 255, ['g'] = 0, ['b'] = 255 }
	},
	['footMarker'] = {
		['markerType'] = 2,
		['markerSize']  = { ['x'] = 0.4, ['y'] = 0.4, ['z'] = 0.4 },
		['markerColor'] = { ['r'] = 0, ['g'] = 86, ['b'] = 172 }
	},	
}

Config.Blips = {
    ['type'] = 267,
    ['name'] = "GoPostal",
    ['scale'] = 0.6,
    ['color'] = 3
}

-- Payment Config --
Config.BaseDeliveryPay = { -- random between these values for a base pay (at every stop in the delivery it gets paid)
	['min'] = 50,
	['max'] = 75
}

Config.PricePerMile = 30 -- the price given for driving each mile so driving further will pay more


Config.DeliveryType = { 5, 10, 15}

Config.DeliveryPoints = {
	{ ['van'] = { ['x'] = 205.67, ['y'] = -35.95, ['z'] = 69.17, ['h'] = 38.17 },  ['foot'] = { ['x'] = 202.2, ['y'] = -26.38, ['z'] = 69.91, ['h'] = 70.47 } }, -- Vinewood City Area
	{ ['van'] = { ['x'] = 223.95, ['y'] = 281.09, ['z'] = 105.53, ['h'] = 115.63 },  ['foot'] = { ['x'] = 210.85, ['y'] = 272.74, ['z'] = 105.54, ['h'] = 77.74 } },
	{ ['van'] = { ['x'] = 327.61, ['y'] = -112.83, ['z'] = 67.96, ['h'] = 175.96 },  ['foot'] = { ['x'] = 315.51, ['y'] = -128.09, ['z'] = 69.98, ['h'] = 157.78 } },
	{ ['van'] = { ['x'] = 545.05, ['y'] = 152.87, ['z'] = 98.89, ['h'] = 336.57 },  ['foot'] = { ['x'] = 551.66, ['y'] = 142.33, ['z'] = 98.85, ['h'] = 222.08 } },
	{ ['van'] = { ['x'] = -118.74, ['y'] = 177.94, ['z'] = 86.79, ['h'] = 104.18 },  ['foot'] = { ['x'] = -147.3, ['y'] = 185.02, ['z'] = 85.43, ['h'] = 76.87 } },
	{ ['van'] = { ['x'] = -156.1, ['y'] = 150.95, ['z'] = 77.46, ['h'] = 41.78 },  ['foot'] = { ['x'] = -149.64, ['y'] = 159.19, ['z'] = 77.65, ['h'] = 325.56 } },
	{ ['van'] = { ['x'] = -193.75, ['y'] = 131.2, ['z'] = 69.61, ['h'] = 251.73 },  ['foot'] = { ['x'] = -198.17, ['y'] = 142.76, ['z'] = 70.32, ['h'] = 236.9 } },
	{ ['van'] = { ['x'] = -341.07, ['y'] = 135.75, ['z'] = 66.8, ['h'] = 336.64 },  ['foot'] = { ['x'] = -347.57, ['y'] = 142.57, ['z'] = 66.69, ['h'] = 58.72 } },
	{ ['van'] = { ['x'] = -365.37, ['y'] = 32.76, ['z'] = 48.02, ['h'] = 4.44 },  ['foot'] = { ['x'] = -360.33, ['y'] = 21.41, ['z'] = 47.86, ['h'] = 161.29 } },
	{ ['van'] = { ['x'] = -311.92, ['y'] = 72.04, ['z'] = 65.65, ['h'] = 240.69 },  ['foot'] = { ['x'] = -302.85, ['y'] = 85.17, ['z'] = 68.66, ['h'] = 295 } },
	{ ['van'] = { ['x'] = -325.98, ['y'] = -36.54, ['z'] = 47.92, ['h'] = 249.96 },  ['foot'] = { ['x'] = -328.19, ['y'] = -53.48, ['z'] = 49.04, ['h'] = 181.32 } },
	{ ['van'] = { ['x'] = -482.33, ['y'] = -8.75, ['z'] = 45.17, ['h'] = 231.61 },  ['foot'] = { ['x'] = -482.69, ['y'] = -16.87, ['z'] = 45.12, ['h'] = 174.17 } },
	{ ['van'] = { ['x'] = -508.61, ['y'] = 122.94, ['z'] = 63.25, ['h'] = 117.34 },  ['foot'] = { ['x'] = -511.85, ['y'] = 108.95, ['z'] = 63.8, ['h'] = 193.42 } },
	{ ['van'] = { ['x'] = -596.98, ['y'] = 185.82, ['z'] = 70.51, ['h'] = 278.08 },  ['foot'] = { ['x'] = -581.27, ['y'] = 181.46, ['z'] = 71.07, ['h'] = 260.42 } },
	{ ['van'] = { ['x'] = -596.98, ['y'] = 185.82, ['z'] = 70.51, ['h'] = 278.08 },  ['foot'] = { ['x'] = -596.65, ['y'] = 209, ['z'] = 74.17, ['h'] = 350.13 } },
	{ ['van'] = { ['x'] = -596.98, ['y'] = 185.82, ['z'] = 70.51, ['h'] = 278.08 },  ['foot'] = { ['x'] = -634.42, ['y'] = 208.57, ['z'] = 74.13, ['h'] = 356.8 } },
	{ ['van'] = { ['x'] = -596.98, ['y'] = 185.82, ['z'] = 70.51, ['h'] = 278.08 },  ['foot'] = { ['x'] = -628.97, ['y'] = 169.58, ['z'] = 61.15, ['h'] = 271.85 } },
	{ ['van'] = { ['x'] = -957.75, ['y'] = 174.61, ['z'] = 65.09, ['h'] = 274.25 },  ['foot'] = { ['x'] = -953.6, ['y'] = 178.97, ['z'] = 65.4, ['h'] = 355.43 } }, -- Around Golf Course
	{ ['van'] = { ['x'] = -1285.26, ['y'] = 294.53, ['z'] = 64.87, ['h'] = 76.91 },  ['foot'] = { ['x'] = -1273.67, ['y'] = 315.91, ['z'] = 65.51, ['h'] = 333.4 } },
	{ ['van'] = { ['x'] = -1192.17, ['y'] = -133.06, ['z'] = 40.3, ['h'] = 274.31 },  ['foot'] = { ['x'] = -1200.17, ['y'] = -155.94, ['z'] = 40.1, ['h'] = 175.21 } },
	{ ['van'] = { ['x'] = -1192.17, ['y'] = -133.06, ['z'] = 40.3, ['h'] = 274.31 },  ['foot'] = { ['x'] = -1188.62, ['y'] = -143.46, ['z'] = 40.1, ['h'] = 175.04 } },
	{ ['van'] = { ['x'] = -1192.17, ['y'] = -133.06, ['z'] = 40.3, ['h'] = 274.31 },  ['foot'] = { ['x'] = -1174.71, ['y'] = -151.09, ['z'] = 40.1, ['h'] = 174.09 } },
	{ ['van'] = { ['x'] = -1192.17, ['y'] = -133.06, ['z'] = 40.3, ['h'] = 274.31 },  ['foot'] = { ['x'] = -1163.63, ['y'] = -156.6, ['z'] = 40.1, ['h'] = 187.26 } },
	{ ['van'] = { ['x'] = -1069.09, ['y'] = 439.68, ['z'] = 73.72, ['h'] = 274.7 },  ['foot'] = { ['x'] = -1051.78, ['y'] = 429.86, ['z'] = 76.86, ['h'] = 289.74 } },
	{ ['van'] = { ['x'] = -1083.85, ['y'] = 436.17, ['z'] = 74.08, ['h'] = 175.21 },  ['foot'] = { ['x'] = -1092.78, ['y'] = 427.32, ['z'] = 75.68, ['h'] = 51.22 } },-- Vinewood Hills Houses
	{ ['van'] = { ['x'] = -1082.66, ['y'] = 454.86, ['z'] = 76.44, ['h'] = 330.08 },  ['foot'] = { ['x'] = -1062.09, ['y'] = 475.56, ['z'] = 81.32, ['h'] = 102.29 } },
	{ ['van'] = { ['x'] = -1100.43, ['y'] = 461.64, ['z'] = 78.49, ['h'] = 244 },  ['foot'] = { ['x'] = -1122.53, ['y'] = 486.12, ['z'] = 82.36, ['h'] = 37.09 } },
	{ ['van'] = { ['x'] = -1100.43, ['y'] = 461.64, ['z'] = 78.49, ['h'] = 244 },  ['foot'] = { ['x'] = -1158.62, ['y'] = 481.31, ['z'] = 86.09, ['h'] = 40.98 } },
	{ ['van'] = { ['x'] = -1024.49, ['y'] = 497.83, ['z'] = 79.21, ['h'] = 350.12 },  ['foot'] = { ['x'] = -1041.46, ['y'] = 507, ['z'] = 84.38, ['h'] = 39.45 } },
	{ ['van'] = { ['x'] = -1023.18, ['y'] = 499.64, ['z'] = 79.27, ['h'] = 224.05 },  ['foot'] = { ['x'] = -1007.19, ['y'] = 512.8, ['z'] = 79.6, ['h'] = 353.06 } },
	{ ['van'] = { ['x'] = -1023.18, ['y'] = 499.64, ['z'] = 79.27, ['h'] = 224.05 },  ['foot'] = { ['x'] = -1008.31, ['y'] = 480.75, ['z'] = 79.41, ['h'] = 175.95 } },
	{ ['van'] = { ['x'] = -1023.18, ['y'] = 499.64, ['z'] = 79.27, ['h'] = 224.05 },  ['foot'] = { ['x'] = -987.4, ['y'] = 487.79, ['z'] = 82.27, ['h'] = 202.64 } },
	{ ['van'] = { ['x'] = -1023.18, ['y'] = 499.64, ['z'] = 79.27, ['h'] = 224.05 },  ['foot'] = { ['x'] = -969.55, ['y'] = 525.09, ['z'] = 81.47, ['h'] = 322.03 } },
	{ ['van'] = { ['x'] = -959.57, ['y'] = 466.99, ['z'] = 79.69, ['h'] = 171.18 },  ['foot'] = { ['x'] = -956.52, ['y'] = 461.86, ['z'] = 79.84, ['h'] = 209.3 } },
	{ ['van'] = { ['x'] = -959.57, ['y'] = 466.99, ['z'] = 79.69, ['h'] = 171.18 },  ['foot'] = { ['x'] = -970.99, ['y'] = 456.16, ['z'] = 79.81, ['h'] = 110.88 } },
	{ ['van'] = { ['x'] = -959.57, ['y'] = 466.99, ['z'] = 79.69, ['h'] = 171.18 },  ['foot'] = { ['x'] = -968.15, ['y'] = 436.86, ['z'] = 80.57, ['h'] = 79.78 } },
	{ ['van'] = { ['x'] = -849.18, ['y'] = 460.57, ['z'] = 87.12, ['h'] = 10.5 },  ['foot'] = { ['x'] = -842.97, ['y'] = 466.68, ['z'] = 87.6, ['h'] = 321.43 } },
	{ ['van'] = { ['x'] = -849.18, ['y'] = 460.57, ['z'] = 87.12, ['h'] = 10.5 },  ['foot'] = { ['x'] = -866.37, ['y'] = 457.16, ['z'] = 88.28, ['h'] = 30.85 } },
	{ ['van'] = { ['x'] = -849.18, ['y'] = 460.57, ['z'] = 87.12, ['h'] = 10.5 },  ['foot'] = { ['x'] = -850.83, ['y'] = 521.47, ['z'] = 90.62, ['h'] = 348.38 } },
	{ ['van'] = { ['x'] = -849.18, ['y'] = 460.57, ['z'] = 87.12, ['h'] = 10.5 },  ['foot'] = { ['x'] = -883.46, ['y'] = 518.38, ['z'] = 92.44, ['h'] = 106.99 } },
	{ ['van'] = { ['x'] = -906.28, ['y'] = 556.93, ['z'] = 96.72, ['h'] = 12.48 },  ['foot'] = { ['x'] = -907.52, ['y'] = 545.06, ['z'] = 100.2, ['h'] = 132 } },
	{ ['van'] = { ['x'] = -906.28, ['y'] = 556.93, ['z'] = 96.72, ['h'] = 12.48 },  ['foot'] = { ['x'] = -904.28, ['y'] = 587.96, ['z'] = 101.19, ['h'] = 337.34 } },
	{ ['van'] = { ['x'] = -906.28, ['y'] = 556.93, ['z'] = 96.72, ['h'] = 12.48 },  ['foot'] = { ['x'] = -924.85, ['y'] = 561.66, ['z'] = 99.96, ['h'] = 162.76 } },
	{ ['van'] = { ['x'] = -955.21, ['y'] = 591.18, ['z'] = 101.2, ['h'] = 115.4 },  ['foot'] = { ['x'] = -958.42, ['y'] = 606.69, ['z'] = 106.14, ['h'] = 333 } },
	{ ['van'] = { ['x'] = -955.21, ['y'] = 591.18, ['z'] = 101.2, ['h'] = 115.4 },  ['foot'] = { ['x'] = -974.28, ['y'] = 582.06, ['z'] = 102.9, ['h'] = 171.41 } },
	{ ['van'] = { ['x'] = -955.21, ['y'] = 591.18, ['z'] = 101.2, ['h'] = 115.4 },  ['foot'] = { ['x'] = -948.07, ['y'] = 568.06, ['z'] = 101.48, ['h'] = 181.92 } },
	{ ['van'] = { ['x'] = -1086.38, ['y'] = 789.83, ['z'] = 164.96, ['h'] = 234.34 },  ['foot'] = { ['x'] = -1100.39, ['y'] = 797.2, ['z'] = 167.35, ['h'] = 7.02 } },
	{ ['van'] = { ['x'] = -1086.38, ['y'] = 789.83, ['z'] = 164.96, ['h'] = 234.34 },  ['foot'] = { ['x'] = -1130.96, ['y'] = 784.33, ['z'] = 163.89, ['h'] = 77.26 } },
	{ ['van'] = { ['x'] = -1086.38, ['y'] = 789.83, ['z'] = 164.96, ['h'] = 234.34 },  ['foot'] = { ['x'] = -1117.78, ['y'] = 761.39, ['z'] = 164.29, ['h'] = 195.89 } },
	{ ['van'] = { ['x'] = -220.0, ['y'] = 607.75, ['z'] = 190.91, ['h'] = 266.07 },  ['foot'] = { ['x'] = -232.71, ['y'] = 588.92, ['z'] = 190.46, ['h'] = 168.08 } },
	{ ['van'] = { ['x'] = -220.0, ['y'] = 607.75, ['z'] = 190.91, ['h'] = 266.07 },  ['foot'] = { ['x'] = -189.31, ['y'] = 617.84, ['z'] = 199.66, ['h'] = 5.71 } },
	{ ['van'] = { ['x'] = -220.0, ['y'] = 607.75, ['z'] = 190.91, ['h'] = 266.07 },  ['foot'] = { ['x'] = -185.25, ['y'] = 591.2, ['z'] = 197.82, ['h'] = 234.08 } },
	{ ['van'] = { ['x'] = -220.0, ['y'] = 607.75, ['z'] = 190.91, ['h'] = 266.07 },  ['foot'] = { ['x'] = -126.19, ['y'] = 588.29, ['z'] = 204.71, ['h'] = 126.26 } },
	{ ['van'] = { ['x'] = -220.0, ['y'] = 607.75, ['z'] = 190.91, ['h'] = 266.07 },  ['foot'] = { ['x'] = -232.77, ['y'] = 588.73, ['z'] = 190.54, ['h'] = 252.95 } },
	{ ['van'] = { ['x'] = -220.0, ['y'] = 607.75, ['z'] = 190.91, ['h'] = 266.07 },  ['foot'] = { ['x'] = -293.27, ['y'] = 601.28, ['z'] = 181.58, ['h'] = 133.54 } },
	{ ['van'] = { ['x'] = 129.26, ['y'] = 577.32, ['z'] = 183.29, ['h'] = 96.49 },  ['foot'] = { ['x'] = 184.29, ['y'] = 578.8, ['z'] = 185.16, ['h'] = 237.29 } },
	{ ['van'] = { ['x'] = 129.26, ['y'] = 577.32, ['z'] = 183.29, ['h'] = 96.49 },  ['foot'] = { ['x'] = 128.19, ['y'] = 565.99, ['z'] = 183.96, ['h'] = 186.19 } },
	{ ['van'] = { ['x'] = 129.26, ['y'] = 577.32, ['z'] = 183.29, ['h'] = 96.49 },  ['foot'] = { ['x'] = 84.72, ['y'] = 563.85, ['z'] = 182.57, ['h'] = 154 } },
	{ ['van'] = { ['x'] = 972.27, ['y'] = 2.67, ['z'] = 81.04, ['h'] = 326.47 },  ['foot'] = { ['x'] = 980.77, ['y'] = 21.85, ['z'] = 80.99, ['h'] = 32.56 } }, -- Mirror Park area
	{ ['van'] = { ['x'] = 937.34, ['y'] = -260.86, ['z'] = 67.51, ['h'] = 42.42 },  ['foot'] = { ['x'] = 952.47, ['y'] = -252.74, ['z'] = 68, ['h'] = 259.14 } },
	{ ['van'] = { ['x'] = 937.34, ['y'] = -260.86, ['z'] = 67.51, ['h'] = 42.42 },  ['foot'] = { ['x'] = 930.77, ['y'] = -245.58, ['z'] = 69, ['h'] = 346.82 } },
	{ ['van'] = { ['x'] = 937.34, ['y'] = -260.86, ['z'] = 67.51, ['h'] = 42.42 },  ['foot'] = { ['x'] = 920.35, ['y'] = -238.9, ['z'] = 70.14, ['h'] = 320.11 } },
	{ ['van'] = { ['x'] = 1148.7, ['y'] = -365.49, ['z'] = 66.95, ['h'] = 224.09 },  ['foot'] = { ['x'] = 1139.33, ['y'] = -342.74, ['z'] = 67.05, ['h'] = 5.38 } },
	{ ['van'] = { ['x'] = 1148.7, ['y'] = -365.49, ['z'] = 66.95, ['h'] = 224.09 },  ['foot'] = { ['x'] = 1124.3, ['y'] = -345.37, ['z'] = 67.11, ['h'] = 18.07 } },
	{ ['van'] = { ['x'] = 1148.7, ['y'] = -365.49, ['z'] = 66.95, ['h'] = 224.09 },  ['foot'] = { ['x'] = 1107.45, ['y'] = -355.98, ['z'] = 67.02, ['h'] = 29.74 } },
	{ ['van'] = { ['x'] = 1148.7, ['y'] = -365.49, ['z'] = 66.95, ['h'] = 224.09 },  ['foot'] = { ['x'] = 1172.14, ['y'] = -377.17, ['z'] = 68.2, ['h'] = 160.1 } },
	{ ['van'] = { ['x'] = 1200.51, ['y'] = -457.61, ['z'] = 66.42, ['h'] = 349.04 },  ['foot'] = { ['x'] = 1209.64, ['y'] = -448.32, ['z'] = 66.87, ['h'] = 250.85 } },
	{ ['van'] = { ['x'] = 1200.51, ['y'] = -457.61, ['z'] = 66.42, ['h'] = 349.04 },  ['foot'] = { ['x'] = 1205.86, ['y'] = -463.15, ['z'] = 66.45, ['h'] = 253.83 } },
	{ ['van'] = { ['x'] = 1200.51, ['y'] = -457.61, ['z'] = 66.42, ['h'] = 349.04 },  ['foot'] = { ['x'] = 1198.79, ['y'] = -502.42, ['z'] = 65.18, ['h'] = 296.65 } },
	{ ['van'] = { ['x'] = 1200.51, ['y'] = -457.61, ['z'] = 66.42, ['h'] = 349.04 },  ['foot'] = { ['x'] = 1173.78, ['y'] = -442.84, ['z'] = 66.79, ['h'] = 69.51 } },
	{ ['van'] = { ['x'] = 1200.51, ['y'] = -457.61, ['z'] = 66.42, ['h'] = 349.04 },  ['foot'] = { ['x'] = 1173.35, ['y'] = -397.65, ['z'] = 67.74, ['h'] = 73.37 } },
	{ ['van'] = { ['x'] = 1357.63, ['y'] = -585.11, ['z'] = 74.26, ['h'] = 219.88 },  ['foot'] = { ['x'] = 1367.14, ['y'] = -606.17, ['z'] = 74.71, ['h'] = 180.25 } },
	{ ['van'] = { ['x'] = 1357.63, ['y'] = -585.11, ['z'] = 74.26, ['h'] = 219.88 },  ['foot'] = { ['x'] = 1384.64, ['y'] = -592.53, ['z'] = 74.41, ['h'] = 234.21 } },
	{ ['van'] = { ['x'] = 1357.63, ['y'] = -585.11, ['z'] = 74.26, ['h'] = 219.88 },  ['foot'] = { ['x'] = 1386.29, ['y'] = -570.93, ['z'] = 74.34, ['h'] = 295.85 } },
	{ ['van'] = { ['x'] = 1357.63, ['y'] = -585.11, ['z'] = 74.26, ['h'] = 219.88 },  ['foot'] = { ['x'] = 1371.71, ['y'] = -556.7, ['z'] = 74.34, ['h'] = 317.39 } },
	{ ['van'] = { ['x'] = 1357.63, ['y'] = -585.11, ['z'] = 74.26, ['h'] = 219.88 },  ['foot'] = { ['x'] = 1324.68, ['y'] = -546.56, ['z'] = 72.4, ['h'] = 343 } },
	{ ['van'] = { ['x'] = 1187.16, ['y'] = -607.49, ['z'] = 63.67, ['h'] = 4.41 },  ['foot'] = { ['x'] = 1192.17, ['y'] = -602.44, ['z'] = 63.94, ['h'] = 258.25 } },
	{ ['van'] = { ['x'] = 1182.61, ['y'] = -561.36, ['z'] = 64.33, ['h'] = 356.78 },  ['foot'] = { ['x'] = 1203.63, ['y'] = -558.05, ['z'] = 69.4, ['h'] = 266.96 } },
	{ ['van'] = { ['x'] = 940.16, ['y'] = -490.13, ['z'] = 60.2, ['h'] = 97.57 },  ['foot'] = { ['x'] = 922.55, ['y'] = -479.56, ['z'] = 60.7, ['h'] = 24.41 } },
	{ ['van'] = { ['x'] = 940.16, ['y'] = -490.13, ['z'] = 60.2, ['h'] = 97.57 },  ['foot'] = { ['x'] = 943.04, ['y'] = -465.11, ['z'] = 61.25, ['h'] = 331.22 } },
	{ ['van'] = { ['x'] = 940.16, ['y'] = -490.13, ['z'] = 60.2, ['h'] = 97.57 },  ['foot'] = { ['x'] = 968.04, ['y'] = -452.14, ['z'] = 62.4, ['h'] = 58.1 } },
	{ ['van'] = { ['x'] = 940.16, ['y'] = -490.13, ['z'] = 60.2, ['h'] = 97.57 },  ['foot'] = { ['x'] = 1013.56, ['y'] = -468.4, ['z'] = 64.29, ['h'] = 221.38 } },
	{ ['van'] = { ['x'] = 940.16, ['y'] = -490.13, ['z'] = 60.2, ['h'] = 97.57 },  ['foot'] = { ['x'] = 969.86, ['y'] = -502.2, ['z'] = 62.14, ['h'] = 233.44 } },
	{ ['van'] = { ['x'] = 864.08, ['y'] = -543.67, ['z'] = 57.2, ['h'] = 104.45 },  ['foot'] = { ['x'] = 850.9, ['y'] = -532.41, ['z'] = 57.93, ['h'] = 165.7 } },
	{ ['van'] = { ['x'] = 864.08, ['y'] = -543.67, ['z'] = 57.2, ['h'] = 104.45 },  ['foot'] = { ['x'] = 845.06, ['y'] = -564.13, ['z'] = 57.71, ['h'] = 302.82 } },
	{ ['van'] = { ['x'] = 864.08, ['y'] = -543.67, ['z'] = 57.2, ['h'] = 104.45 },  ['foot'] = { ['x'] = 886.68, ['y'] = -543.5, ['z'] = 57.95, ['h'] = 297.05 } }, -- Vespucci Canal area
	{ ['van'] = { ['x'] = -1102.61, ['y'] = -1054.5, ['z'] = 2.12, ['h'] = 118.3 },  ['foot'] = { ['x'] = -1105.04, ['y'] = -1058.38, ['z'] = 2.14, ['h'] = 214.3 } },
	{ ['van'] = { ['x'] = -1102.61, ['y'] = -1054.5, ['z'] = 2.12, ['h'] = 118.3 },  ['foot'] = { ['x'] = -1121.12, ['y'] = -1051.23, ['z'] = 2.15, ['h'] = 13.93 } },
	{ ['van'] = { ['x'] = -1102.61, ['y'] = -1054.5, ['z'] = 2.12, ['h'] = 118.3 },  ['foot'] = { ['x'] = -1129.01, ['y'] = -1080.34, ['z'] = 4.22, ['h'] = 199.07 } },
	{ ['van'] = { ['x'] = -1012.89, ['y'] = -1000.77, ['z'] = 2.1, ['h'] = 130.32 },  ['foot'] = { ['x'] = -1022.79, ['y'] = -997.85, ['z'] = 2.15, ['h'] = 57.55 } },
	{ ['van'] = { ['x'] = -1012.89, ['y'] = -1000.77, ['z'] = 2.1, ['h'] = 130.32 },  ['foot'] = { ['x'] = -1008.9, ['y'] = -1014.04, ['z'] = 2.15, ['h'] = 202.28 } },
	{ ['van'] = { ['x'] = -1012.89, ['y'] = -1000.77, ['z'] = 2.1, ['h'] = 130.32 },  ['foot'] = { ['x'] = -990.78, ['y'] = -985.56, ['z'] = 2.15, ['h'] = 15.08 } },
	{ ['van'] = { ['x'] = -964.97, ['y'] = -1093.92, ['z'] = 2.1, ['h'] = 300.04 },  ['foot'] = { ['x'] = -943.15, ['y'] = -1075.64, ['z'] = 2.75, ['h'] = 16.17 } },
	{ ['van'] = { ['x'] = -964.97, ['y'] = -1093.92, ['z'] = 2.1, ['h'] = 300.04 },  ['foot'] = { ['x'] = -960.72, ['y'] = -1108.02, ['z'] = 2.15, ['h'] = 203.67 } },
	{ ['van'] = { ['x'] = -964.97, ['y'] = -1093.92, ['z'] = 2.1, ['h'] = 300.04 },  ['foot'] = { ['x'] = -975.74, ['y'] = -1092.73, ['z'] = 4.22, ['h'] = 343.72 } },
	{ ['van'] = { ['x'] = -964.97, ['y'] = -1093.92, ['z'] = 2.1, ['h'] = 300.04 },  ['foot'] = { ['x'] = -977.94, ['y'] = -1106.53, ['z'] = 2.15, ['h'] = 173.88 } },-- 
	{ ['van'] = { ['x'] = -1277.83, ['y'] = -823.51, ['z'] = 17.1, ['h'] = 18.41 },  ['foot'] = { ['x'] = -1268.6, ['y'] = -812.37, ['z'] = 17.11, ['h'] = 302.78 } },
	{ ['van'] = { ['x'] = -1277.83, ['y'] = -823.51, ['z'] = 17.1, ['h'] = 18.41 },  ['foot'] = { ['x'] = -1264.21, ['y'] = -829.19, ['z'] = 17.1, ['h'] = 227.89 } },
	{ ['van'] = { ['x'] = -1277.83, ['y'] = -823.51, ['z'] = 17.1, ['h'] = 18.41 },  ['foot'] = { ['x'] = -1286.43, ['y'] = -833.39, ['z'] = 17.1, ['h'] = 104.81 } },
	{ ['van'] = { ['x'] = -1277.83, ['y'] = -823.51, ['z'] = 17.1, ['h'] = 18.41 },  ['foot'] = { ['x'] = -1281.15, ['y'] = -840.72, ['z'] = 16.15, ['h'] = 133.56 } },
	{ ['van'] = { ['x'] = -1586.82, ['y'] = -366.08, ['z'] = 45.27, ['h'] = 115.64 },  ['foot'] = { ['x'] = -1596.97, ['y'] = -352.46, ['z'] = 45.98, ['h'] = 50.43 } },
	{ ['van'] = { ['x'] = -1604.42, ['y'] = -385.7, ['z'] = 43.12, ['h'] = 129.39 },  ['foot'] = { ['x'] = -1621.84, ['y'] = -380.41, ['z'] = 43.72, ['h'] = 56.13 } },
	{ ['van'] = { ['x'] = -1629.57, ['y'] = -418.45, ['z'] = 39.91, ['h'] = 285.44 },  ['foot'] = { ['x'] = -1642.1, ['y'] = -412.42, ['z'] = 42.07, ['h'] = 49.78 } },
	{ ['van'] = { ['x'] = -1659.55, ['y'] = -457.79, ['z'] = 38.79, ['h'] = 116.36 },  ['foot'] = { ['x'] = -1667.57, ['y'] = -441.24, ['z'] = 40.36, ['h'] = 40.76 } },
	{ ['van'] = { ['x'] = -1722.5, ['y'] = -506.53, ['z'] = 37.99, ['h'] = 52.68 },  ['foot'] = { ['x'] = -1710.94, ['y'] = -494.08, ['z'] = 41.62, ['h'] = 133.27 } }, 
	{ ['van'] = { ['x'] = -1722.5, ['y'] = -506.53, ['z'] = 37.99, ['h'] = 52.68 },  ['foot'] = { ['x'] = -1712.2, ['y'] = -493.27, ['z'] = 41.62, ['h'] = 322.02 } }, -- del perro beach houses
	{ ['van'] = { ['x'] = -1722.5, ['y'] = -506.53, ['z'] = 37.99, ['h'] = 52.68 },  ['foot'] = { ['x'] = -1722.5, ['y'] = -482.95, ['z'] = 41.62, ['h'] = 295.07 } },
	{ ['van'] = { ['x'] = -1838.33, ['y'] = -415.77, ['z'] = 44.76, ['h'] = 20.63 },  ['foot'] = { ['x'] = -1821.52, ['y'] = -405.52, ['z'] = 46.62, ['h'] = 339.13 } },
	{ ['van'] = { ['x'] = -1813.01, ['y'] = -436.38, ['z'] = 42.79, ['h'] = 289.75 },  ['foot'] = { ['x'] = -1800.25, ['y'] = -421.77, ['z'] = 41.86, ['h'] = 232.11 } },
	{ ['van'] = { ['x'] = -1957.25, ['y'] = -506.4, ['z'] = 11.83, ['h'] = 61.64 },  ['foot'] = { ['x'] = -1970.07, ['y'] = -501.74, ['z'] = 11.88, ['h'] = 84.29 } },
	{ ['van'] = { ['x'] = -1957.25, ['y'] = -506.4, ['z'] = 11.83, ['h'] = 61.64 },  ['foot'] = { ['x'] = -1962.88, ['y'] = -505.99, ['z'] = 11.9, ['h'] = 93.26 } },
	{ ['van'] = { ['x'] = -1957.25, ['y'] = -506.4, ['z'] = 11.83, ['h'] = 61.64 },  ['foot'] = { ['x'] = -1964.33, ['y'] = -519.98, ['z'] = 11.98, ['h'] = 163.07 } },
	{ ['van'] = { ['x'] = -1957.25, ['y'] = -506.4, ['z'] = 11.83, ['h'] = 61.64 },  ['foot'] = { ['x'] = -1947.27, ['y'] = -519.04, ['z'] = 11.87, ['h'] = 132.17 } },
	{ ['van'] = { ['x'] = -1907.8, ['y'] = -547.07, ['z'] = 11.77, ['h'] = 130.82 },  ['foot'] = { ['x'] = -1918.13, ['y'] = -542.33, ['z'] = 11.82, ['h'] = 130.37 } },
	{ ['van'] = { ['x'] = -1907.8, ['y'] = -547.07, ['z'] = 11.77, ['h'] = 130.82 },  ['foot'] = { ['x'] = -1909.67, ['y'] = -563.58, ['z'] = 11.82, ['h'] = 137.98 } },
	{ ['van'] = { ['x'] = -1869.59, ['y'] = -578.91, ['z'] = 11.66, ['h'] = 236.5 },  ['foot'] = { ['x'] = -1883.45, ['y'] = -578.83, ['z'] = 11.82, ['h'] = 135.59 } },
	{ ['van'] = { ['x'] = -1869.59, ['y'] = -578.91, ['z'] = 11.66, ['h'] = 236.5 },  ['foot'] = { ['x'] = -1871.39, ['y'] = -589.11, ['z'] = 11.87, ['h'] = 150.32 } },
	{ ['van'] = { ['x'] = -1869.59, ['y'] = -578.91, ['z'] = 11.66, ['h'] = 236.5 },  ['foot'] = { ['x'] = -1864.83, ['y'] = -594.54, ['z'] = 11.84, ['h'] = 160.68 } },--
	{ ['van'] = { ['x'] = -1597.55, ['y'] = -828.84, ['z'] = 10.02, ['h'] = 229.32 },  ['foot'] = { ['x'] = -1604.18, ['y'] = -832.16, ['z'] = 10.08, ['h'] = 139.13 } },
	{ ['van'] = { ['x'] = -1597.55, ['y'] = -828.84, ['z'] = 10.02, ['h'] = 229.32 },  ['foot'] = { ['x'] = -1584.9, ['y'] = -838.62, ['z'] = 9.96, ['h'] = 234.62 } },
	{ ['van'] = { ['x'] = -1585.87, ['y'] = -909.48, ['z'] = 9.39, ['h'] = 318.73 },  ['foot'] = { ['x'] = -1580, ['y'] = -916.31, ['z'] = 9.41, ['h'] = 238.49 } },
	{ ['van'] = { ['x'] = -1378.93, ['y'] = -973.53, ['z'] = 8.81, ['h'] = 240.01 },  ['foot'] = { ['x'] = -1385.32, ['y'] = -976.72, ['z'] = 9.14, ['h'] = 110.88 } },-- del perro city area
	{ ['van'] = { ['x'] = 195.99, ['y'] = 1242.6, ['z'] = 225.46, ['h'] = 169.04 },  ['foot'] = { ['x'] = 188.51, ['y'] = 1233.7, ['z'] = 225.6, ['h'] = 69.53 } },
	{ ['van'] = { ['x'] = 234.96, ['y'] = 1151.69, ['z'] = 225.46, ['h'] = 178.95 },  ['foot'] = { ['x'] = 227.64, ['y'] = 1150.62, ['z'] = 225.59, ['h'] = 111.85 } },
	{ ['van'] = { ['x'] = -288.36, ['y'] = -1346.56, ['z'] = 30.38, ['h'] = 3.89 },  ['foot'] = { ['x'] = -295.05, ['y'] = -1347.02, ['z'] = 31.3, ['h'] = 85.52 } },
	{ ['van'] = { ['x'] = -288.36, ['y'] = -1346.56, ['z'] = 30.38, ['h'] = 3.89 },  ['foot'] = { ['x'] = -298.32, ['y'] = -1332.83, ['z'] = 31.3, ['h'] = 222.52 } },
	{ ['van'] = { ['x'] = -288.36, ['y'] = -1346.56, ['z'] = 30.38, ['h'] = 3.89 },  ['foot'] = { ['x'] = -296.11, ['y'] = -1353.31, ['z'] = 31.31, ['h'] = 183.42 } },
	{ ['van'] = { ['x'] = -677.66, ['y'] = -847.06, ['z'] = 23.97, ['h'] = 170.17 },  ['foot'] = { ['x'] = -678.3, ['y'] = -854.61, ['z'] = 24.07, ['h'] = 128.4 } },
	{ ['van'] = { ['x'] = -677.66, ['y'] = -847.06, ['z'] = 23.97, ['h'] = 170.17 },  ['foot'] = { ['x'] = -660.19, ['y'] = -858, ['z'] = 24.49, ['h'] = 197.77 } }, -- digital den and surrounding area (little seoul)
	{ ['van'] = { ['x'] = -677.66, ['y'] = -847.06, ['z'] = 23.97, ['h'] = 170.17 },  ['foot'] = { ['x'] = -687.09, ['y'] = -854.94, ['z'] = 23.88, ['h'] = 172.98 } },
	{ ['van'] = { ['x'] = -685.96, ['y'] = -826.64, ['z'] = 23.93, ['h'] = 98.8 },  ['foot'] = { ['x'] = -691.9, ['y'] = -810.39, ['z'] = 24.01, ['h'] = 11.42 } },
	{ ['van'] = { ['x'] = -685.96, ['y'] = -826.64, ['z'] = 23.93, ['h'] = 98.8 },  ['foot'] = { ['x'] = -658.74, ['y'] = -814.38, ['z'] = 24.55, ['h'] = 58.06 } },
	{ ['van'] = { ['x'] = -616.3, ['y'] = -774.43, ['z'] = 25.33, ['h'] = 5.45 },  ['foot'] = { ['x'] = -603.97, ['y'] = -782.8, ['z'] = 25.14, ['h'] = 182.32 } },
	{ ['van'] = { ['x'] = -827.58, ['y'] = -841.28, ['z'] = 19.65, ['h'] = 223.83 },  ['foot'] = { ['x'] = -831.29, ['y'] = -862.55, ['z'] = 20.69, ['h'] = 102.98 } },
	{ ['van'] = { ['x'] = -796.85, ['y'] = -1045.13, ['z'] = 12.53, ['h'] = 263.15 },  ['foot'] = { ['x'] = -785.78, ['y'] = -1044.55, ['z'] = 12.98, ['h'] = 290.44 } },
	{ ['van'] = { ['x'] = -796.85, ['y'] = -1045.13, ['z'] = 12.53, ['h'] = 263.15 },  ['foot'] = { ['x'] = -778.05, ['y'] = -1049.55, ['z'] = 12.98, ['h'] = 285.3 } },
	{ ['van'] = { ['x'] = -794.14, ['y'] = -578.64, ['z'] = 30.13, ['h'] = 82.16 },  ['foot'] = { ['x'] = -818.28, ['y'] = -575.11, ['z'] = 30.28, ['h'] = 113.79 } },
	{ ['van'] = { ['x'] = -794.14, ['y'] = -578.64, ['z'] = 30.13, ['h'] = 82.16 },  ['foot'] = { ['x'] = -813.5, ['y'] = -585.5, ['z'] = 30.28, ['h'] = 137.97 } },
	{ ['van'] = { ['x'] = -794.14, ['y'] = -578.64, ['z'] = 30.13, ['h'] = 82.16 },  ['foot'] = { ['x'] = -788.07, ['y'] = -600.59, ['z'] = 30.48, ['h'] = 156.34 } },
	{ ['van'] = { ['x'] = -1097.97, ['y'] = -316.92, ['z'] = 37.67, ['h'] = 267 },  ['foot'] = { ['x'] = -1095.14, ['y'] = -324.81, ['z'] = 37.82, ['h'] = 176.94 } },
	{ ['van'] = { ['x'] = -1138.75, ['y'] = -318.59, ['z'] = 37.67, ['h'] = 186.24 },  ['foot'] = { ['x'] = -1143.38, ['y'] = -325.78, ['z'] = 37.82, ['h'] = 46.6 } },
	{ ['van'] = { ['x'] = -1202.44, ['y'] = -279.99, ['z'] = 37.71, ['h'] = 351.48 },  ['foot'] = { ['x'] = -1197.2, ['y'] = -260.01, ['z'] = 37.75, ['h'] = 3 } },
	{ ['van'] = { ['x'] = -1533.17, ['y'] = -442.17, ['z'] = 35.44, ['h'] = 178.53 },  ['foot'] = { ['x'] = -1534.94, ['y'] = -454.1, ['z'] = 35.92, ['h'] = 66.74 } },
	{ ['van'] = { ['x'] = -1533.17, ['y'] = -442.17, ['z'] = 35.44, ['h'] = 178.53 },  ['foot'] = { ['x'] = -1548.61, ['y'] = -436.36, ['z'] = 35.89, ['h'] = 44.07 } },
	{ ['van'] = { ['x'] = -1533.17, ['y'] = -442.17, ['z'] = 35.44, ['h'] = 178.53 },  ['foot'] = { ['x'] = -1539.2, ['y'] = -427.96, ['z'] = 35.59, ['h'] = 25.33 } }, -- MRPD Area
	{ ['van'] = { ['x'] = -1533.17, ['y'] = -442.17, ['z'] = 35.44, ['h'] = 178.53 },  ['foot'] = { ['x'] = -1552.77, ['y'] = -440.52, ['z'] = 40.52, ['h'] = 11.34 } },
	{ ['van'] = { ['x'] = -1533.17, ['y'] = -442.17, ['z'] = 35.44, ['h'] = 178.53 },  ['foot'] = { ['x'] = -1540.7, ['y'] = -454.38, ['z'] = 40.52, ['h'] = 85.7 } },
	{ ['van'] = { ['x'] = 497.63, ['y'] = -785.6, ['z'] = 24.65, ['h'] = 168.9 },  ['foot'] = { ['x'] = 489.91, ['y'] = -801.21, ['z'] = 24.89, ['h'] = 105.4 } },
	{ ['van'] = { ['x'] = 497.63, ['y'] = -785.6, ['z'] = 24.65, ['h'] = 168.9 },  ['foot'] = { ['x'] = 493.73, ['y'] = -742.37, ['z'] = 24.88, ['h'] = 94.63 } },
}

