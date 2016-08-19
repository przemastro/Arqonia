SET NOCOUNT ON


;with cte 
        (
        ID,
        RowId,
        ObjectName,
        ObjectType,
        StartDate,
        EndDate,
        uPhotometry,
        uPhotometryTime,
        vPhotometry,
        vPhotometryTime,
        bPhotometry,
        bPhotometryTime,
        rPhotometry,
        rPhotometryTime,
        iPhotometry,
        iPhotometryTime,
        Status,
        Active,
        Verified
		)
        as (
SELECT 1,1,N'9 Cephei','Star',N'2010-10-10',N'2010-10-10',2720.81478,-6.68,2720.81478,-6.44,2720.81478,-6.14,2720.81478,-6.44,2720.81478,-6.14,N'new',1, 1 UNION ALL
SELECT 2,1,N'9 Pegasi','Star',N'2010-10-10',N'2010-10-10',2720.81478,-0.87,2720.81478,-3,2720.81478,-1.83,2720.81478,-3,2720.81478,-1.83,N'new',1, 1 UNION ALL
SELECT 3,1,N'40 Eridani A','Star',N'2010-10-10',N'2010-10-10',2720.81478,7.19,2720.81478,5.92,2720.81478,6.74,2720.81478,5.92,2720.81478,6.74,N'new',1, 1 UNION ALL
SELECT 4,1,N'40 Eridani B','Star',N'2010-10-10',N'2010-10-10',2720.81478,10.36,2720.81478,11.01,2720.81478,11.04,2720.81478,11.01,2720.81478,11.04,N'new',1, 1 UNION ALL
SELECT 5,1,N'40 Eridani C','Star',N'2010-10-10',N'2010-10-10',2720.81478,14.86,2720.81478,12.36,2720.81478,14.03,2720.81478,12.36,2720.81478,14.03,N'new',1, 1 UNION ALL
SELECT 6,1,N'61 Ursae Majoris','Star',N'2010-10-10',N'2010-10-10',2720.81478,6.37,2720.81478,5.41,2720.81478,6.1,2720.81478,5.41,2720.81478,6.1,N'new',1, 1 UNION ALL
SELECT 7,1,N'70 Ophiuchi','Star',N'2010-10-10',N'2010-10-10',2720.81478,6.92,2720.81478,5.5,2720.81478,6.35,2720.81478,5.5,2720.81478,6.35,N'new',1, 1 UNION ALL
SELECT 8,1,N'89 Herculis','Star',N'2010-10-10',N'2010-10-10',2720.81478,-6.5,2720.81478,-6.5,2720.81478,-6.16,2720.81478,-6.5,2720.81478,-6.16,N'new',1, 1 UNION ALL
SELECT 9,1,N'Aldebaran','Star',N'2010-10-10',N'2010-10-10',2720.81478,2.719,2720.81478,-0.614,2720.81478,0.826,2720.81478,-0.614,2720.81478,0.826,N'new',1, 1 UNION ALL
SELECT 10,1,N'Alnilam','Star',N'2010-10-10',N'2010-10-10',2720.81478,-6.1,2720.81478,-6.95,2720.81478,-7.13,2720.81478,-6.95,2720.81478,-7.13,N'new',1, 1 UNION ALL
SELECT 11,1,N'Alpha Coronae Borealis','Star',N'2010-10-10',N'2010-10-10',2720.81478,0.11,2720.81478,0.16,2720.81478,0.14,2720.81478,0.16,2720.81478,0.14,N'new',1, 1 UNION ALL
SELECT 12,1,N'Alpha Leporis','Star',N'2010-10-10',N'2010-10-10',2720.81478,-5.971,2720.81478,-6.574,2720.81478,-6.357,2720.81478,-6.574,2720.81478,-6.357,N'new',1, 1 UNION ALL
SELECT 13,1,N'Alpha Mensae','Star',N'2010-10-10',N'2010-10-10',2720.81478,6.1,2720.81478,5.05,2720.81478,5.77,2720.81478,5.05,2720.81478,5.77,N'new',1, 1 UNION ALL
SELECT 14,1,N'Alpha Persei','Star',N'2010-10-10',N'2010-10-10',2720.81478,-4.237,2720.81478,-5.1,2720.81478,-4.617,2720.81478,-5.1,2720.81478,-4.617,N'new',1, 1 UNION ALL
SELECT 15,1,N'Antares','Star',N'2010-10-10',N'2010-10-10',2720.81478,-2.11,2720.81478,-5.28,2720.81478,-3.45,2720.81478,-5.28,2720.81478,-3.45,N'new',1, 1 UNION ALL
SELECT 16,1,N'Arcturus','Star',N'2010-10-10',N'2010-10-10',2720.81478,2.21,2720.81478,-0.30,2720.81478,0.93,2720.81478,-0.30,2720.81478,0.93,N'new',1, 1 UNION ALL
SELECT 17,1,N'Beta Aquarii','Star',N'2010-10-10',N'2010-10-10',2720.81478,-1.92,2720.81478,-3.34,2720.81478,-2.5,2720.81478,-3.34,2720.81478,-2.5,N'new',1, 1 UNION ALL
SELECT 18,1,N'Beta Canis Majoris','Star',N'2010-10-10',N'2010-10-10',2720.81478,-5.325,2720.81478,-4.100,2720.81478,-4.335,2720.81478,-4.100,2720.81478,-4.335,N'new',1, 1 UNION ALL
SELECT 19,1,N'Beta Canum Venaticorum','Star',N'2010-10-10',N'2010-10-10',2720.81478,5.26,2720.81478,4.64,2720.81478,5.22,2720.81478,4.64,2720.81478,5.22,N'new',1, 1 UNION ALL
SELECT 20,1,N'Beta Centauri','Star',N'2010-10-10',N'2010-10-10',2720.81478,-5.74,2720.81478,-4.53,2720.81478,-4.76,2720.81478,-4.53,2720.81478,-4.76,N'new',1, 1 UNION ALL
SELECT 21,1,N'Beta Cephei','Star',N'2010-10-10',N'2010-10-10',2720.81478,-4.418,2720.81478,-3.468,2720.81478,-3.688,2720.81478,-3.468,2720.81478,-3.688,N'new',1, 1 UNION ALL
SELECT 22,1,N'Beta Comae Berenices','Star',N'2010-10-10',N'2010-10-10',2720.81478,5.08,2720.81478,4.42,2720.81478,5,2720.81478,4.42,2720.81478,5,N'new',1, 1 UNION ALL
SELECT 23,1,N'Beta Pegasi','Star',N'2010-10-10',N'2010-10-10',2720.81478,2.14,2720.81478,-1.49,2720.81478,0.18,2720.81478,-1.49,2720.81478,0.18,N'new',1, 1 UNION ALL
SELECT 24,1,N'Beta Pictoris','Star',N'2010-10-10',N'2010-10-10',2720.81478,2.69,2720.81478,2.42,2720.81478,2.59,2720.81478,2.42,2720.81478,2.59,N'new',1, 1 UNION ALL
SELECT 25,1,N'Betelquese','Star',N'2010-10-10',N'2010-10-10',2720.81478,-1.94,2720.81478,-5.85,2720.81478,-4,2720.81478,-5.85,2720.81478,-4,N'new',1, 1 UNION ALL
SELECT 26,1,N'Delta Canis Majoris','Star',N'2010-10-10',N'2010-10-10',2720.81478,-5.585,2720.81478,-6.86,2720.81478,-6.169,2720.81478,-6.86,2720.81478,-6.169,N'new',1, 1 UNION ALL
SELECT 27,1,N'Delta Cephei','Star',N'2010-10-10',N'2010-10-10',2720.81478,-2.51,2720.81478,-3.47,2720.81478,-2.87,2720.81478,-3.47,2720.81478,-2.87,N'new',1, 1 UNION ALL
SELECT 28,1,N'Deneb','Star',N'2010-10-10',N'2010-10-10',2720.81478,-2.51,2720.81478,-3.47,2720.81478,-2.87,2720.81478,-3.47,2720.81478,-2.87,N'new',1, 1 UNION ALL
SELECT 29,1,N'Epsilon Cygni','Star',N'2010-10-10',N'2010-10-10',2720.81478,2.67,2720.81478,0.78,2720.81478,1.81,2720.81478,0.78,2720.81478,1.81,N'new',1, 1 UNION ALL
SELECT 30,1,N'Epsilon Geminorum','Star',N'2010-10-10',N'2010-10-10',2720.81478,-1.04,2720.81478,-3.90,2720.81478,-2.5,2720.81478,-3.90,2720.81478,-2.5,N'new',1, 1 UNION ALL
SELECT 31,1,N'Epsilon Pegasi','Star',N'2010-10-10',N'2010-10-10',2720.81478,-0.893,2720.81478,-4.142,2720.81478,-2.615,2720.81478,-4.142,2720.81478,-2.615,N'new',1, 1 UNION ALL
SELECT 32,1,N'Epsilon Virginis','Star',N'2010-10-10',N'2010-10-10',2720.81478,2.028,2720.81478,0.37,2720.81478,1.31,2720.81478,0.37,2720.81478,1.31,N'new',1, 1 UNION ALL
SELECT 33,1,N'Eta Aquilae','Star',N'2010-10-10',N'2010-10-10',2720.81478,-2.3,2720.81478,-3.70,2720.81478,-2.81,2720.81478,-3.70,2720.81478,-2.81,N'new',1, 1 UNION ALL
SELECT 34,1,N'Eta Arietis','Star',N'2010-10-10',N'2010-10-10',2720.81478,3.33,2720.81478,2.93,2720.81478,3.37,2720.81478,2.93,2720.81478,3.37,N'new',1, 1 UNION ALL
SELECT 35,1,N'Eta Canis Majoris','Star',N'2010-10-10',N'2010-10-10',2720.81478,-7.795,2720.81478,-7.0,2720.81478,-7.087,2720.81478,-7.0,2720.81478,-7.087,N'new',1, 1 UNION ALL
SELECT 36,1,N'Eta Leonis','Star',N'2010-10-10',N'2010-10-10',2720.81478,-5.772,2720.81478,-5.54,2720.81478,-5.566,2720.81478,-5.54,2720.81478,-5.566,N'new',1, 1 UNION ALL
SELECT 37,1,N'EZ Aquarii','Star',N'2010-10-10',N'2010-10-10', 2720.81478,19.14,2720.81478,15.64,2720.81478,17.6,2720.81478,15.64,2720.81478,17.6,N'new',1, 1 UNION ALL
SELECT 38,1,N'FF Aquilae','Star',N'2010-10-10',N'2010-10-10',2720.81478,-2.17,2720.81478,-3.4,2720.81478,-2.6,2720.81478,-3.4,2720.81478,-2.6,N'new',1, 1 UNION ALL
SELECT 39,1,N'Gamma Crucis','Star',N'2010-10-10',N'2010-10-10',2720.81478,2.85,2720.81478,-0.52,2720.81478,1.07,2720.81478,-0.52,2720.81478,1.07,N'new',1, 1 UNION ALL
SELECT 40,1,N'Gamma Draconis','Star',N'2010-10-10',N'2010-10-10',2720.81478,1.47,2720.81478,-1.93,2720.81478,-0.4,2720.81478,-1.93,2720.81478,-0.4,N'new',1, 1 UNION ALL
SELECT 41,1,N'Gamma Ursae Majoris','Star',N'2010-10-10',N'2010-10-10',2720.81478,0.355,2720.81478,0.36,2720.81478,0.347,2720.81478,0.36,2720.81478,0.347,N'new',1, 1 UNION ALL
SELECT 42,1,N'Gamma Virginis','Star',N'2010-10-10',N'2010-10-10',2720.81478,2.69,2720.81478,2.38,2720.81478,2.74,2720.81478,2.38,2720.81478,2.74,N'new',1, 1 UNION ALL
SELECT 43,1,N'Gliese 229A','Star',N'2010-10-10',N'2010-10-10',2720.81478,12.03,2720.81478,9.33,2720.81478,10.808,2720.81478,9.33,2720.81478,10.808,N'new',1, 1 UNION ALL
SELECT 44,1,N'Gliese 581','Star',N'2010-10-10',N'2010-10-10',null,null,2720.81478,11.6,2720.81478,13.21,2720.81478,11.6,2720.81478,13.21,N'new',1, 1 UNION ALL
SELECT 45,1,N'Hamal','Star',N'2010-10-10',N'2010-10-10',2720.81478,2.75,2720.81478,0.47,2720.81478,1.62,2720.81478,0.47,2720.81478,1.62,N'new',1, 1 UNION ALL
SELECT 46,1,N'HD21389','Star',N'2010-10-10',N'2010-10-10',2720.81478,-6.75,2720.81478,-7.20,2720.81478,-6.64,2720.81478,-7.20,2720.81478,-6.64,N'new',1, 1 UNION ALL
SELECT 47,1,N'HIP12961','Star',N'2010-10-10',N'2010-10-10',null,null,2720.81478,7.8,2720.81478,9.4,2720.81478,7.8,2720.81478,9.4,N'new',1, 1 UNION ALL
SELECT 48,1,N'Kappa Pavonis','Star',N'2010-10-10',N'2010-10-10',null,null,2720.81478,-1.99,2720.81478,-1.63,2720.81478,-1.99,2720.81478,-1.63,N'new',1, 1 UNION ALL
SELECT 49,1,N'KY Cygni','Star',N'2010-10-10',N'2010-10-10',2720.81478,-1.88,2720.81478,-8.18,2720.81478,-4.79,2720.81478,-8.18,2720.81478,-4.79,N'new',1, 1 UNION ALL
SELECT 50,1,N'L 97-12','Star',N'2010-10-10',N'2010-10-10',null,null,2720.81478,14.47,null,null,2720.81478,14.47,null,null,N'new',1, 1 UNION ALL
SELECT 51,1,N'Lalande 21185','Star',N'2010-10-10',N'2010-10-10',2720.81478,12.998,2720.81478,10.48,2720.81478,11.924,2720.81478,10.48,2720.81478,11.924,N'new',1, 1 UNION ALL
SELECT 52,1,N'LP 145-141','Star',N'2010-10-10',N'2010-10-10',2720.81478,12.78,2720.81478,13.18,2720.81478,13.37,2720.81478,13.18,2720.81478,13.37,N'new',1, 1 UNION ALL
SELECT 53,1,N'Mira','Star',N'2010-10-10',N'2010-10-10',2720.81478,2.54,2720.81478,0.93,2720.81478,2.46,2720.81478,0.93,2720.81478,2.46,N'new',1, 1 UNION ALL
SELECT 54,1,N'Mu Cephei','Star',N'2010-10-10',N'2010-10-10',2720.81478,2.54,2720.81478,0.93,2720.81478,2.46,2720.81478,0.93,2720.81478,2.46,N'new',1, 1 UNION ALL
SELECT 55,1,N'P Cygni','Star',N'2010-10-10',N'2010-10-10',2720.81478,-8.06,2720.81478,-7.9,2720.81478,-7.48,2720.81478,-7.9,2720.81478,-7.48,N'new',1, 1 UNION ALL
SELECT 56,1,N'Pi3 Orionis','Star',N'2010-10-10',N'2010-10-10',2720.81478,4.11,2720.81478,3.65,2720.81478,4.11,2720.81478,3.65,2720.81478,4.11,N'new',1, 1 UNION ALL
SELECT 57,1,N'Pi Andromedae','Star',N'2010-10-10',N'2010-10-10',2720.81478,-2.83,2720.81478,-1.67,2720.81478,-1.83,2720.81478,-1.67,2720.81478,-1.83,N'new',1, 1 UNION ALL
SELECT 58,1,N'Polaris','Star',N'2010-10-10',N'2010-10-10',2720.81478,-2.62,2720.81478,-3.6,2720.81478,-3.0,2720.81478,-3.6,2720.81478,-3.0,N'new',1, 1 UNION ALL
SELECT 59,1,N'Pollux','Star',N'2010-10-10',N'2010-10-10',2720.81478,2.94,2720.81478,1.08,2720.81478,2.08,2720.81478,1.08,2720.81478,2.08,N'new',1, 1 UNION ALL
SELECT 60,1,N'Procyon A','Star',N'2010-10-10',N'2010-10-10',null,null,2720.81478,13.0,2720.81478,13.0,2720.81478,13.0,2720.81478,13.0,N'new',1, 1 UNION ALL
SELECT 61,1,N'Procyon B','Star',N'2010-10-10',N'2010-10-10',2720.81478,3.05,2720.81478,2.66,2720.81478,3.06,2720.81478,2.66,2720.81478,3.06,N'new',1, 1 UNION ALL
SELECT 62,1,N'Proxima Centauri','Star',N'2010-10-10',N'2010-10-10',2720.81478,18.68,2720.81478,15.60,2720.81478,17.42,2720.81478,15.60,2720.81478,17.42,N'new',1, 1 UNION ALL
SELECT 63,1,N'Rigel','Star',N'2010-10-10',N'2010-10-10',2720.81478,18.68,2720.81478,15.60,2720.81478,17.42,2720.81478,15.60,2720.81478,17.42,N'new',1, 1 UNION ALL
SELECT 64,1,N'RR Lyrae','Star',N'2010-10-10',N'2010-10-10',2720.81478,0.953,2720.81478,0.6,2720.81478,0.781,2720.81478,0.6,2720.81478,0.781,N'new',1, 1 UNION ALL
SELECT 65,1,N'Sigma Draconis','Star',N'2010-10-10',N'2010-10-10',2720.81478,7.047,2720.81478,5.87,2720.81478,6.661,2720.81478,5.87,2720.81478,6.661,N'new',1, 1 UNION ALL
SELECT 66,1,N'Sirius A','Star',N'2010-10-10',N'2010-10-10',2720.81478,1.37,2720.81478,1.42,2720.81478,1.42,2720.81478,1.42,2720.81478,1.42,N'new',1, 1 UNION ALL
SELECT 67,1,N'Sirius B','Star',N'2010-10-10',N'2010-10-10',2720.81478,10.11,2720.81478,11.18,2720.81478,11.15,2720.81478,11.18,2720.81478,11.15,N'new',1, 1 UNION ALL
SELECT 68,1,N'Spica','Star',N'2010-10-10',N'2010-10-10',2720.81478,-4.72,2720.81478,-3.55,2720.81478,-3.78,2720.81478,-3.55,2720.81478,-3.78,N'new',1, 1 UNION ALL
SELECT 69,1,N'Tau Herculis','Star',N'2010-10-10',N'2010-10-10',2720.81478,-1.755,2720.81478,-1.03,2720.81478,-1.185,2720.81478,-1.03,2720.81478,-1.185,N'new',1, 1 UNION ALL
SELECT 70,1,N'Theta1 Orionis','Star',N'2010-10-10',N'2010-10-10',2720.81478,-5.83,2720.81478,-4.9,2720.81478,-4.88,2720.81478,-4.9,2720.81478,-4.88,N'new',1, 1 UNION ALL
SELECT 71,1,N'U Antilae','Star',N'2010-10-10',N'2010-10-10',2720.81478,4.76,2720.81478,-5.22,2720.81478,-2.34,2720.81478,-5.22,2720.81478,-2.34,N'new',1, 1 UNION ALL
SELECT 72,1,N'Upsilon Orionis','Star',N'2010-10-10',N'2010-10-10',2720.81478,-5.092,2720.81478,-3.76,2720.81478,-4.024,2720.81478,-3.76,2720.81478,-4.024,N'new',1, 1 UNION ALL
SELECT 73,1,N'Vega','Star',N'2010-10-10',N'2010-10-10',2720.81478,0.582,2720.81478,0.582,2720.81478,0.582,2720.81478,0.582,2720.81478,0.582,N'new',1, 1 UNION ALL
SELECT 74,1,N'Wolf 359','Star',N'2010-10-10',N'2010-10-10',2720.81478,19.849,2720.81478,16.65,2720.81478,18.684,2720.81478,16.65,2720.81478,18.684,N'new',1, 1 UNION ALL
SELECT 75,1,N'Wolf 489','Star',N'2010-10-10',N'2010-10-10',null,null,2720.81478,15.08,null,null,2720.81478,15.08,null,null,N'new',1, 1 UNION ALL
SELECT 76,1,N'W Virginis','Star',N'2010-10-10',N'2010-10-10',null,null,2720.81478,-3.0,2720.81478,-2.6,null,null,2720.81478,-3.0,N'new',1, 1 UNION ALL
SELECT 77,1,N'Zeta Leonis','Star',N'2010-10-10',N'2010-10-10',2720.81478,-1.12,2720.81478,-1.49,2720.81478,-1.19,2720.81478,-1.49,2720.81478,-1.19,N'new',1, 1 UNION ALL
SELECT 78,1,N'Zeta Pegasi','Star',N'2010-10-10',N'2010-10-10',2720.81478,-0.889,2720.81478,-0.62,2720.81478,-0.708,2720.81478,-0.62,2720.81478,-0.708,N'new',1, 1 UNION ALL
SELECT 79,1,N'9 Pegasi','Star',N'2010-10-11',N'2010-10-12',2720.81479,-0.88,2720.81479,-3.05,2720.81479,-1.86,2720.81479,-3.05,2720.81479,-1.84,N'new',1, 1 UNION ALL
SELECT 79,2,N'9 Pegasi','Star',N'2010-10-11',N'2010-10-12',2720.81480,-0.90,2720.81480,-3.09,2720.81480,-1.89,2720.81480,-3.08,2720.81480,-1.89,N'new',1, 1 UNION ALL
SELECT 79,3,N'9 Pegasi','Star',N'2010-10-11',N'2010-10-12',2720.81481,-0.95,2720.81481,-3.11,2720.81481,-1.91,2720.81481,-3.11,2720.81481,-1.95,N'new',1, 1 UNION ALL
SELECT 79,4,N'9 Pegasi','Star',N'2010-10-11',N'2010-10-12',2720.81482,-1.00,2720.81482,-3.15,2720.81482,-1.95,2720.81482,-3.16,2720.81482,-1.99,N'new',1, 1 UNION ALL
SELECT 79,5,N'9 Pegasi','Star',N'2010-10-11',N'2010-10-12',2720.81483,-1.07,2720.81483,-3.19,2720.81483,-1.99,2720.81483,-3.22,2720.81483,-2.03,N'new',1, 1 UNION ALL
SELECT 80,1,N'9 Pegasi','Star',N'2010-10-13',N'2010-10-14',2720.81487,-1.03,2720.81487,-3.15,2720.81487,-1.98,2720.81487,-3.24,2720.81487,-2.00,N'new',1, 1 UNION ALL
SELECT 80,2,N'9 Pegasi','Star',N'2010-10-13',N'2010-10-14',2720.81488,-1.00,2720.81488,-3.11,2720.81488,-1.95,2720.81488,-3.22,2720.81488,-2.00,N'new',1, 1 UNION ALL
SELECT 80,3,N'9 Pegasi','Star',N'2010-10-13',N'2010-10-14',2720.81489,-0.95,2720.81489,-3.07,2720.81489,-1.91,2720.81489,-3.18,2720.81489,-1.95,N'new',1, 1 UNION ALL
SELECT 80,4,N'9 Pegasi','Star',N'2010-10-13',N'2010-10-14',2720.81490,-0.91,2720.81490,-3.04,2720.81490,-1.90,2720.81490,-3.16,2720.81490,-1.91,N'new',1, 1 UNION ALL
SELECT 80,5,N'9 Pegasi','Star',N'2010-10-13',N'2010-10-14',2720.81491,-0.88,2720.81491,-3.00,2720.81491,-1.89,2720.81491,-3.10,2720.81491,-1.87,N'new',1, 1)

INSERT INTO stg.stagingObservations
        ( 
		ID,
		RowId,
		ObjectName,
		ObjectType,
		StartDate,
		EndDate,
		uPhotometryTime,
		uPhotometry,
		vPhotometryTime,
		vPhotometry,
		bPhotometryTime,
		bPhotometry,
		rPhotometryTime,
		rPhotometry,
		iPhotometryTime,
		iPhotometry,
		Status,
		Active,
		Verified
	    )
	    select * from cte
GO
