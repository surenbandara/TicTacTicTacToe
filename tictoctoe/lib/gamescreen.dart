import 'dart:math';

import 'package:flutter/material.dart';
import 'package:TicTacTicTacToe/main.dart';

class GamePage extends StatefulWidget {
  late String difficulty,gametype ;

  GamePage(this.difficulty ,this.gametype);


  @override
  _GamePageState createState() => _GamePageState(difficulty,gametype);
}

class _GamePageState extends State<GamePage> {
  final double _cellSize = 50.0;
  final Offset _boardOffset = Offset.zero;
  late List<List<String>> _board;
  late TransformationController zoomTransformationController = TransformationController();
  List<int> lastXpos = [-1,-1];
  List<int> lastOpos = [-1,-1];

  int Xcounter =0;
  int Ocounter =0;


  Color delftblue = const Color.fromARGB(255, 29, 47, 111);
  Color chestnut = const Color.fromARGB(255, 142, 68, 61);
  Color alabaster = const Color.fromARGB(255, 221, 229, 220);
  Color smokyblack = const Color.fromARGB(255, 17, 14, 3);

  late String difficulty,gametype ="" ;
  late int _difficultylevel = -1;

  int grids = 19;
  int boundry =19;

  bool Oisenable=false;

  final random = Random();
  late int emptycell;


  List<List<int>> Xhardlevelposmemory =[];
  List<List<int>> Ohardlevelposmemory =[];

  List<List<int>> Xeasylevelposmemory =[];
  List<List<int>> Oeasylevelposmemory =[];

  List<List<int>> Xmidlevelposmemory =[];
  List<List<int>> Omidlevelposmemory =[];


  double maxscale =3 ;
  double fontsize =20;


  ///////////////////////////////////////////////


  _GamePageState(this.difficulty ,this.gametype);

  @override
  void initState() {
    super.initState();

    if(gametype=="30x30"){
    _zoomIn(scale: 3);
    maxscale = 5;
    fontsize = 12;
    grids= 30;
    boundry =30;}

    _board = List.generate(grids, (_) => List.filled(grids, ''));
    emptycell= grids*grids;

    bool randomfirstplayer = random.nextBool();
    if (randomfirstplayer){
      Oisenable=true;
    }

    else{
      List<int> initOpos_ = _randomPosgen();
      _board[initOpos_[0]][initOpos_[1]] = "O";
      Ohardlevelposmemory.add([initOpos_[0],initOpos_[1]]);
      Oeasylevelposmemory.add([initOpos_[0],initOpos_[1]]);
      Omidlevelposmemory.add([initOpos_[0],initOpos_[1]]);
      Oisenable=true;
    }


    if(difficulty == "easy"){_difficultylevel=0;}
    else if(difficulty == "medium"){_difficultylevel=1;}
    else{_difficultylevel=2;}
    }

    List<int> _randomPosgen(){
      int Oinitialrow = random.nextInt(10);
      int Oinitialcol = random.nextInt(10);

      return [Oinitialrow,Oinitialcol];
    }

  int _findBoundry(int index , int boundry){

    if(index>= boundry){
      return boundry-1;
    }

    else if(index<0){

      return 0;
    }

    else{
      return index;
    }
  }

