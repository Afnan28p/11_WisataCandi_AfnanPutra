import 'package:flutter/material.dart';
import 'package:wisata_candi/widgets/profil_item_info.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // TODO: 1.Deklarasi variabel yang dibutuhkan
  bool isSignedin = true;
  String fullName = "Nadya";
  String userName = "nadya";
  int favoriteCandiCount = 0;

  // TODO: 5.Implementasi Fungsi SignIn
  void signIn() {
    setState(() {
      isSignedin = !isSignedin;
    });
  }
  // TODO: 6.Implementasi Fungsi SignOut
  void signOut() {
    setState(() {
      isSignedin = !isSignedin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
              height: 200, width: double.infinity, color: Colors.deepPurple),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                // TODO : 2 buat bagian ProfilHeader yang berisi gambar profil
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 200 - 50),
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.deepPurple,
                              width: 2,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                AssetImage('images/placeholder_image.png'),
                          ),
                        ),
                        if (isSignedin)
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.camera_alt,
                              color: Colors.deepPurple[50],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                //TODO : 3 buat bagian ProfilInfo yang Info Profil
                SizedBox(height: 20),
                Divider(color: Colors.deepPurple[100]),
                SizedBox(height: 4),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                      child: Row(children: [
                        Icon(Icons.lock, color: Colors.amber),
                        SizedBox(width: 8),
                        Text(
                          'Pengguna',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ]),
                    ),
                    Expanded(
                      child: Text(
                        ': $userName',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Divider(color: Colors.deepPurple[100]),
                SizedBox(height: 4),
                // Row(
                //   children: [
                //     SizedBox(
                //       width: MediaQuery.of(context).size.width / 3,
                //       child: Row(
                //         children: [
                //           Icon(Icons.person, color: Colors.blue),
                //           SizedBox(width: 8),
                //           Text(
                //             'Nama',
                //             style: TextStyle(
                //                 fontSize: 18, fontWeight: FontWeight.bold),
                //           ),
                //         ],
                //       ),
                //     ),
                //     Expanded(
                //       child: Text(
                //         ': $fullName',
                //         style: const TextStyle(
                //           fontSize: 18,
                //         ),
                //       ),
                //     ),
                //     if (isSignedin) const Icon(Icons.edit),
                //   ],
                // ),
                ProfilItemInfo(
                  icon : Icons.person,
                  label: 'Name',
                  value: fullName,
                  iconColor : Colors.blue,
                  showEditIcon: isSignedin,
                  onEditPressed: () {
                    debugPrint('Icon Edit Ditekan');
                  },
                ),
                SizedBox(
                  height: 4,
                ),
                Divider(color: Colors.deepPurple[100]),
                SizedBox(
                  height: 4,
                ),
                ProfilItemInfo(
                  icon : Icons.favorite,
                  label: 'Favorit',
                  value: favoriteCandiCount > 0? '$favoriteCandiCount' : '',
                  iconColor: Colors.red
                ),
                //TODO : 4 buat bagian ProfilAction yang berisi TextButton sign in/out
                SizedBox(
                  height: 4,
                ),
                Divider(color: Colors.deepPurple[100]),
                SizedBox(
                  height: 20,
                ),
                isSignedin
                    ? TextButton(
                        onPressed: signOut,
                        child: Text('Sign Out'),
                      )
                    : TextButton(
                        onPressed: signIn,
                        child: Text('Sign In'),
                      ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
