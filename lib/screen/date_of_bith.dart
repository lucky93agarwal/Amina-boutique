import 'package:amin/Components/bottom_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';


class DateOfBirth extends StatefulWidget {
  const DateOfBirth({Key? key}) : super(key: key);

  @override
  State<DateOfBirth> createState() => _DateOfBirthState();
}

class _DateOfBirthState extends State<DateOfBirth> {
  String ButtonText = "Continue";
  DateTime date = DateTime.now();
  var dateFormat = DateFormat('dd/MM/yyyy');
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  _nextHandler() async{
  /*  final SharedPreferences prefs = await _prefs;
    prefs.setString("DOB", Month+"-"+Date+"-"+Year);*/
    String dob = Month+"-"+Date+"-"+Year;
    Navigator.pop(context,dob);
/*    print("year data = "+controlleryear.position.toString());*/
    // Navigator.of(context).pushNamed('/gender');
    //Navigator.push(context, MaterialPageRoute(builder: (context) =>Gender()));
  }

  _backHandler() {
    Navigator.of(context).pop();
  }
  static const List<String> MonthsList_EN = const [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];
  int yearBegin = 1900;
  int yearEnd = 2100;


  String Month = "Apr",Date = "4",Year = "1990";
  static const List<String> MonthsList_EN_L = const [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];
  static const List<String> Year_EN_L = const [
    "1960",
    "1961",
    "1962",
    "1963",
    "1964",
    "1965",
    "1966",
    "1967",
    "1968",
    "1969",
    "1970",
    "1971",
    "1972",
    "1973",
    "1974",
    "1975",
    "1976",
    "1977",
    "1978",
    "1979",
    "1980",
    "1981",
    "1982",
    "1983",
    "1984",
    "1985",
    "1986",
    "1987",
    "1988",
    "1989",
    "1990",
    "1991",
    "1992",
    "1993",
    "1994",
    "1995",
    "1996",
    "1997",
    "1998",
    "1999",
    "2000",
    "2001",
    "2002",
    "2003",
    "2004",
    "2005",
    "2006",
    "2007",
    "2008",
    "2009",
    "2010",
    "2011",
    "2012",
    "2013",
    "2014",
    "2015",
    "2016",
    "2017",
    "2018"
  ];

  static const List<String> Date_EN_L = const [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11",
    "12",
    "13",
    "14",
    "15",
    "16",
    "17",
    "18",
    "19",
    "20",
    "21",
    "22",
    "23",
    "24",
    "25",
    "26",
    "27",
    "28",
    "29",
    "30",
    "31"
  ];
  var controllermonth = PageController(viewportFraction: 1 / 3,initialPage: 3);
  var controllerdate = PageController(viewportFraction: 1 / 3,initialPage: 3);
  var controlleryear = PageController(viewportFraction: 1 / 3,initialPage: 30);
  @override
  Widget build(BuildContext context) {
    DateTime date;



    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              margin: const EdgeInsets.only(
                top: 50,
                bottom: 10,
                left: 10,
                right: 10,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          top: 10,
                          bottom: 10,
                        ),
                        child: Text(
                          "What's your birthday ?",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            top: 10, bottom: 10, left: 10, right: 10),
                        child: Text(
                          'Choose your date of birth,\nyou can always make this private later',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: Stack(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 160,
                                    width: 75,
                                    child: Container(
                                        width: 60,
                                        height: 150,
                                        margin: EdgeInsets.fromLTRB(0, 60, 5, 45),
                                        padding: EdgeInsets.all(9.0),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            border: Border(
                                              top: BorderSide(width: 3, color: Colors.white),
                                              bottom: BorderSide(width: 3, color: Colors.white),
                                            )),
                                        child: SizedBox()),
                                  ),
                                  Container(
                                    height: 160,
                                    width: 75,
                                    child: Container(
                                        width: 60,
                                        height: 150,
                                        margin: EdgeInsets.fromLTRB(5, 60, 5, 45),
                                        padding: EdgeInsets.all(9.0),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            border: Border(
                                              top: BorderSide(width: 3, color: Colors.white),
                                              bottom: BorderSide(width: 3, color: Colors.white),
                                            )),
                                        child: SizedBox()),
                                  ),
                                  Container(
                                    height: 160,
                                    width: 75,
                                    child: Container(
                                        width: 60,
                                        height: 150,
                                        margin: EdgeInsets.fromLTRB(5, 60, 5, 45),
                                        padding: EdgeInsets.all(9.0),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            border: Border(
                                              top: BorderSide(width: 3, color: Colors.white),
                                              bottom: BorderSide(width: 3, color: Colors.white),
                                            )),
                                        child: SizedBox()),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 160,
                                    width: 75,
                                    child: PageView.builder(
                                      controller: controllermonth,
                                      scrollDirection: Axis.vertical,
                                      itemCount: MonthsList_EN.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          alignment: Alignment.center,
                                          height: 55,
                                          margin: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                                          child: InkWell(
                                            onTap: () {
                                              // Navigator.push(
                                              //     context,
                                              //     MaterialPageRoute(
                                              //         builder: (context) => ProductListActivity()));
                                            },
                                            child: Text(
                                              MonthsList_EN[index],
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context).textTheme.headline2,
                                            ),
                                          ),
                                        );
                                      },
                                      onPageChanged: (index) {
                                        setState(() {
                                          String _currentIndex = MonthsList_EN[index].toString();
                                          Month = _currentIndex;
                                          print("Months    =  " + _currentIndex);
                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                    height: 160,
                                    width: 75,
                                    child: PageView.builder(
                                      controller: controllerdate,
                                      scrollDirection: Axis.vertical,
                                      itemCount: Date_EN_L.length,
                                      itemBuilder: (context, index) {
                                        print("year index = "+index.toString());
                                        return Container(
                                          alignment: Alignment.center,
                                          height: 55,
                                          margin: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                                          child: InkWell(
                                            onTap: () {
                                              // Navigator.push(
                                              //     context,
                                              //     MaterialPageRoute(
                                              //         builder: (context) => ProductListActivity()));
                                            },
                                            child: Text(
                                              Date_EN_L[index],
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context).textTheme.headline2,
                                            ),
                                          ),
                                        );
                                      },
                                      onPageChanged: (index) {
                                        setState(() {
                                          String _currentIndex = Date_EN_L[index].toString();
                                          Date = _currentIndex;
                                          print("Date    =  " + _currentIndex);
                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                    height: 160,
                                    width: 75,
                                    child: PageView.builder(
                                      controller: controlleryear,
                                      scrollDirection: Axis.vertical,

                                      itemCount: Year_EN_L.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          alignment: Alignment.center,
                                          height: 55,
                                          margin: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                                          child: InkWell(
                                            onTap: () {
                                              // Navigator.push(
                                              //     context,
                                              //     MaterialPageRoute(
                                              //         builder: (context) => ProductListActivity()));
                                            },
                                            child: Text(
                                              Year_EN_L[index],
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context).textTheme.headline2,
                                            ),
                                          ),
                                        );
                                      },
                                      onPageChanged: (index) {
                                        setState(() {
                                          String _currentIndex = Year_EN_L[index].toString();
                                          Year = _currentIndex;
                                          print("Year    =  " + _currentIndex);
                                        });
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),

                      Container(
                        height: 64.0,
                        margin: const EdgeInsets.only(top: 50,bottom: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            BottomBar(
                              check: false,
                              text: ButtonText,
                              onTap: () {
                                /*if(_nameController.text.length ==0){
                          showToast("Please enter your Name..");
                        }else*/
                                _nextHandler();


                              },
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
