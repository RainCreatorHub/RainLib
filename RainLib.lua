local RainLib = {
    Version = "1.1.0",
    Themes = {
        Dark = {
            Background = Color3.fromRGB(30, 30, 30),
            Accent = Color3.fromRGB(50, 150, 255),
            Text = Color3.fromRGB(255, 255, 255),
            Secondary = Color3.fromRGB(50, 50, 50),
            Disabled = Color3.fromRGB(100, 100, 100)
        }
    },
    Icons = {
        ["activity"] = "rbxassetid://10709791437",
        ["airvent"] = "rbxassetid://10709791532",
        ["alarmcheck"] = "rbxassetid://10709791785",
        ["alarmclock"] = "rbxassetid://10709792020",
        ["alarmminus"] = "rbxassetid://10709792162",
        ["alarmplus"] = "rbxassetid://10709792556",
        ["alertcircle"] = "rbxassetid://10709792737",
        ["alertcircleoutline"] = "rbxassetid://6026568240",
        ["alertoctagon"] = "rbxassetid://10709792936",
        ["alerttriangle"] = "rbxassetid://10709793126",
        ["aligncenter"] = "rbxassetid://10709793348",
        ["alignjustify"] = "rbxassetid://10709793613",
        ["alignleft"] = "rbxassetid://10709793870",
        ["alignright"] = "rbxassetid://10709794060",
        ["anchor"] = "rbxassetid://10709794305",
        ["aperture"] = "rbxassetid://10709794481",
        ["archive"] = "rbxassetid://10709794626",
        ["arrowdown"] = "rbxassetid://10709795222",
        ["arrowdowncircle"] = "rbxassetid://10709794795",
        ["arrowdownleft"] = "rbxassetid://10709794967",
        ["arrowdownright"] = "rbxassetid://10709795103",
        ["arrowleft"] = "rbxassetid://10709795515",
        ["arrowleftcircle"] = "rbxassetid://10709795351",
        ["arrowright"] = "rbxassetid://10709795998",
        ["arrowrightcircle"] = "rbxassetid://10709795746",
        ["arrowup"] = "rbxassetid://10709796505",
        ["arrowupcircle"] = "rbxassetid://10709796122",
        ["arrowupleft"] = "rbxassetid://10709796274",
        ["arrowupright"] = "rbxassetid://10709796382",
        ["asterisk"] = "rbxassetid://10709796676",
        ["atsign"] = "rbxassetid://10709796843",
        ["award"] = "rbxassetid://10709797034",
        ["baby"] = "rbxassetid://10709797225",
        ["barchart"] = "rbxassetid://10709797559",
        ["barchart2"] = "rbxassetid://10709797387",
        ["batterycharging"] = "rbxassetid://10709797789",
        ["bell"] = "rbxassetid://10709798104",
        ["belloff"] = "rbxassetid://10709797963",
        ["bluetooth"] = "rbxassetid://10709798299",
        ["bold"] = "rbxassetid://10709798434",
        ["bomb"] = "rbxassetid://10709798577",
        ["bone"] = "rbxassetid://10709798767",
        ["book"] = "rbxassetid://10709799122",
        ["bookmark"] = "rbxassetid://10709799274",
        ["bookopen"] = "rbxassetid://10709798985",
        ["box"] = "rbxassetid://10709799456",
        ["briefcase"] = "rbxassetid://10709799654",
        ["bug"] = "rbxassetid://10734844673",
        ["building"] = "rbxassetid://10734844852",
        ["building2"] = "rbxassetid://10734844770",
        ["bus"] = "rbxassetid://10709799863",
        ["cake"] = "rbxassetid://10734845061",
        ["calculator"] = "rbxassetid://10709800040",
        ["calendar"] = "rbxassetid://10709800228",
        ["camera"] = "rbxassetid://10709800499",
        ["cameraoff"] = "rbxassetid://10709800386",
        ["car"] = "rbxassetid://10734845230",
        ["cast"] = "rbxassetid://10709800691",
        ["cat"] = "rbxassetid://10734845373",
        ["check"] = "rbxassetid://10709801424",
        ["checkcircle"] = "rbxassetid://10709800875",
        ["checkcircle2"] = "rbxassetid://10709800990",
        ["checkbox"] = "rbxassetid://10709801154",
        ["checksquare"] = "rbxassetid://10709801319",
        ["chevrondown"] = "rbxassetid://10709801615",
        ["chevronleft"] = "rbxassetid://10709801759",
        ["chevronright"] = "rbxassetid://10709801893",
        ["chevronup"] = "rbxassetid://10709802059",
        ["chevronsdown"] = "rbxassetid://10709802251",
        ["chevronsleft"] = "rbxassetid://10709802355",
        ["chevronsright"] = "rbxassetid://10709802511",
        ["chevronsup"] = "rbxassetid://10709802646",
        ["chrome"] = "rbxassetid://10709802799",
        ["circle"] = "rbxassetid://10709802998",
        ["clipboard"] = "rbxassetid://10709803207",
        ["clock"] = "rbxassetid://10709803448",
        ["cloud"] = "rbxassetid://10709805262",
        ["clouddownload"] = "rbxassetid://10709803690",
        ["clouddrizzle"] = "rbxassetid://10709803845",
        ["cloudlightning"] = "rbxassetid://10709803989",
        ["cloudmoon"] = "rbxassetid://10734845532",
        ["cloudoff"] = "rbxassetid://10709804139",
        ["cloudrain"] = "rbxassetid://10709804299",
        ["cloudsnow"] = "rbxassetid://10709804512",
        ["cloudsun"] = "rbxassetid://10734845725",
        ["cloudupload"] = "rbxassetid://10709804774",
        ["code"] = "rbxassetid://10709805422",
        ["codepen"] = "rbxassetid://10709805568",
        ["codesandbox"] = "rbxassetid://10709805706",
        ["coffee"] = "rbxassetid://10709805896",
        ["columns"] = "rbxassetid://10709806071",
        ["command"] = "rbxassetid://10709806226",
        ["compass"] = "rbxassetid://10709806394",
        ["copy"] = "rbxassetid://10709806552",
        ["cornerdownleft"] = "rbxassetid://10709806751",
        ["cornerdownright"] = "rbxassetid://10709806958",
        ["cornerleftdown"] = "rbxassetid://10709807134",
        ["cornerleftup"] = "rbxassetid://10709807307",
        ["cornerrightdown"] = "rbxassetid://10709807573",
        ["cornerrightup"] = "rbxassetid://10709807732",
        ["cornerupleft"] = "rbxassetid://10709807893",
        ["cornerupright"] = "rbxassetid://10709808077",
        ["cpu"] = "rbxassetid://10709808292",
        ["creditcard"] = "rbxassetid://10709808443",
        ["crop"] = "rbxassetid://10709808577",
        ["crosshair"] = "rbxassetid://10709808734",
        ["database"] = "rbxassetid://10709808934",
        ["delete"] = "rbxassetid://10709809059",
        ["disc"] = "rbxassetid://10709809249",
        ["divide"] = "rbxassetid://10709809604",
        ["dividecircle"] = "rbxassetid://10709809351",
        ["dividesquare"] = "rbxassetid://10709809478",
        ["dollar"] = "rbxassetid://10709809749",
        ["dollarsign"] = "rbxassetid://10747359862",
        ["download"] = "rbxassetid://10709810227",
        ["downloadcloud"] = "rbxassetid://10709809926",
        ["droplet"] = "rbxassetid://10709810395",
        ["edit"] = "rbxassetid://10709810708",
        ["edit2"] = "rbxassetid://10709810517",
        ["edit3"] = "rbxassetid://10709810617",
        ["external"] = "rbxassetid://10709810874",
        ["externallink"] = "rbxassetid://10747359979",
        ["eye"] = "rbxassetid://10709811152",
        ["eyeoff"] = "rbxassetid://10709811033",
        ["facebook"] = "rbxassetid://10709811305",
        ["fastforward"] = "rbxassetid://10709811463",
        ["feather"] = "rbxassetid://10709811605",
        ["figma"] = "rbxassetid://10709811727",
        ["file"] = "rbxassetid://10709812439",
        ["fileminus"] = "rbxassetid://10709811911",
        ["fileplus"] = "rbxassetid://10709812099",
        ["filetext"] = "rbxassetid://10709812274",
        ["film"] = "rbxassetid://10709812634",
        ["filter"] = "rbxassetid://10709812803",
        ["flag"] = "rbxassetid://10709812985",
        ["folder"] = "rbxassetid://10709813552",
        ["folderminus"] = "rbxassetid://10709813144",
        ["folderplus"] = "rbxassetid://10709813362",
        ["framer"] = "rbxassetid://10709813711",
        ["frown"] = "rbxassetid://10709813843",
        ["gift"] = "rbxassetid://10709813981",
        ["gitbranch"] = "rbxassetid://10709814127",
        ["gitcommit"] = "rbxassetid://10709814270",
        ["github"] = "rbxassetid://10709814421",
        ["gitlab"] = "rbxassetid://10709814591",
        ["glasses"] = "rbxassetid://10734845911",
        ["globe"] = "rbxassetid://10709814921",
        ["globe2"] = "rbxassetid://10709814734",
        ["grid"] = "rbxassetid://10709815038",
        ["grip"] = "rbxassetid://10734846307",
        ["griphorizontal"] = "rbxassetid://10734846033",
        ["gripvertical"] = "rbxassetid://10734846172",
        ["hammer"] = "rbxassetid://10734846438",
        ["hand"] = "rbxassetid://10734846595",
        ["harddrive"] = "rbxassetid://10709815259",
        ["hash"] = "rbxassetid://10709815379",
        ["haze"] = "rbxassetid://10709815520",
        ["headphones"] = "rbxassetid://10709815682",
        ["heart"] = "rbxassetid://10709815844",
        ["help"] = "rbxassetid://10709816028",
        ["helpcircle"] = "rbxassetid://10709815941",
        ["hexagon"] = "rbxassetid://10734846727",
        ["highlighter"] = "rbxassetid://10734846825",
        ["history"] = "rbxassetid://10734846940",
        ["home"] = "rbxassetid://10709816259",
        ["hourglass"] = "rbxassetid://10734847042",
        ["icecream"] = "rbxassetid://10734847165",
        ["image"] = "rbxassetid://10734847299",
        ["inbox"] = "rbxassetid://10734847400",
        ["info"] = "rbxassetid://10734847516",
        ["instagram"] = "rbxassetid://10709816407",
        ["italic"] = "rbxassetid://10734847630",
        ["key"] = "rbxassetid://10734847747",
        ["keyboard"] = "rbxassetid://10709816570",
        ["languages"] = "rbxassetid://10734847908",
        ["laptop"] = "rbxassetid://10734848019",
        ["laptop2"] = "rbxassetid://10709816749",
        ["lastfm"] = "rbxassetid://10709816934",
        ["layers"] = "rbxassetid://10734848124",
        ["layout"] = "rbxassetid://10734848237",
        ["leaf"] = "rbxassetid://10734848332",
        ["library"] = "rbxassetid://10734848443",
        ["lifebuoy"] = "rbxassetid://10709817189",
        ["lightbulb"] = "rbxassetid://10734848572",
        ["link"] = "rbxassetid://10709817569",
        ["link2"] = "rbxassetid://10709817370",
        ["linkedin"] = "rbxassetid://10709817725",
        ["list"] = "rbxassetid://10709817959",
        ["loader"] = "rbxassetid://10709818106",
        ["lock"] = "rbxassetid://10709818317",
        ["login"] = "rbxassetid://10709818447",
        ["logincircle"] = "rbxassetid://10747359006",
        ["logout"] = "rbxassetid://10709818656",
        ["logoutcircle"] = "rbxassetid://10747359135",
        ["mail"] = "rbxassetid://10709818810",
        ["map"] = "rbxassetid://10734848968",
        ["mappin"] = "rbxassetid://10734848777",
        ["maximize"] = "rbxassetid://10734849204",
        ["maximize2"] = "rbxassetid://10734849097",
        ["megaphone"] = "rbxassetid://10734849326",
        ["meh"] = "rbxassetid://10709818997",
        ["menu"] = "rbxassetid://10709819150",
        ["messagecircle"] = "rbxassetid://10709819312",
        ["messagesquare"] = "rbxassetid://10709819508",
        ["mic"] = "rbxassetid://10734849643",
        ["micoff"] = "rbxassetid://10734849513",
        ["minimize"] = "rbxassetid://10734849886",
        ["minimize2"] = "rbxassetid://10734849773",
        ["minus"] = "rbxassetid://10709820040",
        ["minuscircle"] = "rbxassetid://10709819694",
        ["minussquare"] = "rbxassetid://10709819873",
        ["monitor"] = "rbxassetid://10734896360",
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
        ["movie"] = "rbxassetid://10709820203",
        ["music"] = "rbxassetid://10709820369",
        ["navigation"] = "rbxassetid://10734900204",
        ["navigation2"] = "rbxassetid://10734900101",
        ["octagon"] = "rbxassetid://10734900318",
        ["package"] = "rbxassetid://10734900451",
        ["paintbucket"] = "rbxassetid://10747359288",
        ["paperclip"] = "rbxassetid://10734900570",
        ["pause"] = "rbxassetid://10734900886",
        ["pausecircle"] = "rbxassetid://10734900693",
        ["pen"] = "rbxassetid://10747359474",
        ["pentool"] = "rbxassetid://10734901015",
        ["percent"] = "rbxassetid://10734901183",
        ["personstanding"] = "rbxassetid://10747359668",
        ["phone"] = "rbxassetid://10734901852",
        ["phonecall"] = "rbxassetid://10734901320",
        ["phoneforwarded"] = "rbxassetid://10734901466",
        ["phoneincoming"] = "rbxassetid://10734901577",
        ["phonemissed"] = "rbxassetid://10734901677",
        ["phoneoff"] = "rbxassetid://10734901779",
        ["phoneoutgoing"] = "rbxassetid://10734901979",
        ["piechart"] = "rbxassetid://10734902115",
        ["play"] = "rbxassetid://10734902473",
        ["playcircle"] = "rbxassetid://10734902287",
        ["plus"] = "rbxassetid://10734902856",
        ["pluscircle"] = "rbxassetid://10734902606",
        ["plussquare"] = "rbxassetid://10734902739",
        ["pocket"] = "rbxassetid://10734902998",
        ["podcast"] = "rbxassetid://10747360102",
        ["pointer"] = "rbxassetid://10734903186",
        ["pound"] = "rbxassetid://10734903314",
        ["power"] = "rbxassetid://10734903670",
        ["poweroff"] = "rbxassetid://10734903535",
        ["printer"] = "rbxassetid://10734903777",
        ["radio"] = "rbxassetid://10734904060",
        ["rain"] = "rbxassetid://10747360270",
        ["recycle"] = "rbxassetid://10734904219",
        ["refreshccw"] = "rbxassetid://10734904358",
        ["refreshcw"] = "rbxassetid://10734904474",
        ["regex"] = "rbxassetid://10734904600",
        ["repeat"] = "rbxassetid://10734904896",
        ["repeat1"] = "rbxassetid://10734904749",
        ["reply"] = "rbxassetid://10734905199",
        ["replyall"] = "rbxassetid://10734905049",
        ["rewind"] = "rbxassetid://10734905347",
        ["rocket"] = "rbxassetid://10747360453",
        ["rotateccw"] = "rbxassetid://10734905484",
        ["rotatecw"] = "rbxassetid://10734905621",
        ["rss"] = "rbxassetid://10734905749",
        ["ruler"] = "rbxassetid://10747360608",
        ["save"] = "rbxassetid://10734905940",
        ["scissors"] = "rbxassetid://10734906095",
        ["screen"] = "rbxassetid://10747360760",
        ["screenoff"] = "rbxassetid://10747360931",
        ["screenon"] = "rbxassetid://10747361133",
        ["search"] = "rbxassetid://10734906293",
        ["send"] = "rbxassetid://10734906403",
        ["server"] = "rbxassetid://10734906595",
        ["settings"] = "rbxassetid://10734906752",
        ["share"] = "rbxassetid://10734907126",
        ["share2"] = "rbxassetid://10734906948",
        ["shield"] = "rbxassetid://10734907442",
        ["shieldoff"] = "rbxassetid://10734907285",
        ["shoppingbag"] = "rbxassetid://10734907560",
        ["shoppingcart"] = "rbxassetid://10747361303",
        ["shuffle"] = "rbxassetid://10734907732",
        ["sidebar"] = "rbxassetid://10734907910",
        ["skipback"] = "rbxassetid://10734908099",
        ["skipforward"] = "rbxassetid://10734908280",
        ["skull"] = "rbxassetid://10747361458",
        ["slack"] = "rbxassetid://10734908415",
        ["slash"] = "rbxassetid://10734908580",
        ["sliders"] = "rbxassetid://10734963400",
        ["slidershorizontal"] = "rbxassetid://10734963191",
        ["smartphone"] = "rbxassetid://10734963940",
        ["smartphonecharging"] = "rbxassetid://10734963671",
        ["smile"] = "rbxassetid://10734964441",
        ["smileplus"] = "rbxassetid://10734964188",
        ["snowflake"] = "rbxassetid://10734964600",
        ["sofa"] = "rbxassetid://10734964852",
        ["sortasc"] = "rbxassetid://10734965115",
        ["sortdesc"] = "rbxassetid://10734965287",
        ["speaker"] = "rbxassetid://10734965419",
        ["sprout"] = "rbxassetid://10734965572",
        ["square"] = "rbxassetid://10734965702",
        ["star"] = "rbxassetid://10734966248",
        ["starhalf"] = "rbxassetid://10734965897",
        ["staroff"] = "rbxassetid://10734966097",
        ["stethoscope"] = "rbxassetid://10734966384",
        ["sticker"] = "rbxassetid://10734972234",
        ["stickynote"] = "rbxassetid://10734972463",
        ["stopcircle"] = "rbxassetid://10734972621",
        ["stretchhorizontal"] = "rbxassetid://10734972862",
        ["stretchvertical"] = "rbxassetid://10734973130",
        ["strikethrough"] = "rbxassetid://10734973290",
        ["subscript"] = "rbxassetid://10734973457",
        ["sun"] = "rbxassetid://10734974297",
        ["sundim"] = "rbxassetid://10734973645",
        ["sunmedium"] = "rbxassetid://10734973778",
        ["sunmoon"] = "rbxassetid://10734973999",
        ["sunsnow"] = "rbxassetid://10734974130",
        ["sunrise"] = "rbxassetid://10734974522",
        ["sunset"] = "rbxassetid://10734974689",
        ["superscript"] = "rbxassetid://10734974850",
        ["swissfranc"] = "rbxassetid://10734975024",
        ["switchcamera"] = "rbxassetid://10734975214",
        ["sword"] = "rbxassetid://10734975486",
        ["swords"] = "rbxassetid://10734975692",
        ["syringe"] = "rbxassetid://10734975932",
        ["table"] = "rbxassetid://10734976230",
        ["table2"] = "rbxassetid://10734976097",
        ["tablet"] = "rbxassetid://10734976394",
        ["tag"] = "rbxassetid://10734976528",
        ["tags"] = "rbxassetid://10734976739",
        ["target"] = "rbxassetid://10734977012",
        ["tent"] = "rbxassetid://10734981750",
        ["terminal"] = "rbxassetid://10734982144",
        ["terminalsquare"] = "rbxassetid://10734981995",
        ["textcursor"] = "rbxassetid://10734982395",
        ["textcursorinput"] = "rbxassetid://10734982297",
        ["thermometer"] = "rbxassetid://10734983134",
        ["thermometersnowflake"] = "rbxassetid://10734982571",
        ["thermometersun"] = "rbxassetid://10734982771",
        ["thumbsdown"] = "rbxassetid://10734983359",
        ["thumbsup"] = "rbxassetid://10734983629",
        ["ticket"] = "rbxassetid://10734983868",
        ["timer"] = "rbxassetid://10734984606",
        ["timeroff"] = "rbxassetid://10734984138",
        ["timerreset"] = "rbxassetid://10734984355",
        ["toggleleft"] = "rbxassetid://10734984834",
        ["toggleright"] = "rbxassetid://10734985040",
        ["tornado"] = "rbxassetid://10734985247",
        ["toybrick"] = "rbxassetid://10747361919",
        ["train"] = "rbxassetid://10747362105",
        ["trash"] = "rbxassetid://10747362393",
        ["trash2"] = "rbxassetid://10747362241",
        ["treedeciduous"] = "rbxassetid://10747362534",
        ["treepine"] = "rbxassetid://10747362748",
        ["trees"] = "rbxassetid://10747363016",
        ["trendingdown"] = "rbxassetid://10747363205",
        ["trendingup"] = "rbxassetid://10747363465",
        ["triangle"] = "rbxassetid://10747363621",
        ["trophy"] = "rbxassetid://10747363809",
        ["truck"] = "rbxassetid://10747364031",
        ["tv"] = "rbxassetid://10747364593",
        ["tv2"] = "rbxassetid://10747364302",
        ["type"] = "rbxassetid://10747364761",
        ["umbrella"] = "rbxassetid://10747364971",
        ["underline"] = "rbxassetid://10747365191",
        ["undo"] = "rbxassetid://10747365484",
        ["undo2"] = "rbxassetid://10747365359",
        ["unlink"] = "rbxassetid://10747365771",
        ["unlink2"] = "rbxassetid://10747397871",
        ["unlock"] = "rbxassetid://10747366027",
        ["upload"] = "rbxassetid://10747366434",
        ["uploadcloud"] = "rbxassetid://10747366266",
        ["usb"] = "rbxassetid://10747366606",
        ["user"] = "rbxassetid://10747373176",
        ["usercheck"] = "rbxassetid://10747371901",
        ["usercog"] = "rbxassetid://10747372167",
        ["userminus"] = "rbxassetid://10747372346",
        ["userplus"] = "rbxassetid://10747372702",
        ["userx"] = "rbxassetid://10747372992",
        ["users"] = "rbxassetid://10747373426",
        ["utensils"] = "rbxassetid://10747373821",
        ["utensilscrossed"] = "rbxassetid://10747373629",
        ["venetianmask"] = "rbxassetid://10747374003",
        ["verified"] = "rbxassetid://10747374131",
        ["vibrate"] = "rbxassetid://10747374489",
        ["vibrateoff"] = "rbxassetid://10747374269",
        ["video"] = "rbxassetid://10747374938",
        ["videooff"] = "rbxassetid://10747374721",
        ["view"] = "rbxassetid://10747375132",
        ["voicemail"] = "rbxassetid://10747375281",
        ["volume"] = "rbxassetid://10747376008",
        ["volume1"] = "rbxassetid://10747375450",
        ["volume2"] = "rbxassetid://10747375679",
        ["volumex"] = "rbxassetid://10747375880",
        ["wallet"] = "rbxassetid://10747376205",
        ["wand"] = "rbxassetid://10747376565",
        ["wand2"] = "rbxassetid://10747376349",
        ["watch"] = "rbxassetid://10747376722",
        ["waves"] = "rbxassetid://10747376931",
        ["webcam"] = "rbxassetid://10747381992",
        ["wifi"] = "rbxassetid://10747382504",
        ["wifioff"] = "rbxassetid://10747382268",
        ["wind"] = "rbxassetid://10747382750",
        ["wraptext"] = "rbxassetid://10747383065",
        ["wrench"] = "rbxassetid://10747383470",
        ["x"] = "rbxassetid://10747384394",
        ["xcircle"] = "rbxassetid://10747383819",
        ["xoctagon"] = "rbxassetid://10747384037",
        ["xsquare"] = "rbxassetid://10747384217",
        ["youtube"] = "rbxassetid://10747384552",
        ["zap"] = "rbxassetid://10747384679",
        ["zapoff"] = "rbxassetid://10747384839",
        ["zoomin"] = "rbxassetid://10747384967",
        ["zoomout"] = "rbxassetid://10747385061"
    },
    Windows = {},
    CurrentTheme = nil
}