  String _checkEnd(int row,int col){
    String symbol = _board[row][col];

    int upindex = _findBoundry(row-4, boundry);
    int bottomindex = _findBoundry(row+4, boundry);
    int leftindex = _findBoundry(col-4, boundry);
    int rightindex = _findBoundry(col+4, boundry);
    int checkrow=0;


    for(int i=leftindex;i<=rightindex;i++ ){
      if(checkrow==5){
        return symbol;
      }
      else{
        if(_board[row][i]==symbol){
          checkrow+=1;
        }
        else{checkrow=0;}}
    }
    if(checkrow==5){
      return symbol;
    }



    checkrow=0;
    for(int i=upindex;i<=bottomindex;i++ ){
      if(checkrow==5){
        return symbol;
      }
      else{

        if(_board[i][col]==symbol){
          checkrow+=1;
        }
        else{checkrow=0;}}
    }
    if(checkrow==5){
      return symbol;
    }


    int gapup = row - upindex;
    int gapbottom = bottomindex - row ;
    int gapleft = col - leftindex;
    int gapright = rightindex - col;

    int upleftchange = -1*min(gapup,gapleft);
    int bottomrightchange = min(gapbottom ,gapright);
    int uprightchange = -1*min(gapup,gapright);
    int bottomleftchange = min(gapbottom,gapleft);



    checkrow=0;
    for(int i=upleftchange;i<=bottomrightchange;i++ ){
      if(checkrow==5){
        return symbol;
      }
      else{

        if(_board[row+i][col+i]==symbol){
          checkrow+=1;
        }
        else{checkrow=0;}}
    }
    if(checkrow==5){
      return symbol;
    }



    checkrow=0;
    for(int i=uprightchange;i<=bottomleftchange;i++ ){
      if(checkrow==5){
        return symbol;
      }
      else{

        if(_board[row+i][col+i*-1]==symbol){
          checkrow+=1;
        }
        else{checkrow=0;}}
    }
    if(checkrow==5){
      return symbol;
    }




    if(emptycell ==0){
      return "D";
    }

    else{return "";}



  }

  Object _difficultyDialouge(int difficultylevel) {

    if(difficultylevel==0){
      return

        showDialog<String>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => WillPopScope(
            onWillPop: () async => true,
            child: AlertDialog(
              title: const Text('Easy mode'),
              actions: <Widget>[

                TextButton(
                  onPressed:  () {
                    Navigator.pop(context);
                    _difficultylevel=0;
                  },
                  child: const Text('Ok'),
                ),
              ],
            ),
          )
          ,
        );


    }

