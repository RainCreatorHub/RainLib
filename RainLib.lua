local RainLib = {
    Version = "1.2.0",
    Themes = {
        Futuristic = {
            Background = Color3.fromRGB(10, 15, 25),
            Accent = Color3.fromRGB(0, 200, 255),
            Text = Color3.fromRGB(220, 240, 255),
            Secondary = Color3.fromRGB(25, 35, 50),
            Disabled = Color3.fromRGB(60, 70, 90),
            GradientStart = Color3.fromRGB(0, 150, 255),
            GradientEnd = Color3.fromRGB(100, 0, 255)
        }
    },
    Icons = {
			["accessibility"] = "rbxassetid://10709751939",
			["activity"] = "rbxassetid://10709752035",
			["airvent"] = "rbxassetid://10709752131",
			["airplay"] = "rbxassetid://10709752254",
			["alarmcheck"] = "rbxassetid://10709752405",
			["alarmclock"] = "rbxassetid://10709752630",
			["alarmclockoff"] = "rbxassetid://10709752508",
			["alarmminus"] = "rbxassetid://10709752732",
			["alarmplus"] = "rbxassetid://10709752825",
			["album"] = "rbxassetid://10709752906",
			["alertcircle"] = "rbxassetid://10709752996",
			["alertoctagon"] = "rbxassetid://10709753064",
			["alerttriangle"] = "rbxassetid://10709753149",
			["aligncenter"] = "rbxassetid://10709753570",
			["aligncenterhorizontal"] = "rbxassetid://10709753272",
			["aligncentervertical"] = "rbxassetid://10709753421",
			["alignendhorizontal"] = "rbxassetid://10709753692",
			["alignendvertical"] = "rbxassetid://10709753808",
			["alignhorizontaldistributecenter"] = "rbxassetid://10747779791",
			["alignhorizontaldistributeend"] = "rbxassetid://10747784534",
			["alignhorizontaldistributestart"] = "rbxassetid://10709754118",
			["alignhorizontaljustifycenter"] = "rbxassetid://10709754204",
			["alignhorizontaljustifyend"] = "rbxassetid://10709754317",
			["alignhorizontaljustifystart"] = "rbxassetid://10709754436",
			["alignhorizontalspacearound"] = "rbxassetid://10709754590",
			["alignhorizontalspacebetween"] = "rbxassetid://10709754749",
			["alignjustify"] = "rbxassetid://10709759610",
			["alignleft"] = "rbxassetid://10709759764",
			["alignright"] = "rbxassetid://10709759895",
			["alignstarthorizontal"] = "rbxassetid://10709760051",
			["alignstartvertical"] = "rbxassetid://10709760244",
			["alignverticaldistributecenter"] = "rbxassetid://10709760351",
			["alignverticaldistributeend"] = "rbxassetid://10709760434",
			["alignverticaldistributestart"] = "rbxassetid://10709760612",
			["alignverticaljustifycenter"] = "rbxassetid://10709760814",
			["alignverticaljustifyend"] = "rbxassetid://10709761003",
			["alignverticaljustifystart"] = "rbxassetid://10709761176",
			["alignverticalspacearound"] = "rbxassetid://10709761324",
			["alignverticalspacebetween"] = "rbxassetid://10709761434",
			["anchor"] = "rbxassetid://10709761530",
			["angry"] = "rbxassetid://10709761629",
			["annoyed"] = "rbxassetid://10709761722",
			["aperture"] = "rbxassetid://10709761813",
			["apple"] = "rbxassetid://10709761889",
			["archive"] = "rbxassetid://10709762233",
			["archiverestore"] = "rbxassetid://10709762058",
			["armchair"] = "rbxassetid://10709762327",
			["arrowbigdown"] = "rbxassetid://10747796644",
			["arrowbigleft"] = "rbxassetid://10709762574",
			["arrowbigright"] = "rbxassetid://10709762727",
			["arrowbigup"] = "rbxassetid://10709762879",
			["arrowdown"] = "rbxassetid://10709767827",
			["arrowdowncircle"] = "rbxassetid://10709763034",
			["arrowdownleft"] = "rbxassetid://10709767656",
			["arrowdownright"] = "rbxassetid://10709767750",
			["arrowleft"] = "rbxassetid://10709768114",
			["arrowleftcircle"] = "rbxassetid://10709767936",
			["arrowleftright"] = "rbxassetid://10709768019",
			["arrowright"] = "rbxassetid://10709768347",
			["arrowrightcircle"] = "rbxassetid://10709768226",
			["arrowup"] = "rbxassetid://10709768939",
			["arrowupcircle"] = "rbxassetid://10709768432",
			["arrowupdown"] = "rbxassetid://10709768538",
			["arrowupleft"] = "rbxassetid://10709768661",
			["arrowupright"] = "rbxassetid://10709768787",
			["asterisk"] = "rbxassetid://10709769095",
			["atsign"] = "rbxassetid://10709769286",
			["award"] = "rbxassetid://10709769406",
			["axe"] = "rbxassetid://10709769508",
			["axis3d"] = "rbxassetid://10709769598",
			["baby"] = "rbxassetid://10709769732",
			["backpack"] = "rbxassetid://10709769841",
			["baggageclaim"] = "rbxassetid://10709769935",
			["banana"] = "rbxassetid://10709770005",
			["banknote"] = "rbxassetid://10709770178",
			["barchart"] = "rbxassetid://10709773755",
			["barchart2"] = "rbxassetid://10709770317",
			["barchart3"] = "rbxassetid://10709770431",
			["barchart4"] = "rbxassetid://10709770560",
			["barcharthorizontal"] = "rbxassetid://10709773669",
			["barcode"] = "rbxassetid://10747360675",
			["baseline"] = "rbxassetid://10709773863",
			["bath"] = "rbxassetid://10709773963",
			["battery"] = "rbxassetid://10709774640",
			["batterycharging"] = "rbxassetid://10709774068",
			["batteryfull"] = "rbxassetid://10709774206",
			["batterylow"] = "rbxassetid://10709774370",
			["batterymedium"] = "rbxassetid://10709774513",
			["beaker"] = "rbxassetid://10709774756",
			["bed"] = "rbxassetid://10709775036",
			["beddouble"] = "rbxassetid://10709774864",
			["bedsingle"] = "rbxassetid://10709774968",
			["beer"] = "rbxassetid://10709775167",
			["bell"] = "rbxassetid://10709775704",
			["bellminus"] = "rbxassetid://10709775241",
			["belloff"] = "rbxassetid://10709775320",
			["bellplus"] = "rbxassetid://10709775448",
			["bellring"] = "rbxassetid://10709775560",
			["bike"] = "rbxassetid://10709775894",
			["binary"] = "rbxassetid://10709776050",
			["bitcoin"] = "rbxassetid://10709776126",
			["bluetooth"] = "rbxassetid://10709776655",
			["bluetoothconnected"] = "rbxassetid://10709776240",
			["bluetoothoff"] = "rbxassetid://10709776344",
			["bluetoothsearching"] = "rbxassetid://10709776501",
			["bold"] = "rbxassetid://10747813908",
			["bomb"] = "rbxassetid://10709781460",
			["bone"] = "rbxassetid://10709781605",
			["book"] = "rbxassetid://10709781824",
			["bookopen"] = "rbxassetid://10709781717",
			["bookmark"] = "rbxassetid://10709782154",
			["bookmarkminus"] = "rbxassetid://10709781919",
			["bookmarkplus"] = "rbxassetid://10709782044",
			["bot"] = "rbxassetid://10709782230",
			["box"] = "rbxassetid://10709782497",
			["boxselect"] = "rbxassetid://10709782342",
			["boxes"] = "rbxassetid://10709782582",
			["briefcase"] = "rbxassetid://10709782662",
			["brush"] = "rbxassetid://10709782758",
			["bug"] = "rbxassetid://10709782845",
			["building"] = "rbxassetid://10709783051",
			["building2"] = "rbxassetid://10709782939",
			["bus"] = "rbxassetid://10709783137",
			["cake"] = "rbxassetid://10709783217",
			["calculator"] = "rbxassetid://10709783311",
			["calendar"] = "rbxassetid://10709789505",
			["calendarcheck"] = "rbxassetid://10709783474",
			["calendarcheck2"] = "rbxassetid://10709783392",
			["calendarclock"] = "rbxassetid://10709783577",
			["calendardays"] = "rbxassetid://10709783673",
			["calendarheart"] = "rbxassetid://10709783835",
			["calendarminus"] = "rbxassetid://10709783959",
			["calendaroff"] = "rbxassetid://10709788784",
			["calendarplus"] = "rbxassetid://10709788937",
			["calendarrange"] = "rbxassetid://10709789053",
			["calendarsearch"] = "rbxassetid://10709789200",
			["calendarx"] = "rbxassetid://10709789407",
			["calendarx2"] = "rbxassetid://10709789329",
			["camera"] = "rbxassetid://10709789686",
			["cameraoff"] = "rbxassetid://10747822677",
			["car"] = "rbxassetid://10709789810",
			["carrot"] = "rbxassetid://10709789960",
			["cast"] = "rbxassetid://10709790097",
			["charge"] = "rbxassetid://10709790202",
			["check"] = "rbxassetid://10709790644",
			["checkcircle"] = "rbxassetid://10709790387",
			["checkcircle2"] = "rbxassetid://10709790298",
			["checksquare"] = "rbxassetid://10709790537",
			["chefhat"] = "rbxassetid://10709790757",
			["cherry"] = "rbxassetid://10709790875",
			["chevrondown"] = "rbxassetid://10709790948",
			["chevronfirst"] = "rbxassetid://10709791015",
			["chevronlast"] = "rbxassetid://10709791130",
			["chevronleft"] = "rbxassetid://10709791281",
			["chevronright"] = "rbxassetid://10709791437",
			["chevronup"] = "rbxassetid://10709791523",
			["chevronsdown"] = "rbxassetid://10709796864",
			["chevronsdownup"] = "rbxassetid://10709791632",
			["chevronsleft"] = "rbxassetid://10709797151",
			["chevronsleftright"] = "rbxassetid://10709797006",
			["chevronsright"] = "rbxassetid://10709797382",
			["chevronsrightleft"] = "rbxassetid://10709797274",
			["chevronsup"] = "rbxassetid://10709797622",
			["chevronsupdown"] = "rbxassetid://10709797508",
			["chrome"] = "rbxassetid://10709797725",
			["circle"] = "rbxassetid://10709798174",
			["circledot"] = "rbxassetid://10709797837",
			["circleellipsis"] = "rbxassetid://10709797985",
			["circleslashed"] = "rbxassetid://10709798100",
			["citrus"] = "rbxassetid://10709798276",
			["clapperboard"] = "rbxassetid://10709798350",
			["clipboard"] = "rbxassetid://10709799288",
			["clipboardcheck"] = "rbxassetid://10709798443",
			["clipboardcopy"] = "rbxassetid://10709798574",
			["clipboardedit"] = "rbxassetid://10709798682",
			["clipboardlist"] = "rbxassetid://10709798792",
			["clipboardsignature"] = "rbxassetid://10709798890",
			["clipboardtype"] = "rbxassetid://10709798999",
			["clipboardx"] = "rbxassetid://10709799124",
			["clock"] = "rbxassetid://10709805144",
			["clock1"] = "rbxassetid://10709799535",
			["clock10"] = "rbxassetid://10709799718",
			["clock11"] = "rbxassetid://10709799818",
			["clock12"] = "rbxassetid://10709799962",
			["clock2"] = "rbxassetid://10709803876",
			["clock3"] = "rbxassetid://10709803989",
			["clock4"] = "rbxassetid://10709804164",
			["clock5"] = "rbxassetid://10709804291",
			["clock6"] = "rbxassetid://10709804435",
			["clock7"] = "rbxassetid://10709804599",
			["clock8"] = "rbxassetid://10709804784",
			["clock9"] = "rbxassetid://10709804996",
			["cloud"] = "rbxassetid://10709806740",
			["cloudcog"] = "rbxassetid://10709805262",
			["clouddrizzle"] = "rbxassetid://10709805371",
			["cloudfog"] = "rbxassetid://10709805477",
			["cloudhail"] = "rbxassetid://10709805596",
			["cloudlightning"] = "rbxassetid://10709805727",
			["cloudmoon"] = "rbxassetid://10709805942",
			["cloudmoonrain"] = "rbxassetid://10709805838",
			["cloudoff"] = "rbxassetid://10709806060",
			["cloudrain"] = "rbxassetid://10709806277",
			["cloudrainwind"] = "rbxassetid://10709806166",
			["cloudsnow"] = "rbxassetid://10709806374",
			["cloudsun"] = "rbxassetid://10709806631",
			["cloudsunrain"] = "rbxassetid://10709806475",
			["cloudy"] = "rbxassetid://10709806859",
			["clover"] = "rbxassetid://10709806995",
			["code"] = "rbxassetid://10709810463",
			["code2"] = "rbxassetid://10709807111",
			["codepen"] = "rbxassetid://10709810534",
			["codesandbox"] = "rbxassetid://10709810676",
			["coffee"] = "rbxassetid://10709810814",
			["cog"] = "rbxassetid://10709810948",
			["coins"] = "rbxassetid://10709811110",
			["columns"] = "rbxassetid://10709811261",
			["command"] = "rbxassetid://10709811365",
			["compass"] = "rbxassetid://10709811445",
			["component"] = "rbxassetid://10709811595",
			["conciergebell"] = "rbxassetid://10709811706",
			["connection"] = "rbxassetid://10747361219",
			["contact"] = "rbxassetid://10709811834",
			["contrast"] = "rbxassetid://10709811939",
			["cookie"] = "rbxassetid://10709812067",
			["copy"] = "rbxassetid://10709812159",
			["copyleft"] = "rbxassetid://10709812251",
			["copyright"] = "rbxassetid://10709812311",
			["cornerdownleft"] = "rbxassetid://10709812396",
			["cornerdownright"] = "rbxassetid://10709812485",
			["cornerleftdown"] = "rbxassetid://10709812632",
			["cornerleftup"] = "rbxassetid://10709812784",
			["cornerrightdown"] = "rbxassetid://10709812939",
			["cornerrightup"] = "rbxassetid://10709813094",
			["cornerupleft"] = "rbxassetid://10709813185",
			["cornerupright"] = "rbxassetid://10709813281",
			["cpu"] = "rbxassetid://10709813383",
			["croissant"] = "rbxassetid://10709818125",
			["crop"] = "rbxassetid://10709818245",
			["cross"] = "rbxassetid://10709818399",
			["crosshair"] = "rbxassetid://10709818534",
			["crown"] = "rbxassetid://10709818626",
			["cupsoda"] = "rbxassetid://10709818763",
			["curlybraces"] = "rbxassetid://10709818847",
			["currency"] = "rbxassetid://10709818931",
			["database"] = "rbxassetid://10709818996",
			["delete"] = "rbxassetid://10709819059",
			["diamond"] = "rbxassetid://10709819149",
			["dice1"] = "rbxassetid://10709819266",
			["dice2"] = "rbxassetid://10709819361",
			["dice3"] = "rbxassetid://10709819508",
			["dice4"] = "rbxassetid://10709819670",
			["dice5"] = "rbxassetid://10709819801",
			["dice6"] = "rbxassetid://10709819896",
			["dices"] = "rbxassetid://10723343321",
			["diff"] = "rbxassetid://10723343416",
			["disc"] = "rbxassetid://10723343537",
			["divide"] = "rbxassetid://10723343805",
			["dividecircle"] = "rbxassetid://10723343636",
			["dividesquare"] = "rbxassetid://10723343737",
			["dollarsign"] = "rbxassetid://10723343958",
			["download"] = "rbxassetid://10723344270",
			["downloadcloud"] = "rbxassetid://10723344088",
			["droplet"] = "rbxassetid://10723344432",
			["droplets"] = "rbxassetid://10734883356",
			["drumstick"] = "rbxassetid://10723344737",
			["edit"] = "rbxassetid://10734883598",
			["edit2"] = "rbxassetid://10723344885",
			["edit3"] = "rbxassetid://10723345088",
			["egg"] = "rbxassetid://10723345518",
			["eggfried"] = "rbxassetid://10723345347",
			["electricity"] = "rbxassetid://10723345749",
			["electricityoff"] = "rbxassetid://10723345643",
			["equal"] = "rbxassetid://10723345990",
			["equalnot"] = "rbxassetid://10723345866",
			["eraser"] = "rbxassetid://10723346158",
			["euro"] = "rbxassetid://10723346372",
			["expand"] = "rbxassetid://10723346553",
			["externallink"] = "rbxassetid://10723346684",
			["eye"] = "rbxassetid://10723346959",
			["eyeoff"] = "rbxassetid://10723346871",
			["factory"] = "rbxassetid://10723347051",
			["fan"] = "rbxassetid://10723354359",
			["fastforward"] = "rbxassetid://10723354521",
			["feather"] = "rbxassetid://10723354671",
			["figma"] = "rbxassetid://10723354801",
			["file"] = "rbxassetid://10723374641",
			["filearchive"] = "rbxassetid://10723354921",
			["fileaudio"] = "rbxassetid://10723355148",
			["fileaudio2"] = "rbxassetid://10723355026",
			["fileaxis3d"] = "rbxassetid://10723355272",
			["filebadge"] = "rbxassetid://10723355622",
			["filebadge2"] = "rbxassetid://10723355451",
			["filebarchart"] = "rbxassetid://10723355887",
			["filebarchart2"] = "rbxassetid://10723355746",
			["filebox"] = "rbxassetid://10723355989",
			["filecheck"] = "rbxassetid://10723356210",
			["filecheck2"] = "rbxassetid://10723356100",
			["fileclock"] = "rbxassetid://10723356329",
			["filecode"] = "rbxassetid://10723356507",
			["filecog"] = "rbxassetid://10723356830",
			["filecog2"] = "rbxassetid://10723356676",
			["filediff"] = "rbxassetid://10723357039",
			["filedigit"] = "rbxassetid://10723357151",
			["filedown"] = "rbxassetid://10723357322",
			["fileedit"] = "rbxassetid://10723357495",
			["fileheart"] = "rbxassetid://10723357637",
			["fileimage"] = "rbxassetid://10723357790",
			["fileinput"] = "rbxassetid://10723357933",
			["filejson"] = "rbxassetid://10723364435",
			["filejson2"] = "rbxassetid://10723364361",
			["filekey"] = "rbxassetid://10723364605",
			["filekey2"] = "rbxassetid://10723364515",
			["filelinechart"] = "rbxassetid://10723364725",
			["filelock"] = "rbxassetid://10723364957",
			["filelock2"] = "rbxassetid://10723364861",
			["fileminus"] = "rbxassetid://10723365254",
			["fileminus2"] = "rbxassetid://10723365086",
			["fileoutput"] = "rbxassetid://10723365457",
			["filepiechart"] = "rbxassetid://10723365598",
			["fileplus"] = "rbxassetid://10723365877",
			["fileplus2"] = "rbxassetid://10723365766",
			["filequestion"] = "rbxassetid://10723365987",
			["filescan"] = "rbxassetid://10723366167",
			["filesearch"] = "rbxassetid://10723366550",
			["filesearch2"] = "rbxassetid://10723366340",
			["filesignature"] = "rbxassetid://10723366741",
			["filespreadsheet"] = "rbxassetid://10723366962",
			["filesymlink"] = "rbxassetid://10723367098",
			["fileterminal"] = "rbxassetid://10723367244",
			["filetext"] = "rbxassetid://10723367380",
			["filetype"] = "rbxassetid://10723367606",
			["filetype2"] = "rbxassetid://10723367509",
			["fileup"] = "rbxassetid://10723367734",
			["filevideo"] = "rbxassetid://10723373884",
			["filevideo2"] = "rbxassetid://10723367834",
			["filevolume"] = "rbxassetid://10723374172",
			["filevolume2"] = "rbxassetid://10723374030",
			["filewarning"] = "rbxassetid://10723374276",
			["filex"] = "rbxassetid://10723374544",
			["filex2"] = "rbxassetid://10723374378",
			["files"] = "rbxassetid://10723374759",
			["film"] = "rbxassetid://10723374981",
			["filter"] = "rbxassetid://10723375128",
			["fingerprint"] = "rbxassetid://10723375250",
			["flag"] = "rbxassetid://10723375890",
			["flagoff"] = "rbxassetid://10723375443",
			["flagtriangleleft"] = "rbxassetid://10723375608",
			["flagtriangleright"] = "rbxassetid://10723375727",
			["flame"] = "rbxassetid://10723376114",
			["flashlight"] = "rbxassetid://10723376471",
			["flashlightoff"] = "rbxassetid://10723376365",
			["flaskconical"] = "rbxassetid://10734883986",
			["flaskround"] = "rbxassetid://10723376614",
			["fliphorizontal"] = "rbxassetid://10723376884",
			["fliphorizontal2"] = "rbxassetid://10723376745",
			["flipvertical"] = "rbxassetid://10723377138",
			["flipvertical2"] = "rbxassetid://10723377026",
			["flower"] = "rbxassetid://10747830374",
			["flower2"] = "rbxassetid://10723377305",
			["focus"] = "rbxassetid://10723377537",
			["folder"] = "rbxassetid://10723387563",
			["folderarchive"] = "rbxassetid://10723384478",
			["foldercheck"] = "rbxassetid://10723384605",
			["folderclock"] = "rbxassetid://10723384731",
			["folderclosed"] = "rbxassetid://10723384893",
			["foldercog"] = "rbxassetid://10723385213",
			["foldercog2"] = "rbxassetid://10723385036",
			["folderdown"] = "rbxassetid://10723385338",
			["folderedit"] = "rbxassetid://10723385445",
			["folderheart"] = "rbxassetid://10723385545",
			["folderinput"] = "rbxassetid://10723385721",
			["folderkey"] = "rbxassetid://10723385848",
			["folderlock"] = "rbxassetid://10723386005",
			["folderminus"] = "rbxassetid://10723386127",
			["folderopen"] = "rbxassetid://10723386277",
			["folderoutput"] = "rbxassetid://10723386386",
			["folderplus"] = "rbxassetid://10723386531",
			["foldersearch"] = "rbxassetid://10723386787",
			["foldersearch2"] = "rbxassetid://10723386674",
			["foldersymlink"] = "rbxassetid://10723386930",
			["foldertree"] = "rbxassetid://10723387085",
			["folderup"] = "rbxassetid://10723387265",
			["folderx"] = "rbxassetid://10723387448",
			["folders"] = "rbxassetid://10723387721",
			["forminput"] = "rbxassetid://10723387841",
			["forward"] = "rbxassetid://10723388016",
			["frame"] = "rbxassetid://10723394389",
			["framer"] = "rbxassetid://10723394565",
			["frown"] = "rbxassetid://10723394681",
			["fuel"] = "rbxassetid://10723394846",
			["functionsquare"] = "rbxassetid://10723395041",
			["gamepad"] = "rbxassetid://10723395457",
			["gamepad2"] = "rbxassetid://10723395215",
			["gauge"] = "rbxassetid://10723395708",
			["gavel"] = "rbxassetid://10723395896",
			["gem"] = "rbxassetid://10723396000",
			["ghost"] = "rbxassetid://10723396107",
			["gift"] = "rbxassetid://10723396402",
			["giftcard"] = "rbxassetid://10723396225",
			["gitbranch"] = "rbxassetid://10723396676",
			["gitbranchplus"] = "rbxassetid://10723396542",
			["gitcommit"] = "rbxassetid://10723396812",
			["gitcompare"] = "rbxassetid://10723396954",
			["gitfork"] = "rbxassetid://10723397049",
			["gitmerge"] = "rbxassetid://10723397165",
			["gitpullrequest"] = "rbxassetid://10723397431",
			["gitpullrequestclosed"] = "rbxassetid://10723397268",
			["gitpullrequestdraft"] = "rbxassetid://10734884302",
			["glass"] = "rbxassetid://10723397788",
			["glass2"] = "rbxassetid://10723397529",
			["glasswater"] = "rbxassetid://10723397678",
			["glasses"] = "rbxassetid://10723397895",
			["globe"] = "rbxassetid://10723404337",
			["globe2"] = "rbxassetid://10723398002",
			["grab"] = "rbxassetid://10723404472",
			["graduationcap"] = "rbxassetid://10723404691",
			["grape"] = "rbxassetid://10723404822",
			["grid"] = "rbxassetid://10723404936",
			["griphorizontal"] = "rbxassetid://10723405089",
			["gripvertical"] = "rbxassetid://10723405236",
			["hammer"] = "rbxassetid://10723405360",
			["hand"] = "rbxassetid://10723405649",
			["handmetal"] = "rbxassetid://10723405508",
			["harddrive"] = "rbxassetid://10723405749",
			["hardhat"] = "rbxassetid://10723405859",
			["hash"] = "rbxassetid://10723405975",
			["haze"] = "rbxassetid://10723406078",
			["headphones"] = "rbxassetid://10723406165",
			["heart"] = "rbxassetid://10723406885",
			["heartcrack"] = "rbxassetid://10723406299",
			["hearthandshake"] = "rbxassetid://10723406480",
			["heartoff"] = "rbxassetid://10723406662",
			["heartpulse"] = "rbxassetid://10723406795",
			["helpcircle"] = "rbxassetid://10723406988",
			["hexagon"] = "rbxassetid://10723407092",
			["highlighter"] = "rbxassetid://10723407192",
			["history"] = "rbxassetid://10723407335",
			["home"] = "rbxassetid://10723407389",
			["hourglass"] = "rbxassetid://10723407498",
			["icecream"] = "rbxassetid://10723414308",
			["image"] = "rbxassetid://10723415040",
			["imageminus"] = "rbxassetid://10723414487",
			["imageoff"] = "rbxassetid://10723414677",
			["imageplus"] = "rbxassetid://10723414827",
			["import"] = "rbxassetid://10723415205",
			["inbox"] = "rbxassetid://10723415335",
			["indent"] = "rbxassetid://10723415494",
			["indianrupee"] = "rbxassetid://10723415642",
			["infinity"] = "rbxassetid://10723415766",
			["info"] = "rbxassetid://10723415903",
			["inspect"] = "rbxassetid://10723416057",
			["italic"] = "rbxassetid://10723416195",
			["japaneseyen"] = "rbxassetid://10723416363",
			["joystick"] = "rbxassetid://10723416527",
			["key"] = "rbxassetid://10723416652",
			["keyboard"] = "rbxassetid://10723416765",
			["lamp"] = "rbxassetid://10723417513",
			["lampceiling"] = "rbxassetid://10723416922",
			["lampdesk"] = "rbxassetid://10723417016",
			["lampfloor"] = "rbxassetid://10723417131",
			["lampwalldown"] = "rbxassetid://10723417240",
			["lampwallup"] = "rbxassetid://10723417356",
			["landmark"] = "rbxassetid://10723417608",
			["languages"] = "rbxassetid://10723417703",
			["laptop"] = "rbxassetid://10723423881",
			["laptop2"] = "rbxassetid://10723417797",
			["lasso"] = "rbxassetid://10723424235",
			["lassoselect"] = "rbxassetid://10723424058",
			["laugh"] = "rbxassetid://10723424372",
			["layers"] = "rbxassetid://10723424505",
			["layout"] = "rbxassetid://10723425376",
			["layoutdashboard"] = "rbxassetid://10723424646",
			["layoutgrid"] = "rbxassetid://10723424838",
			["layoutlist"] = "rbxassetid://10723424963",
			["layouttemplate"] = "rbxassetid://10723425187",
			["leaf"] = "rbxassetid://10723425539",
			["library"] = "rbxassetid://10723425615",
			["lifebuoy"] = "rbxassetid://10723425685",
			["lightbulb"] = "rbxassetid://10723425852",
			["lightbulboff"] = "rbxassetid://10723425762",
			["linechart"] = "rbxassetid://10723426393",
			["link"] = "rbxassetid://10723426722",
			["link2"] = "rbxassetid://10723426595",
			["link2off"] = "rbxassetid://10723426513",
			["list"] = "rbxassetid://10723433811",
			["listchecks"] = "rbxassetid://10734884548",
			["listend"] = "rbxassetid://10723426886",
			["listminus"] = "rbxassetid://10723426986",
			["listmusic"] = "rbxassetid://10723427081",
			["listordered"] = "rbxassetid://10723427199",
			["listplus"] = "rbxassetid://10723427334",
			["liststart"] = "rbxassetid://10723427494",
			["listvideo"] = "rbxassetid://10723427619",
			["listx"] = "rbxassetid://10723433655",
			["loader"] = "rbxassetid://10723434070",
			["loader2"] = "rbxassetid://10723433935",
			["locate"] = "rbxassetid://10723434557",
			["locatefixed"] = "rbxassetid://10723434236",
			["locateoff"] = "rbxassetid://10723434379",
			["lock"] = "rbxassetid://10723434711",
			["login"] = "rbxassetid://10723434830",
			["logout"] = "rbxassetid://10723434906",
			["luggage"] = "rbxassetid://10723434993",
			["magnet"] = "rbxassetid://10723435069",
			["mail"] = "rbxassetid://10734885430",
			["mailcheck"] = "rbxassetid://10723435182",
			["mailminus"] = "rbxassetid://10723435261",
			["mailopen"] = "rbxassetid://10723435342",
			["mailplus"] = "rbxassetid://10723435443",
			["mailquestion"] = "rbxassetid://10723435515",
			["mailsearch"] = "rbxassetid://10734884739",
			["mailwarning"] = "rbxassetid://10734885015",
			["mailx"] = "rbxassetid://10734885247",
			["mails"] = "rbxassetid://10734885614",
			["map"] = "rbxassetid://10734886202",
			["mappin"] = "rbxassetid://10734886004",
			["mappinoff"] = "rbxassetid://10734885803",
			["maximize"] = "rbxassetid://10734886735",
			["maximize2"] = "rbxassetid://10734886496",
			["medal"] = "rbxassetid://10734887072",
			["megaphone"] = "rbxassetid://10734887454",
			["megaphoneoff"] = "rbxassetid://10734887311",
			["meh"] = "rbxassetid://10734887603",
			["menu"] = "rbxassetid://10734887784",
			["messagecircle"] = "rbxassetid://10734888000",
			["messagesquare"] = "rbxassetid://10734888228",
			["mic"] = "rbxassetid://10734888864",
			["mic2"] = "rbxassetid://10734888430",
			["micoff"] = "rbxassetid://10734888646",
			["microscope"] = "rbxassetid://10734889106",
			["microwave"] = "rbxassetid://10734895076",
			["milestone"] = "rbxassetid://10734895310",
			["minimize"] = "rbxassetid://10734895698",
			["minimize2"] = "rbxassetid://10734895530",
			["minus"] = "rbxassetid://10734896206",
			["minuscircle"] = "rbxassetid://10734895856",
			["minussquare"] = "rbxassetid://10734896029",
			["monitor"] = "rbxassetid://10734896881",
			["monitoroff"] = "rbxassetid://10734896360",
			["monitorspeaker"] = "rbxassetid://10734896512",
			["moon"] = "rbxassetid://10734897102",
			["morehorizontal"] = "rbxassetid://10734897250",
			["morevertical"] = "rbxassetid://10734897387",
			["mountain"] = "rbxassetid://10734897956",
			["mountainsnow"] = "rbxassetid://10734897665",
			["mouse"] = "rbxassetid://10734898592",
			["mousepointer"] = "rbxassetid://10734898476",
			["mousepointer2"] = "rbxassetid://10734898194",
			["mousepointerclick"] = "rbxassetid://10734898355",
			["move"] = "rbxassetid://10734900011",
			["move3d"] = "rbxassetid://10734898756",
			["movediagonal"] = "rbxassetid://10734899164",
			["movediagonal2"] = "rbxassetid://10734898934",
			["movehorizontal"] = "rbxassetid://10734899414",
			["movevertical"] = "rbxassetid://10734899821",
			["music"] = "rbxassetid://10734905958",
			["music2"] = "rbxassetid://10734900215",
			["music3"] = "rbxassetid://10734905665",
			["music4"] = "rbxassetid://10734905823",
			["navigation"] = "rbxassetid://10734906744",
			["navigation2"] = "rbxassetid://10734906332",
			["navigation2off"] = "rbxassetid://10734906144",
			["navigationoff"] = "rbxassetid://10734906580",
			["network"] = "rbxassetid://10734906975",
			["newspaper"] = "rbxassetid://10734907168",
			["octagon"] = "rbxassetid://10734907361",
			["option"] = "rbxassetid://10734907649",
			["outdent"] = "rbxassetid://10734907933",
			["package"] = "rbxassetid://10734909540",
			["package2"] = "rbxassetid://10734908151",
			["packagecheck"] = "rbxassetid://10734908384",
			["packageminus"] = "rbxassetid://10734908626",
			["packageopen"] = "rbxassetid://10734908793",
			["packageplus"] = "rbxassetid://10734909016",
			["packagesearch"] = "rbxassetid://10734909196",
			["packagex"] = "rbxassetid://10734909375",
			["paintbucket"] = "rbxassetid://10734909847",
			["paintbrush"] = "rbxassetid://10734910187",
			["paintbrush2"] = "rbxassetid://10734910030",
			["palette"] = "rbxassetid://10734910430",
			["palmtree"] = "rbxassetid://10734910680",
			["paperclip"] = "rbxassetid://10734910927",
			["partypopper"] = "rbxassetid://10734918735",
			["pause"] = "rbxassetid://10734919336",
			["pausecircle"] = "rbxassetid://10735024209",
			["pauseoctagon"] = "rbxassetid://10734919143",
			["pentool"] = "rbxassetid://10734919503",
			["pencil"] = "rbxassetid://10734919691",
			["percent"] = "rbxassetid://10734919919",
			["personstanding"] = "rbxassetid://10734920149",
			["phone"] = "rbxassetid://10734921524",
			["phonecall"] = "rbxassetid://10734920305",
			["phoneforwarded"] = "rbxassetid://10734920508",
			["phoneincoming"] = "rbxassetid://10734920694",
			["phonemissed"] = "rbxassetid://10734920845",
			["phoneoff"] = "rbxassetid://10734921077",
			["phoneoutgoing"] = "rbxassetid://10734921288",
			["piechart"] = "rbxassetid://10734921727",
			["piggybank"] = "rbxassetid://10734921935",
			["pin"] = "rbxassetid://10734922324",
			["pinoff"] = "rbxassetid://10734922180",
			["pipette"] = "rbxassetid://10734922497",
			["pizza"] = "rbxassetid://10734922774",
			["plane"] = "rbxassetid://10734922971",
			["play"] = "rbxassetid://10734923549",
			["playcircle"] = "rbxassetid://10734923214",
			["plus"] = "rbxassetid://10734924532",
			["pluscircle"] = "rbxassetid://10734923868",
			["plussquare"] = "rbxassetid://10734924219",
			["podcast"] = "rbxassetid://10734929553",
			["pointer"] = "rbxassetid://10734929723",
			["poundsterling"] = "rbxassetid://10734929981",
			["power"] = "rbxassetid://10734930466",
			["poweroff"] = "rbxassetid://10734930257",
			["printer"] = "rbxassetid://10734930632",
			["puzzle"] = "rbxassetid://10734930886",
			["quote"] = "rbxassetid://10734931234",
			["radio"] = "rbxassetid://10734931596",
			["radioreceiver"] = "rbxassetid://10734931402",
			["rectanglehorizontal"] = "rbxassetid://10734931777",
			["rectanglevertical"] = "rbxassetid://10734932081",
			["recycle"] = "rbxassetid://10734932295",
			["redo"] = "rbxassetid://10734932822",
			["redo2"] = "rbxassetid://10734932586",
			["refreshccw"] = "rbxassetid://10734933056",
			["refreshcw"] = "rbxassetid://10734933222",
			["refrigerator"] = "rbxassetid://10734933465",
			["regex"] = "rbxassetid://10734933655",
			["repeat"] = "rbxassetid://10734933966",
			["repeat1"] = "rbxassetid://10734933826",
			["reply"] = "rbxassetid://10734934252",
			["replyall"] = "rbxassetid://10734934132",
			["rewind"] = "rbxassetid://10734934347",
			["rocket"] = "rbxassetid://10734934585",
			["rockingchair"] = "rbxassetid://10734939942",
			["rotate3d"] = "rbxassetid://10734940107",
			["rotateccw"] = "rbxassetid://10734940376",
			["rotatecw"] = "rbxassetid://10734940654",
			["rss"] = "rbxassetid://10734940825",
			["ruler"] = "rbxassetid://10734941018",
			["russianruble"] = "rbxassetid://10734941199",
			["sailboat"] = "rbxassetid://10734941354",
			["save"] = "rbxassetid://10734941499",
			["scale"] = "rbxassetid://10734941912",
			["scale3d"] = "rbxassetid://10734941739",
			["scaling"] = "rbxassetid://10734942072",
			["scan"] = "rbxassetid://10734942565",
			["scanface"] = "rbxassetid://10734942198",
			["scanline"] = "rbxassetid://10734942351",
			["scissors"] = "rbxassetid://10734942778",
			["screenshare"] = "rbxassetid://10734943193",
			["screenshareoff"] = "rbxassetid://10734942967",
			["scroll"] = "rbxassetid://10734943448",
			["search"] = "rbxassetid://10734943674",
			["send"] = "rbxassetid://10734943902",
			["separatorhorizontal"] = "rbxassetid://10734944115"
},
    Windows = {},
    CurrentTheme = nil
}

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local function tween(obj, info, properties)
    local tween = TweenService:Create(obj, info or TweenInfo.new(0.4, Enum.EasingStyle.Quart), properties)
    tween:Play()
    return tween
