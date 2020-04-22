class Question{
  String _q;
  bool _a;
  Question(String ques,bool ans){
    _q = ques;
    _a = ans;
  }
  String getQuestion(){
    return _q;
  }
  bool getAnswer(){
    return _a;
  }

}