    else if(difficultylevel==1){
      return

        showDialog<String>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => WillPopScope(
            onWillPop: () async => true,
            child: AlertDialog(
              title: const Text('Medium mode'),
              actions: <Widget>[

                TextButton(
                  onPressed:  () {
                    Navigator.pop(context);
                    _difficultylevel=1;
                  },
                  child: const Text('Ok'),
                ),
              ],
            ),
          )
          ,
        );


    }

    else{
      return

        showDialog<String>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => WillPopScope(
            onWillPop: () async => true,
            child: AlertDialog(
              title: const Text('Expert mode'),
              actions: <Widget>[

                TextButton(
                  onPressed:  () {
                    Navigator.pop(context);
                    _difficultylevel=2;
                  },
                  child: const Text('Ok'),
                ),
              ],
            ),
          )
          ,
        );
    }
  }
  Object? _finishDialouge(String symbol) {

    if(symbol=="X"){
      return

        showDialog<String>(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) => AlertDialog(
              title: const Text('You win'),
              actions: <Widget>[
                TextButton(
                  onPressed:  () {
                    Navigator.pop(context);
                    _nexGame("X");
                  },
                  child: const Text('Next game'),
                ),
                TextButton(
                  onPressed:  () {
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const MyApp()),
                    );
                  },
                  child: const Text('Exit to main menu'),
                ),
              ],
            ),

        );


    }

    else if(symbol=="O"){
      return

        showDialog<String>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => AlertDialog(
              title: const Text('Computer wins'),
              actions: <Widget>[
                TextButton(
                  onPressed:  () {
                    Navigator.pop(context);
                    _nexGame("O");
                  },
                  child: const Text('Next game'),
                ),
                TextButton(
                  onPressed:  () {
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const MyApp()),
                    );
                  },
                  child: const Text('Exit to main menu'),
                ),
              ],
            ),

        );
    }


    else if(symbol=="D"){
      return

        showDialog<String>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Game Draw'),
            actions: <Widget>[
              TextButton(
                onPressed:  () {
                  Navigator.pop(context);
                  _nexGame("D");
                },
                child: const Text('Next game'),
              ),
              TextButton(
                onPressed:  () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const MyApp()),
                  );
                },
                child: const Text('Exit to main menu'),
              ),
            ],
          ),

        );


    }


    else{
      return null;

    }
  }
  Object goBack() async {
    return (await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: new Text('Are you sure ?'),
        content: new Text('Do you want to go to menu'),
        actions: <Widget>[
          TextButton(
            onPressed: () =>Navigator.pop(context), //<-- SEE HERE
            child: new Text('No'),
          ),
          TextButton(

            onPressed: () =>
            {Navigator.pop(context),
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const MyApp())
              )},
            child: new Text('Yes'),
          ),
        ],
      ),
    )) ;
  }



  void _nexGame(String winner){

    setState(() {
      _board = List.generate(grids, (_) => List.filled(grids, ''));});
    Xhardlevelposmemory =[];
    Ohardlevelposmemory =[];

    Xeasylevelposmemory =[];
    Oeasylevelposmemory =[];

    Xmidlevelposmemory =[];
    Omidlevelposmemory =[];

    emptycell= grids*grids;

    if (winner == "O"){
      Oisenable=true;
    }

    else if(winner=="X"){
      List<int> initOpos_ = _randomPosgen();
      _board[initOpos_[0]][initOpos_[1]] = "O";
      Ohardlevelposmemory.add([initOpos_[0],initOpos_[1]]);
      Omidlevelposmemory.add([initOpos_[0],initOpos_[1]]);
      Oeasylevelposmemory.add([initOpos_[0],initOpos_[1]]);
      Oisenable=true;
    }

    else if(winner=="D"){

      bool randomfirstplayer = random.nextBool();
      if (randomfirstplayer){
        Oisenable=true;
      }

      else{
        List<int> initOpos_ = _randomPosgen();
        _board[initOpos_[0]][initOpos_[1]] = "O";
        Ohardlevelposmemory.add([initOpos_[0],initOpos_[1]]);
        Omidlevelposmemory.add([initOpos_[0],initOpos_[1]]);
        Oeasylevelposmemory.add([initOpos_[0],initOpos_[1]]);
        Oisenable=true;
      }

    }


  }

  ///////////////////////////////////////////////////

  Object? _playCell(int row, int col) {
      setState(() {
        _board[row][col] = "X";
      });

      _stackmanager(Xhardlevelposmemory, "+", [row,col], 7);
      _stackmanager(Xmidlevelposmemory, "+", [row,col], 5);
      _stackmanager(Xeasylevelposmemory, "+", [row,col], 2);

      emptycell -= 1;

      String symbol = _checkEnd(row, col);
      lastXpos = [row, col];
      if (symbol == "X") {
        setState(() {
          Xcounter += 1;
        });

      }
      return _finishDialouge(symbol);

  }
  Object? _machinemove(int row , int col){


    late List<int> opos;
    if (_difficultylevel == 0) {
      opos = _easyLevelmove(row, col);
    } else if (_difficultylevel == 1) {
      opos = _mediumLevelmove(row, col);
    } else {
      opos = _expertLevelmove(row, col);
    }

     lastOpos = opos;



  setState(() {
    _board[opos[0]][opos[1]] = "O";
  });
    _stackmanager(Ohardlevelposmemory, "+", opos, 7);
    _stackmanager(Omidlevelposmemory, "+", opos, 5);
    _stackmanager(Oeasylevelposmemory, "+", opos, 2);
    emptycell -= 1;

  String symbol = _checkEnd(opos[0], opos[1]);
  if (symbol == "O") {
    setState(() {
      Ocounter += 1;
    });
  }
  return _finishDialouge(symbol);}


  //////////////////////////////////////////////////////
  void _stackmanager(List<List<int>> modifiedlist , String operation ,List<int> value ,int length){
    if(operation =="+"){
      modifiedlist.add(value);
      if(modifiedlist.length ==length){
      modifiedlist.removeAt(0);}

    }

    else{
      if(modifiedlist.length !=0){
        modifiedlist.removeLast();
      }

    }

  }

  List<int> _Xgetsuitablepos(int row , int col , int howfar){

    int upindex = _findBoundry(row-howfar, boundry);
    int bottomindex = _findBoundry(row+howfar, boundry);
    int leftindex = _findBoundry(col-howfar, boundry);
    int rightindex = _findBoundry(col+howfar, boundry);

    List<List<int>> pos = [];
    List<int> value =[];


    int oval=0;
    int fowardval=0;
    bool hasback = false;
    for(int i=leftindex;i<=rightindex;i++ ){
      if(_board[row][i]=='X'){
        fowardval += 1;
      }
      else{
        if(_board[row][i]==''){
          if(hasback){
            value.add(oval+fowardval);
          }

          oval  = fowardval;
          fowardval = 0;
          pos.add([row,i]);
          hasback = true;
        }

        else{
          if(hasback){
            value.add(oval+fowardval);
          }

          oval  = 0;
          fowardval = 0;
          hasback = false;

        }
      }
    }

    if(hasback){
      value.add(oval+fowardval);
    }




    oval=0;
    fowardval=0;
    hasback = false;
    for(int i=upindex;i<=bottomindex;i++ ){
      if(_board[i][col]=='X'){
        fowardval += 1;
      }
      else{
        if(_board[i][col]==''){
          if(hasback){
            value.add(oval+fowardval);
          }

          oval  = fowardval;
          fowardval = 0;
          pos.add([i,col]);
          hasback = true;
        }

        else{
          if(hasback){
            value.add(oval+fowardval);
          }

          oval  = 0;
          fowardval = 0;
          hasback = false;

        }
      }
    }

    if(hasback){
      value.add(oval+fowardval);
    }





    int gapup = row - upindex;
    int gapbottom = bottomindex - row ;
    int gapleft = col - leftindex;
    int gapright = rightindex - col;

    int upleftchange = -1*min(gapup,gapleft);
    int bottomrightchange = min(gapbottom ,gapright);
    int uprightchange = -1*min(gapup,gapright);
    int bottomleftchange = min(gapbottom,gapleft);



    oval=0;
    fowardval=0;
    hasback = false;

    for(int i=upleftchange;i<=bottomrightchange;i++ ){
      if(_board[row+i][col+i]=='X'){
        fowardval += 1;
      }
      else{
        if(_board[row+i][col+i]==''){
          if(hasback){
            value.add(oval+fowardval);
          }

          oval  = fowardval;
          fowardval = 0;
          pos.add([row+i,col+i]);
          hasback = true;
        }

        else{
          if(hasback){
            value.add(oval+fowardval);
          }

          oval  = 0;
          fowardval = 0;
          hasback = false;

        }
      }
    }

    if(hasback){
      value.add(oval+fowardval);
    }




    oval=0;
    fowardval=0;
    hasback = false;

    for( int i=uprightchange;i<=bottomleftchange;i++ ){
      if(_board[row+i][col+i*-1]=='X'){
        fowardval += 1;
      }
      else{
        if(_board[row+i][col+i*-1]==''){
          if(hasback){
            value.add(oval+fowardval);
          }

          oval  = fowardval;
          fowardval = 0;
          pos.add([row+i,col+i*-1]);
          hasback = true;
        }

        else{
          if(hasback){
            value.add(oval+fowardval);
          }

          oval  = 0;
          fowardval = 0;

          hasback = false;

        }
      }
    }

    if(hasback){
      value.add(oval+fowardval);
    }

    List<int> highpos = [-1,-1];
    int  highval = 0;
    for(int i=0;i<value.length ;i++){
      if(value[i]>highval){
        highpos = pos[i];
        highval = value[i];
      }
    }

    return [highpos[0],highpos[1],highval];


  }
  List<int> _Ogetsuitablepos(int row , int col , int howfar){

    int upindex = _findBoundry(row-howfar, boundry);
    int bottomindex = _findBoundry(row+howfar, boundry);
    int leftindex = _findBoundry(col-howfar, boundry);
    int rightindex = _findBoundry(col+howfar, boundry);

    List<List<int>> pos = [];
    List<int> value =[];


    int oval=0;
    int fowardval=0;
    bool hasback = false;
    for(int i=leftindex;i<=rightindex;i++ ){
      if(_board[row][i]=='O'){
        fowardval += 1;
      }
      else{
        if(_board[row][i]==''){
          if(hasback){
            value.add(oval+fowardval);
          }

          oval  = fowardval;
          fowardval = 0;
          pos.add([row,i]);
          hasback = true;
        }

        else{
          if(hasback){
            value.add(oval+fowardval);
          }

          oval  = 0;
          fowardval = 0;
          hasback = false;

        }
      }
    }

    if(hasback){
      value.add(oval+fowardval);
    }




    oval=0;
    fowardval=0;
    hasback = false;
    for(int i=upindex;i<=bottomindex;i++ ){
      if(_board[i][col]=='O'){
        fowardval += 1;
      }
      else{
        if(_board[i][col]==''){
          if(hasback){
            value.add(oval+fowardval);
          }

          oval  = fowardval;
          fowardval = 0;
          pos.add([i,col]);
          hasback = true;
        }

        else{
          if(hasback){
            value.add(oval+fowardval);
          }

          oval  = 0;
          fowardval = 0;
          hasback = false;

        }
      }
    }

    if(hasback){
      value.add(oval+fowardval);
    }





    int gapup = row - upindex;
    int gapbottom = bottomindex - row ;
    int gapleft = col - leftindex;
    int gapright = rightindex - col;

    int upleftchange = -1*min(gapup,gapleft);
    int bottomrightchange = min(gapbottom ,gapright);
    int uprightchange = -1*min(gapup,gapright);
    int bottomleftchange = min(gapbottom,gapleft);



    oval=0;
    fowardval=0;
    hasback = false;

    for(int i=upleftchange;i<=bottomrightchange;i++ ){
      if(_board[row+i][col+i]=='O'){
        fowardval += 1;
      }
      else{
        if(_board[row+i][col+i]==''){
          if(hasback){
            value.add(oval+fowardval);
          }

          oval  = fowardval;
          fowardval = 0;
          pos.add([row+i,col+i]);
          hasback = true;
        }

        else{
          if(hasback){
            value.add(oval+fowardval);
          }

          oval  = 0;
          fowardval = 0;
          hasback = false;

        }
      }
    }

    if(hasback){
      value.add(oval+fowardval);
    }




    oval=0;
    fowardval=0;
    hasback = false;

    for( int i=uprightchange;i<=bottomleftchange;i++ ){
      if(_board[row+i][col+i*-1]=='O'){
        fowardval += 1;
      }
      else{
        if(_board[row+i][col+i*-1]==''){
          if(hasback){
            value.add(oval+fowardval);
          }

          oval  = fowardval;
          fowardval = 0;
          pos.add([row+i,col+i*-1]);
          hasback = true;
        }

        else{
          if(hasback){
            value.add(oval+fowardval);
          }

          oval  = 0;
          fowardval = 0;

          hasback = false;

        }
      }
    }

    if(hasback){
      value.add(oval+fowardval);
    }

    List<int> highpos = [-1,-1];
    int  highval = 0;
    for(int i=0;i<value.length ;i++){
      if(value[i]>highval){
        highpos = pos[i];
        highval = value[i];
      }
    }

    return [highpos[0],highpos[1],highval];


  }


  List<int> _easyLevelmove(int row , int col){



    int Xmaxval = -1;
    int Omaxval = -1;

    List<int> Xsuit = [-1,-1];
    List<int> Osuit = [-1,-1];


    for(List<int> i in  Xeasylevelposmemory){
      List<int> posdetail=_Xgetsuitablepos(i[0],i[1],3);

      if(posdetail[0]!=-1 && Xmaxval< posdetail[2]){
        Xsuit = [posdetail[0] , posdetail[1]];
        Xmaxval = posdetail[2];
      }
    }

    for(List<int> i in  Oeasylevelposmemory){
      List<int> posdetail=_Ogetsuitablepos(i[0],i[1],3);

      if(posdetail[0]!=-1 && Omaxval< posdetail[2]){
        Osuit = [posdetail[0] , posdetail[1]];
        Omaxval = posdetail[2];
      }
    }


    late List<int> highpos;

    if(Xmaxval ==-1 && Omaxval == -1){
      int emptyIndexRow = -1;
      int emptyIndexColumn = -1;

      _board.any((row) {
        if (row.indexOf('') != -1) {
          emptyIndexRow = _board.indexOf(row);
          emptyIndexColumn = row.indexOf('');
          return true; // Break out of the any() loop
        }
        return false;
      });

      highpos = [emptyIndexRow,emptyIndexColumn];
    }

    else{

      if(Omaxval>=Xmaxval){
        highpos = Osuit;
      }
      else{
        highpos = Xsuit;
      }
    }

    return highpos;





  }
  List<int> _mediumLevelmove(int row , int col){

    int Xmaxval = -1;
    int Omaxval = -1;

    List<int> Xsuit = [-1,-1];
    List<int> Osuit = [-1,-1];


    for(List<int> i in  Xmidlevelposmemory){
      List<int> posdetail=_Xgetsuitablepos(i[0],i[1],5);

      if(posdetail[0]!=-1 && Xmaxval< posdetail[2]){
        Xsuit = [posdetail[0] , posdetail[1]];
        Xmaxval = posdetail[2];
      }
    }

    for(List<int> i in  Omidlevelposmemory){
      List<int> posdetail=_Ogetsuitablepos(i[0],i[1],5);

      if(posdetail[0]!=-1 && Omaxval< posdetail[2]){
        Osuit = [posdetail[0] , posdetail[1]];
        Omaxval = posdetail[2];
      }
    }


    late List<int> highpos;

    if(Xmaxval ==-1 && Omaxval == -1){
      int emptyIndexRow = -1;
      int emptyIndexColumn = -1;

      _board.any((row) {
        if (row.indexOf('') != -1) {
          emptyIndexRow = _board.indexOf(row);
          emptyIndexColumn = row.indexOf('');
          return true; // Break out of the any() loop
        }
        return false;
      });

      highpos = [emptyIndexRow,emptyIndexColumn];
    }

    else{

      if(Omaxval>=Xmaxval){
        highpos = Osuit;
      }
      else{
        highpos = Xsuit;
      }
    }

    return highpos;




  }
  List<int> _expertLevelmove(int row , int col){

    int Xmaxval = -1;
    int Omaxval = -1;

    List<int> Xsuit = [-1,-1];
    List<int> Osuit = [-1,-1];


    for(List<int> i in  Xhardlevelposmemory){
      List<int> posdetail=_Xgetsuitablepos(i[0],i[1],7);

      if(posdetail[0]!=-1 && Xmaxval< posdetail[2]){
        Xsuit = [posdetail[0] , posdetail[1]];
        Xmaxval = posdetail[2];
      }
    }

    for(List<int> i in  Ohardlevelposmemory){
      List<int> posdetail=_Ogetsuitablepos(i[0],i[1],7);

      if(posdetail[0]!=-1 && Omaxval< posdetail[2]){
        Osuit = [posdetail[0] , posdetail[1]];
        Omaxval = posdetail[2];
      }
    }


    late List<int> highpos;

    if(Xmaxval ==-1 && Omaxval == -1){
      int emptyIndexRow = -1;
      int emptyIndexColumn = -1;

      _board.any((row) {
        if (row.indexOf('') != -1) {
          emptyIndexRow = _board.indexOf(row);
          emptyIndexColumn = row.indexOf('');
          return true; // Break out of the any() loop
        }
        return false;
      });

      highpos = [emptyIndexRow,emptyIndexColumn];
    }

    else{

      if(Omaxval>=Xmaxval){
        highpos = Osuit;
      }
      else{
        highpos = Xsuit;
      }
    }

    return highpos;



  }

