import 'package:flutter/material.dart';

void main(){
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Interest Claculator',
      home: SIForm(),
      //Theme update
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.indigo,
        accentColor: Colors.indigoAccent
      ),
    )
  );
}

class SIForm extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _SIFormState();
  }

}

class _SIFormState extends State<SIForm>{
  var _formKey = GlobalKey<FormState>();
  var _currencies = ['Dollars','Shillings','Euros'];
  final double _minumumPadding = 5.0;
  var _selectedCurrency = '';

  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();

  var _displayResult = '';

  @override
  void initState(){
    super.initState();
    _selectedCurrency = _currencies[0];
  }


  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.body1;

    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Simple Interest Calculator'),
      ),//AppBar
      body: Form(
        key:_formKey,
        child: Padding(
          padding: EdgeInsets.all(_minumumPadding*2),
          child: ListView(
            children: <Widget>[
              getImageAsset(),

              Padding(
                padding: EdgeInsets.only(top: _minumumPadding, bottom:_minumumPadding),
                child: TextFormField(
                  style: textStyle,
                  keyboardType: TextInputType.number,
                  controller: principalController,
                  validator: (String value){
                    if(value.isEmpty){
                      return "Please enter the principal amount";
                    }
                  },
                  decoration: InputDecoration(
                      labelText: 'Principal',
                      hintText: 'Enter Principal e.g. 24000',
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)
                      )//Border
                  ),//Decoration
                ),//TextFormField (Principal)
              ),//Padding

              Padding(
                padding: EdgeInsets.only(top: _minumumPadding, bottom:_minumumPadding),
                child: TextFormField(
                  style: textStyle,
                  keyboardType: TextInputType.number,
                  controller: roiController,
                  validator: (String value){
                    if(value.isEmpty){
                      return "Please enter the rate";
                    }
                  },
                  decoration: InputDecoration(
                      labelText: 'Rate of Interest',
                      hintText: 'In percentage',
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)
                      )//Border
                  ),//Decoration
                ),//TextField (Rate of Interest)
              ),//Padding

              Padding(
                padding: EdgeInsets.only(top: _minumumPadding, bottom:_minumumPadding),
                child: Row(
                  children: <Widget>[

                    Expanded(
                      child: TextFormField(
                        style: textStyle,
                        keyboardType: TextInputType.number,
                        controller: termController,
                        validator: (String value){
                          if(value.isEmpty){
                            return "Please enter the term";
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'Term',
                            labelStyle: textStyle,
                            hintText: 'time in years',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)
                            )//Border
                        ),//Decoration
                      ),//TextField (Term),
                    ),//Expanded

                    Container(width:_minumumPadding*5),

                    Expanded(
                      child: DropdownButton<String>(
                        style: textStyle,
                        items: _currencies.map((String currency){
                          return DropdownMenuItem<String>(
                            value: currency,
                            child: Text(currency),
                          );//DropdownMenuItem
                        }).toList(),//Items
                        onChanged:(String newCurrency){
                          _onDropDownMenuSelected(newCurrency);
                        },
                        value:_selectedCurrency,
                      ),//DropdownButton
                    ),//Expanded
                  ],//widget list
                ),//Row
              ),//Padding

              Padding(
                padding: EdgeInsets.only(top: _minumumPadding, bottom:_minumumPadding),
                child: Row(
                  children: <Widget>[

                    Expanded(
                      child: RaisedButton(
                          color:Theme.of(context).accentColor,
                          textColor: Theme.of(context).primaryColorDark,
                          child: Text('Calculate',),
                          onPressed: (){
                            setState(() {
                              if(_formKey.currentState.validate()){
                                this._displayResult = _calculateTotalReturns();
                              }
                            });
                          }
                      ),
                    ),//Expanded

                    Expanded(
                      child: RaisedButton(
                          color:Theme.of(context).primaryColorDark,
                          textColor: Theme.of(context).primaryColorLight,
                          child: Text('Reset',),
                          onPressed: (){
                            setState(() {
                              _reset();
                            });
                          }
                      ),
                    ),//Expanded

                  ],//Row children
                ),//Row
              ),//Padding

              Padding(
                padding: EdgeInsets.only(top: _minumumPadding, bottom:_minumumPadding),
                child: Text(
                  _displayResult,
                  style: textStyle,
                ),//Text
              ),//Padding

            ],//Column widget list
          ),//List View,
        )
      ),//Form
    );//Scaffold
  }

  void _onDropDownMenuSelected(String newCurrency){
    setState(() {
      this._selectedCurrency = newCurrency;
    });
  }

  String _calculateTotalReturns(){
    double principal = double.parse(principalController.text);
    double roi = double.parse(roiController.text);
    double term = double.parse(termController.text);

    double total = principal + (principal * roi) / 100 * term;
    String output = "After $term years, your investment will be worth $total $_selectedCurrency";

    return output;
  }

  void _reset(){
    principalController.text = '';
    roiController.text = '';
    termController.text = '';
    _displayResult = '';
    _selectedCurrency = _currencies[0];
  }

  Widget getImageAsset(){
    AssetImage assetImage = AssetImage('images/money.png');
    Image image = Image(image: assetImage, width: 60.0, height: 60.0,);

    return Container(child: image,padding: EdgeInsets.all(_minumumPadding*10),);
  }

}