import 'dart:convert';
import 'dart:ffi';

import 'package:http/http.dart' as http;

class DataClass {
  DataClass();

  Future<Map?> getData() async {
    var url = Uri.parse(
      'https://matthiasmaes.com/krachtbal/scraped_data/latest.json',
    );
    var response = await http.get(url);
    // var parsed = jsonDecode(utf8.decode(response.bodyBytes)) as Map;

    Map<String, dynamic> data = json.decode(response.body);

    return data;
  }
}

final Map data_fo_real = {
  '1° Nationale Heren': [
    {'place': '1', 'club': 'KRB Jabbeke', 'points': '46'},
    {'place': '2', 'club': 'KBC Male', 'points': '46'},
    {'place': '3', 'club': 'KSVV Inter Assebroek', 'points': '45'},
    {'place': '4', 'club': 'KBC St. Michiels', 'points': '43'},
    {'place': '5', 'club': 'HO Beitem', 'points': '40'},
    {'place': '6', 'club': 'D&W Koekelare', 'points': '40'},
    {'place': '7', 'club': 'Sporting Brugge', 'points': '38'},
    {'place': '8', 'club': 'Grenskracht Menen', 'points': '38'},
    {'place': '9', 'club': 't Klaverken Buggenhout', 'points': '36'},
    {'place': '10', 'club': 'KBK Ichtegem', 'points': '28'},
    {'place': '11', 'club': 'Avanti Lissewege', 'points': '28'},
    {'place': '12', 'club': 't Botterken Baasrode', 'points': '28'}
  ],
  '1° Nationale Heren Beloften': [
    {'place': '1', 'club': 'KRB Jabbeke', 'points': '44'},
    {'place': '2', 'club': 'Sporting Brugge', 'points': '44'},
    {'place': '3', 'club': 'D&W Koekelare', 'points': '41'},
    {'place': '4', 'club': 'KBC St. Michiels', 'points': '40'},
    {'place': '5', 'club': 't Klaverken Buggenhout', 'points': '39'},
    {'place': '6', 'club': 'KBC Male', 'points': '38'},
    {'place': '7', 'club': 't Botterken Baasrode', 'points': '38'},
    {'place': '8', 'club': 'HO Beitem', 'points': '38'},
    {'place': '9', 'club': 'Grenskracht Menen', 'points': '38'},
    {'place': '10', 'club': 'KSVV Inter Assebroek', 'points': '36'},
    {'place': '11', 'club': 'KBK Ichtegem', 'points': '30'},
    {'place': '12', 'club': 'Avanti Lissewege', 'points': '24'}
  ],
  '1° Nationale Dames': [
    {'place': '1', 'club': 'KBC Male', 'points': '52'},
    {'place': '2', 'club': 't Botterken Baasrode', 'points': '52'},
    {'place': '3', 'club': 'KBC St. Michiels', 'points': '48'},
    {'place': '4', 'club': 't Klaverken Buggenhout', 'points': '48'},
    {'place': '5', 'club': 'WWR Ingelmunster', 'points': '38'},
    {'place': '6', 'club': 'HO Beitem', 'points': '38'},
    {'place': '7', 'club': 'Avanti Lissewege', 'points': '32'},
    {'place': '8', 'club': 'Noordster Dudzele', 'points': '32'},
    {'place': '9', 'club': 'KBK Ichtegem', 'points': '28'},
    {'place': '10', 'club': 'KBC Heist', 'points': '26'}
  ],
  '1e Nationale Dames Beloften': [
    {'place': '1', 'club': 'KBC St. Michiels', 'points': '48'},
    {'place': '2', 'club': 't Klaverken Buggenhout', 'points': '46'},
    {'place': '3', 'club': 't Botterken Baasrode', 'points': '43'},
    {'place': '4', 'club': 'KBC Heist', 'points': '39'},
    {'place': '5', 'club': 'HO Beitem', 'points': '39'},
    {'place': '6', 'club': 'KBC Male', 'points': '38'},
    {'place': '7', 'club': 'Avanti Lissewege', 'points': '38'},
    {'place': '8', 'club': 'Noordster Dudzele', 'points': '32'},
    {'place': '9', 'club': 'KBK Ichtegem', 'points': '28'},
    {'place': '10', 'club': 'WWR Ingelmunster', 'points': '19'}
  ],
  '2° Nationale Heren': [
    {'place': '1', 'club': 'WWR Ingelmunster', 'points': '45'},
    {'place': '2', 'club': 'KBC Male', 'points': '41'},
    {'place': '3', 'club': 'Osiris Aalst', 'points': '41'},
    {'place': '4', 'club': 'KBC St. Michiels', 'points': '40'},
    {'place': '5', 'club': 'D&W Koekelare', 'points': '39'},
    {'place': '6', 'club': 'KBC Opstal', 'points': '34'},
    {'place': '7', 'club': 'Krachtbal Snellegem', 'points': '30'},
    {'place': '8', 'club': 'KBK Temse', 'points': '28'},
    {'place': '9', 'club': 'Helios Halle', 'points': '26'}
  ],
  '2° Nationale Heren Beloften': [
    {'place': '1', 'club': 'D&W Koekelare', 'points': '42'},
    {'place': '2', 'club': 'WWR Ingelmunster', 'points': '40'},
    {'place': '3', 'club': 'KBK Temse', 'points': '38'},
    {'place': '4', 'club': 'Osiris Aalst', 'points': '37'},
    {'place': '5', 'club': 'KBC Opstal', 'points': '37'},
    {'place': '6', 'club': 'KBC Male', 'points': '36'},
    {'place': '7', 'club': 'Krachtbal Snellegem', 'points': '34'},
    {'place': '8', 'club': 'KBC St. Michiels', 'points': '30'},
    {'place': '9', 'club': 'Helios Halle', 'points': '12'}
  ],
  '1° Landelijke Heren': [
    {'place': '1', 'club': 'KBC Aalter', 'points': '56'},
    {'place': '2', 'club': 'D&W Koekelare', 'points': '54'},
    {'place': '3', 'club': 'KBC Heist', 'points': '53'},
    {'place': '4', 'club': 'HO Beitem', 'points': '50'},
    {'place': '5', 'club': 'KSVV Inter Assebroek', 'points': '37'},
    {'place': '6', 'club': 'Osiris Aalst', 'points': '36'},
    {'place': '7', 'club': 'KBC Male', 'points': '34'},
    {'place': '8', 'club': 'Atlas Varsenare', 'points': '32'}
  ],
  '1° Landelijke Dames': [
    {'place': '1', 'club': 'Atlas Varsenare', 'points': '60'},
    {'place': '2', 'club': 'KBC St. Michiels', 'points': '54'},
    {'place': '3', 'club': 'Grenskracht Menen', 'points': '54'},
    {'place': '4', 'club': 'Sporting Brugge', 'points': '50'},
    {'place': '5', 'club': 't Klaverken Buggenhout', 'points': '39'},
    {'place': '6', 'club': 'KRB Jabbeke', 'points': '35'},
    {'place': '7', 'club': 'KBK Ichtegem', 'points': '34'},
    {'place': '8', 'club': 'KBC Opstal', 'points': '34'},
    {'place': '9', 'club': 't Botterken Baasrode', 'points': '30'},
    {'place': '10', 'club': 'Meraki Aalst', 'points': '20'}
  ],
  '2° Landelijke Heren': [
    {'place': '1', 'club': 'KBK Temse', 'points': '52'},
    {'place': '2', 'club': 'Z.A.K.Beveren', 'points': '50'},
    {'place': '3', 'club': 't Klaverken Buggenhout B', 'points': '46'},
    {'place': '4', 'club': 'Krachtbal Torhout', 'points': '46'},
    {'place': '5', 'club': 't Klaverken Buggenhout A', 'points': '45'},
    {'place': '6', 'club': 'KBC Aalter', 'points': '44'},
    {'place': '7', 'club': 'KB Moerdamme', 'points': '39'},
    {'place': '8', 'club': 'Buffalo s Sijsele', 'points': '34'},
    {'place': '9', 'club': 'Meraki Aalst', 'points': '32'},
    {'place': '10', 'club': 'Noordster Dudzele', 'points': '30'}
  ],
  '2° Landelijke Dames A': [
    {'place': '1', 'club': 'KB Moerdamme', 'points': '46'},
    {'place': '2', 'club': 'KRB Jabbeke', 'points': '41'},
    {'place': '3', 'club': 'KBC Male', 'points': '41'},
    {'place': '4', 'club': 'KRB Loppem', 'points': '38'},
    {'place': '5', 'club': 't Botterken Baasrode (2LD)', 'points': '36'},
    {'place': '6', 'club': 'D&W Koekelare', 'points': '34'},
    {'place': '7', 'club': 'Atlas Varsenare', 'points': '34'},
    {'place': '8', 'club': 'Krachtbal Snellegem', 'points': '24'},
    {'place': '9', 'club': 'HO Beitem', 'points': '22'}
  ],
  '2° Landelijke Dames B': [
    {'place': '1', 'club': 'Avanti Lissewege', 'points': '42'},
    {'place': '2', 'club': 'KBC Maldegem-Donk', 'points': '40'},
    {'place': '3', 'club': 'KBK Temse (2LD)', 'points': '38'},
    {'place': '4', 'club': 'Grenskracht Menen', 'points': '38'},
    {'place': '5', 'club': 'KRB Jabbeke', 'points': '32'},
    {'place': '6', 'club': 'HO Beitem', 'points': '28'},
    {'place': '7', 'club': 'KBC St. Michiels', 'points': '26'},
    {'place': '8', 'club': 'Krachtbal Torhout', 'points': '24'}
  ],
  'Regionale Heren A': [
    {'place': '1', 'club': 'HO Beitem B', 'points': '49'},
    {'place': '2', 'club': 'KBK Ichtegem', 'points': '47'},
    {'place': '3', 'club': 'HO Beitem A', 'points': '45'},
    {'place': '4', 'club': 'Grenskracht Menen', 'points': '45'},
    {'place': '5', 'club': 't Botterken Baasrode', 'points': '44'},
    {'place': '6', 'club': 'KRB Loppem', 'points': '40'},
    {'place': '7', 'club': 'Sporting Brugge', 'points': '39'},
    {'place': '8', 'club': 'KBC St. Michiels', 'points': '36'},
    {'place': '9', 'club': 'D&W Koekelare', 'points': '35'},
    {'place': '10', 'club': 'KRB Jabbeke', 'points': '20'}
  ],
  'Regionale Heren B': [
    {'place': '1', 'club': 'KBC St. Michiels', 'points': '51'},
    {'place': '2', 'club': 't Botterken Baasrode', 'points': '48'},
    {'place': '3', 'club': 'KRB Jabbeke', 'points': '47'},
    {'place': '4', 'club': 'HO Beitem', 'points': '44'},
    {'place': '5', 'club': 'KBC Aalter', 'points': '40'},
    {'place': '6', 'club': 'KBC Heist', 'points': '39'},
    {'place': '7', 'club': 'Atlas Varsenare', 'points': '36'},
    {'place': '8', 'club': 'KRB Loppem', 'points': '32'},
    {'place': '9', 'club': 'D&W Koekelare', 'points': '28'},
    {'place': '10', 'club': 'Avanti Lissewege', 'points': '27'}
  ],
  'Recrea Limburg': [
    {'place': '1', 'club': 'HO Grote Brogel', 'points': '50'},
    {'place': '2', 'club': 'PJ Kaulille B', 'points': '44'},
    {'place': '3', 'club': 'PJ Kaulille C', 'points': '42'},
    {'place': '4', 'club': 'KBC Overpelt', 'points': '40'},
    {'place': '5', 'club': 'Lozen Bocholt A', 'points': '35'},
    {'place': '6', 'club': 'Molenkracht Bree', 'points': '34'},
    {'place': '7', 'club': 'PJ Kaulille A', 'points': '33'},
    {'place': '8', 'club': 'Lozen Bocholt B', 'points': '32'},
    {'place': '9', 'club': 'KBC Edegem', 'points': '24'}
  ],
  'U18 jongens': [
    {'place': '1', 'club': 'D&W Koekelare', 'points': '56'},
    {'place': '2', 'club': 't Klaverken Buggenhout', 'points': '56'},
    {'place': '3', 'club': 'KBC Heist', 'points': '44'},
    {'place': '4', 'club': 'KBC St. Michiels', 'points': '43'},
    {'place': '5', 'club': 'Avanti Lissewege', 'points': '42'},
    {'place': '6', 'club': 't Botterken Baasrode', 'points': '38'},
    {'place': '7', 'club': 'Krachtbal Torhout', 'points': '28'},
    {'place': '8', 'club': 'HO Beitem', 'points': '14'},
    {'place': '9', 'club': 'KBC Opstal', 'points': '0'}
  ],
  'U18 meisjes': [
    {'place': '1', 'club': 'KBK Ichtegem', 'points': '50'},
    {'place': '2', 'club': 'Sporting Brugge', 'points': '50'},
    {'place': '3', 'club': 'KRB Jabbeke A', 'points': '48'},
    {'place': '4', 'club': 'KBC St. Michiels', 'points': '45'},
    {'place': '5', 'club': 't Botterken Baasrode', 'points': '43'},
    {'place': '6', 'club': 't Klaverken Buggenhout', 'points': '42'},
    {'place': '7', 'club': 'KRB Jabbeke B', 'points': '40'},
    {'place': '8', 'club': 'D&W Koekelare', 'points': '32'},
    {'place': '9', 'club': 'WWR Ingelmunster', 'points': '24'},
    {'place': '10', 'club': 'Helios Halle', 'points': '0'}
  ],
  'U16 jongens A': [
    {'place': '1', 'club': 'KBC Male', 'points': '62'},
    {'place': '2', 'club': 'KBC St. Michiels', 'points': '51'},
    {'place': '3', 'club': 't Klaverken Buggenhout', 'points': '46'},
    {'place': '4', 'club': 'KBC Heist', 'points': '45'},
    {'place': '5', 'club': 'D&W Koekelare', 'points': '44'},
    {'place': '6', 'club': 'WWR Ingelmunster', 'points': '38'},
    {'place': '7', 'club': 'Krachtbal Torhout', 'points': '36'},
    {'place': '8', 'club': 'HO Beitem', 'points': '30'}
  ],
  'U16 jongens B': [
    {'place': '1', 'club': 'Noordster Dudzele', 'points': '45'},
    {'place': '2', 'club': 'Avanti Lissewege', 'points': '45'},
    {'place': '3', 'club': 'Sporting Brugge', 'points': '44'},
    {'place': '4', 'club': 'KBC St. Michiels', 'points': '38'},
    {'place': '5', 'club': 'KBK Ichtegem', 'points': '31'},
    {'place': '6', 'club': 'KRB Jabbeke', 'points': '30'},
    {'place': '7', 'club': 'Krachtbal Snellegem', 'points': '29'}
  ],
  'U16 meisjes': [
    {'place': '1', 'club': 'Noordster Dudzele', 'points': '55'},
    {'place': '2', 'club': 'HO Beitem', 'points': '53'},
    {'place': '3', 'club': 'KBC St. Michiels', 'points': '53'},
    {'place': '4', 'club': 'KBC Male', 'points': '53'},
    {'place': '5', 'club': 'Krachtbal Torhout', 'points': '46'},
    {'place': '6', 'club': 'KBC Heist', 'points': '44'},
    {'place': '7', 'club': 'Grenskracht Menen', 'points': '32'},
    {'place': '8', 'club': 'Avanti Lissewege', 'points': '30'}
  ],
  'U14 jongens A': [
    {'place': '1', 'club': 't Klaverken Buggenhout', 'points': '58'},
    {'place': '2', 'club': 'KBK Ichtegem B', 'points': '56'},
    {'place': '3', 'club': 'KBC Opstal', 'points': '47'},
    {'place': '4', 'club': 'KBC St. Michiels', 'points': '46'},
    {'place': '5', 'club': 'KBK Ichtegem A', 'points': '46'},
    {'place': '6', 'club': 'KRB Jabbeke', 'points': '41'},
    {'place': '7', 'club': 'Krachtbal Torhout', 'points': '33'},
    {'place': '8', 'club': 'D&W Koekelare', 'points': '31'},
    {'place': '9', 'club': 'Osiris Aalst', 'points': '28'},
    {'place': '10', 'club': 't Botterken Baasrode', 'points': '26'}
  ],
  'U14 jongens B': [
    {'place': '1', 'club': 'HO Beitem', 'points': '58'},
    {'place': '2', 'club': 'KBK Temse', 'points': '50'},
    {'place': '3', 'club': 'KBC St. Michiels', 'points': '44'},
    {'place': '4', 'club': 'Avanti Lissewege', 'points': '43'},
    {'place': '5', 'club': 'Noordster Dudzele', 'points': '41'},
    {'place': '6', 'club': 'KRB Jabbeke', 'points': '32'},
    {'place': '7', 'club': 'KBC Aalter', 'points': '32'},
    {'place': '8', 'club': 'KBK Ichtegem', 'points': '31'},
    {'place': '9', 'club': 'WWR Ingelmunster', 'points': '26'}
  ],
  'U14 meisjes': [
    {'place': '1', 'club': 'Noordster Dudzele', 'points': '52'},
    {'place': '2', 'club': 'KBC St. Michiels', 'points': '50'},
    {'place': '3', 'club': 't Klaverken Buggenhout', 'points': '47'},
    {'place': '4', 'club': 'Osiris Aalst', 'points': '40'},
    {'place': '5', 'club': 'HO Beitem', 'points': '39'},
    {'place': '6', 'club': 'KBK Ichtegem A', 'points': '38'},
    {'place': '7', 'club': 'Avanti Lissewege', 'points': '33'},
    {'place': '8', 'club': 'D&W Koekelare', 'points': '32'},
    {'place': '9', 'club': 't Botterken Baasrode', 'points': '28'},
    {'place': '10', 'club': 'KBK Ichtegem B', 'points': '25'},
    {'place': '11', 'club': 'KRB Jabbeke', 'points': '22'}
  ],
  'U12 A': [
    {'place': '1', 'club': 'Noordster Dudzele B', 'points': '40'},
    {'place': '2', 'club': 'Grenskracht Menen', 'points': '40'},
    {'place': '3', 'club': 'KBK Ichtegem', 'points': '39'},
    {'place': '4', 'club': 't Klaverken Buggenhout', 'points': '38'},
    {'place': '5', 'club': 'D&W Koekelare', 'points': '32'},
    {'place': '6', 'club': 'KBC St. Michiels', 'points': '24'},
    {'place': '7', 'club': 'HO Beitem', 'points': '22'},
    {'place': '8', 'club': 'Noordster Dudzele A', 'points': '21'}
  ],
  'U12 B': [
    {'place': '1', 'club': 'Avanti Lissewege', 'points': '42'},
    {'place': '2', 'club': 't Klaverken Buggenhout', 'points': '40'},
    {'place': '3', 'club': 'KBK Ichtegem', 'points': '38'},
    {'place': '4', 'club': 'D&W Koekelare', 'points': '31'},
    {'place': '5', 'club': 'Noordster Dudzele', 'points': '28'},
    {'place': '6', 'club': 'Buffalo s Sijsele', 'points': '27'},
    {'place': '7', 'club': 'Krachtbal Snellegem', 'points': '26'},
    {'place': '8', 'club': 'HO Beitem', 'points': '20'}
  ],
  'U12 Titel': [
    {'place': '1', 'club': 'KBK Ichtegem B', 'points': '10'},
    {'place': '2', 'club': 'KBK Ichtegem A', 'points': '10'},
    {'place': '3', 'club': 'Noordster Dudzele', 'points': '8'},
    {'place': '4', 'club': 't Klaverken Buggenhout', 'points': '8'},
    {'place': '5', 'club': 'D&W Koekelare A', 'points': '8'},
    {'place': '6', 'club': 'Avanti Lissewege', 'points': '6'},
    {'place': '7', 'club': 'D&W Koekelare B', 'points': '6'},
    {'place': '8', 'club': 'Grenskracht Menen', 'points': '4'}
  ],
  'U12 NA': [
    {'place': '1', 'club': 't Klaverken Buggenhout', 'points': '12'},
    {'place': '2', 'club': 'Sporting Brugge', 'points': '10'},
    {'place': '3', 'club': 'HO Beitem', 'points': '8'},
    {'place': '4', 'club': 'Noordster Dudzele', 'points': '6'}
  ],
  'U12 NB': [
    {'place': '1', 'club': 'KBC St. Michiels', 'points': '8'},
    {'place': '2', 'club': 'HO Beitem', 'points': '8'},
    {'place': '3', 'club': 'Avanti Lissewege', 'points': '8'},
    {'place': '4', 'club': 'Buffalo s Sijsele', 'points': '6'}
  ],
  'U12 NC': [
    {'place': '1', 'club': 'Krachtbal Torhout', 'points': '12'},
    {'place': '2', 'club': 'Noordster Dudzele', 'points': '10'},
    {'place': '3', 'club': 'Krachtbal Snellegem', 'points': '8'},
    {'place': '4', 'club': 'HO Beitem', 'points': '6'}
  ]
};