///////////////////////////////////////////////////////
  void _undoPlay() {
    if(lastXpos[0] !=-1 || lastOpos[0] !=-1){
      setState(() {
        _board[lastXpos[0]][lastXpos[1]]='';
        _board[lastOpos[0]][lastOpos[1]]='';

      });
      _stackmanager(Xhardlevelposmemory, "-", [-1,-1], 7);
      _stackmanager(Ohardlevelposmemory, "-", [-1,-1], 7);

      _stackmanager(Xmidlevelposmemory, "-", [-1,-1], 5);
      _stackmanager(Omidlevelposmemory, "-", [-1,-1], 5);

      _stackmanager(Xeasylevelposmemory, "-", [-1,-1], 2);
      _stackmanager(Oeasylevelposmemory, "-", [-1,-1], 2);
      emptycell +=2;

    }
  }
  void _onScaleUpdate(ScaleUpdateDetails details) {
    setState(() {
    });
  }
  void _zoomIn({double scale = 1.1}){
    final Matrix4 transform = zoomTransformationController.value;
    if(transform.getMaxScaleOnAxis()<maxscale){
      setState(() {
        zoomTransformationController.value.scale(scale);
      });

    }

  }
  void _zoomOut() {
    final Matrix4 transform = zoomTransformationController.value;
    final double maxScale = transform.getMaxScaleOnAxis();
    final double newScale = maxScale * 0.9; // calculate the new scale

    // check if the new scale is less than or equal to 1, and adjust it if necessary
    if (newScale <= 1) {
      zoomTransformationController.value = Matrix4.identity(); // reset the transformation matrix
    } else {
      final Offset currentOffset = Offset(transform.getTranslation().x, transform.getTranslation().y);
      final Offset centerOffset = Offset(_cellSize*10 / 2, _cellSize*10 / 2);

      final Offset offsetDiff = centerOffset - currentOffset;
      final Offset newOffset = currentOffset + (offsetDiff * 0.13); // move 13% towards the center

      setState(() {
        zoomTransformationController.value = Matrix4.identity()
          ..translate(newOffset.dx.abs()*-1, newOffset.dy.abs()*-1)
          ..scale(newScale);
      });
    }
  }



  @override
  Future<bool> onWillPop() async {
    return false;
  }







  @override
  Widget build(BuildContext context) {
    // calculate visible cells based on zoom level and board offset


    int visibleRows = (_boardOffset.dy / _cellSize).abs().ceil() + grids;
    int visibleCols = (_boardOffset.dx / _cellSize).abs().ceil() + grids;
    int startRow = (_boardOffset.dy / _cellSize).floor();
    int startCol = (_boardOffset.dx / _cellSize).floor();
    int endRow = startRow + visibleRows;
    int endCol = startCol + visibleCols;


    return WillPopScope( onWillPop: onWillPop ,child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text("TicTacTicTacToe - $gametype" ,  style:  const TextStyle(

          fontWeight: FontWeight.bold, // set the font weight of the text

        ),),]),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: Icon(Icons.refresh),
                        title: Text('Reset counter'),
                        onTap: () {
                          // handle reset counter option
                         //
                           Navigator.pop(context);
                          setState((){
                            Xcounter = 0;
                            Ocounter = 0;
                          });

                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.star_border),
                        title: Text('Change difficulty'),
                        onTap: () {
                          // handle change difficulty option
                          Navigator.pop(context); // close the bottom sheet


                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [


                                  ListTile(
                                  leading:  (_difficultylevel==0) ? const Icon(Icons.check) : null,
                                  title: Text('Easy'),
                                  onTap: () {
                                  Navigator.pop(context);
                                  _difficultyDialouge(0);

                                  },
                                  ),

                                  ListTile(
                                    leading:  (_difficultylevel==1) ? const Icon(Icons.check) : null,
                                    title: Text('Medium'),
                                    onTap: () {
                                      Navigator.pop(context);
                                      _difficultyDialouge(1);

                                    },
                                  ),

                                  ListTile(
                                    leading: (_difficultylevel==2) ? const Icon(Icons.check) : null,
                                    title: Text('Expert'),
                                    onTap: () {
                                      Navigator.pop(context);
                                      _difficultyDialouge(2);
                                    },
                                  ),

                                ],
                              );
                            },
                          );
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.exit_to_app),
                        title: Text('Exit to main menu'),
                        onTap: () {
                          Navigator.pop(context);
                          goBack();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),

        ],
      ),
      backgroundColor: alabaster,
      body: GestureDetector(
        onScaleUpdate: _onScaleUpdate,
        child: Stack(

          children: [
            // game board
            Positioned(
              child:

            Center(

                child: SizedBox(
                  width: _cellSize * 10,
                  height: _cellSize * 10,
                  child:
                  InteractiveViewer(

                    boundaryMargin: EdgeInsets.zero,
                    transformationController: zoomTransformationController,
                    maxScale: maxscale,
                    minScale: 1,
                    constrained: true,
                    child:GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: visibleCols,
                        childAspectRatio: 1.0,
                        mainAxisSpacing: 0, // set to 0 to remove gap between rows
                        crossAxisSpacing: 0, // set to 0 to remove gap between columns
                      ),
                      itemBuilder: (context, index) {
                        final int row = startRow + index ~/ visibleCols;
                        final int col = startCol + index % visibleCols;

                        if (row < 0 || row >= _board.length || col < 0 || col >= _board[row].length) {

                          return const SizedBox.shrink();
                        } else {

                          return GestureDetector(

                            onTap: () async {

                                if (_board[row][col] == '' && Oisenable) {
                                Object? result =  _playCell(row, col);
                                Oisenable =false;

                                if(result==null){
                                  await Future.delayed(const Duration(milliseconds: 500));
                                  _machinemove(row, col);
                                  Oisenable=true;}
                                }
                            }
                            ,
                            child: Container(
                              decoration: BoxDecoration(
                                color: alabaster,
                                border: Border.all(color: Colors.grey),

                              ),




                                  child: FittedBox(
                                      fit: BoxFit.contain,
                        child:Text(
                                  _board[row][col], // set the text you want to display inside the box
                                  style:  TextStyle(

                                    //fontSize: fontsize, // set the font size of the text
                                    fontWeight: FontWeight.bold, // set the font weight of the text
                                    color: (_board[row][col]=="X")? delftblue: (_board[row][col]=="O")? chestnut :null, // set the color of the text
                                  ),
                        ),
                                ),

                            ),
                          );
                        }
                      },
                      itemCount: visibleRows * visibleCols,



                    ),
                  ),
                ),

            ),),
            // zoom buttons and undo button
            Positioned(
              bottom: 16.0,
              right: 16.0,
              child: Column(
                children: [
                  FloatingActionButton(
                    heroTag: 'undo',
                    onPressed: _undoPlay,
                    child: const Icon(Icons.undo),
                  ),
                  const SizedBox(height: 16.0),
                  FloatingActionButton(
                    heroTag: 'zoom_in',
                    onPressed: (){

                      setState(() {
                        _zoomIn();
                      });
                    },
                    child: const Icon(Icons.add),
                  ),
                  const SizedBox(height: 16.0),
                  FloatingActionButton(
                    heroTag: 'zoom_out',
                    onPressed:  (){
                      setState(() {
                        _zoomOut();
                      });
                    },
                    child:
                    const Icon(Icons.remove),
                  ),

                ],
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 50,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'YOU ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: delftblue, // set color for Xcounter
                          ),
                          children: [
                            TextSpan(
                              text: '$Xcounter',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: delftblue, // set color for Xcounter
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Text('    '),
                      RichText(
                        text: TextSpan(
                          text: 'COMPUTER ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: chestnut, // set color for Ocounter
                          ),
                          children: [
                            TextSpan(
                              text: '$Ocounter',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: chestnut, // set color for Ocounter
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),


              ),
            )
          ],
        ),
      ),
    ));
  }

}