print("[RainLib] Carregando serviços...")

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local function tween(obj, info, properties)
    local tween = TweenService:Create(obj, info or TweenInfo.new(0.3), properties)
    tween:Play()
    return tween
end

print("[RainLib] Inicializando...")
local success, err = pcall(function()
    RainLib.ScreenGui = Instance.new("ScreenGui")
    RainLib.ScreenGui.Name = "RainLib"
    RainLib.ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui", 5)
    RainLib.ScreenGui.ResetOnSpawn = false
    RainLib.ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    RainLib.CurrentTheme = RainLib.Themes.Dark
    RainLib.Notifications = Instance.new("Frame")
    RainLib.Notifications.Size = UDim2.new(0, 300, 1, 0)
    RainLib.Notifications.Position = UDim2.new(1, -310, 0, 0)
    RainLib.Notifications.BackgroundTransparency = 1
    RainLib.Notifications.Parent = RainLib.ScreenGui
end)
if not success then
    return nil -- Sai silenciosamente se der erro
end
print("[RainLib] Inicializado com sucesso!")

function RainLib:Window(options)
    print("[RainLib] Criando janela...")
    local window = {}
    options = options or {}
    
    window.Title = options.Title or "Rain Lib"
    window.Size = options.Size or UDim2.new(0, 500, 0, 350)
    window.Position = options.Position or UDim2.new(0.5, -250, 0.5, -175)
    window.Minimized = false
    window.Tabs = {}
    window.CurrentTabIndex = 1
    window.MinimizeButton = nil
    
    local success, err = pcall(function()
        window.MainFrame = Instance.new("Frame")
        window.MainFrame.Size = window.Size
        window.MainFrame.Position = window.Position
        window.MainFrame.BackgroundColor3 = RainLib.CurrentTheme.Background
        window.MainFrame.ClipsDescendants = true
        window.MainFrame.Parent = RainLib.ScreenGui
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 10)
        corner.Parent = window.MainFrame
        
        local shadow = Instance.new("ImageLabel")
        shadow.Size = UDim2.new(1, 20, 1, 20)
        shadow.Position = UDim2.new(0, -10, 0, -10)
        shadow.BackgroundTransparency = 1
        shadow.Image = "rbxassetid://1316045217"
        shadow.ImageTransparency = 0.7
        shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
        shadow.ScaleType = Enum.ScaleType.Slice
        shadow.SliceCenter = Rect.new(10, 10, 118, 118)
        shadow.Parent = window.MainFrame
        
        window.TitleBar = Instance.new("Frame")
        window.TitleBar.Size = UDim2.new(1, 0, 0, 40)
        window.TitleBar.BackgroundColor3 = RainLib.CurrentTheme.Secondary
        window.TitleBar.Parent = window.MainFrame
        
        window.TitleLabel = Instance.new("TextLabel")
        window.TitleLabel.Size = UDim2.new(1, -40, 1, 0)
        window.TitleLabel.Position = UDim2.new(0, 10, 0, 0)
        window.TitleLabel.BackgroundTransparency = 1
        window.TitleLabel.Text = window.Title
        window.TitleLabel.TextColor3 = RainLib.CurrentTheme.Text
        window.TitleLabel.Font = Enum.Font.GothamBold
        window.TitleLabel.TextSize = 16
        window.TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
        window.TitleLabel.Parent = window.TitleBar
        
        window.CloseButton = Instance.new("TextButton")
        window.CloseButton.Size = UDim2.new(0, 30, 0, 30)
        window.CloseButton.Position = UDim2.new(1, -35, 0, 5)
        window.CloseButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        window.CloseButton.Text = "X"
        window.CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        window.CloseButton.Font = Enum.Font.SourceSansBold
        window.CloseButton.TextSize = 16
        window.CloseButton.Parent = window.TitleBar
        
        local closeCorner = Instance.new("UICorner")
        closeCorner.CornerRadius = UDim.new(0, 8)
        closeCorner.Parent = window.CloseButton
        
        window.TabContainer = Instance.new("ScrollingFrame")
        window.TabContainer.Size = UDim2.new(0, 150, 1, -40)
        window.TabContainer.Position = UDim2.new(0, 0, 0, 40)
        window.TabContainer.BackgroundColor3 = RainLib.CurrentTheme.Secondary
        window.TabContainer.ScrollBarThickness = 0
        window.TabContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
        window.TabContainer.Parent = window.MainFrame
        
        window.TabIndicator = Instance.new("Frame")
        window.TabIndicator.Size = UDim2.new(0, 3, 0, 40)
        window.TabIndicator.BackgroundColor3 = RainLib.CurrentTheme.Accent
        window.TabIndicator.Position = UDim2.new(0, 0, 0, 5)
        window.TabIndicator.Parent = window.TabContainer
    end)
    if not success then
        return nil -- Sai silenciosamente se der erro
    end
    print("[RainLib] Janela criada!")
    
    window.CloseButton.MouseButton1Click:Connect(function()
        if window.MinimizeButton then
            window.MinimizeButton:Destroy()
            window.MinimizeButton = nil
            print("[RainLib] Botão de minimizar destruído")
        end
        window.MainFrame:Destroy()
        print("[RainLib] Janela destruída")
    end)
    
    local dragging, dragStart, startPos
    window.TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = window.MainFrame.Position
            print("[RainLib] Começando a arrastar janela")
        end
    end)
    
    window.TitleBar.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
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
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
            print("[RainLib] Parou de arrastar janela")
        end
    end)
    
    function window:Minimize(options)
        print("[RainLib] Criando botão de minimizar...")
        options = options or {}
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(0, 100, 0, 30)
        button.Position = UDim2.new(0, 10, 0, 10) -- Posição fixa
        button.Text = options.Text1 or "Close" -- Texto inicial quando a janela tá aberta
        button.BackgroundColor3 = RainLib.CurrentTheme.Accent
        button.TextColor3 = RainLib.CurrentTheme.Text
        button.Font = Enum.Font.SourceSansBold
        button.TextSize = 16
        button.BackgroundTransparency = options.BackgroundTransparency or 0
        button.Parent = RainLib.ScreenGui
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = options.CornerRadius or UDim.new(0, 8)
        corner.Parent = button
        
        button.MouseButton1Click:Connect(function()
            window.MainFrame.Visible = not window.MainFrame.Visible
            button.Text = window.MainFrame.Visible and (options.Text1 or "Close") or (options.Text2 or "Open")
            print("[RainLib] GUI " .. (window.MainFrame.Visible and "aberto" or "fechado"))
        end)
        
        if options.Draggable then
            local draggingButton, dragStartButton, startPosButton
            button.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    draggingButton = true
                    dragStartButton = input.Position
                    startPosButton = button.Position
                    print("[RainLib] Começando a arrastar botão")
                end
            end)
            
            button.InputChanged:Connect(function(input)
                if draggingButton and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
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
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    draggingButton = false
                    print("[RainLib] Parou de arrastar botão")
                end
            end)
        end
        
        window.MinimizeButton = button
        return button
    end

    function window:Tab(options)
    print("[RainLib] Criando aba...")
    local tab = {}
    options = options or {}
    tab.Name = options.Name or "Tab"
    tab.Icon = options.Icon or nil
    tab.ElementsPerRow = options.ElementsPerRow or 1
    tab.ElementCount = 0
    
    tab.Content = Instance.new("ScrollingFrame")
    tab.Content.Size = UDim2.new(1, -160, 1, -50)
    tab.Content.Position = UDim2.new(0, 155, 0, 45)
    tab.Content.BackgroundTransparency = 1
    tab.Content.ScrollBarThickness = 5
    tab.Content.CanvasPosition = Vector2.new(0, 0)
    tab.Content.Visible = false
    tab.Content.Parent = window.MainFrame
    
    tab.Container = Instance.new("Frame")
    tab.Container.Size = UDim2.new(1, -10, 1, -10)
    tab.Container.Position = UDim2.new(0, 5, 0, 5)
    tab.Container.BackgroundTransparency = 1
    tab.Container.Parent = tab.Content
    
    local containerCorner = Instance.new("UICorner")
    containerCorner.CornerRadius = UDim.new(0, 8)
    containerCorner.Parent = tab.Container
    
    local containerStroke = Instance.new("UIStroke")
    containerStroke.Thickness = 1
    containerStroke.Color = Color3.fromRGB(0, 0, 0)
    containerStroke.Parent = tab.Container
    
    tab.Button = Instance.new("TextButton")
    tab.Button.Size = UDim2.new(1, -10, 0, 40)
    tab.Button.Position = UDim2.new(0, 5, 0, #window.Tabs * 45 + 5)
    tab.Button.BackgroundTransparency = 1
    tab.Button.Text = tab.Icon and "" or tab.Name
    tab.Button.TextColor3 = RainLib.CurrentTheme.Text
    tab.Button.Font = Enum.Font.SourceSansBold
    tab.Button.TextSize = 16
    tab.Button.TextXAlignment = Enum.TextXAlignment.Left
    tab.Button.Parent = window.TabContainer
    window.TabContainer.CanvasSize = UDim2.new(0, 0, 0, #window.Tabs * 45 + 50)
    
    if tab.Icon then
        local icon = Instance.new("ImageLabel")
        icon.Size = UDim2.new(0, 24, 0, 24)
        icon.Position = UDim2.new(0, 5, 0.5, -12)
        icon.BackgroundTransparency = 1
        icon.Image = RainLib.Icons[tab.Icon] or tab.Icon
        icon.Parent = tab.Button
        
        local text = Instance.new("TextLabel")
        text.Size = UDim2.new(1, -40, 1, 0)
        text.Position = UDim2.new(0, 35, 0, 0)
        text.BackgroundTransparency = 1
        text.Text = tab.Name
        text.TextColor3 = RainLib.CurrentTheme.Text
        text.Font = Enum.Font.SourceSansBold
        text.TextSize = 16
        text.TextXAlignment = Enum.TextXAlignment.Left
        text.Parent = tab.Button
    else
        tab.Button.Position = UDim2.new(0, 15, 0, #window.Tabs * 45 + 5)
    end
    
    table.insert(window.Tabs, tab)
    
    local function selectTab(index)
        for i, t in pairs(window.Tabs) do
            if i == index then
                t.Content.Visible = true
                tween(t.Content, TweenInfo.new(0.2), {BackgroundTransparency = 1})
                tween(window.TabIndicator, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(0, 0, 0, (i-1) * 45 + 5)})
                window.CurrentTabIndex = i
                print("[RainLib] Aba selecionada: " .. t.Name)
            else
                tween(t.Content, TweenInfo.new(0.2), {BackgroundTransparency = 1})
                task.delay(0.2, function() t.Content.Visible = false end)
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
    
    -- Função ajustada para calcular posição com base em ElementsPerRow
    local function getNextPosition(elementSize)
        local row = math.floor(tab.ElementCount / tab.ElementsPerRow)
        local col = tab.ElementCount % tab.ElementsPerRow
        local totalWidth = tab.Container.AbsoluteSize.X - 10 -- Largura disponível menos margens
        local elementWidth = totalWidth / tab.ElementsPerRow -- Largura por elemento
        local xOffset = 10 + col * elementWidth
        local yOffset = 10 + row * (elementSize.Y.Offset + 10)
        tab.ElementCount = tab.ElementCount + 1
        
        -- Ajusta o CanvasSize dinamicamente
        tab.Content.CanvasSize = UDim2.new(0, 0, 0, yOffset + elementSize.Y.Offset + 10)
        return UDim2.new(0, xOffset, 0, yOffset)
        end
    
    function tab:Button(options)
        local buttonSize = options.Size or UDim2.new(0, 100, 0, 30)
        local button = Instance.new("TextButton")
        button.Size = buttonSize
        button.Position = getNextPosition(buttonSize)
        button.Text = options.Text or "Button"
        button.BackgroundColor3 = options.BackgroundColor3 or RainLib.CurrentTheme.Accent
        button.TextColor3 = RainLib.CurrentTheme.Text
        button.Font = Enum.Font.SourceSansBold
        button.TextSize = 16
        button.Parent = tab.Container
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 8)
        corner.Parent = button
        
        button.MouseButton1Click:Connect(options.Callback or function() end)
        return button
    end
    
    function tab:Textbox(options)
        local textboxSize = options.Size or UDim2.new(0, 100, 0, 30)
        local textbox = Instance.new("TextBox")
        textbox.Size = textboxSize
        textbox.Position = getNextPosition(textboxSize)
        textbox.Text = options.Text or ""
        textbox.BackgroundColor3 = options.BackgroundColor3 or RainLib.CurrentTheme.Secondary
        textbox.TextColor3 = RainLib.CurrentTheme.Text
        textbox.Font = Enum.Font.SourceSans
        textbox.TextSize = 16
        textbox.Parent = tab.Container
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 8)
        corner.Parent = textbox
        
        textbox.FocusLost:Connect(function(enterPressed)
            if enterPressed and options.Callback then
                options.Callback(textbox.Text)
            end
        end)
        
        return textbox
    end
    
    function tab:Toggle(options)
        local toggleSize = options.Size or UDim2.new(0, 100, 0, 30)
        local toggle = { Value = options.Default or false }
        local frame = Instance.new("Frame")
        frame.Size = toggleSize
        frame.Position = getNextPosition(toggleSize)
        frame.BackgroundColor3 = RainLib.CurrentTheme.Secondary
        frame.Parent = tab.Container
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 8)
        corner.Parent = frame
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(0, 70, 1, 0)
        label.Text = options.Text or "Toggle"
        label.BackgroundTransparency = 1
        label.TextColor3 = RainLib.CurrentTheme.Text
        label.Font = Enum.Font.SourceSans
        label.TextSize = 16
        label.Parent = frame
        
        local indicator = Instance.new("Frame")
        indicator.Size = UDim2.new(0, 20, 0, 20)
        indicator.Position = UDim2.new(1, -25, 0.5, -10)
        indicator.BackgroundColor3 = toggle.Value and RainLib.CurrentTheme.Accent or RainLib.CurrentTheme.Disabled
        indicator.Parent = frame
        
        local indicatorCorner = Instance.new("UICorner")
        indicatorCorner.CornerRadius = UDim.new(0, 5)
        indicatorCorner.Parent = indicator
        
        frame.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                toggle.Value = not toggle.Value
                tween(indicator, TweenInfo.new(0.2), {BackgroundColor3 = toggle.Value and RainLib.CurrentTheme.Accent or RainLib.CurrentTheme.Disabled})
                if options.Callback then
                    options.Callback(toggle.Value)
                end
            end
        end)
        
        return toggle
    end
    
    function tab:Slider(options)
        local sliderSize = options.Size or UDim2.new(0, 200, 0, 40)
        local slider = { Value = options.Default or 0 }
        local frame = Instance.new("Frame")
        frame.Size = sliderSize
        frame.Position = getNextPosition(sliderSize)
        frame.BackgroundColor3 = RainLib.CurrentTheme.Secondary
        frame.Parent = tab.Container
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 8)
        corner.Parent = frame
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(0, 100, 0, 20)
        label.Text = options.Text or "Slider"
        label.BackgroundTransparency = 1
        label.TextColor3 = RainLib.CurrentTheme.Text
        label.Font = Enum.Font.SourceSans
        label.TextSize = 16
        label.Parent = frame
        
        local valueLabel = Instance.new("TextLabel")
        valueLabel.Size = UDim2.new(0, 50, 0, 20)
        valueLabel.Position = UDim2.new(1, -60, 0, 0)
        valueLabel.Text = tostring(slider.Value)
        valueLabel.BackgroundTransparency = 1
        valueLabel.TextColor3 = RainLib.CurrentTheme.Text
        valueLabel.Font = Enum.Font.SourceSans
        valueLabel.TextSize = 16
        valueLabel.Parent = frame
        
        local bar = Instance.new("Frame")
        bar.Size = UDim2.new(1, -10, 0, 10)
        bar.Position = UDim2.new(0, 5, 0, 25)
        bar.BackgroundColor3 = RainLib.CurrentTheme.Disabled
        bar.Parent = frame
        
        local fill = Instance.new("Frame")
        fill.Size = UDim2.new(slider.Value / (options.Max or 100), 0, 1, 0)
        fill.BackgroundColor3 = RainLib.CurrentTheme.Accent
        fill.Parent = bar
        
        local cornerBar = Instance.new("UICorner")
        cornerBar.CornerRadius = UDim.new(0, 5)
        cornerBar.Parent = bar
        
        local cornerFill = Instance.new("UICorner")
        cornerFill.CornerRadius = UDim.new(0, 5)
        cornerFill.Parent = fill
        
        local dragging
        bar.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
            end
        end)
        
        bar.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
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
        local dropdownSize = options.Size or UDim2.new(0, 150, 0, 30)
        local dropdown = { Value = options.Default or options.Options[1] }
        local frame = Instance.new("Frame")
        frame.Size = dropdownSize
        frame.Position = getNextPosition(dropdownSize)
        frame.BackgroundColor3 = RainLib.CurrentTheme.Secondary
        frame.Parent = tab.Container
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 8)
        corner.Parent = frame
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -30, 1, 0)
        label.Text = dropdown.Value
        label.BackgroundTransparency = 1
        label.TextColor3 = RainLib.CurrentTheme.Text
        label.Font = Enum.Font.SourceSans
        label.TextSize = 16
        label.Parent = frame
        
        local arrow = Instance.new("TextLabel")
        arrow.Size = UDim2.new(0, 20, 1, 0)
        arrow.Position = UDim2.new(1, -25, 0, 0)
        arrow.Text = "▼"
        arrow.BackgroundTransparency = 1
        arrow.TextColor3 = RainLib.CurrentTheme.Text
        arrow.Font = Enum.Font.SourceSans
        arrow.TextSize = 16
        arrow.Parent = frame
        
        local list = Instance.new("Frame")
        list.Size = UDim2.new(1, 0, 0, #options.Options * 30)
        list.Position = UDim2.new(0, 0, 1, 5)
        list.BackgroundColor3 = RainLib.CurrentTheme.Secondary
        list.Visible = false
        list.Parent = frame
        
        local listCorner = Instance.new("UICorner")
        listCorner.CornerRadius = UDim.new(0, 8)
        listCorner.Parent = list
        
        for i, opt in ipairs(options.Options) do
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, 0, 0, 30)
            btn.Position = UDim2.new(0, 0, 0, (i-1) * 30)
            btn.Text = opt
            btn.BackgroundTransparency = 1
            btn.TextColor3 = RainLib.CurrentTheme.Text
            btn.Font = Enum.Font.SourceSans
            btn.TextSize = 16
            btn.Parent = list
            
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
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                list.Visible = not list.Visible
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
    print("[RainLib] Criando notificação...")
    local success, err = pcall(function()
        local notification = Instance.new("Frame")
        notification.Size = UDim2.new(0, 280, 0, 80)
        notification.Position = UDim2.new(0, 10, 0, (#RainLib.Notifications:GetChildren() - 1) * 90 + 10)
        notification.BackgroundColor3 = RainLib.CurrentTheme.Background
        notification.Parent = RainLib.Notifications
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 8)
        corner.Parent = notification
        
        local title = Instance.new("TextLabel")
        title.Size = UDim2.new(1, -10, 0, 20)
        title.Position = UDim2.new(0, 5, 0, 5)
        title.Text = options.Title or "Notification"
        title.BackgroundTransparency = 1
        title.TextColor3 = RainLib.CurrentTheme.Text
        title.Font = Enum.Font.GothamBold
        title.TextSize = 16
        title.Parent = notification
        
        local message = Instance.new("TextLabel")
        message.Size = UDim2.new(1, -10, 0, 40)
        message.Position = UDim2.new(0, 5, 0, 30)
        message.Text = options.Message or "Message"
        message.BackgroundTransparency = 1
        message.TextColor3 = RainLib.CurrentTheme.Text
        message.Font = Enum.Font.SourceSans
        message.TextSize = 14
        message.TextWrapped = true
        message.Parent = notification
        
        tween(notification, TweenInfo.new(0.5), {Position = UDim2.new(0, 10, 0, (#RainLib.Notifications:GetChildren() - 1) * 90 + 10)})
        task.wait(options.Duration or 3)
        tween(notification, TweenInfo.new(0.5), {Position = UDim2.new(1, 10, 0, notification.Position.Y.Offset)}).Completed:Connect(function()
            notification:Destroy()
            print("[RainLib] Notificação removida")
        end)
    end)
    -- Sem warn, ignora erros silenciosamente
end

function RainLib:SetTheme(theme)
    print("[RainLib] Mudando tema...")
    local success, err = pcall(function()
        RainLib.CurrentTheme = theme
        for _, window in pairs(RainLib.Windows) do
            window.MainFrame.BackgroundColor3 = theme.Background
            window.TitleBar.BackgroundColor3 = theme.Secondary
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
                    if child:IsA("TextButton") or child:IsA("TextBox") then
                        child.BackgroundColor3 = theme.Accent
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
    end)
    if success then
        print("[RainLib] Tema mudado com sucesso!")
    end
    -- Sem warn, ignora erros silenciosamente
end

print("[RainLib] Biblioteca carregada!")
return RainLib
