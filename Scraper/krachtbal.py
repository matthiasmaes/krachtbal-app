import requests, json
from bs4 import BeautifulSoup
from datetime import datetime
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
from os import environ
from pytz import timezone
import pytz

class BackendKrachtbal:

	def __init__(self, uploadResults):
		self.firebase = self.initFirebase()
		self.now = datetime.now()
		self.uploadResults = uploadResults
		self.filename = datetime.now(tz=pytz.timezone('Europe/Brussels')).strftime("%d-%m-%Y-%H-%M-%S") + '-krachtbal-scraped.json'
		self.filename_short = datetime.now(tz=pytz.timezone('Europe/Brussels')).strftime("%d-%m-%Y-%H-%M-%S")
		self.url_ranking = 'http://krachtbal.be/rangschikking.asp?club=11_0&reeks=0'
		self.url_calendar = 'http://krachtbal.be/kalender.asp?club=11_0&reeks=0&datum=0'
		self.url_base_remote = 'krachtbal/scraped_data/'
		self.devisions_ranking = []
		self.devisions_calendar = []


	def getTables(self, url):
		request_text = requests.get(url).text
		request_soup = BeautifulSoup(request_text, 'html.parser')
		return request_soup.find_all('table')


	def getDevisons (self, table):
		return [devison.get_text()[devison.get_text().find("(")+1:devison.get_text().find(")")] for devison in BeautifulSoup(str(table), 'html.parser').find_all('td', {'class': 'td_reeks'})]


	def tableToJson(self, table_list, processor):
		table_data = {}
		table_index = 0

		for table_iter in table_list:
			table_results = []
			table_rows = table_iter.find_all('tr')
			del table_rows[:2]
			for table_row in table_rows:
				table_columns = table_row.find_all('td')
				try:
					if(processor == 'calendar'):
						if datetime.strptime(table_columns[0].get_text() + '-' + table_columns[1].get_text(), '%d/%m/%Y-%H:%M') < self.now: continue
						table_results.append({'date': table_columns[0].get_text(), 'time': table_columns[1].get_text(), 'home': table_columns[2].get_text(), 'away': table_columns[3].get_text(), 'score_home': table_columns[4].get_text(), 'score_away': table_columns[6].get_text().strip()})
					elif(processor == 'synchCalendar'):
						table_results.append({'date': table_columns[0].get_text(), 'time': table_columns[1].get_text(), 'home': table_columns[2].get_text(), 'away': table_columns[3].get_text(), 'score_home': table_columns[4].get_text(), 'score_away': table_columns[6].get_text().strip()})
					elif(processor == 'ranking'):
						table_results.append({'place': table_columns[0].get_text(), 'club': table_columns[1].get_text(), 'games': table_columns[2].get_text(),'points': table_columns[-1].get_text()})
				except IndexError as error:
					pass

			table_data[self.devisions_ranking[table_index]] = table_results
			table_index += 1
		
		return table_data


	def createSynchrCalendar(self, calendarTable):
		unsortedList = []
		for devision in calendarTable.keys():
			for entry in calendarTable[devision]:
				newEntry = entry
				newEntry['devision'] = devision
				newEntry['datetime'] = datetime.strptime(entry['date'] + '-' + entry['time'], '%d/%m/%Y-%H:%M')
				if newEntry['datetime'] > self.now: continue
				unsortedList.append(newEntry)
		return sorted(unsortedList, reverse=True, key=lambda d: d['datetime']) 


	def initFirebase(self):
		if environ.get('FIREBASE') is None:
			cred = credentials.Certificate("C:/Users/matth/Desktop/KRACHTBAL/krachtbal-klaverken-firebase-adminsdk-htytx-4f3a847736.json")
		else:
			cred = credentials.Certificate(json.loads(environ.get('FIREBASE')))
		firebase_admin.initialize_app(cred)
		return firestore.client()


	def storeFirebase(self, collection, value):
		if(self.uploadResults):
			timestamped_doc = self.firebase.collection(collection).document(self.filename_short)
			timestamped_doc.set({'data': value})
			latest_doc = self.firebase.collection(collection).document('latest')
			latest_doc.set({'data': value})
		else: 
			print('[DEBUG MODE] Not pushing to firebase')


if __name__ == "__main__":
	worker = BackendKrachtbal(uploadResults = True)

	worker.devisions_ranking = worker.getDevisons(worker.getTables(worker.url_ranking))
	ranking = worker.tableToJson(worker.getTables(worker.url_ranking), 'ranking')
	worker.storeFirebase('ranking', ranking)
	
	worker.devisions_calendar = worker.getDevisons(worker.getTables(worker.url_calendar))
	calendar = worker.tableToJson(worker.getTables(worker.url_calendar), 'calendar')
	worker.storeFirebase('calendar', calendar)

	synchCalendar = worker.createSynchrCalendar(worker.tableToJson(worker.getTables(worker.url_calendar), 'synchCalendar'))
	worker.storeFirebase('synchCalendar', synchCalendar)

	print('Very good Sir, updates were pushed:', worker.filename)
