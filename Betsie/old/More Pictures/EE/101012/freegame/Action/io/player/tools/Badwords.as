package io.player.tools
{

    public class Badwords extends Object
    {
        public static var removeBadWords:Boolean = false;
        public static var badwordReplacement:String = "****";
        private static var badwords:Array = "ahole*,anus*,arse*,arss*,ashole*,ass,asshole,asswipe,ballsdeep,*bastard*,*basterd*,*bassterd*,*biatch*,*bitch*,blowjob,*bollock*,boner,*boob*,breast*,bukkak*,butthole*,buttwipe*,carpetmunch*,chink*,chode*,choad*,clit*,*cnts*,cock*,cok,cokbite*,cokhead*,cokjock*,cokmunch*,coks,coksuck*,coksmoke*,crap+,cum*,cunnie*,cunnilingus*,cunny*,*cunt*,*dammit*,dick,dik,dike*,diks,dildo*,douche*,doosh*,dooch*,*dumbars*,*dumbass*,*dumars*,*dumass*,edjaculat*,ejacculat*,ejackulat*,ejaculat*,ejaculit*,ejakulat*,enema*,faeces*,fag*,*fatars*,*fatass*,*fcuk*,feces*,felatio*feltch*,flikker*,*foreskin*,*forskin*,*fuck*,*fudgepack*,*fuk*,gay*,*handjob*,hardon*,*hiroshima*,*hitler*,hoar,homo,honkey*,hoor,hoore,hoores,hoors,horing,hooring,humping*,*jackars*,*jackass*,*jackoff*,*jerkoff*,jiss*,*jizz*,kike*,knobjock*,knobrid*,knobsuck*,kooch*,kootch*,kraut*,kunt*,kyke*,*lardars*,*lardass*,*lesbian*,lesbo*,lessie*,lezzie*,lezzy*,*masturbat*,minge*,minging*,mofo,muffdive*,munge*,munging*,*nazi*,*negro*,niga,nigg*,niglet*,nutsack*,orafis,*orgasm*,*orgasum*,oriface,orifice,orifiss,paci,pacie,packi,packie,packy,paki,pakie,paky,panooch,pecker,peanis,peeenis,peeenus,peeenusss,peenis,peenus,peinus,penas,*penis*,penus,phuc,phuck*,phuk*,pissflap*,polac,polack*,polak*,polesmok*,pollac,pollack*,pollak*,polloc,pollock*,pollok*,poon,poonani,poonanni,poonanny,poonany,poontang,poop*,porn*,preteen*,pula,pule,punani,punanni,punanny,punany,pusse,pussee,pussie,pussies,pussy,pussying,pussylick,pussysuck,poossy*,poossie*,puuke,puuker,queef*,queer*,qweer*,qweir*,recktum*,rectum*,renob,retard*,rimming*,rimjob*,ruski*,sadist*,scank*,schlong*,schmuck*,screw*,scrote*,scrotum*,semen*,sex*,shemale*,shat,*shit*,skank*,*slut*,spic,spick,spik,stalin*,tard,teets,testic*,tit,tits,titt,titty*,tittie*,twat*,*vagina*,*vaginna*,*vaggina*,*vaagina*,*vagiina*,vag,vags,vaj,vajs,*vajina*,*vulva*,wank*,*whoar*,whoe,*whor*,*B=D*,*B==D*,*B===*".toLowerCase().split(",");

        public function Badwords()
        {
            return;
        }// end function

        public static function Filter(param1:String) : String
        {
            var _loc_2:* = param1;
            _loc_2 = _loc_2.replace(/(\s){2,}""(\s){2,}/mgi, " ");
            var _loc_3:* = _loc_2.split(" ");
            var _loc_4:Boolean = false;
            var _loc_5:int = 0;
            while (_loc_5 < (_loc_3.length - 1))
            {
                
                if ((_loc_3[_loc_5].length == 1 || _loc_4) && _loc_3[(_loc_5 + 1)].length == 1)
                {
                    _loc_3[_loc_5] = _loc_3[_loc_5] + _loc_3[(_loc_5 + 1)];
                    _loc_3.splice((_loc_5 + 1), 1);
                    _loc_5 = _loc_5 - 1;
                    _loc_4 = true;
                }
                else
                {
                    _loc_4 = false;
                }
                _loc_5++;
            }
            var _loc_6:Boolean = false;
            var _loc_7:int = 0;
            while (_loc_7 < _loc_3.length)
            {
                
                if (isBadword(_loc_3[_loc_7]))
                {
                    if (removeBadWords)
                    {
                        _loc_3.splice(_loc_7--, 1);
                    }
                    else
                    {
                        _loc_3[_loc_7] = badwordReplacement;
                    }
                    _loc_6 = true;
                }
                _loc_7++;
            }
            if (_loc_6)
            {
                return _loc_3.join(" ");
            }
            return param1;
        }// end function

        private static function isBadword(param1:String, param2:Boolean = false) : Boolean
        {
            var _loc_4:String = null;
            var _loc_5:String = null;
            param1 = param1.toLowerCase();
            var _loc_3:int = 0;
            while (_loc_3 < badwords.length)
            {
                
                _loc_5 = badwords[_loc_3];
                if (badwords[_loc_3].charAt((_loc_5.length - 1)) == "*" && _loc_5.charAt(0) == "*")
                {
                    _loc_5 = _loc_5.substr(1).substr(0, _loc_5.length - 2);
                    if (param1.indexOf(_loc_5) != -1)
                    {
                        return true;
                    }
                }
                else if (_loc_5.charAt(0) == "*")
                {
                    _loc_5 = _loc_5.substr(1);
                    if (param1.length >= _loc_5.length && param1.indexOf(_loc_5) == param1.length - _loc_5.length)
                    {
                        return true;
                    }
                }
                else if (_loc_5.charAt(0) == "+")
                {
                    _loc_5 = _loc_5.substr(1);
                    if (param1.length > _loc_5.length && param1.indexOf(_loc_5) == param1.length - _loc_5.length)
                    {
                        return true;
                    }
                }
                else if (_loc_5.charAt((_loc_5.length - 1)) == "*")
                {
                    _loc_5 = _loc_5.substr(0, (_loc_5.length - 1));
                    if (param1.indexOf(_loc_5) == 0)
                    {
                        return true;
                    }
                }
                else if (param1.length >= _loc_5.length && _loc_5.charAt((_loc_5.length - 1)) == "+")
                {
                    _loc_5 = _loc_5.substr(0, (_loc_5.length - 1));
                    if (param1.length > _loc_5.length && param1.indexOf(_loc_5) == 0)
                    {
                        return true;
                    }
                }
                else if (param1 == _loc_5)
                {
                    return true;
                }
                _loc_3++;
            }
            if (param2)
            {
                return false;
            }
            if (isBadword(param1.replace(/[^\w| ]""[^\w| ]/mgi, ""), true))
            {
                return true;
            }
            _loc_4 = param1.replace(/[^\w| ]""[^\w| ]/mgi, " ");
            if (_loc_4 != param1 && Filter(_loc_4) != _loc_4)
            {
                return true;
            }
            _loc_4 = param1;
            _loc_4 = _loc_4.replace(/\$""\$/mgi, "s");
            _loc_4 = _loc_4.replace(/5""5/mgi, "s");
            _loc_4 = _loc_4.replace(/3""3/mgi, "b");
            _loc_4 = _loc_4.replace(/\!""\!/mgi, "l");
            _loc_4 = _loc_4.replace(/0""0/mgi, "o");
            _loc_4 = _loc_4.replace(/1""1/mgi, "i");
            _loc_4 = _loc_4.replace(/\#""\#/mgi, "h");
            _loc_4 = _loc_4.replace(/€""€/mgi, "e");
            _loc_4 = _loc_4.replace(/\(""\(/mgi, "c");
            if (isBadword(_loc_4, true))
            {
                return true;
            }
            _loc_4 = _loc_4.replace(/z""z/mgi, "s");
            if (isBadword(_loc_4, true))
            {
                return true;
            }
            return false;
        }// end function

    }
}
