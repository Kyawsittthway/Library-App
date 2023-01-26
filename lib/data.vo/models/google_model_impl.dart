import 'package:library_app/data.vo/google_book_vo.dart';
import 'package:library_app/data.vo/models/google_model.dart';
import 'package:library_app/network/google_data_agent.dart';
import 'package:library_app/network/google_data_agent_impl.dart';

class GoogleModelImpl extends GoogleModel{

  GoogleDataAgent mDataAgent = GoogleDataAgentImpl();
  @override
  static final GoogleModelImpl _singleton = GoogleModelImpl._internal();

  factory GoogleModelImpl(){
    return _singleton;
  }
  GoogleModelImpl._internal(){
  }


  @override
  Future<List<GoogleBookVO>> getResultFromGoogle(String keyword) {
   return mDataAgent.getResultFromGoogle(keyword);
  }

}