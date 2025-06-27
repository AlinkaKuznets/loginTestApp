import 'package:logintestapp/data/repository/email_repository_impl.dart';
import 'package:logintestapp/data/source/local_source.dart';
import 'package:logintestapp/data/source/rest_source.dart';
import 'package:logintestapp/domain/cubit/auth_cubit.dart';
import 'package:logintestapp/domain/cubit/get_user_id_cubit.dart';
import 'package:logintestapp/domain/cubit/post_code_cubit.dart';
import 'package:logintestapp/domain/cubit/post_email_cubit.dart';

final inj = Injection();

class Injection {
  final _restSource = RestSource();
  final _localSource = LocalSource();
  late final _emailRepository = EmailRepositoryImpl(
    restSource: _restSource,
    localSource: _localSource,
  );

  PostEmailCubit get postEmailCubit => PostEmailCubit(_emailRepository);
  PostCodeCubit get postCodeCubit => PostCodeCubit(_emailRepository);
  GetUserIdCubit get getUserIdCubit => GetUserIdCubit(
    _emailRepository,
  );
  AuthCubit get authCubit => AuthCubit(_emailRepository);
}
