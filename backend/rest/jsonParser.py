import sys
import re
import pyodbc
import ConfigParser
import csv
import pandas


config = ConfigParser.RawConfigParser()
config.read('../resources/ConfigFile.properties')
dbAddress = config.get('DatabaseSection', 'database.address');

reload(sys)
sys.setdefaultencoding('utf8')

#----------------------------------------------insert new observation---------------------------------------------------
def json_parser(name, startDate, endDate, uName, uFileName, vPhotometry, bPhotometry):
 try:
     cnx = pyodbc.connect(dbAddress)
     cursor = cnx.cursor()


     get_lastId = ("select top 1 id from stg.StagingObservations order by id desc")
     cursor.execute(get_lastId)
     lastId = cursor.fetchone()

     if lastId is None:
         lastId = 1
     else:
         lastId = lastId[0] + 1

     lastId = str(lastId)
     name = str(name)
     startDate = str(startDate)
     endDate = str(endDate)
     vPhotometry = str(vPhotometry)
     bPhotometry = str(bPhotometry)


  #--insert to data.fileNames
     print uName
     uName = str(uName)
     uFileName = str(uFileName)

     insert_uFileName = ("insert into data.fileNames(ObservationId, FileName, FileType, FileSize) values("+lastId+",'"+uFileName+"', ' ', ' ')")

     print insert_uFileName

     cursor.execute(insert_uFileName)
     cnx.commit()

  #---insert to stg.stagingObservations
     #--read file

     data = pandas.read_csv('uploads/'+uFileName, header=None)
     print data
     dataRange = len(data)
     print dataRange
     data.columns = ["uTime", "uFlux"]
     print(data.columns)
     print data.uTime[0]



     insert_observation = ''

     for counter in range(0,dataRange):
        if counter < dataRange-1:
           i = counter
           j = counter
           utime = str(data.uTime[i])
           uflux = str(data.uFlux[i])
           j = str(counter + 1)
           observation = "SELECT "+lastId+","+j+",'"+name+"','"+startDate+"','"+endDate+"','"+utime+"','"+uflux+"','2720.81478','-6.44','2720.81478','-6.14','new',1 UNION ALL "
           insert_observation = insert_observation + observation
        else:
           i = counter
           j = counter
           utime = str(data.uTime[i])
           uflux = str(data.uFlux[i])
           j = str(counter + 1)
           observation = "SELECT "+lastId+","+j+",'"+name+"','"+startDate+"','"+endDate+"','"+utime+"','"+uflux+"','2720.81478','-6.44','2720.81478','-6.14','new',1"
           insert_observation = insert_observation + observation



     insert_observation = "SET NOCOUNT ON ;with cte (ID,RowId,StarName,StartDate,EndDate,uPhotometryTime,uPhotometry,vPhotometryTime,vPhotometry,bPhotometryTime," \
                          "bPhotometry,Status,Active) as (" + insert_observation + ") INSERT INTO stg.stagingObservations (ID,RowId,StarName,StartDate,EndDate," \
                          "uPhotometryTime,uPhotometry,vPhotometryTime,vPhotometry,bPhotometryTime,bPhotometry,Status,Active) select * from cte GO"

     print insert_observation

     cursor.execute(insert_observation)
     cnx.commit()

     cursor.close()

 except:
   print 'errors'
 else:
   cnx.close()


#---------------------------------------------Update existing observation----------------------------------------------
def updateObservation(id, name, startDate, endDate, uPhotometry, vPhotometry, bPhotometry):
    try:
        cnx = pyodbc.connect(dbAddress)
        cursor = cnx.cursor()

        id = str(id)
        name = str(name)
        startDate = str(startDate)
        endDate = str(endDate)
        uPhotometry = str(uPhotometry)
        vPhotometry = str(vPhotometry)
        bPhotometry = str(bPhotometry)

        update_observation = ("Update stg.stagingObservations set starName='"+name+"', startDate='"+startDate+"', endDate='"+endDate+"', uPhotometry='0.259254028383', uPhotometryTime='2721.7367',"
                              "vPhotometry='0.259254028383', vPhotometryTime='2721.7367', bPhotometry='0.259254028383', bPhotometryTime='2721.7367', Status='new', active=1 where id="+id+"")

        print update_observation

        cursor.execute(update_observation)
        cnx.commit()

        cursor.close()

    except:
        print 'errors'
    else:
        cnx.close()