import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:wisata_candi/widgets/profil_item_info.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreen();
  
}
class _ProfileScreen extends State<ProfileScreen> {
  bool isSigned = false;
  String userName = 'Afnan';
  String fullName = 'Afnan Putra';
  int favoriteCandiCount = 0;
  Future<Map<String, String>> _retrieveAndDecryptDataFromPrefs(
      Future<SharedPreferences> prefs,
      ) async {
    final sharedPreferences = await prefs;

    // Ambil data dari SharedPreferences
    final encryptedUsername = sharedPreferences.getString('username') ?? '';
    final encryptedPassword = sharedPreferences.getString('password') ?? '';
    final encryptedFullname = sharedPreferences.getString('fullname') ?? '';
    final keyString = sharedPreferences.getString('key') ?? '';
    final ivString = sharedPreferences.getString('iv') ?? '';

    // Validasi jika ada data yang kosong
    if (encryptedUsername.isEmpty ||
        encryptedPassword.isEmpty ||
        encryptedFullname.isEmpty ||
        keyString.isEmpty ||
        ivString.isEmpty) {
      print('Stored credentials are invalid or incomplete');
      return {};
    }

    // Dekripsi data
    final encrypt.Key key = encrypt.Key.fromBase64(keyString);
    final iv = encrypt.IV.fromBase64(ivString);

    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final decryptedUsername = encrypter.decrypt64(encryptedUsername, iv: iv);
    final decryptedPassword = encrypter.decrypt64(encryptedPassword, iv: iv);
    final decryptedFullname = encrypter.decrypt64(encryptedFullname, iv: iv);

    print('Decrypted Username: $decryptedUsername');
    print('Decrypted Password: $decryptedPassword');
    print('Decrypted Fullname: $decryptedFullname');

    // Mengembalikan data terdeskripsi
    return {'username': decryptedUsername, 'password': decryptedPassword, 'fulname': decryptedFullname};
  }
  void _loadUserData() async {
    final Future<SharedPreferences> prefsFuture =
    SharedPreferences.getInstance();
    final data = await _retrieveAndDecryptDataFromPrefs(prefsFuture);
    if (data.isNotEmpty) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        isSigned = prefs.getBool('isSignIn') ?? true;
        fullName = data['fulname'] ?? 'Nama belum diatur';
        userName = data['username'] ?? 'Pengguna belum diatur';
      });
    }

  }
  //TODO: 5. Implementasi fungsi SignIn
  void signIn(){
    // setState(() {
    //   isSignedIn = !isSignedIn;
    // });
    Navigator.pushNamed(context, '/signin');
  }
  //TODO: 6. Implementasi fungsi SignOut
  void signOut() async {
    // setState(() {
    //   isSignedIn = !isSignedIn;
    // });
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Hapus semua data dari SharedPreferences
    setState(() {
      isSigned = false;
      fullName = " DummyName";
      userName = " DummyUsername";
      favoriteCandiCount = 0;
    });
    Navigator.pushReplacementNamed(context, '/signin');
  }
  @override
  void initState() {
    super.initState();
    _loadUserData();
  }
  @override
  Widget build(BuildContext context) {
     return Scaffold(
       body: Stack(
         children: [
           Container(
             height: 200, width: double.infinity, color: Colors.deepPurple,
           ),
           Padding(
               padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 200 - 50),
                      child: Column(
                        children: [
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.deepPurple,
                                      width: 2,
                                    ),
                                    shape: BoxShape.circle
                                ),
                                child: const CircleAvatar(
                                  radius: 50,
                                  backgroundImage: AssetImage("images/placeholder_image.png"),
                                ),
                              ),
                              if(isSigned)
                                IconButton(
                                  onPressed: null,
                                  icon: Icon(
                                    Icons.camera_alt,
                                    color: Colors.deepPurple,
                                  ),
                                )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Divider(color: Colors.deepPurple[200],),
                  const SizedBox(height: 4,),
                  Row(
                    children: [
                      SizedBox(width: MediaQuery.of(context).size.width / 3,
                      child: const Row(
                        children: [
                          Icon(Icons.lock, color: Colors.amber,),
                          SizedBox(width: 8,),
                          Text("Pengguna", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,),)
                        ],
                      ),
                      ),
                      Expanded(child: Text(": $userName", style: const TextStyle(fontSize: 18),))
                    ],
                  ),
                  SizedBox(height: 4,),
                  Divider(color: Colors.deepPurple[100],),
                  SizedBox(height: 4,),
                  // Row(
                  //   children: [
                  //     SizedBox(width: MediaQuery.of(context).size.width / 3,
                  //       child: Row(
                  //         children: [
                  //           Icon(Icons.person, color: Colors.blue
                  //             ,),
                  //           SizedBox(width: 8,),
                  //           Text('Nama', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  //         ],
                  //       ),
                  //     ),
                  //     Expanded(child: Text(': $fullName', style: TextStyle(fontSize: 18),)),
                  //     if(isSigned) const Icon(Icons.edit),
                  //   ],
                  // ),
                  ProfilItemInfo(icon: Icons.person, label: 'Name', value: this.fullName, iconColor: Colors.blue),
                  Divider(color: Colors.deepPurple[100],),
                  SizedBox(height: 4,),
                  ProfilItemInfo(icon: Icons.favorite, label: 'Favorit', value: this.favoriteCandiCount > 0 ? "$favoriteCandiCount" : "0", iconColor: Colors.red),
                  SizedBox(height: 4,),
                  Divider(color: Colors.deepPurple[100],),
                  SizedBox(
                    height: 20,
                  ),
                  isSigned
                      ? TextButton(onPressed: signOut, child: Text("Sign Out"))
                      : TextButton(onPressed: signIn, child: Text("Sign In"))
                ],
              ),
           )
         ],
       ),

     );
  }

}