end

local function applyGradient(frame, startColor, endColor)
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new(startColor, endColor)
    gradient.Rotation = 45
    gradient.Parent = frame
end

RainLib.ScreenGui = Instance.new("ScreenGui")
RainLib.ScreenGui.Name = "RainLib"
RainLib.ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui", 5)
RainLib.ScreenGui.ResetOnSpawn = false
RainLib.ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

RainLib.CurrentTheme = RainLib.Themes.Futuristic
RainLib.Notifications = Instance.new("Frame")
RainLib.Notifications.Size = UDim2.new(0, 320, 1, 0)
RainLib.Notifications.Position = UDim2.new(1, -330, 0, 0)
RainLib.Notifications.BackgroundTransparency = 1
RainLib.Notifications.Parent = RainLib.ScreenGui

function RainLib:Window(options)
    local window = {}
    options = options or {}
    
    window.Title = options.Title or "Rain Lib"
    window.Size = options.Size or UDim2.new(0, 650, 0, 450)
    window.Position = options.Position or UDim2.new(0.5, -325, 0.5, -225)
    window.Acrylic = options.Acrylic or false
    window.Tabs = {}
    window.CurrentTabIndex = 1
    
    window.MainFrame = Instance.new("Frame")
    window.MainFrame.Size = window.Size
    window.MainFrame.Position = window.Position
    window.MainFrame.BackgroundColor3 = RainLib.CurrentTheme.Background
    window.MainFrame.BackgroundTransparency = window.Acrylic and 0.3 or 0
    window.MainFrame.ClipsDescendants = true
    window.MainFrame.Parent = RainLib.ScreenGui
    
    if window.Acrylic then
        local blur = Instance.new("ImageLabel")
        blur.Size = UDim2.new(1, 0, 1, 0)
        blur.BackgroundTransparency = 1
        blur.Image = "rbxassetid://9125062475" -- Efeito de desfoque
        blur.ImageTransparency = 0.7
        blur.Parent = window.MainFrame
    end
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = window.MainFrame
    
    local shadow = Instance.new("ImageLabel")
    shadow.Size = UDim2.new(1, 30, 1, 30)
    shadow.Position = UDim2.new(0, -15, 0, -15)
    shadow.BackgroundTransparency = 1
    shadow.Image = "rbxassetid://1316045217"
    shadow.ImageTransparency = 0.6
    shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(10, 10, 118, 118)
    shadow.Parent = window.MainFrame
    
    window.TitleBar = Instance.new("Frame")
    window.TitleBar.Size = UDim2.new(1, 0, 0, 50)
    window.TitleBar.BackgroundColor3 = RainLib.CurrentTheme.Secondary
    window.TitleBar.Parent = window.MainFrame
    applyGradient(window.TitleBar, RainLib.CurrentTheme.GradientStart, RainLib.CurrentTheme.GradientEnd)
    
    window.TitleLabel = Instance.new("TextLabel")
    window.TitleLabel.Size = UDim2.new(1, -50, 1, 0)
    window.TitleLabel.Position = UDim2.new(0, 15, 0, 0)
    window.TitleLabel.BackgroundTransparency = 1
    window.TitleLabel.Text = window.Title
    window.TitleLabel.TextColor3 = RainLib.CurrentTheme.Text
    window.TitleLabel.Font = Enum.Font.SciFi
    window.TitleLabel.TextSize = 18
    window.TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    window.TitleLabel.Parent = window.TitleBar
    
    window.CloseButton = Instance.new("TextButton")
    window.CloseButton.Size = UDim2.new(0, 35, 0, 35)
    window.CloseButton.Position = UDim2.new(1, -45, 0, 7)
    window.CloseButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    window.CloseButton.Text = "X"
    window.CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    window.CloseButton.Font = Enum.Font.SciFi
    window.CloseButton.TextSize = 18
    window.CloseButton.Parent = window.TitleBar
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 10)
    closeCorner.Parent = window.CloseButton
    
    window.TabContainer = Instance.new("ScrollingFrame")
    window.TabContainer.Size = UDim2.new(0, 160, 1, -50)
    window.TabContainer.Position = UDim2.new(0, 0, 0, 50)
    window.TabContainer.BackgroundColor3 = RainLib.CurrentTheme.Secondary
    window.TabContainer.BackgroundTransparency = 0.2
    window.TabContainer.ScrollBarThickness = 0
    window.TabContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
    window.TabContainer.Parent = window.MainFrame
    
    window.TabIndicator = Instance.new("Frame")
    window.TabIndicator.Size = UDim2.new(0, 4, 0, 45)
    window.TabIndicator.BackgroundColor3 = RainLib.CurrentTheme.Accent
    window.TabIndicator.Position = UDim2.new(0, 0, 0, 5)
    window.TabIndicator.Parent = window.TabContainer
    
    local dragging, dragStart, startPos
    window.TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = window.MainFrame.Position
        end
    end)
    
    window.TitleBar.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            window.MainFrame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
    
    window.TitleBar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    function window:Minimize(options)
        options = options or {}
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(0, 120, 0, 40)
        button.Position = UDim2.new(0, 15, 0, 15)
        button.Text = options.Text1 or "Colapsar"
        button.BackgroundColor3 = RainLib.CurrentTheme.Accent
        button.TextColor3 = RainLib.CurrentTheme.Text
        button.Font = Enum.Font.SciFi
        button.TextSize = 16
        button.BackgroundTransparency = options.Gradient and 0 or 0.1
        button.Parent = RainLib.ScreenGui
        
        if options.Gradient then
            applyGradient(button, RainLib.CurrentTheme.GradientStart, RainLib.CurrentTheme.GradientEnd)
        end
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = options.CornerRadius or UDim.new(0, 12)
        corner.Parent = button
        
        button.MouseButton1Click:Connect(function()
            window.MainFrame.Visible = not window.MainFrame.Visible
            button.Text = window.MainFrame.Visible and (options.Text1 or "Colapsar") or (options.Text2 or "Expandir")
            tween(button, nil, {Size = window.MainFrame.Visible and UDim2.new(0, 120, 0, 40) or UDim2.new(0, 140, 0, 45)})
        end)
        
        if options.Draggable then
            local draggingButton, dragStartButton, startPosButton
            button.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    draggingButton = true
                    dragStartButton = input.Position
                    startPosButton = button.Position
                end
            end)
            
            button.InputChanged:Connect(function(input)
                if draggingButton and input.UserInputType == Enum.UserInputType.MouseMovement then
                    local delta = input.Position - dragStartButton
                    button.Position = UDim2.new(
                        startPosButton.X.Scale,
                        startPosButton.X.Offset + delta.X,
                        startPosButton.Y.Scale,
                        startPosButton.Y.Offset + delta.Y
                    )
                end
            end)
            
            button.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    draggingButton = false
                end
            end)
        end
        
        window.MinimizeButton = button
        return button
    end
    
    function window:Tab(options)
        local tab = {}
        options = options or {}
        tab.Name = options.Name or "Tab"
        tab.Icon = options.Icon or nil
        tab.ElementsPerRow = options.ElementsPerRow or 1
        tab.ElementCount = 0
        
        tab.Content = Instance.new("ScrollingFrame")
        tab.Content.Size = UDim2.new(1, -170, 1, -60)
        tab.Content.Position = UDim2.new(0, 165, 0, 55)
        tab.Content.BackgroundTransparency = 1
        tab.Content.ScrollBarThickness = 5
        tab.Content.CanvasSize = UDim2.new(0, 0, 0, 0)
        tab.Content.Visible = false
        tab.Content.Parent = window.MainFrame
        
        tab.Container = Instance.new("Frame")
        tab.Container.Size = UDim2.new(1, -10, 1, -10)
        tab.Container.Position = UDim2.new(0, 5, 0, 5)
        tab.Container.BackgroundTransparency = 1
        tab.Container.Parent = tab.Content
        
        tab.Button = Instance.new("TextButton")
        tab.Button.Size = UDim2.new(1, -10, 0, 45)
        tab.Button.Position = UDim2.new(0, 5, 0, #window.Tabs * 50 + 5)
        tab.Button.BackgroundTransparency = 0.5
        tab.Button.Text = tab.Icon and "" or tab.Name
        tab.Button.TextColor3 = RainLib.CurrentTheme.Text
        tab.Button.Font = Enum.Font.SciFi
        tab.Button.TextSize = 16
        tab.Button.TextXAlignment = Enum.TextXAlignment.Left
        tab.Button.Parent = window.TabContainer
        window.TabContainer.CanvasSize = UDim2.new(0, 0, 0, #window.Tabs * 50 + 55)
        
        if tab.Icon then
            local icon = Instance.new("ImageLabel")
            icon.Size = UDim2.new(0, 28, 0, 28)
            icon.Position = UDim2.new(0, 10, 0.5, -14)
            icon.BackgroundTransparency = 1
            icon.Image = RainLib.Icons[tab.Icon] or tab.Icon
            icon.Parent = tab.Button
            
            local text = Instance.new("TextLabel")
            text.Size = UDim2.new(1, -45, 1, 0)
            text.Position = UDim2.new(0, 40, 0, 0)
            text.BackgroundTransparency = 1
            text.Text = tab.Name
            text.TextColor3 = RainLib.CurrentTheme.Text
            text.Font = Enum.Font.SciFi
            text.TextSize = 16
            text.TextXAlignment = Enum.TextXAlignment.Left
            text.Parent = tab.Button
        end
        
        tab.Button.MouseEnter:Connect(function()
            tween(tab.Button, TweenInfo.new(0.2), {BackgroundTransparency = 0.2})
        end)
        tab.Button.MouseLeave:Connect(function()
            tween(tab.Button, TweenInfo.new(0.2), {BackgroundTransparency = 0.5})
        end)
        
        table.insert(window.Tabs, tab)
        
        local function selectTab(index)
            for i, t in pairs(window.Tabs) do
                if i == index then
                    t.Content.Visible = true
                    tween(t.Content, TweenInfo.new(0.3), {BackgroundTransparency = 1})
                    tween(window.TabIndicator, TweenInfo.new(0.4, Enum.EasingStyle.Quart), {Position = UDim2.new(0, 0, 0, (i-1) * 50 + 5)})
                    window.CurrentTabIndex = i
                else
                    tween(t.Content, TweenInfo.new(0.3), {BackgroundTransparency = 1})
                    task.delay(0.3, function() t.Content.Visible = false end)
                end
            end
        end
        
        tab.Button.MouseButton1Click:Connect(function()
            local index = table.find(window.Tabs, tab)
            selectTab(index)
        end)
        
        if #window.Tabs == 1 then
            selectTab(1)
        end
        
        local function getNextPosition(elementSize)
            local row = math.floor(tab.ElementCount / tab.ElementsPerRow)
            local col = tab.ElementCount % tab.ElementsPerRow
            local xOffset = 15 + col * (elementSize.X.Offset + 15)
            local yOffset = 15 + row * (elementSize.Y.Offset + 15)
            tab.ElementCount = tab.ElementCount + 1
            return UDim2.new(0, xOffset, 0, yOffset)
        end
        
        function tab:Button(options)
            local buttonSize = options.Size or UDim2.new(0, 130, 0, 45)
            local button = Instance.new("TextButton")
            button.Size = buttonSize
            button.Position = getNextPosition(buttonSize)
            button.Text = options.Text or "Button"
            button.BackgroundColor3 = RainLib.CurrentTheme.Accent
            button.TextColor3 = RainLib.CurrentTheme.Text
            button.Font = Enum.Font.SciFi
            button.TextSize = 16
            button.BackgroundTransparency = 0.1
            button.Parent = tab.Container
            
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 10)
            corner.Parent = button
            
            button.MouseEnter:Connect(function()
                tween(button, TweenInfo.new(0.2), {BackgroundTransparency = 0})
            end)
            button.MouseLeave:Connect(function()
                tween(button, TweenInfo.new(0.2), {BackgroundTransparency = 0.1})
            end)
            
            button.MouseButton1Click:Connect(options.Callback or function() end)
            return button
        end
        
        function tab:Textbox(options)
            local textboxSize = options.Size or UDim2.new(0, 130, 0, 45)
            local textbox = Instance.new("TextBox")
            textbox.Size = textboxSize
            textbox.Position = getNextPosition(textboxSize)
            textbox.Text = options.Text or ""
            textbox.BackgroundColor3 = RainLib.CurrentTheme.Secondary
            textbox.TextColor3 = RainLib.CurrentTheme.Text
            textbox.Font = Enum.Font.SciFi
            textbox.TextSize = 16
            textbox.BackgroundTransparency = 0.2
            textbox.Parent = tab.Container
            
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 10)
            corner.Parent = textbox
            
            textbox.Focused:Connect(function()
                tween(textbox, TweenInfo.new(0.2), {BackgroundColor3 = RainLib.CurrentTheme.Accent})
            end)
            textbox.FocusLost:Connect(function()
                tween(textbox, TweenInfo.new(0.2), {BackgroundColor3 = RainLib.CurrentTheme.Secondary})
                if options.Callback then
                    options.Callback(textbox.Text)
                end
            end)
            
            return textbox
        end
        
        function tab:Toggle(options)
            local toggleSize = options.Size or UDim2.new(0, 130, 0, 45)
            local toggle = { Value = options.Default or false }
            local frame = Instance.new("Frame")
            frame.Size = toggleSize
            frame.Position = getNextPosition(toggleSize)
            frame.BackgroundColor3 = RainLib.CurrentTheme.Secondary
            frame.BackgroundTransparency = 0.2
            frame.Parent = tab.Container
            
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 10)
            corner.Parent = frame
            
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(0, 80, 1, 0)
            label.Text = options.Text or "Toggle"
            label.BackgroundTransparency = 1
            label.TextColor3 = RainLib.CurrentTheme.Text
            label.Font = Enum.Font.SciFi
            label.TextSize = 16
            label.Parent = frame
            
            local indicator = Instance.new("Frame")
            indicator.Size = UDim2.new(0, 25, 0, 25)
            indicator.Position = UDim2.new(1, -35, 0.5, -12.5)
            indicator.BackgroundColor3 = toggle.Value and RainLib.CurrentTheme.Accent or RainLib.CurrentTheme.Disabled
            indicator.Parent = frame
            
            local indicatorCorner = Instance.new("UICorner")
            indicatorCorner.CornerRadius = UDim.new(0, 8)
            indicatorCorner.Parent = indicator
            
            frame.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    toggle.Value = not toggle.Value
                    tween(indicator, TweenInfo.new(0.3), {BackgroundColor3 = toggle.Value and RainLib.CurrentTheme.Accent or RainLib.CurrentTheme.Disabled})
                    if options.Callback then
                        options.Callback(toggle.Value)
                    end
                end
            end)
            
            return toggle
        end
        
        function tab:Slider(options)
            local sliderSize = options.Size or UDim2.new(0, 220, 0, 55)
            local slider = { Value = options.Default or 0 }
            local frame = Instance.new("Frame")
            frame.Size = sliderSize
            frame.Position = getNextPosition(sliderSize)
            frame.BackgroundColor3 = RainLib.CurrentTheme.Secondary
            frame.BackgroundTransparency = 0.2
            frame.Parent = tab.Container
            
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 10)
            corner.Parent = frame
            
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(0, 110, 0, 25)
            label.Text = options.Text or "Slider"
            label.BackgroundTransparency = 1
            label.TextColor3 = RainLib.CurrentTheme.Text
            label.Font = Enum.Font.SciFi
            label.TextSize = 16
            label.Parent = frame
            
            local valueLabel = Instance.new("TextLabel")
            valueLabel.Size = UDim2.new(0, 60, 0, 25)
            valueLabel.Position = UDim2.new(1, -70, 0, 0)
            valueLabel.Text = tostring(slider.Value)
            valueLabel.BackgroundTransparency = 1
            valueLabel.TextColor3 = RainLib.CurrentTheme.Text
            valueLabel.Font = Enum.Font.SciFi
            valueLabel.TextSize = 16
            valueLabel.Parent = frame
            
            local bar = Instance.new("Frame")
            bar.Size = UDim2.new(1, -15, 0, 12)
            bar.Position = UDim2.new(0, 7, 0, 35)
            bar.BackgroundColor3 = RainLib.CurrentTheme.Disabled
            bar.Parent = frame
            
            local fill = Instance.new("Frame")
            fill.Size = UDim2.new(slider.Value / (options.Max or 100), 0, 1, 0)
            fill.BackgroundColor3 = RainLib.CurrentTheme.Accent
            fill.Parent = bar
            
            applyGradient(fill, RainLib.CurrentTheme.GradientStart, RainLib.CurrentTheme.GradientEnd)
            
            local cornerBar = Instance.new("UICorner")
            cornerBar.CornerRadius = UDim.new(0, 6)
            cornerBar.Parent = bar
            
            local cornerFill = Instance.new("UICorner")
            cornerFill.CornerRadius = UDim.new(0, 6)
            cornerFill.Parent = fill
            
            local dragging
            bar.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = true
                end
            end)
            
            bar.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = false
                end
            end)
            
            RunService.RenderStepped:Connect(function()
                if dragging then
                    local mousePos = UserInputService:GetMouseLocation()
                    local relativeX = math.clamp((mousePos.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
                    slider.Value = math.floor(relativeX * (options.Max or 100))
                    fill.Size = UDim2.new(relativeX, 0, 1, 0)
                    valueLabel.Text = tostring(slider.Value)
                    if options.Callback then
                        options.Callback(slider.Value)
                    end
                end
            end)
            
            return slider
        end
        
        function tab:Dropdown(options)
            local dropdownSize = options.Size or UDim2.new(0, 130, 0, 45)
            local dropdown = { Value = options.Default or options.Options[1] }
            local frame = Instance.new("Frame")
            frame.Size = dropdownSize
            frame.Position = getNextPosition(dropdownSize)
            frame.BackgroundColor3 = RainLib.CurrentTheme.Secondary
            frame.BackgroundTransparency = 0.2
            frame.Parent = tab.Container
            
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 10)
            corner.Parent = frame
            
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, -35, 1, 0)
            label.Text = dropdown.Value
            label.BackgroundTransparency = 1
            label.TextColor3 = RainLib.CurrentTheme.Text
            label.Font = Enum.Font.SciFi
            label.TextSize = 16
            label.Parent = frame
            
            local arrow = Instance.new("TextLabel")
            arrow.Size = UDim2.new(0, 25, 1, 0)
            arrow.Position = UDim2.new(1, -30, 0, 0)
            arrow.Text = "▼"
            arrow.BackgroundTransparency = 1
            arrow.TextColor3 = RainLib.CurrentTheme.Text
            arrow.Font = Enum.Font.SciFi
            arrow.TextSize = 16
            arrow.Parent = frame
            
            local list = Instance.new("Frame")
            list.Size = UDim2.new(1, 0, 0, #options.Options * 35)
            list.Position = UDim2.new(0, 0, 1, 10)
            list.BackgroundColor3 = RainLib.CurrentTheme.Secondary
            list.BackgroundTransparency = 0.2
            list.Visible = false
            list.Parent = frame
            
            local listCorner = Instance.new("UICorner")
            listCorner.CornerRadius = UDim.new(0, 10)
            listCorner.Parent = list
            
            for i, opt in ipairs(options.Options) do
                local btn = Instance.new("TextButton")
                btn.Size = UDim2.new(1, 0, 0, 35)
                btn.Position = UDim2.new(0, 0, 0, (i-1) * 35)
                btn.Text = opt
                btn.BackgroundTransparency = 0.5
                btn.TextColor3 = RainLib.CurrentTheme.Text
                btn.Font = Enum.Font.SciFi
                btn.TextSize = 16
                btn.Parent = list
                
                btn.MouseEnter:Connect(function()
                    tween(btn, TweenInfo.new(0.2), {BackgroundTransparency = 0})
                end)
                btn.MouseLeave:Connect(function()
                    tween(btn, TweenInfo.new(0.2), {BackgroundTransparency = 0.5})
                end)
                
                btn.MouseButton1Click:Connect(function()
                    dropdown.Value = opt
                    label.Text = opt
                    list.Visible = false
                    if options.Callback then
                        options.Callback(dropdown.Value)
                    end
                end)
            end
            
            frame.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    list.Visible = not list.Visible
                    tween(frame, TweenInfo.new(0.3), {Size = list.Visible and UDim2.new(0, 130, 0, 50) or dropdownSize})
                end
            end)
            
            return dropdown
        end
        
        return tab
    end
    
    table.insert(RainLib.Windows, window)
    return window
