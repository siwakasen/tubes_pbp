class Person {
  final String name;
  final String phone;
  final String picture;
  const Person(this.name, this.phone, this.picture);
}

final List<Person> people = _people
    .map((e) => Person(
        e['name'] as String, e['phone'] as String, e['picture'] as String))
    .toList(growable: false);

final List<Map<String, Object>> _people = [
  {
    "_id": "6502384c26b19e5fb95c3eef",
    "index": 0,
    "guid": "d49e6116-ec04-4343-a0ce-8b561205cf38",
    "isActive": true,
    "balance": "3,279.04",
    "picture": "http://placehold.it/32x32",
    "age": 35,
    "eyeColor": "brown",
    "name": "Hines Combs",
    "gender": "male",
    "company": "MOTOVATE",
    "email": "hinescombs@motovate.com",
    "phone": "+1 (905) 549-3569",
    "address": "893 Huron Street, Oceola, Hawaii, 8229",
    "about":
        "Commodo do pariatur nulla ad culpa consequat ullamco cupidatat anim. Consectetur cillum ad ea amet incididunt non cupidatat. In mollit sunt consequat amet id do consectetur. Consectetur laborum aliquip proident magna sunt.\r\n",
    "registered": "2019-04-13T10:55:49 -07:00",
    "latitude": 27.40376,
    "longitude": -165.916981,
    "tags": ["quis", "enim", "pariatur", "ut", "aliquip", "laboris", "tempor"],
    "friends": [
      {"id": 0, "name": "Clarke Whitfield"},
      {"id": 1, "name": "Pitts Mcneil"},
      {"id": 2, "name": "Baker Kelley"}
    ],
    "greeting": "Hello, Hines Combs! You have 2 unread messages.",
    "favoriteFruit": "apple"
  },
  {
    "_id": "6502384c04b0eb37937de2ba",
    "index": 1,
    "guid": "4fab6a70-4355-456c-b9ec-31f58cffabac",
    "isActive": false,
    "balance": "2,516.63",
    "picture": "http://placehold.it/32x32",
    "age": 29,
    "eyeColor": "blue",
    "name": "Moody Ramos",
    "gender": "male",
    "company": "GRUPOLI",
    "email": "moodyramos@grupoli.com",
    "phone": "+1 (854) 544-2317",
    "address": "323 Will Place, Sunbury, Wisconsin, 9949",
    "about":
        "Pariatur minim occaecat officia laboris nulla culpa in veniam amet pariatur. Id proident tempor deserunt proident Lorem commodo tempor labore eiusmod magna. Incididunt est exercitation laboris consequat ut adipisicing id duis. Elit nulla amet labore dolor id eu aute ut culpa in. Sunt laborum ex nostrud consectetur labore. Culpa ad fugiat labore fugiat aute anim reprehenderit duis sint. Dolor ipsum nulla proident ipsum cupidatat irure ipsum culpa.\r\n",
    "registered": "2022-01-20T03:38:38 -07:00",
    "latitude": 35.223483,
    "longitude": -31.309531,
    "tags": [
      "qui",
      "aliquip",
      "veniam",
      "consequat",
      "aute",
      "esse",
      "commodo"
    ],
    "friends": [
      {"id": 0, "name": "Fischer French"},
      {"id": 1, "name": "Jody Koch"},
      {"id": 2, "name": "Margery Stewart"}
    ],
    "greeting": "Hello, Moody Ramos! You have 8 unread messages.",
    "favoriteFruit": "strawberry"
  },
  {
    "_id": "6502384cffd0425259a7492d",
    "index": 2,
    "guid": "1ce35f42-15d6-416c-ac51-65d1091e0171",
    "isActive": true,
    "balance": "2,344.61",
    "picture": "http://placehold.it/32x32",
    "age": 38,
    "eyeColor": "brown",
    "name": "Mcconnell Delaney",
    "gender": "male",
    "company": "LETPRO",
    "email": "mcconnelldelaney@letpro.com",
    "phone": "+1 (963) 545-3684",
    "address": "907 Ditmars Street, Kipp, Oregon, 9562",
    "about":
        "Pariatur aliquip nisi excepteur do exercitation proident duis cillum ut occaecat. Incididunt proident nulla laborum dolore adipisicing amet ipsum. Aute elit ad consectetur culpa ex.\r\n",
    "registered": "2017-04-23T11:01:31 -07:00",
    "latitude": 47.951272,
    "longitude": 59.078348,
    "tags": ["aliquip", "in", "nostrud", "minim", "et", "elit", "magna"],
    "friends": [
      {"id": 0, "name": "Jarvis Dillon"},
      {"id": 1, "name": "Lilian Preston"},
      {"id": 2, "name": "Concepcion Vaughn"}
    ],
    "greeting": "Hello, Mcconnell Delaney! You have 1 unread messages.",
    "favoriteFruit": "apple"
  },
  {
    "_id": "6502384c6e7848606af51aa6",
    "index": 3,
    "guid": "975105cd-be8d-4d31-be0c-606994f3985e",
    "isActive": false,
    "balance": "1,699.39",
    "picture": "http://placehold.it/32x32",
    "age": 30,
    "eyeColor": "blue",
    "name": "Kline Ayala",
    "gender": "male",
    "company": "ECLIPTO",
    "email": "klineayala@eclipto.com",
    "phone": "+1 (830) 581-3955",
    "address": "811 Bay Street, Gerton, Georgia, 4835",
    "about":
        "Aute irure proident aliqua qui eiusmod. Proident magna ea ullamco eu elit excepteur sunt mollit. Dolore ut qui aliquip nulla consectetur anim reprehenderit incididunt excepteur ea ex adipisicing irure sit. Fugiat consectetur nostrud consequat nulla deserunt cupidatat aliqua. Ipsum excepteur id fugiat irure occaecat aliqua enim irure esse mollit sint consectetur sunt.\r\n",
    "registered": "2020-03-14T06:12:26 -07:00",
    "latitude": 8.291304,
    "longitude": -64.418659,
    "tags": [
      "non",
      "sint",
      "cillum",
      "reprehenderit",
      "esse",
      "irure",
      "cillum"
    ],
    "friends": [
      {"id": 0, "name": "Perkins Goodman"},
      {"id": 1, "name": "Dale Melendez"},
      {"id": 2, "name": "Potter Jefferson"}
    ],
    "greeting": "Hello, Kline Ayala! You have 7 unread messages.",
    "favoriteFruit": "strawberry"
  },
  {
    "_id": "6502384c37cffc6ed9bce921",
    "index": 4,
    "guid": "22fa85c1-522f-457e-809b-aabaa7931810",
    "isActive": true,
    "balance": "1,863.11",
    "picture": "http://placehold.it/32x32",
    "age": 32,
    "eyeColor": "green",
    "name": "Sharlene Bowers",
    "gender": "female",
    "company": "CEPRENE",
    "email": "sharlenebowers@ceprene.com",
    "phone": "+1 (938) 491-2999",
    "address": "964 Sedgwick Place, Dennard, Wyoming, 4471",
    "about":
        "Mollit deserunt velit dolore eu consectetur commodo ex id consequat qui ullamco ex consequat amet. Qui ut excepteur minim in commodo irure. Elit anim velit cupidatat labore cillum qui reprehenderit culpa nulla reprehenderit deserunt. Nisi duis ipsum mollit elit proident sint. Aliqua aliquip elit cupidatat excepteur anim sunt labore amet ullamco. Commodo eu cillum ut adipisicing enim elit anim sint officia cillum veniam.\r\n",
    "registered": "2015-09-05T02:25:29 -07:00",
    "latitude": 42.139701,
    "longitude": -6.240367,
    "tags": ["voluptate", "ea", "sint", "labore", "aliqua", "ut", "ut"],
    "friends": [
      {"id": 0, "name": "Isabella Espinoza"},
      {"id": 1, "name": "Rowland Pollard"},
      {"id": 2, "name": "Jeannette Wolf"}
    ],
    "greeting": "Hello, Sharlene Bowers! You have 1 unread messages.",
    "favoriteFruit": "apple"
  },
  {
    "_id": "6502384c1c78744327c1375d",
    "index": 5,
    "guid": "bad850cc-6736-4ae5-ad99-d74ac2eea49e",
    "isActive": false,
    "balance": "3,360.12",
    "picture": "http://placehold.it/32x32",
    "age": 40,
    "eyeColor": "brown",
    "name": "Candace Kim",
    "gender": "female",
    "company": "IZZBY",
    "email": "candacekim@izzby.com",
    "phone": "+1 (864) 502-2909",
    "address": "161 Williams Court, Jamestown, Marshall Islands, 1934",
    "about":
        "Aliquip velit enim excepteur dolore laborum non duis aliquip irure anim in consequat excepteur. Id minim anim quis nulla. In est sint cupidatat nulla est culpa. Commodo velit quis qui aute irure commodo dolore qui occaecat. Sit non aute est cupidatat adipisicing ex duis dolore voluptate eiusmod id tempor deserunt magna.\r\n",
    "registered": "2023-05-10T03:11:29 -07:00",
    "latitude": -14.732555,
    "longitude": 91.883141,
    "tags": ["duis", "enim", "ipsum", "nisi", "laborum", "sunt", "proident"],
    "friends": [
      {"id": 0, "name": "Kelley Horne"},
      {"id": 1, "name": "Martin Weiss"},
      {"id": 2, "name": "Ofelia Kinney"}
    ],
    "greeting": "Hello, Candace Kim! You have 7 unread messages.",
    "favoriteFruit": "strawberry"
  },
  {
    "_id": "6502384c72e29eff3ac65e7d",
    "index": 6,
    "guid": "194bb788-7a5d-4818-afc6-7e60f682985d",
    "isActive": true,
    "balance": "2,034.29",
    "picture": "http://placehold.it/32x32",
    "age": 34,
    "eyeColor": "green",
    "name": "Clarissa Travis",
    "gender": "female",
    "company": "CINCYR",
    "email": "clarissatravis@cincyr.com",
    "phone": "+1 (999) 424-3807",
    "address":
        "739 Hamilton Walk, Edinburg, Federated States Of Micronesia, 3431",
    "about":
        "Nisi laboris Lorem mollit commodo dolore consequat eiusmod. Officia magna sit est ullamco laborum anim id sint aliqua dolore. Consequat mollit consequat ad voluptate aute. Commodo et quis minim ipsum commodo consequat cupidatat proident. In aliquip ad esse sit aute ullamco aliquip velit commodo proident aute laboris occaecat.\r\n",
    "registered": "2016-03-16T01:53:39 -07:00",
    "latitude": -64.521872,
    "longitude": -66.84304,
    "tags": ["esse", "ut", "ut", "enim", "sint", "aliquip", "ea"],
    "friends": [
      {"id": 0, "name": "Nunez Sears"},
      {"id": 1, "name": "Payne Silva"},
      {"id": 2, "name": "Vang Malone"}
    ],
    "greeting": "Hello, Clarissa Travis! You have 10 unread messages.",
    "favoriteFruit": "strawberry"
  }
];
