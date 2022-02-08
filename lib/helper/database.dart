import 'package:chatti/models/story_model.dart';

final User user = User(
  name: 'John Doe',
  profileImageUrl: 'https://wallpapercave.com/wp/AYWg3iu.jpg',
);
final List<Story> storiess = [
  Story(
    url:
        'https://images.unsplash.com/photo-1534103362078-d07e750bd0c4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
    media: MediaType.image,
    duration: const Duration(seconds: 10),
    user: user,
  ),
  Story(
    url: 'https://media.giphy.com/media/moyzrwjUIkdNe/giphy.gif',
    media: MediaType.image,
    user: User(
      name: 'John Doe',
      profileImageUrl: 'https://wallpapercave.com/wp/AYWg3iu.jpg',
    ),
    duration: const Duration(seconds: 7),
  ),
  Story(
    url:
        'https://static.videezy.com/system/resources/previews/000/005/529/original/Reaviling_Sjusj%C3%B8en_Ski_Senter.mp4',
    media: MediaType.video,
    duration: const Duration(seconds: 0),
    user: user,
  ),
  Story(
    url:
        'https://images.unsplash.com/photo-1531694611353-d4758f86fa6d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=564&q=80',
    media: MediaType.image,
    duration: const Duration(seconds: 5),
    user: user,
  ),
  Story(
    url:
        'https://static.videezy.com/system/resources/previews/000/007/536/original/rockybeach.mp4',
    media: MediaType.video,
    duration: const Duration(seconds: 0),
    user: user,
  ),
  Story(
    url: 'https://media2.giphy.com/media/M8PxVICV5KlezP1pGE/giphy.gif',
    media: MediaType.image,
    duration: const Duration(seconds: 8),
    user: user,
  ),
];

// user prfile
String profile =
    "https://images.unsplash.com/photo-1599842057874-37393e9342df?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTF8fGdpcmx8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60";
String name = "panhchaneath_ung";

// stories
List stories = [
  {
    "id": 1,
    "img":
        "https://images.unsplash.com/photo-1503185912284-5271ff81b9a8?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8Z2lybHxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
    "name": "sonitakhoun"
  },
  {
    "id": 2,
    "img":
        "https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8Z2lybHxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
    "name": "babysweetiepie"
  },
  {
    "id": 3,
    "img":
        "https://images.unsplash.com/photo-1545912452-8aea7e25a3d3?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60",
    "name": "whereavygoes"
  },
  {
    "id": 4,
    "img":
        "https://images.unsplash.com/photo-1525879000488-bff3b1c387cf?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60",
    "name": "collins_lesulie"
  },
  {
    "id": 5,
    "img":
        "https://images.unsplash.com/photo-1517070208541-6ddc4d3efbcb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60",
    "name": "tyler_nix"
  },
  {
    "id": 6,
    "img":
        "https://images.unsplash.com/photo-1503185912284-5271ff81b9a8?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8Z2lybHxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
    "name": "sonitakhoun"
  },
  {
    "id": 7,
    "img":
        "https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8Z2lybHxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
    "name": "babysweetiepie"
  },
  {
    "id": 8,
    "img":
        "https://images.unsplash.com/photo-1545912452-8aea7e25a3d3?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60",
    "name": "whereavygoes"
  },
  {
    "id": 9,
    "img":
        "https://images.unsplash.com/photo-1525879000488-bff3b1c387cf?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60",
    "name": "collins_lesulie"
  },
  {
    "id": 10,
    "img":
        "https://images.unsplash.com/photo-1517070208541-6ddc4d3efbcb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60",
    "name": "tyler_nix"
  }
];