end

function RainLib:Notify(options)
    local notification = Instance.new("Frame")
    notification.Size = UDim2.new(0, 300, 0, 90)
    notification.Position = UDim2.new(1, 10, 0, (#RainLib.Notifications:GetChildren() - 1) * 100 + 10)
    notification.BackgroundColor3 = RainLib.CurrentTheme.Background
    notification.BackgroundTransparency = 0.3
    notification.Parent = RainLib.Notifications
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = notification
    
    if options.Glow then
        local glow = Instance.new("ImageLabel")
        glow.Size = UDim2.new(1, 40, 1, 40)
        glow.Position = UDim2.new(0, -20, 0, -20)
        glow.BackgroundTransparency = 1
        glow.Image = "rbxassetid://5028857084"
        glow.ImageTransparency = 0.7
        glow.ImageColor3 = RainLib.CurrentTheme.Accent
        glow.Parent = notification
    end
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -15, 0, 25)
    title.Position = UDim2.new(0, 10, 0, 10)
    title.Text = options.Title or "Notification"
    title.BackgroundTransparency = 1
    title.TextColor3 = RainLib.CurrentTheme.Text
    title.Font = Enum.Font.SciFi
    title.TextSize = 18
    title.Parent = notification
    
    local message = Instance.new("TextLabel")
    message.Size = UDim2.new(1, -15, 0, 45)
    message.Position = UDim2.new(0, 10, 0, 40)
    message.Text = options.Message or "Message"
    message.BackgroundTransparency = 1
    message.TextColor3 = RainLib.CurrentTheme.Text
    message.Font = Enum.Font.SourceSans
    message.TextSize = 14
    message.TextWrapped = true
    message.Parent = notification
    
    tween(notification, TweenInfo.new(0.5), {Position = UDim2.new(0, 10, 0, (#RainLib.Notifications:GetChildren() - 1) * 100 + 10)})
    task.wait(options.Duration or 3)
    tween(notification, TweenInfo.new(0.5), {Position = UDim2.new(1, 10, 0, notification.Position.Y.Offset)}).Completed:Connect(function()
        notification:Destroy()
    end)
end

function RainLib:SetTheme(theme)
    RainLib.CurrentTheme = theme
    for _, window in pairs(RainLib.Windows) do
        window.MainFrame.BackgroundColor3 = theme.Background
        window.TitleBar.BackgroundColor3 = theme.Secondary
        applyGradient(window.TitleBar, theme.GradientStart, theme.GradientEnd)
        window.TitleLabel.TextColor3 = theme.Text
        window.TabContainer.BackgroundColor3 = theme.Secondary
        window.TabIndicator.BackgroundColor3 = theme.Accent
        for _, tab in pairs(window.Tabs) do
            tab.Button.TextColor3 = theme.Text
            for _, child in pairs(tab.Button:GetChildren()) do
                if child:IsA("TextLabel") then
                    child.TextColor3 = theme.Text
                end
            end
            for _, child in pairs(tab.Container:GetChildren()) do
                if child:IsA("TextButton") then
                    child.BackgroundColor3 = theme.Accent
                    child.TextColor3 = theme.Text
                elseif child:IsA("TextBox") then
                    child.BackgroundColor3 = theme.Secondary
                    child.TextColor3 = theme.Text
                elseif child:IsA("Frame") then
                    child.BackgroundColor3 = theme.Secondary
                    for _, subchild in pairs(child:GetChildren()) do
                        if subchild:IsA("TextLabel") then
                            subchild.TextColor3 = theme.Text
                        elseif subchild:IsA("Frame") then
                            subchild.BackgroundColor3 = subchild.Parent.BackgroundColor3 == theme.Accent and theme.Accent or theme.Disabled
                        end
                    end
                end
            end
        end
    end
end

return RainLib
