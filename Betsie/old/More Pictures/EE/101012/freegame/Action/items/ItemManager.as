package items
{
    import __AS3__.vec.*;
    import blitter.*;
    import flash.display.*;
    import flash.filters.*;
    import flash.geom.*;
    import flash.media.*;

    public class ItemManager extends Object
    {
        private static var smiliesBM:Class = ItemManager_smiliesBM;
        public static var smiliesBMD:BitmapData = new smiliesBM().bitmapData;
        private static var shopitems131BM:Class = ItemManager_shopitems131BM;
        public static var shopitems131BMD:BitmapData = new shopitems131BM().bitmapData;
        private static var shopitems227BM:Class = ItemManager_shopitems227BM;
        public static var shopitems227BMD:BitmapData = new shopitems227BM().bitmapData;
        private static var shopitems323BM:Class = ItemManager_shopitems323BM;
        public static var shopitems323BMD:BitmapData = new shopitems323BM().bitmapData;
        private static var shopitemsOtherBM:Class = ItemManager_shopitemsOtherBM;
        public static var shopitemsOtherBMD:BitmapData = new shopitemsOtherBM().bitmapData;
        private static var forgroundBricksBM:Class = ItemManager_forgroundBricksBM;
        private static var forgroundBricksBMD:BitmapData = new forgroundBricksBM().bitmapData;
        private static var decorationsBM:Class = ItemManager_decorationsBM;
        private static var decorationsBMD:BitmapData = new decorationsBM().bitmapData;
        private static var backgroundBricksBM:Class = ItemManager_backgroundBricksBM;
        private static var backgroundBricksBMD:BitmapData = new backgroundBricksBM().bitmapData;
        private static var potionBM:Class = ItemManager_potionBM;
        public static var potionBMD:BitmapData = new potionBM().bitmapData;
        static var secretBricksBM:Class = ItemManager_secretBricksBM;
        private static var secretBricksBMD:BitmapData = new secretBricksBM().bitmapData;
        static var coinBM:Class = ItemManager_coinBM;
        private static var coinBMD:BitmapData = new coinBM().bitmapData;
        static var bonusCoinBM:Class = ItemManager_bonusCoinBM;
        private static var bonusCoinBMD:BitmapData = new bonusCoinBM().bitmapData;
        static var coinShadowBM:Class = ItemManager_coinShadowBM;
        private static var coinShadowBMD:BitmapData = new coinShadowBM().bitmapData;
        static var bonusCoinShadowBM:Class = ItemManager_bonusCoinShadowBM;
        private static var bonusCoinShadowBMD:BitmapData = new bonusCoinShadowBM().bitmapData;
        static var waterBM:Class = ItemManager_waterBM;
        private static var waterBMD:BitmapData = new waterBM().bitmapData;
        static var waveBM:Class = ItemManager_waveBM;
        private static var waveBMD:BitmapData = new waveBM().bitmapData;
        static var completeBM:Class = ItemManager_completeBM;
        private static var completeBMD:BitmapData = new completeBM().bitmapData;
        static var doorsBM:Class = ItemManager_doorsBM;
        private static var doorsBMD:BitmapData = new doorsBM().bitmapData;
        static var doorstimeBM:Class = ItemManager_doorstimeBM;
        private static var doorstimeBMD:BitmapData = new doorstimeBM().bitmapData;
        static var portalBM:Class = ItemManager_portalBM;
        private static var portalBMD:BitmapData = new portalBM().bitmapData;
        static var diamondBM:Class = ItemManager_diamondBM;
        private static var diamondBMD:BitmapData = new diamondBM().bitmapData;
        static var cakeBM:Class = ItemManager_cakeBM;
        private static var cakeBMD:BitmapData = new cakeBM().bitmapData;
        static var pianoBlinkBM:Class = ItemManager_pianoBlinkBM;
        private static var pianoBlinkBMD:BitmapData = new pianoBlinkBM().bitmapData;
        static var drumBlinkBM:Class = ItemManager_drumBlinkBM;
        private static var drumsBlinkBMD:BitmapData = new drumBlinkBM().bitmapData;
        static var piano01:Class = ItemManager_piano01;
        static var piano02:Class = ItemManager_piano02;
        static var piano03:Class = ItemManager_piano03;
        static var piano04:Class = ItemManager_piano04;
        static var piano05:Class = ItemManager_piano05;
        static var piano06:Class = ItemManager_piano06;
        static var piano07:Class = ItemManager_piano07;
        static var piano08:Class = ItemManager_piano08;
        static var piano09:Class = ItemManager_piano09;
        static var piano10:Class = ItemManager_piano10;
        static var piano11:Class = ItemManager_piano11;
        static var piano12:Class = ItemManager_piano12;
        static var piano13:Class = ItemManager_piano13;
        static var piano14:Class = ItemManager_piano14;
        static var piano15:Class = ItemManager_piano15;
        static var piano16:Class = ItemManager_piano16;
        static var piano17:Class = ItemManager_piano17;
        static var piano18:Class = ItemManager_piano18;
        static var piano19:Class = ItemManager_piano19;
        static var piano20:Class = ItemManager_piano20;
        static var piano21:Class = ItemManager_piano21;
        static var piano22:Class = ItemManager_piano22;
        static var piano23:Class = ItemManager_piano23;
        static var piano24:Class = ItemManager_piano24;
        static var piano25:Class = ItemManager_piano25;
        static var drums01:Class = ItemManager_drums01;
        static var drums02:Class = ItemManager_drums02;
        static var drums03:Class = ItemManager_drums03;
        static var drums04:Class = ItemManager_drums04;
        static var drums05:Class = ItemManager_drums05;
        static var drums06:Class = ItemManager_drums06;
        static var drums07:Class = ItemManager_drums07;
        static var drums08:Class = ItemManager_drums08;
        static var drums09:Class = ItemManager_drums09;
        static var drums10:Class = ItemManager_drums10;
        public static var pianoSounds:Vector.<Sound> = new Vector.<Sound>;
        public static var drumSounds:Vector.<Sound> = new Vector.<Sound>;
        private static var coinDoorsBMD:BitmapData = new BitmapData(1800, 18, true, 0);
        private static var coinGatesBMD:BitmapData = new BitmapData(1800, 18, true, 0);
        public static var smilies:Vector.<ItemSmiley> = new Vector.<ItemSmiley>;
        public static var potions:Vector.<ItemPotion> = new Vector.<ItemPotion>;
        public static var brickPackages:Vector.<ItemBrickPackage> = new Vector.<ItemBrickPackage>;
        public static var bmdBricks:Vector.<BitmapData> = new Vector.<BitmapData>(1001);
        public static var bricks:Vector.<ItemBrick> = new Vector.<ItemBrick>(1001);
        public static var sprDoors:BlSprite = new BlSprite(doorsBMD, 0, 0, 16, 16, doorsBMD.width / 16);
        public static var sprDoorsTime:BlSprite = new BlSprite(doorstimeBMD, 0, 0, 16, 16, doorstimeBMD.width / 16);
        public static var sprSecret:BlSprite = new BlSprite(secretBricksBMD, 0, 0, 16, 16, secretBricksBMD.width / 16);
        public static var sprPortal:BlSprite = new BlSprite(portalBMD, 0, 0, 16, 16, portalBMD.width / 16);
        public static var sprCoin:BlSprite = new BlSprite(coinBMD, 0, 0, 16, 16, coinBMD.width / 16);
        public static var sprCoinShadow:BlSprite = new BlSprite(coinShadowBMD, 0, 0, 16, 16, coinShadowBMD.width / 16);
        public static var sprBonusCoin:BlSprite = new BlSprite(bonusCoinBMD, 0, 0, 16, 16, bonusCoinBMD.width / 16);
        public static var sprBonusCoinShadow:BlSprite = new BlSprite(bonusCoinShadowBMD, 0, 0, 16, 16, bonusCoinShadowBMD.width / 16);
        public static var sprWater:BlSprite = new BlSprite(waterBMD, 0, 0, 16, 16, waterBMD.width / 16);
        public static var sprWave:BlSprite = new BlSprite(waveBMD, 0, 0, 16, 16, waveBMD.width / 16);
        public static var sprDiamond:BlSprite = new BlSprite(diamondBMD, 0, 0, 16, 16, diamondBMD.width / 16);
        public static var sprCake:BlSprite = new BlSprite(cakeBMD, 0, 0, 16, 16, cakeBMD.width / 16);
        public static var sprPianoBlink:BlSprite = new BlSprite(pianoBlinkBMD, 0, 0, 16, 16, pianoBlinkBMD.width / 16);
        public static var sprDrumsBlink:BlSprite = new BlSprite(drumsBlinkBMD, 0, 0, 16, 16, drumsBlinkBMD.width / 16);
        public static var sprCoinDoors:BlSprite;
        public static var sprCoinGates:BlSprite;
        private static var totalBricks:int = 0;
        private static var totalSmilies:int = 0;
        private static var totalPotions:int = 0;

        public function ItemManager()
        {
            return;
        }// end function

        public static function init() : void
        {
            var _loc_68:Matrix = null;
            pianoSounds.push(new piano01() as Sound, new piano02() as Sound, new piano03() as Sound, new piano04() as Sound, new piano05() as Sound, new piano06() as Sound, new piano07() as Sound, new piano08() as Sound, new piano09() as Sound, new piano10() as Sound, new piano11() as Sound, new piano12() as Sound, new piano13() as Sound, new piano14() as Sound, new piano15() as Sound, new piano16() as Sound, new piano17() as Sound, new piano18() as Sound, new piano19() as Sound, new piano20() as Sound, new piano21() as Sound, new piano22() as Sound, new piano23() as Sound, new piano24() as Sound, new piano25() as Sound);
            drumSounds.push(new drums01() as Sound, new drums02() as Sound, new drums03() as Sound, new drums04() as Sound, new drums05() as Sound, new drums06() as Sound, new drums07() as Sound, new drums08() as Sound, new drums09() as Sound, new drums10() as Sound);
            addSmiley(0, "Smiley", "", smiliesBMD, "");
            addSmiley(1, "Grin", "", smiliesBMD, "");
            addSmiley(2, "Tongue", "", smiliesBMD, "");
            addSmiley(3, "Happy", "", smiliesBMD, "");
            addSmiley(4, "Annoyed", "", smiliesBMD, "");
            addSmiley(5, "Sad", "", smiliesBMD, "");
            addSmiley(6, "Crying", "", smiliesBMD, "pro");
            addSmiley(7, "Wink", "", smiliesBMD, "pro");
            addSmiley(8, "Frustrated", "", smiliesBMD, "pro");
            addSmiley(9, "Shades", "", smiliesBMD, "pro");
            addSmiley(10, "Devil", "", smiliesBMD, "pro");
            addSmiley(11, "Inquisitive", "", smiliesBMD, "pro");
            addSmiley(12, "Ninja", "", smiliesBMD, "smileyninja", 0);
            addSmiley(13, "Santa", "", smiliesBMD, "smileysanta");
            addSmiley(14, "Worker", "", smiliesBMD, "smileyworker");
            addSmiley(15, "Big Spender", "", smiliesBMD, "smileybigspender");
            addSmiley(16, "Superman", "", smiliesBMD, "smileysuper");
            addSmiley(17, "Surprise", "", smiliesBMD, "smileysupprice");
            addSmiley(18, "Indifferent", "", smiliesBMD, "");
            addSmiley(19, "Girl", "", smiliesBMD, "smileygirl");
            addSmiley(20, "New Year 2010", "", smiliesBMD, "mixednewyear2010");
            addSmiley(21, "Coy", "", smiliesBMD, "smileycoy");
            addSmiley(22, "Wizard", "", smiliesBMD, "smileywizard");
            addSmiley(23, "Fan Boy", "", smiliesBMD, "smileyfanboy");
            addSmiley(24, "Terminator", "", smiliesBMD, "smileyterminator");
            addSmiley(25, "Extra Grin", "", smiliesBMD, "smileyxd");
            addSmiley(26, "Bully", "", smiliesBMD, "smileybully");
            addSmiley(27, "Commando", "", smiliesBMD, "smileycommando");
            addSmiley(28, "Kissing", "", smiliesBMD, "smileyvalentines2011");
            addSmiley(29, "Bird", "", smiliesBMD, "smileybird");
            addSmiley(30, "Bunny", "", smiliesBMD, "smileybunni");
            addSmiley(31, "Diamond Touch", "", smiliesBMD, "unobtainable");
            addSmiley(32, "Fire Wizard", "", smiliesBMD, "smileywizard2");
            addSmiley(33, "Extra Tongue", "", smiliesBMD, "smileyxdp");
            addSmiley(34, "Postman", "", smiliesBMD, "smileypostman");
            addSmiley(35, "Templar", "", smiliesBMD, "smileytemplar");
            addSmiley(36, "Angel", "", smiliesBMD, "smileyangel");
            addSmiley(37, "Nurse", "", smiliesBMD, "smileynurse");
            addSmiley(38, "Vampire", "", smiliesBMD, "smileyhw2011vampire");
            addSmiley(39, "Ghost", "", smiliesBMD, "smileyhw2011ghost");
            addSmiley(40, "Frankenstein", "", smiliesBMD, "smileyhw2011frankenstein");
            addSmiley(41, "Witch", "", smiliesBMD, "smileywitch");
            addSmiley(42, "Indian", "", smiliesBMD, "smileytg2011indian");
            addSmiley(43, "Pilgrim", "", smiliesBMD, "smileytg2011pilgrim");
            addSmiley(44, "Pumpkin", "", smiliesBMD, "smileypumpkin1");
            addSmiley(45, "Lit Pumpkin", "", smiliesBMD, "smileypumpkin2");
            addSmiley(46, "Snowman", "", smiliesBMD, "smileyxmassnowman");
            addSmiley(47, "Reindeer", "", smiliesBMD, "smileyxmasreindeer");
            addSmiley(48, "Grinch", "", smiliesBMD, "smileyxmasgrinch");
            addSmiley(49, "Maestro", "", smiliesBMD, "bricknode");
            addSmiley(51, "Sigh", "", smiliesBMD, "smileysigh");
            addSmiley(52, "Robber", "", smiliesBMD, "smileyrobber", 0);
            addSmiley(53, "Police", "", smiliesBMD, "smileypolice", 4279002358);
            addSmiley(55, "Pirate", "", smiliesBMD, "smileypirate");
            addSmiley(56, "Viking", "", smiliesBMD, "smileyviking");
            addSmiley(57, "Karate", "", smiliesBMD, "smileykarate");
            addSmiley(58, "Cowboy", "", smiliesBMD, "smileycowboy");
            addSmiley(59, "Diver", "", smiliesBMD, "smileydiver");
            addSmiley(60, "Tanned", "", smiliesBMD, "smileytanned");
            addSmiley(61, "Propeller", "", smiliesBMD, "smileypropeller");
            addSmiley(62, "Hard hat", "", smiliesBMD, "smileyhardhat");
            addSmiley(63, "Gasmask", "", smiliesBMD, "smileygasmask");
            addSmiley(64, "Robot", "", smiliesBMD, "smileyrobot");
            addSmiley(65, "Peasant", "", smiliesBMD, "smileypeasant");
            addSmiley(66, "Soldier", "", smiliesBMD, "smileysoldier");
            addSmiley(67, "Blacksmith", "", smiliesBMD, "smileyblacksmith");
            addSmiley(68, "LOL", "", smiliesBMD, "smileylaughing");
            addSmiley(69, "Laika", "", smiliesBMD, "smileylaika");
            addSmiley(70, "Alien", "", smiliesBMD, "smileyalien");
            addSmiley(71, "Astronaut", "", smiliesBMD, "smileyastronaut");
            addSmiley(72, "PartyOrange", "", smiliesBMD, "unobtainable");
            addSmiley(73, "PartyGreen", "", smiliesBMD, "unobtainable");
            addSmiley(74, "PartyBlue", "", smiliesBMD, "unobtainable");
            addSmiley(75, "PartyRed", "", smiliesBMD, "unobtainable");
            addSmiley(76, "Cannonball", "", smiliesBMD, "smileycannon");
            addSmiley(77, "Monster", "", smiliesBMD, "smileymonster");
            addPotion(1, "RedAura", "Potion of red aura", potionBMD, "potionaurared");
            addPotion(2, "BlueAura", "Potion of blue aura", potionBMD, "potionaurablue");
            addPotion(3, "YellowAura", "Potion of yellow aura", potionBMD, "potionaurayellow");
            var _loc_1:* = new ItemBrickPackage("basic", "Basic Blocks");
            _loc_1.addBrick(createBrick(9, ItemLayer.FORGROUND, forgroundBricksBMD, "", ItemTab.BLOCK, false, true, 9, 4285427310));
            _loc_1.addBrick(createBrick(10, ItemLayer.FORGROUND, forgroundBricksBMD, "", ItemTab.BLOCK, false, true, 10, 4281684648));
            _loc_1.addBrick(createBrick(11, ItemLayer.FORGROUND, forgroundBricksBMD, "", ItemTab.BLOCK, false, true, 11, 4288099751));
            _loc_1.addBrick(createBrick(12, ItemLayer.FORGROUND, forgroundBricksBMD, "", ItemTab.BLOCK, false, true, 12, 4289213780));
            _loc_1.addBrick(createBrick(13, ItemLayer.FORGROUND, forgroundBricksBMD, "", ItemTab.BLOCK, false, true, 13, 4287866933));
            _loc_1.addBrick(createBrick(14, ItemLayer.FORGROUND, forgroundBricksBMD, "", ItemTab.BLOCK, false, true, 14, 4282558518));
            _loc_1.addBrick(createBrick(15, ItemLayer.FORGROUND, forgroundBricksBMD, "", ItemTab.BLOCK, false, true, 15, 4281704102));
            _loc_1.addBrick(createBrick(182, ItemLayer.FORGROUND, forgroundBricksBMD, "", ItemTab.BLOCK, false, true, 156, 4279834905));
            brickPackages.push(_loc_1);
            var _loc_2:* = new ItemBrickPackage("beta", "Beta Blocks");
            _loc_2.addBrick(createBrick(37, ItemLayer.FORGROUND, forgroundBricksBMD, "pro", ItemTab.BLOCK, false, true, 37, 4291715791));
            _loc_2.addBrick(createBrick(38, ItemLayer.FORGROUND, forgroundBricksBMD, "pro", ItemTab.BLOCK, false, true, 38, 4283091074));
            _loc_2.addBrick(createBrick(39, ItemLayer.FORGROUND, forgroundBricksBMD, "pro", ItemTab.BLOCK, false, true, 39, 4283270342));
            _loc_2.addBrick(createBrick(40, ItemLayer.FORGROUND, forgroundBricksBMD, "pro", ItemTab.BLOCK, false, true, 40, 4291782224));
            _loc_2.addBrick(createBrick(41, ItemLayer.FORGROUND, forgroundBricksBMD, "pro", ItemTab.BLOCK, false, true, 41, 4291995973));
            _loc_2.addBrick(createBrick(42, ItemLayer.FORGROUND, forgroundBricksBMD, "pro", ItemTab.BLOCK, false, true, 42, 4288321167));
            brickPackages.push(_loc_2);
            var _loc_3:* = new ItemBrickPackage("brick", "Brick Blocks");
            _loc_3.addBrick(createBrick(16, ItemLayer.FORGROUND, forgroundBricksBMD, "", ItemTab.BLOCK, false, true, 16, 4287315465));
            _loc_3.addBrick(createBrick(17, ItemLayer.FORGROUND, forgroundBricksBMD, "", ItemTab.BLOCK, false, true, 17, 4280577869));
            _loc_3.addBrick(createBrick(18, ItemLayer.FORGROUND, forgroundBricksBMD, "", ItemTab.BLOCK, false, true, 18, 4283311215));
            _loc_3.addBrick(createBrick(19, ItemLayer.FORGROUND, forgroundBricksBMD, "", ItemTab.BLOCK, false, true, 19, 4282614544));
            _loc_3.addBrick(createBrick(20, ItemLayer.FORGROUND, forgroundBricksBMD, "", ItemTab.BLOCK, false, true, 20, 4285473833));
            _loc_3.addBrick(createBrick(21, ItemLayer.FORGROUND, forgroundBricksBMD, "", ItemTab.BLOCK, false, true, 21, 4285488420));
            brickPackages.push(_loc_3);
            var _loc_4:* = new ItemBrickPackage("metal", "Metal Blocks");
            new ItemBrickPackage("metal", "Metal Blocks").addBrick(createBrick(29, ItemLayer.FORGROUND, forgroundBricksBMD, "", ItemTab.BLOCK, false, true, 29, 4288783269));
            _loc_4.addBrick(createBrick(30, ItemLayer.FORGROUND, forgroundBricksBMD, "", ItemTab.BLOCK, false, true, 30, 4292835905));
            _loc_4.addBrick(createBrick(31, ItemLayer.FORGROUND, forgroundBricksBMD, "", ItemTab.BLOCK, false, true, 31, 4293962023));
            brickPackages.push(_loc_4);
            var _loc_5:* = new ItemBrickPackage("grass", "Grass Blocks");
            new ItemBrickPackage("grass", "Grass Blocks").addBrick(createBrick(34, ItemLayer.DECORATION, forgroundBricksBMD, "", ItemTab.BLOCK, false, true, 34, 4282737427));
            _loc_5.addBrick(createBrick(35, ItemLayer.FORGROUND, forgroundBricksBMD, "", ItemTab.BLOCK, false, true, 35, 4282737427));
            _loc_5.addBrick(createBrick(36, ItemLayer.DECORATION, forgroundBricksBMD, "", ItemTab.BLOCK, false, true, 36, 4282737427));
            brickPackages.push(_loc_5);
            var _loc_6:* = new ItemBrickPackage("special", "Special Blocks");
            new ItemBrickPackage("special", "Special Blocks").addBrick(createBrick(22, ItemLayer.DECORATION, forgroundBricksBMD, "", ItemTab.BLOCK, false, true, 22, 4287191826));
            _loc_6.addBrick(createBrick(32, ItemLayer.DECORATION, forgroundBricksBMD, "", ItemTab.BLOCK, false, true, 32, 4291792930));
            _loc_6.addBrick(createBrick(33, ItemLayer.FORGROUND, forgroundBricksBMD, "", ItemTab.BLOCK, false, true, 33, 4278190080));
            _loc_6.addBrick(createBrick(44, ItemLayer.FORGROUND, forgroundBricksBMD, "brickblackblock", ItemTab.BLOCK, false, true, 44, 16777216));
            brickPackages.push(_loc_6);
            var _loc_7:* = new ItemBrickPackage("factory", "Factory Blocks");
            new ItemBrickPackage("factory", "Factory Blocks").addBrick(createBrick(45, ItemLayer.FORGROUND, forgroundBricksBMD, "brickfactorypack", ItemTab.BLOCK, false, true, 45, 4285686091));
            _loc_7.addBrick(createBrick(46, ItemLayer.FORGROUND, forgroundBricksBMD, "brickfactorypack", ItemTab.BLOCK, false, true, 46, 4285426528));
            _loc_7.addBrick(createBrick(47, ItemLayer.FORGROUND, forgroundBricksBMD, "brickfactorypack", ItemTab.BLOCK, false, true, 47, 4287525711));
            _loc_7.addBrick(createBrick(48, ItemLayer.FORGROUND, forgroundBricksBMD, "brickfactorypack", ItemTab.BLOCK, false, true, 48, 4286533419));
            _loc_7.addBrick(createBrick(49, ItemLayer.FORGROUND, forgroundBricksBMD, "brickfactorypack", ItemTab.BLOCK, false, true, 49, 4285887861));
            brickPackages.push(_loc_7);
            var _loc_8:* = new ItemBrickPackage("secrets", "Secret Blocks");
            new ItemBrickPackage("secrets", "Secret Blocks").addBrick(createBrick(50, ItemLayer.DECORATION, secretBricksBMD, "bricksecret", ItemTab.BLOCK, true, true, 0, 0));
            _loc_8.addBrick(createBrick(243, ItemLayer.DECORATION, secretBricksBMD, "bricksecret", ItemTab.BLOCK, true, true, 1, 16777216));
            brickPackages.push(_loc_8);
            var _loc_9:* = new ItemBrickPackage("glass", "Glass Blocks");
            new ItemBrickPackage("glass", "Glass Blocks").addBrick(createBrick(51, ItemLayer.FORGROUND, forgroundBricksBMD, "brickglass", ItemTab.BLOCK, false, true, 51, 4294480537));
            _loc_9.addBrick(createBrick(52, ItemLayer.FORGROUND, forgroundBricksBMD, "brickglass", ItemTab.BLOCK, false, true, 52, 4293495798));
            _loc_9.addBrick(createBrick(53, ItemLayer.FORGROUND, forgroundBricksBMD, "brickglass", ItemTab.BLOCK, false, true, 53, 4289169910));
            _loc_9.addBrick(createBrick(54, ItemLayer.FORGROUND, forgroundBricksBMD, "brickglass", ItemTab.BLOCK, false, true, 54, 4286487030));
            _loc_9.addBrick(createBrick(55, ItemLayer.FORGROUND, forgroundBricksBMD, "brickglass", ItemTab.BLOCK, false, true, 55, 4288011510));
            _loc_9.addBrick(createBrick(56, ItemLayer.FORGROUND, forgroundBricksBMD, "brickglass", ItemTab.BLOCK, false, true, 56, 4287822762));
            _loc_9.addBrick(createBrick(57, ItemLayer.FORGROUND, forgroundBricksBMD, "brickglass", ItemTab.BLOCK, false, true, 57, 4294498956));
            _loc_9.addBrick(createBrick(58, ItemLayer.FORGROUND, forgroundBricksBMD, "brickglass", ItemTab.BLOCK, false, true, 58, 4294359700));
            brickPackages.push(_loc_9);
            var _loc_10:* = new ItemBrickPackage("minerals", "Mineral Blocks");
            new ItemBrickPackage("minerals", "Mineral Blocks").addBrick(createBrick(70, ItemLayer.FORGROUND, forgroundBricksBMD, "brickminiral", ItemTab.BLOCK, false, true, 70, 4293787648));
            _loc_10.addBrick(createBrick(71, ItemLayer.FORGROUND, forgroundBricksBMD, "brickminiral", ItemTab.BLOCK, false, true, 71, 4293787886));
            _loc_10.addBrick(createBrick(72, ItemLayer.FORGROUND, forgroundBricksBMD, "brickminiral", ItemTab.BLOCK, false, true, 72, 4278190318));
            _loc_10.addBrick(createBrick(73, ItemLayer.FORGROUND, forgroundBricksBMD, "brickminiral", ItemTab.BLOCK, false, true, 73, 4278251246));
            _loc_10.addBrick(createBrick(74, ItemLayer.FORGROUND, forgroundBricksBMD, "brickminiral", ItemTab.BLOCK, false, true, 74, 4278251008));
            _loc_10.addBrick(createBrick(75, ItemLayer.FORGROUND, forgroundBricksBMD, "brickminiral", ItemTab.BLOCK, false, true, 75, 4293848576));
            _loc_10.addBrick(createBrick(76, ItemLayer.FORGROUND, forgroundBricksBMD, "brickminiral", ItemTab.BLOCK, false, true, 76, 4293818112));
            brickPackages.push(_loc_10);
            var _loc_11:* = new ItemBrickPackage("christmas 2011", "Christmas 2011 Blocks");
            new ItemBrickPackage("christmas 2011", "Christmas 2011 Blocks").addBrick(createBrick(78, ItemLayer.FORGROUND, forgroundBricksBMD, "brickxmas2011", ItemTab.BLOCK, false, true, 78));
            _loc_11.addBrick(createBrick(79, ItemLayer.FORGROUND, forgroundBricksBMD, "brickxmas2011", ItemTab.BLOCK, false, true, 79));
            _loc_11.addBrick(createBrick(80, ItemLayer.FORGROUND, forgroundBricksBMD, "brickxmas2011", ItemTab.BLOCK, false, true, 80));
            _loc_11.addBrick(createBrick(81, ItemLayer.FORGROUND, forgroundBricksBMD, "brickxmas2011", ItemTab.BLOCK, false, true, 81));
            _loc_11.addBrick(createBrick(82, ItemLayer.FORGROUND, forgroundBricksBMD, "brickxmas2011", ItemTab.BLOCK, false, true, 82));
            brickPackages.push(_loc_11);
            var _loc_12:* = new ItemBrickPackage("adm", "Admin Blocks");
            new ItemBrickPackage("adm", "Admin Blocks").addBrick(createBrick(1000, ItemLayer.DECORATION, forgroundBricksBMD, "", ItemTab.BLOCK, false, true, 1000, -1, true));
            brickPackages.push(_loc_12);
            var _loc_13:* = new ItemBrickPackage("keys", "Key Blocks");
            new ItemBrickPackage("keys", "Key Blocks").addBrick(createBrick(6, ItemLayer.DECORATION, forgroundBricksBMD, "", ItemTab.ACTION, false, false, 6, 4281080346));
            _loc_13.addBrick(createBrick(7, ItemLayer.DECORATION, forgroundBricksBMD, "", ItemTab.ACTION, false, false, 7, 4279905306));
            _loc_13.addBrick(createBrick(8, ItemLayer.DECORATION, forgroundBricksBMD, "", ItemTab.ACTION, false, false, 8, 4279900716));
            brickPackages.push(_loc_13);
            var _loc_14:* = new ItemBrickPackage("gates", "Gate Blocks");
            new ItemBrickPackage("gates", "Gate Blocks").addBrick(createBrick(26, ItemLayer.DECORATION, forgroundBricksBMD, "", ItemTab.ACTION, false, false, 26, 4288425286));
            _loc_14.addBrick(createBrick(27, ItemLayer.DECORATION, forgroundBricksBMD, "", ItemTab.ACTION, false, false, 27, 4281834544));
            _loc_14.addBrick(createBrick(28, ItemLayer.DECORATION, forgroundBricksBMD, "", ItemTab.ACTION, false, false, 28, 4281156764));
            _loc_14.addBrick(createBrick(ItemId.COINGATE, ItemLayer.DECORATION, forgroundBricksBMD, "brickcoingate", ItemTab.ACTION, true, false, 139, 4290285077));
            _loc_14.addBrick(createBrick(ItemId.TIMEGATE, ItemLayer.DECORATION, doorstimeBMD, "bricktimeddoor", ItemTab.ACTION, true, false, 8));
            brickPackages.push(_loc_14);
            var _loc_15:* = new ItemBrickPackage("doors", "Door Blocks");
            new ItemBrickPackage("doors", "Door Blocks").addBrick(createBrick(23, ItemLayer.DECORATION, forgroundBricksBMD, "", ItemTab.ACTION, false, true, 23, 4288425286));
            _loc_15.addBrick(createBrick(24, ItemLayer.DECORATION, forgroundBricksBMD, "", ItemTab.ACTION, false, true, 24, 4281834544));
            _loc_15.addBrick(createBrick(25, ItemLayer.DECORATION, forgroundBricksBMD, "", ItemTab.ACTION, false, true, 25, 4281156764));
            _loc_15.addBrick(createBrick(ItemId.COINDOOR, ItemLayer.DECORATION, forgroundBricksBMD, "brickcoindoor", ItemTab.ACTION, true, true, 43, 4290285077));
            _loc_15.addBrick(createBrick(ItemId.TIMEDOOR, ItemLayer.DECORATION, doorstimeBMD, "bricktimeddoor", ItemTab.ACTION, true, true, 3));
            brickPackages.push(_loc_15);
            var _loc_16:* = new ItemBrickPackage("gravity", "Gravity Modifying Arrows");
            new ItemBrickPackage("gravity", "Gravity Modifying Arrows").addBrick(createBrick(0, ItemLayer.BACKGROUND, forgroundBricksBMD, "", ItemTab.ACTION, false, false, 0, 4278190080));
            _loc_16.addBrick(createBrick(1, ItemLayer.DECORATION, forgroundBricksBMD, "", ItemTab.ACTION, false, false, 1, 0));
            _loc_16.addBrick(createBrick(2, ItemLayer.DECORATION, forgroundBricksBMD, "", ItemTab.ACTION, false, false, 2, 0));
            _loc_16.addBrick(createBrick(3, ItemLayer.DECORATION, forgroundBricksBMD, "", ItemTab.ACTION, false, false, 3, 0));
            _loc_16.addBrick(createBrick(4, ItemLayer.DECORATION, forgroundBricksBMD, "", ItemTab.ACTION, false, false, 4, 0));
            brickPackages.push(_loc_16);
            var _loc_17:* = new ItemBrickPackage("Boost", "Boost Arrows");
            new ItemBrickPackage("Boost", "Boost Arrows").addBrick(createBrick(ItemId.SPEED_LEFT, ItemLayer.DECORATION, forgroundBricksBMD, "brickboost", ItemTab.ACTION, false, false, 157, 0));
            _loc_17.addBrick(createBrick(ItemId.SPEED_RIGHT, ItemLayer.DECORATION, forgroundBricksBMD, "brickboost", ItemTab.ACTION, false, false, 158, 0));
            _loc_17.addBrick(createBrick(ItemId.SPEED_UP, ItemLayer.DECORATION, forgroundBricksBMD, "brickboost", ItemTab.ACTION, false, false, 159, 0));
            _loc_17.addBrick(createBrick(ItemId.SPEED_DOWN, ItemLayer.DECORATION, forgroundBricksBMD, "brickboost", ItemTab.ACTION, false, false, 160, 0));
            brickPackages.push(_loc_17);
            var _loc_18:* = new ItemBrickPackage("music", "Music Blocks");
            new ItemBrickPackage("music", "Music Blocks").addBrick(createBrick(77, ItemLayer.DECORATION, forgroundBricksBMD, "bricknode", ItemTab.ACTION, false, false, 77, 0));
            _loc_18.addBrick(createBrick(83, ItemLayer.DECORATION, forgroundBricksBMD, "brickdrums", ItemTab.ACTION, false, false, 83, 0));
            brickPackages.push(_loc_18);
            var _loc_19:* = new ItemBrickPackage("coins", "Coin Blocks");
            new ItemBrickPackage("coins", "Coin Blocks").addBrick(createBrick(100, ItemLayer.ABOVE, coinBMD, "", ItemTab.ACTION, false, false, 0, 0));
            _loc_19.addBrick(createBrick(101, ItemLayer.ABOVE, bonusCoinBMD, "", ItemTab.ACTION, false, false, 0, 0));
            _loc_19.addBrick(createBrick(110, ItemLayer.DECORATION, coinBMD, "hidden", ItemTab.ACTION, false, false, 0, 0));
            _loc_19.addBrick(createBrick(111, ItemLayer.DECORATION, bonusCoinBMD, "hidden", ItemTab.ACTION, false, false, 0, 0));
            brickPackages.push(_loc_19);
            var _loc_20:* = new ItemBrickPackage("crowns", "Crown Awarders");
            new ItemBrickPackage("crowns", "Crown Awarders").addBrick(createBrick(5, ItemLayer.DECORATION, forgroundBricksBMD, "", ItemTab.ACTION, false, true, 5, 4282595615));
            brickPackages.push(_loc_20);
            var _loc_21:* = new ItemBrickPackage("tools", "Tool Blocks");
            new ItemBrickPackage("tools", "Tool Blocks").addBrick(createBrick(255, ItemLayer.DECORATION, decorationsBMD, "brickspawn", ItemTab.ACTION, true, true, 255 - 128));
            _loc_21.addBrick(createBrick(ItemId.BRICK_COMPLETE, ItemLayer.ABOVE, completeBMD, "brickcomplete", ItemTab.ACTION, true, false, 0, 0));
            brickPackages.push(_loc_21);
            var _loc_22:* = new ItemBrickPackage("Ladders", "Ladder Blocks");
            new ItemBrickPackage("Ladders", "Ladder Blocks").addBrick(createBrick(ItemId.CHAIN, ItemLayer.DECORATION, forgroundBricksBMD, "brickcastle", ItemTab.ACTION, false, true, 135, 0));
            _loc_22.addBrick(createBrick(ItemId.NINJA_LADDER, ItemLayer.DECORATION, forgroundBricksBMD, "brickninja", ItemTab.ACTION, false, false, 98, 0));
            brickPackages.push(_loc_22);
            var _loc_23:* = new ItemBrickPackage("portal", "Portal Block");
            new ItemBrickPackage("portal", "Portal Block").addBrick(createBrick(242, ItemLayer.DECORATION, decorationsBMD, "", ItemTab.ACTION, true, true, 242 - 128));
            brickPackages.push(_loc_23);
            var _loc_24:* = new ItemBrickPackage("diamond", "Diamond Block");
            new ItemBrickPackage("diamond", "Diamond Block").addBrick(createBrick(ItemId.DIAMOND, ItemLayer.DECORATION, decorationsBMD, "brickdiamond", ItemTab.ACTION, true, true, 241 - 128));
            brickPackages.push(_loc_24);
            var _loc_25:* = new ItemBrickPackage("cake", "Cake Block");
            new ItemBrickPackage("cake", "Cake Block").addBrick(createBrick(ItemId.CAKE, ItemLayer.DECORATION, cakeBMD, "brickcake", ItemTab.ACTION, true, true, 0, 4294902015));
            brickPackages.push(_loc_25);
            var _loc_26:* = new ItemBrickPackage("christmas 2010", "Christmas 2010 Blocks");
            new ItemBrickPackage("christmas 2010", "Christmas 2010 Blocks").addBrick(createBrick(249, ItemLayer.DECORATION, decorationsBMD, "brickchristmas2010", ItemTab.DECORATIVE, false, true, 249 - 128, 0));
            _loc_26.addBrick(createBrick(250, ItemLayer.DECORATION, decorationsBMD, "brickchristmas2010", ItemTab.DECORATIVE, false, true, 250 - 128, 0));
            _loc_26.addBrick(createBrick(251, ItemLayer.DECORATION, decorationsBMD, "brickchristmas2010", ItemTab.DECORATIVE, false, true, 251 - 128, 0));
            _loc_26.addBrick(createBrick(252, ItemLayer.DECORATION, decorationsBMD, "brickchristmas2010", ItemTab.DECORATIVE, false, true, 252 - 128, 0));
            _loc_26.addBrick(createBrick(253, ItemLayer.ABOVE, decorationsBMD, "brickchristmas2010", ItemTab.DECORATIVE, false, true, 253 - 128, 0));
            _loc_26.addBrick(createBrick(254, ItemLayer.ABOVE, decorationsBMD, "brickchristmas2010", ItemTab.DECORATIVE, false, true, 254 - 128, 0));
            brickPackages.push(_loc_26);
            var _loc_27:* = new ItemBrickPackage("new year 2010", "New Year 2010 Blocks");
            new ItemBrickPackage("new year 2010", "New Year 2010 Blocks").addBrick(createBrick(244, ItemLayer.DECORATION, decorationsBMD, "mixednewyear2010", ItemTab.DECORATIVE, false, true, 244 - 128, 0));
            _loc_27.addBrick(createBrick(245, ItemLayer.DECORATION, decorationsBMD, "mixednewyear2010", ItemTab.DECORATIVE, false, true, 245 - 128, 0));
            _loc_27.addBrick(createBrick(246, ItemLayer.DECORATION, decorationsBMD, "mixednewyear2010", ItemTab.DECORATIVE, false, true, 246 - 128, 0));
            _loc_27.addBrick(createBrick(247, ItemLayer.DECORATION, decorationsBMD, "mixednewyear2010", ItemTab.DECORATIVE, false, true, 247 - 128, 0));
            _loc_27.addBrick(createBrick(248, ItemLayer.DECORATION, decorationsBMD, "mixednewyear2010", ItemTab.DECORATIVE, false, true, 248 - 128, 0));
            brickPackages.push(_loc_27);
            var _loc_28:* = new ItemBrickPackage("spring 2011", "Spring 2011 Blocks");
            new ItemBrickPackage("spring 2011", "Spring 2011 Blocks").addBrick(createBrick(233, ItemLayer.ABOVE, decorationsBMD, "brickspring2011", ItemTab.DECORATIVE, false, true, 233 - 128, 0));
            _loc_28.addBrick(createBrick(234, ItemLayer.ABOVE, decorationsBMD, "brickspring2011", ItemTab.DECORATIVE, false, true, 234 - 128, 0));
            _loc_28.addBrick(createBrick(235, ItemLayer.ABOVE, decorationsBMD, "brickspring2011", ItemTab.DECORATIVE, false, true, 235 - 128, 0));
            _loc_28.addBrick(createBrick(236, ItemLayer.ABOVE, decorationsBMD, "brickspring2011", ItemTab.DECORATIVE, false, true, 236 - 128, 0));
            _loc_28.addBrick(createBrick(237, ItemLayer.ABOVE, decorationsBMD, "brickspring2011", ItemTab.DECORATIVE, false, true, 237 - 128, 0));
            _loc_28.addBrick(createBrick(238, ItemLayer.ABOVE, decorationsBMD, "brickspring2011", ItemTab.DECORATIVE, false, true, 238 - 128, 0));
            _loc_28.addBrick(createBrick(239, ItemLayer.DECORATION, decorationsBMD, "brickspring2011", ItemTab.DECORATIVE, false, true, 239 - 128, 0));
            _loc_28.addBrick(createBrick(240, ItemLayer.ABOVE, decorationsBMD, "brickspring2011", ItemTab.DECORATIVE, false, true, 240 - 128, 0));
            brickPackages.push(_loc_28);
            var _loc_29:* = new ItemBrickPackage("Prizes", "Your Prices");
            new ItemBrickPackage("Prizes", "Your Prices").addBrick(createBrick(223, ItemLayer.DECORATION, decorationsBMD, "brickhwtrophy", ItemTab.DECORATIVE, false, false, 223 - 128, 0));
            brickPackages.push(_loc_29);
            var _loc_30:* = new ItemBrickPackage("easter 2012", "Easter 2012 Blocks");
            new ItemBrickPackage("easter 2012", "Easter 2012 Blocks").addBrick(createBrick(256, ItemLayer.DECORATION, decorationsBMD, "brickeaster2012", ItemTab.DECORATIVE, false, false, 256 - 128, 0));
            _loc_30.addBrick(createBrick(257, ItemLayer.DECORATION, decorationsBMD, "brickeaster2012", ItemTab.DECORATIVE, false, false, 257 - 128, 0));
            _loc_30.addBrick(createBrick(258, ItemLayer.DECORATION, decorationsBMD, "brickeaster2012", ItemTab.DECORATIVE, false, false, 258 - 128, 0));
            _loc_30.addBrick(createBrick(259, ItemLayer.DECORATION, decorationsBMD, "brickeaster2012", ItemTab.DECORATIVE, false, false, 259 - 128, 0));
            _loc_30.addBrick(createBrick(260, ItemLayer.DECORATION, decorationsBMD, "brickeaster2012", ItemTab.DECORATIVE, false, false, 260 - 128, 0));
            brickPackages.push(_loc_30);
            var _loc_31:* = new ItemBrickPackage("basic", "Basic Background Blocks");
            new ItemBrickPackage("basic", "Basic Background Blocks").addBrick(createBrick(500, ItemLayer.BACKGROUND, backgroundBricksBMD, "", ItemTab.BACKGROUND, false, false, 500 - 500));
            _loc_31.addBrick(createBrick(501, ItemLayer.BACKGROUND, backgroundBricksBMD, "", ItemTab.BACKGROUND, false, false, 501 - 500));
            _loc_31.addBrick(createBrick(502, ItemLayer.BACKGROUND, backgroundBricksBMD, "", ItemTab.BACKGROUND, false, false, 502 - 500));
            _loc_31.addBrick(createBrick(503, ItemLayer.BACKGROUND, backgroundBricksBMD, "", ItemTab.BACKGROUND, false, false, 503 - 500));
            _loc_31.addBrick(createBrick(504, ItemLayer.BACKGROUND, backgroundBricksBMD, "", ItemTab.BACKGROUND, false, false, 504 - 500));
            _loc_31.addBrick(createBrick(505, ItemLayer.BACKGROUND, backgroundBricksBMD, "", ItemTab.BACKGROUND, false, false, 505 - 500));
            _loc_31.addBrick(createBrick(506, ItemLayer.BACKGROUND, backgroundBricksBMD, "", ItemTab.BACKGROUND, false, false, 506 - 500));
            brickPackages.push(_loc_31);
            var _loc_32:* = new ItemBrickPackage("brick", "Brick Background Blocks");
            new ItemBrickPackage("brick", "Brick Background Blocks").addBrick(createBrick(507, ItemLayer.BACKGROUND, backgroundBricksBMD, "", ItemTab.BACKGROUND, false, false, 507 - 500));
            _loc_32.addBrick(createBrick(508, ItemLayer.BACKGROUND, backgroundBricksBMD, "", ItemTab.BACKGROUND, false, false, 508 - 500));
            _loc_32.addBrick(createBrick(509, ItemLayer.BACKGROUND, backgroundBricksBMD, "", ItemTab.BACKGROUND, false, false, 509 - 500));
            _loc_32.addBrick(createBrick(510, ItemLayer.BACKGROUND, backgroundBricksBMD, "", ItemTab.BACKGROUND, false, false, 510 - 500));
            _loc_32.addBrick(createBrick(511, ItemLayer.BACKGROUND, backgroundBricksBMD, "", ItemTab.BACKGROUND, false, false, 511 - 500));
            _loc_32.addBrick(createBrick(512, ItemLayer.BACKGROUND, backgroundBricksBMD, "", ItemTab.BACKGROUND, false, false, 512 - 500));
            brickPackages.push(_loc_32);
            var _loc_33:* = new ItemBrickPackage("checker", "Checker Background Blocks");
            new ItemBrickPackage("checker", "Checker Background Blocks").addBrick(createBrick(513, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickbgchecker", ItemTab.BACKGROUND, false, false, 513 - 500));
            _loc_33.addBrick(createBrick(514, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickbgchecker", ItemTab.BACKGROUND, false, false, 514 - 500));
            _loc_33.addBrick(createBrick(515, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickbgchecker", ItemTab.BACKGROUND, false, false, 515 - 500));
            _loc_33.addBrick(createBrick(516, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickbgchecker", ItemTab.BACKGROUND, false, false, 516 - 500));
            _loc_33.addBrick(createBrick(517, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickbgchecker", ItemTab.BACKGROUND, false, false, 517 - 500));
            _loc_33.addBrick(createBrick(518, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickbgchecker", ItemTab.BACKGROUND, false, false, 518 - 500));
            _loc_33.addBrick(createBrick(519, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickbgchecker", ItemTab.BACKGROUND, false, false, 519 - 500));
            brickPackages.push(_loc_33);
            var _loc_34:* = new ItemBrickPackage("dark", "Dark Background Blocks");
            new ItemBrickPackage("dark", "Dark Background Blocks").addBrick(createBrick(520, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickbgdark", ItemTab.BACKGROUND, false, false, 520 - 500));
            _loc_34.addBrick(createBrick(521, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickbgdark", ItemTab.BACKGROUND, false, false, 521 - 500));
            _loc_34.addBrick(createBrick(522, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickbgdark", ItemTab.BACKGROUND, false, false, 522 - 500));
            _loc_34.addBrick(createBrick(523, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickbgdark", ItemTab.BACKGROUND, false, false, 523 - 500));
            _loc_34.addBrick(createBrick(524, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickbgdark", ItemTab.BACKGROUND, false, false, 524 - 500));
            _loc_34.addBrick(createBrick(525, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickbgdark", ItemTab.BACKGROUND, false, false, 525 - 500));
            _loc_34.addBrick(createBrick(526, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickbgdark", ItemTab.BACKGROUND, false, false, 526 - 500));
            brickPackages.push(_loc_34);
            var _loc_35:* = new ItemBrickPackage("pastel", "Pastel Background Blocks");
            new ItemBrickPackage("pastel", "Pastel Background Blocks").addBrick(createBrick(527, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickbgpastel", ItemTab.BACKGROUND, false, false, 527 - 500));
            _loc_35.addBrick(createBrick(528, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickbgpastel", ItemTab.BACKGROUND, false, false, 528 - 500));
            _loc_35.addBrick(createBrick(529, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickbgpastel", ItemTab.BACKGROUND, false, false, 529 - 500));
            _loc_35.addBrick(createBrick(530, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickbgpastel", ItemTab.BACKGROUND, false, false, 530 - 500));
            _loc_35.addBrick(createBrick(531, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickbgpastel", ItemTab.BACKGROUND, false, false, 531 - 500));
            _loc_35.addBrick(createBrick(532, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickbgpastel", ItemTab.BACKGROUND, false, false, 532 - 500));
            brickPackages.push(_loc_35);
            var _loc_36:* = new ItemBrickPackage("canvas", "Canvas Background Blocks");
            new ItemBrickPackage("canvas", "Canvas Background Blocks").addBrick(createBrick(533, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickbgcanvas", ItemTab.BACKGROUND, false, false, 533 - 500));
            _loc_36.addBrick(createBrick(534, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickbgcanvas", ItemTab.BACKGROUND, false, false, 534 - 500));
            _loc_36.addBrick(createBrick(535, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickbgcanvas", ItemTab.BACKGROUND, false, false, 535 - 500));
            _loc_36.addBrick(createBrick(536, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickbgcanvas", ItemTab.BACKGROUND, false, false, 536 - 500));
            _loc_36.addBrick(createBrick(537, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickbgcanvas", ItemTab.BACKGROUND, false, false, 537 - 500));
            _loc_36.addBrick(createBrick(538, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickbgcanvas", ItemTab.BACKGROUND, false, false, 538 - 500));
            brickPackages.push(_loc_36);
            var _loc_37:* = new ItemBrickPackage("carnival", "Carnival Blocks");
            new ItemBrickPackage("carnival", "Carnival Blocks").addBrick(createBrick(545, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickbgcarnival", ItemTab.BACKGROUND, false, true, 45));
            _loc_37.addBrick(createBrick(546, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickbgcarnival", ItemTab.BACKGROUND, false, true, 46));
            _loc_37.addBrick(createBrick(547, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickbgcarnival", ItemTab.BACKGROUND, false, true, 47));
            _loc_37.addBrick(createBrick(548, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickbgcarnival", ItemTab.BACKGROUND, false, true, 48));
            _loc_37.addBrick(createBrick(549, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickbgcarnival", ItemTab.BACKGROUND, false, true, 49));
            brickPackages.push(_loc_37);
            var _loc_38:* = new ItemBrickPackage("candy", "Candy Blocks");
            new ItemBrickPackage("candy", "Candy Blocks").addBrick(createBrick(60, ItemLayer.FORGROUND, forgroundBricksBMD, "brickcandy", ItemTab.BLOCK, false, true, 60));
            _loc_38.addBrick(createBrick(61, ItemLayer.DECORATION, forgroundBricksBMD, "brickcandy", ItemTab.BLOCK, false, true, 61));
            _loc_38.addBrick(createBrick(62, ItemLayer.DECORATION, forgroundBricksBMD, "brickcandy", ItemTab.BLOCK, false, true, 62));
            _loc_38.addBrick(createBrick(63, ItemLayer.DECORATION, forgroundBricksBMD, "brickcandy", ItemTab.BLOCK, false, true, 63));
            _loc_38.addBrick(createBrick(64, ItemLayer.DECORATION, forgroundBricksBMD, "brickcandy", ItemTab.BLOCK, false, true, 64));
            _loc_38.addBrick(createBrick(65, ItemLayer.DECORATION, forgroundBricksBMD, "brickcandy", ItemTab.BLOCK, false, true, 65));
            _loc_38.addBrick(createBrick(66, ItemLayer.DECORATION, forgroundBricksBMD, "brickcandy", ItemTab.BLOCK, false, true, 66));
            _loc_38.addBrick(createBrick(67, ItemLayer.DECORATION, forgroundBricksBMD, "brickcandy", ItemTab.BLOCK, false, true, 67));
            _loc_38.addBrick(createBrick(227, ItemLayer.DECORATION, decorationsBMD, "brickcandy", ItemTab.DECORATIVE, false, true, 227 - 128, 0));
            _loc_38.addBrick(createBrick(539, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickcandy", ItemTab.BACKGROUND, false, false, 539 - 500));
            _loc_38.addBrick(createBrick(540, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickcandy", ItemTab.BACKGROUND, false, false, 540 - 500));
            brickPackages.push(_loc_38);
            var _loc_39:* = new ItemBrickPackage("summer 2011", "Summer 2011 Blocks");
            new ItemBrickPackage("summer 2011", "Summer 2011 Blocks").addBrick(createBrick(59, ItemLayer.FORGROUND, forgroundBricksBMD, "bricksummer2011", ItemTab.BLOCK, false, true, 59));
            _loc_39.addBrick(createBrick(228, ItemLayer.ABOVE, decorationsBMD, "bricksummer2011", ItemTab.DECORATIVE, false, false, 228 - 128, 0));
            _loc_39.addBrick(createBrick(229, ItemLayer.ABOVE, decorationsBMD, "bricksummer2011", ItemTab.DECORATIVE, false, false, 229 - 128, 0));
            _loc_39.addBrick(createBrick(230, ItemLayer.ABOVE, decorationsBMD, "bricksummer2011", ItemTab.DECORATIVE, false, false, 230 - 128, 0));
            _loc_39.addBrick(createBrick(231, ItemLayer.ABOVE, decorationsBMD, "bricksummer2011", ItemTab.DECORATIVE, false, false, 231 - 128, 0));
            _loc_39.addBrick(createBrick(232, ItemLayer.ABOVE, decorationsBMD, "bricksummer2011", ItemTab.DECORATIVE, false, false, 232 - 128, 0));
            brickPackages.push(_loc_39);
            var _loc_40:* = new ItemBrickPackage("halloween 2011", "Halloween 2011 Blocks");
            new ItemBrickPackage("halloween 2011", "Halloween 2011 Blocks").addBrick(createBrick(68, ItemLayer.FORGROUND, forgroundBricksBMD, "brickhw2011", ItemTab.BLOCK, false, true, 68));
            _loc_40.addBrick(createBrick(69, ItemLayer.FORGROUND, forgroundBricksBMD, "brickhw2011", ItemTab.BLOCK, false, true, 69));
            _loc_40.addBrick(createBrick(224, ItemLayer.DECORATION, decorationsBMD, "brickhw2011", ItemTab.DECORATIVE, false, true, 224 - 128, 0));
            _loc_40.addBrick(createBrick(225, ItemLayer.DECORATION, decorationsBMD, "brickhw2011", ItemTab.DECORATIVE, false, true, 225 - 128, 0));
            _loc_40.addBrick(createBrick(226, ItemLayer.DECORATION, decorationsBMD, "brickhw2011", ItemTab.DECORATIVE, false, true, 226 - 128, 0));
            _loc_40.addBrick(createBrick(541, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickhw2011", ItemTab.BACKGROUND, false, false, 541 - 500));
            _loc_40.addBrick(createBrick(542, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickhw2011", ItemTab.BACKGROUND, false, false, 542 - 500));
            _loc_40.addBrick(createBrick(543, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickhw2011", ItemTab.BACKGROUND, false, false, 543 - 500));
            _loc_40.addBrick(createBrick(544, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickhw2011", ItemTab.BACKGROUND, false, false, 544 - 500));
            brickPackages.push(_loc_40);
            var _loc_41:* = new ItemBrickPackage("christmas 2011", "Christmas 2011 Blocks");
            new ItemBrickPackage("christmas 2011", "Christmas 2011 Blocks").addBrick(createBrick(218, ItemLayer.DECORATION, decorationsBMD, "brickxmas2011", ItemTab.DECORATIVE, false, true, 218 - 128, 0));
            _loc_41.addBrick(createBrick(219, ItemLayer.DECORATION, decorationsBMD, "brickxmas2011", ItemTab.DECORATIVE, false, true, 219 - 128, 0));
            _loc_41.addBrick(createBrick(220, ItemLayer.DECORATION, decorationsBMD, "brickxmas2011", ItemTab.DECORATIVE, false, true, 220 - 128, 0));
            _loc_41.addBrick(createBrick(221, ItemLayer.DECORATION, decorationsBMD, "brickxmas2011", ItemTab.DECORATIVE, false, true, 221 - 128, 0));
            _loc_41.addBrick(createBrick(222, ItemLayer.DECORATION, decorationsBMD, "brickxmas2011", ItemTab.DECORATIVE, false, true, 222 - 128, 0));
            brickPackages.push(_loc_41);
            var _loc_42:* = new ItemBrickPackage("scifi", "SciFi Blocks");
            new ItemBrickPackage("scifi", "SciFi Blocks").addBrick(createBrick(84, ItemLayer.DECORATION, forgroundBricksBMD, "brickscifi", ItemTab.BLOCK, false, true, 84));
            _loc_42.addBrick(createBrick(85, ItemLayer.DECORATION, forgroundBricksBMD, "brickscifi", ItemTab.BLOCK, false, true, 85));
            _loc_42.addBrick(createBrick(86, ItemLayer.DECORATION, forgroundBricksBMD, "brickscifi", ItemTab.BLOCK, false, true, 86));
            _loc_42.addBrick(createBrick(87, ItemLayer.DECORATION, forgroundBricksBMD, "brickscifi", ItemTab.BLOCK, false, true, 87, 4294967295));
            _loc_42.addBrick(createBrick(88, ItemLayer.DECORATION, forgroundBricksBMD, "brickscifi", ItemTab.BLOCK, false, true, 88));
            _loc_42.addBrick(createBrick(89, ItemLayer.DECORATION, forgroundBricksBMD, "brickscifi", ItemTab.BLOCK, false, true, 89));
            _loc_42.addBrick(createBrick(90, ItemLayer.DECORATION, forgroundBricksBMD, "brickscifi", ItemTab.BLOCK, false, true, 90));
            _loc_42.addBrick(createBrick(91, ItemLayer.DECORATION, forgroundBricksBMD, "brickscifi", ItemTab.BLOCK, false, true, 91));
            brickPackages.push(_loc_42);
            var _loc_43:* = new ItemBrickPackage("prison", "Prison Blocks");
            new ItemBrickPackage("prison", "Prison Blocks").addBrick(createBrick(261, ItemLayer.ABOVE, decorationsBMD, "brickprison", ItemTab.DECORATIVE, false, false, 261 - 128, 0));
            _loc_43.addBrick(createBrick(92, ItemLayer.FORGROUND, forgroundBricksBMD, "brickprison", ItemTab.BLOCK, false, true, 92));
            _loc_43.addBrick(createBrick(550, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickprison", ItemTab.BACKGROUND, false, true, 50));
            _loc_43.addBrick(createBrick(551, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickprison", ItemTab.BACKGROUND, false, true, 51));
            _loc_43.addBrick(createBrick(552, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickprison", ItemTab.BACKGROUND, false, true, 52));
            _loc_43.addBrick(createBrick(553, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickprison", ItemTab.BACKGROUND, false, true, 53));
            brickPackages.push(_loc_43);
            var _loc_44:* = new ItemBrickPackage("windows", "Window Blocks");
            new ItemBrickPackage("windows", "Window Blocks").addBrick(createBrick(262, ItemLayer.ABOVE, decorationsBMD, "brickwindow", ItemTab.DECORATIVE, false, false, 262 - 128, 0));
            _loc_44.addBrick(createBrick(263, ItemLayer.ABOVE, decorationsBMD, "brickwindow", ItemTab.DECORATIVE, false, false, 263 - 128, 0));
            _loc_44.addBrick(createBrick(264, ItemLayer.ABOVE, decorationsBMD, "brickwindow", ItemTab.DECORATIVE, false, false, 264 - 128, 0));
            _loc_44.addBrick(createBrick(265, ItemLayer.ABOVE, decorationsBMD, "brickwindow", ItemTab.DECORATIVE, false, false, 265 - 128, 0));
            _loc_44.addBrick(createBrick(266, ItemLayer.ABOVE, decorationsBMD, "brickwindow", ItemTab.DECORATIVE, false, false, 266 - 128, 0));
            _loc_44.addBrick(createBrick(267, ItemLayer.ABOVE, decorationsBMD, "brickwindow", ItemTab.DECORATIVE, false, false, 267 - 128, 0));
            _loc_44.addBrick(createBrick(268, ItemLayer.ABOVE, decorationsBMD, "brickwindow", ItemTab.DECORATIVE, false, false, 268 - 128, 0));
            _loc_44.addBrick(createBrick(269, ItemLayer.ABOVE, decorationsBMD, "brickwindow", ItemTab.DECORATIVE, false, false, 269 - 128, 0));
            _loc_44.addBrick(createBrick(270, ItemLayer.ABOVE, decorationsBMD, "brickwindow", ItemTab.DECORATIVE, false, false, 270 - 128, 0));
            brickPackages.push(_loc_44);
            var _loc_45:* = new ItemBrickPackage("pirate", "Pirate Blocks");
            new ItemBrickPackage("pirate", "Pirate Blocks").addBrick(createBrick(93, ItemLayer.FORGROUND, forgroundBricksBMD, "brickpirate", ItemTab.BLOCK, false, true, 93));
            _loc_45.addBrick(createBrick(94, ItemLayer.FORGROUND, forgroundBricksBMD, "brickpirate", ItemTab.BLOCK, false, true, 94));
            _loc_45.addBrick(createBrick(271, ItemLayer.DECORATION, decorationsBMD, "brickpirate", ItemTab.DECORATIVE, false, false, 271 - 128, 0));
            _loc_45.addBrick(createBrick(272, ItemLayer.DECORATION, decorationsBMD, "brickpirate", ItemTab.DECORATIVE, false, false, 272 - 128, 0));
            _loc_45.addBrick(createBrick(554, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickpirate", ItemTab.BACKGROUND, false, false, 54));
            _loc_45.addBrick(createBrick(555, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickpirate", ItemTab.BACKGROUND, false, false, 55));
            _loc_45.addBrick(createBrick(556, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickpirate", ItemTab.BACKGROUND, false, false, 56));
            _loc_45.addBrick(createBrick(557, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickpirate", ItemTab.BACKGROUND, false, false, 57));
            _loc_45.addBrick(createBrick(558, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickpirate", ItemTab.BACKGROUND, false, false, 58));
            _loc_45.addBrick(createBrick(559, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickpirate", ItemTab.BACKGROUND, false, false, 59));
            _loc_45.addBrick(createBrick(560, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickpirate", ItemTab.BACKGROUND, false, false, 60));
            brickPackages.push(_loc_45);
            var _loc_46:* = new ItemBrickPackage("vikings", "Viking Blocks");
            new ItemBrickPackage("vikings", "Viking Blocks").addBrick(createBrick(95, ItemLayer.FORGROUND, forgroundBricksBMD, "brickviking", ItemTab.BLOCK, false, true, 95));
            _loc_46.addBrick(createBrick(273, ItemLayer.DECORATION, decorationsBMD, "brickviking", ItemTab.DECORATIVE, false, false, 273 - 128, 0));
            _loc_46.addBrick(createBrick(274, ItemLayer.DECORATION, decorationsBMD, "brickviking", ItemTab.DECORATIVE, false, false, 274 - 128, 0));
            _loc_46.addBrick(createBrick(275, ItemLayer.DECORATION, decorationsBMD, "brickviking", ItemTab.DECORATIVE, false, false, 275 - 128, 0));
            _loc_46.addBrick(createBrick(561, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickviking", ItemTab.BACKGROUND, false, false, 61));
            _loc_46.addBrick(createBrick(562, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickviking", ItemTab.BACKGROUND, false, false, 62));
            _loc_46.addBrick(createBrick(563, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickviking", ItemTab.BACKGROUND, false, false, 63));
            brickPackages.push(_loc_46);
            var _loc_47:* = new ItemBrickPackage("ninja", "Ninja Blocks");
            new ItemBrickPackage("ninja", "Ninja Blocks").addBrick(createBrick(96, ItemLayer.DECORATION, forgroundBricksBMD, "brickninja", ItemTab.BLOCK, false, false, 96, 0));
            _loc_47.addBrick(createBrick(97, ItemLayer.DECORATION, forgroundBricksBMD, "brickninja", ItemTab.BLOCK, false, false, 97, 0));
            _loc_47.addBrick(createBrick(564, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickninja", ItemTab.BACKGROUND, false, true, 64));
            _loc_47.addBrick(createBrick(565, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickninja", ItemTab.BACKGROUND, false, true, 65));
            _loc_47.addBrick(createBrick(566, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickninja", ItemTab.BACKGROUND, false, true, 66));
            _loc_47.addBrick(createBrick(567, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickninja", ItemTab.BACKGROUND, false, true, 67));
            _loc_47.addBrick(createBrick(276, ItemLayer.DECORATION, decorationsBMD, "brickninja", ItemTab.DECORATIVE, false, false, 276 - 128, 0));
            _loc_47.addBrick(createBrick(277, ItemLayer.DECORATION, decorationsBMD, "brickninja", ItemTab.DECORATIVE, false, false, 277 - 128, 0));
            _loc_47.addBrick(createBrick(278, ItemLayer.DECORATION, decorationsBMD, "brickninja", ItemTab.DECORATIVE, false, false, 278 - 128, 0));
            _loc_47.addBrick(createBrick(279, ItemLayer.DECORATION, decorationsBMD, "brickninja", ItemTab.DECORATIVE, false, false, 279 - 128, 0));
            _loc_47.addBrick(createBrick(280, ItemLayer.DECORATION, decorationsBMD, "brickninja", ItemTab.DECORATIVE, false, false, 280 - 128, 0));
            _loc_47.addBrick(createBrick(281, ItemLayer.DECORATION, decorationsBMD, "brickninja", ItemTab.DECORATIVE, false, false, 281 - 128, 0));
            _loc_47.addBrick(createBrick(282, ItemLayer.DECORATION, decorationsBMD, "brickninja", ItemTab.DECORATIVE, false, false, 282 - 128, 0));
            _loc_47.addBrick(createBrick(283, ItemLayer.DECORATION, decorationsBMD, "brickninja", ItemTab.DECORATIVE, false, false, 283 - 128, 0));
            _loc_47.addBrick(createBrick(284, ItemLayer.DECORATION, decorationsBMD, "brickninja", ItemTab.DECORATIVE, false, false, 284 - 128, 0));
            brickPackages.push(_loc_47);
            var _loc_48:* = new ItemBrickPackage("cowboy", "Cowboy Blocks");
            new ItemBrickPackage("cowboy", "Cowboy Blocks").addBrick(createBrick(122, ItemLayer.DECORATION, forgroundBricksBMD, "brickcowboy", ItemTab.BLOCK, false, false, 99, 0));
            _loc_48.addBrick(createBrick(123, ItemLayer.DECORATION, forgroundBricksBMD, "brickcowboy", ItemTab.BLOCK, false, false, 100, 0));
            _loc_48.addBrick(createBrick(124, ItemLayer.DECORATION, forgroundBricksBMD, "brickcowboy", ItemTab.BLOCK, false, false, 101, 0));
            _loc_48.addBrick(createBrick(125, ItemLayer.DECORATION, forgroundBricksBMD, "brickcowboy", ItemTab.BLOCK, false, false, 102, 0));
            _loc_48.addBrick(createBrick(126, ItemLayer.DECORATION, forgroundBricksBMD, "brickcowboy", ItemTab.BLOCK, false, false, 103, 0));
            _loc_48.addBrick(createBrick(127, ItemLayer.DECORATION, forgroundBricksBMD, "brickcowboy", ItemTab.BLOCK, false, false, 104, 0));
            _loc_48.addBrick(createBrick(568, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickcowboy", ItemTab.BACKGROUND, false, true, 68));
            _loc_48.addBrick(createBrick(569, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickcowboy", ItemTab.BACKGROUND, false, true, 69));
            _loc_48.addBrick(createBrick(570, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickcowboy", ItemTab.BACKGROUND, false, true, 70));
            _loc_48.addBrick(createBrick(571, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickcowboy", ItemTab.BACKGROUND, false, true, 71));
            _loc_48.addBrick(createBrick(572, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickcowboy", ItemTab.BACKGROUND, false, true, 72));
            _loc_48.addBrick(createBrick(573, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickcowboy", ItemTab.BACKGROUND, false, true, 73));
            _loc_48.addBrick(createBrick(285, ItemLayer.ABOVE, decorationsBMD, "brickcowboy", ItemTab.DECORATIVE, false, true, 285 - 128, 0));
            _loc_48.addBrick(createBrick(286, ItemLayer.ABOVE, decorationsBMD, "brickcowboy", ItemTab.DECORATIVE, false, true, 286 - 128, 0));
            _loc_48.addBrick(createBrick(287, ItemLayer.DECORATION, decorationsBMD, "brickcowboy", ItemTab.DECORATIVE, false, false, 287 - 128, 0));
            _loc_48.addBrick(createBrick(288, ItemLayer.DECORATION, decorationsBMD, "brickcowboy", ItemTab.DECORATIVE, false, false, 288 - 128, 0));
            _loc_48.addBrick(createBrick(289, ItemLayer.DECORATION, decorationsBMD, "brickcowboy", ItemTab.DECORATIVE, false, false, 289 - 128, 0));
            _loc_48.addBrick(createBrick(290, ItemLayer.DECORATION, decorationsBMD, "brickcowboy", ItemTab.DECORATIVE, false, false, 290 - 128, 0));
            _loc_48.addBrick(createBrick(291, ItemLayer.DECORATION, decorationsBMD, "brickcowboy", ItemTab.DECORATIVE, false, false, 291 - 128, 0));
            _loc_48.addBrick(createBrick(292, ItemLayer.DECORATION, decorationsBMD, "brickcowboy", ItemTab.DECORATIVE, false, false, 292 - 128, 0));
            _loc_48.addBrick(createBrick(293, ItemLayer.DECORATION, decorationsBMD, "brickcowboy", ItemTab.DECORATIVE, false, false, 293 - 128, 0));
            _loc_48.addBrick(createBrick(294, ItemLayer.ABOVE, decorationsBMD, "brickcowboy", ItemTab.DECORATIVE, false, false, 294 - 128, 0));
            _loc_48.addBrick(createBrick(295, ItemLayer.ABOVE, decorationsBMD, "brickcowboy", ItemTab.DECORATIVE, false, false, 295 - 128, 0));
            _loc_48.addBrick(createBrick(296, ItemLayer.ABOVE, decorationsBMD, "brickcowboy", ItemTab.DECORATIVE, false, false, 296 - 128, 0));
            _loc_48.addBrick(createBrick(297, ItemLayer.ABOVE, decorationsBMD, "brickcowboy", ItemTab.DECORATIVE, false, false, 297 - 128, 0));
            _loc_48.addBrick(createBrick(298, ItemLayer.ABOVE, decorationsBMD, "brickcowboy", ItemTab.DECORATIVE, false, false, 298 - 128, 0));
            _loc_48.addBrick(createBrick(299, ItemLayer.ABOVE, decorationsBMD, "brickcowboy", ItemTab.DECORATIVE, false, false, 299 - 128, 0));
            brickPackages.push(_loc_48);
            var _loc_49:* = new ItemBrickPackage("plastic", "Plastic Blocks");
            new ItemBrickPackage("plastic", "Plastic Blocks").addBrick(createBrick(128, ItemLayer.DECORATION, forgroundBricksBMD, "brickplastic", ItemTab.BLOCK, false, true, 105));
            _loc_49.addBrick(createBrick(129, ItemLayer.DECORATION, forgroundBricksBMD, "brickplastic", ItemTab.BLOCK, false, true, 106));
            _loc_49.addBrick(createBrick(130, ItemLayer.DECORATION, forgroundBricksBMD, "brickplastic", ItemTab.BLOCK, false, true, 107));
            _loc_49.addBrick(createBrick(131, ItemLayer.DECORATION, forgroundBricksBMD, "brickplastic", ItemTab.BLOCK, false, true, 108));
            _loc_49.addBrick(createBrick(132, ItemLayer.DECORATION, forgroundBricksBMD, "brickplastic", ItemTab.BLOCK, false, true, 109));
            _loc_49.addBrick(createBrick(133, ItemLayer.DECORATION, forgroundBricksBMD, "brickplastic", ItemTab.BLOCK, false, true, 110));
            _loc_49.addBrick(createBrick(134, ItemLayer.DECORATION, forgroundBricksBMD, "brickplastic", ItemTab.BLOCK, false, true, 111));
            _loc_49.addBrick(createBrick(135, ItemLayer.DECORATION, forgroundBricksBMD, "brickplastic", ItemTab.BLOCK, false, true, 112));
            brickPackages.push(_loc_49);
            var _loc_50:* = new ItemBrickPackage("water", "Water Blocks");
            new ItemBrickPackage("water", "Water Blocks").addBrick(createBrick(ItemId.WATER, ItemLayer.ABOVE, waterBMD, "brickwater", ItemTab.ACTION, false, false, 0, 0));
            _loc_50.addBrick(createBrick(ItemId.WAVE, ItemLayer.ABOVE, waveBMD, "brickwater", ItemTab.DECORATIVE, false, false, 0, 0));
            _loc_50.addBrick(createBrick(574, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickwater", ItemTab.BACKGROUND, false, true, 74, 4285913831));
            _loc_50.addBrick(createBrick(575, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickwater", ItemTab.BACKGROUND, false, true, 75, 4285913831));
            _loc_50.addBrick(createBrick(576, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickwater", ItemTab.BACKGROUND, false, true, 76, 4285913831));
            _loc_50.addBrick(createBrick(577, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickwater", ItemTab.BACKGROUND, false, true, 77, 4285913831));
            _loc_50.addBrick(createBrick(578, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickwater", ItemTab.BACKGROUND, false, true, 78, 4285913831));
            brickPackages.push(_loc_50);
            var _loc_51:* = new ItemBrickPackage("sand", "Sand Blocks");
            new ItemBrickPackage("sand", "Sand Blocks").addBrick(createBrick(137, ItemLayer.FORGROUND, forgroundBricksBMD, "bricksand", ItemTab.BLOCK, false, true, 114));
            _loc_51.addBrick(createBrick(138, ItemLayer.FORGROUND, forgroundBricksBMD, "bricksand", ItemTab.BLOCK, false, true, 115));
            _loc_51.addBrick(createBrick(139, ItemLayer.FORGROUND, forgroundBricksBMD, "bricksand", ItemTab.BLOCK, false, true, 116));
            _loc_51.addBrick(createBrick(140, ItemLayer.FORGROUND, forgroundBricksBMD, "bricksand", ItemTab.BLOCK, false, true, 117));
            _loc_51.addBrick(createBrick(141, ItemLayer.FORGROUND, forgroundBricksBMD, "bricksand", ItemTab.BLOCK, false, true, 118));
            _loc_51.addBrick(createBrick(142, ItemLayer.FORGROUND, forgroundBricksBMD, "bricksand", ItemTab.BLOCK, false, true, 119));
            _loc_51.addBrick(createBrick(579, ItemLayer.BACKGROUND, backgroundBricksBMD, "bricksand", ItemTab.BACKGROUND, false, false, 79));
            _loc_51.addBrick(createBrick(580, ItemLayer.BACKGROUND, backgroundBricksBMD, "bricksand", ItemTab.BACKGROUND, false, false, 80));
            _loc_51.addBrick(createBrick(581, ItemLayer.BACKGROUND, backgroundBricksBMD, "bricksand", ItemTab.BACKGROUND, false, false, 81));
            _loc_51.addBrick(createBrick(582, ItemLayer.BACKGROUND, backgroundBricksBMD, "bricksand", ItemTab.BACKGROUND, false, false, 82));
            _loc_51.addBrick(createBrick(583, ItemLayer.BACKGROUND, backgroundBricksBMD, "bricksand", ItemTab.BACKGROUND, false, false, 83));
            _loc_51.addBrick(createBrick(584, ItemLayer.BACKGROUND, backgroundBricksBMD, "bricksand", ItemTab.BACKGROUND, false, false, 84));
            _loc_51.addBrick(createBrick(301, ItemLayer.DECORATION, decorationsBMD, "bricksand", ItemTab.DECORATIVE, false, false, 300 - 128, 0));
            _loc_51.addBrick(createBrick(302, ItemLayer.DECORATION, decorationsBMD, "bricksand", ItemTab.DECORATIVE, false, false, 301 - 128, 0));
            _loc_51.addBrick(createBrick(303, ItemLayer.DECORATION, decorationsBMD, "bricksand", ItemTab.DECORATIVE, false, false, 302 - 128, 0));
            _loc_51.addBrick(createBrick(304, ItemLayer.DECORATION, decorationsBMD, "bricksand", ItemTab.DECORATIVE, false, false, 303 - 128, 0));
            _loc_51.addBrick(createBrick(305, ItemLayer.DECORATION, decorationsBMD, "bricksand", ItemTab.DECORATIVE, false, false, 304 - 128, 0));
            _loc_51.addBrick(createBrick(306, ItemLayer.DECORATION, decorationsBMD, "bricksand", ItemTab.DECORATIVE, false, false, 305 - 128, 0));
            brickPackages.push(_loc_51);
            var _loc_52:* = new ItemBrickPackage("summer 2012", "Summer 2012 Blocks");
            new ItemBrickPackage("summer 2012", "Summer 2012 Blocks").addBrick(createBrick(307, ItemLayer.DECORATION, decorationsBMD, "bricksummer2012", ItemTab.DECORATIVE, false, false, 306 - 128, 0));
            _loc_52.addBrick(createBrick(308, ItemLayer.DECORATION, decorationsBMD, "bricksummer2012", ItemTab.DECORATIVE, false, false, 307 - 128, 0));
            _loc_52.addBrick(createBrick(309, ItemLayer.DECORATION, decorationsBMD, "bricksummer2012", ItemTab.DECORATIVE, false, false, 308 - 128, 0));
            _loc_52.addBrick(createBrick(310, ItemLayer.DECORATION, decorationsBMD, "bricksummer2012", ItemTab.DECORATIVE, false, false, 309 - 128, 0));
            brickPackages.push(_loc_52);
            var _loc_53:* = new ItemBrickPackage("cloud", "Cloud Blocks");
            new ItemBrickPackage("cloud", "Cloud Blocks").addBrick(createBrick(143, ItemLayer.FORGROUND, forgroundBricksBMD, "brickcloud", ItemTab.BLOCK, false, false, 120));
            _loc_53.addBrick(createBrick(311, ItemLayer.ABOVE, decorationsBMD, "brickcloud", ItemTab.DECORATIVE, false, false, 310 - 128));
            _loc_53.addBrick(createBrick(312, ItemLayer.ABOVE, decorationsBMD, "brickcloud", ItemTab.DECORATIVE, false, false, 311 - 128));
            _loc_53.addBrick(createBrick(313, ItemLayer.ABOVE, decorationsBMD, "brickcloud", ItemTab.DECORATIVE, false, false, 312 - 128));
            _loc_53.addBrick(createBrick(314, ItemLayer.ABOVE, decorationsBMD, "brickcloud", ItemTab.DECORATIVE, false, false, 313 - 128));
            _loc_53.addBrick(createBrick(315, ItemLayer.ABOVE, decorationsBMD, "brickcloud", ItemTab.DECORATIVE, false, false, 314 - 128));
            _loc_53.addBrick(createBrick(316, ItemLayer.ABOVE, decorationsBMD, "brickcloud", ItemTab.DECORATIVE, false, false, 315 - 128));
            _loc_53.addBrick(createBrick(317, ItemLayer.ABOVE, decorationsBMD, "brickcloud", ItemTab.DECORATIVE, false, false, 316 - 128));
            _loc_53.addBrick(createBrick(318, ItemLayer.ABOVE, decorationsBMD, "brickcloud", ItemTab.DECORATIVE, false, false, 317 - 128));
            brickPackages.push(_loc_53);
            var _loc_54:* = new ItemBrickPackage("plate iron", "Plate Iron Blocks");
            new ItemBrickPackage("plate iron", "Plate Iron Blocks").addBrick(createBrick(144, ItemLayer.FORGROUND, forgroundBricksBMD, "brickplateiron", ItemTab.BLOCK, false, false, 121));
            _loc_54.addBrick(createBrick(145, ItemLayer.FORGROUND, forgroundBricksBMD, "brickplateiron", ItemTab.BLOCK, false, false, 122));
            _loc_54.addBrick(createBrick(585, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickplateiron", ItemTab.BACKGROUND, false, false, 85));
            _loc_54.addBrick(createBrick(586, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickplateiron", ItemTab.BACKGROUND, false, false, 86));
            _loc_54.addBrick(createBrick(587, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickplateiron", ItemTab.BACKGROUND, false, false, 87));
            _loc_54.addBrick(createBrick(588, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickplateiron", ItemTab.BACKGROUND, false, false, 88));
            _loc_54.addBrick(createBrick(589, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickplateiron", ItemTab.BACKGROUND, false, false, 89));
            brickPackages.push(_loc_54);
            var _loc_55:* = new ItemBrickPackage("signs", "Warning Sign Blocks");
            new ItemBrickPackage("signs", "Warning Sign Blocks").addBrick(createBrick(319, ItemLayer.DECORATION, decorationsBMD, "bricksigns", ItemTab.DECORATIVE, false, false, 190, 0));
            _loc_55.addBrick(createBrick(320, ItemLayer.DECORATION, decorationsBMD, "bricksigns", ItemTab.DECORATIVE, false, false, 191, 0));
            _loc_55.addBrick(createBrick(321, ItemLayer.DECORATION, decorationsBMD, "bricksigns", ItemTab.DECORATIVE, false, false, 192, 0));
            _loc_55.addBrick(createBrick(322, ItemLayer.DECORATION, decorationsBMD, "bricksigns", ItemTab.DECORATIVE, false, false, 193, 0));
            _loc_55.addBrick(createBrick(323, ItemLayer.DECORATION, decorationsBMD, "bricksigns", ItemTab.DECORATIVE, false, false, 194, 0));
            _loc_55.addBrick(createBrick(324, ItemLayer.DECORATION, decorationsBMD, "bricksigns", ItemTab.DECORATIVE, false, false, 195, 0));
            brickPackages.push(_loc_55);
            var _loc_56:* = new ItemBrickPackage("industrial", "Industrial Blocks");
            new ItemBrickPackage("industrial", "Industrial Blocks").addBrick(createBrick(146, ItemLayer.ABOVE, forgroundBricksBMD, "brickindustrial", ItemTab.BLOCK, false, false, 123));
            _loc_56.addBrick(createBrick(147, ItemLayer.ABOVE, forgroundBricksBMD, "brickindustrial", ItemTab.BLOCK, false, false, 124));
            _loc_56.addBrick(createBrick(148, ItemLayer.ABOVE, forgroundBricksBMD, "brickindustrial", ItemTab.BLOCK, false, false, 125));
            _loc_56.addBrick(createBrick(149, ItemLayer.FORGROUND, forgroundBricksBMD, "brickindustrial", ItemTab.BLOCK, false, false, 126));
            _loc_56.addBrick(createBrick(150, ItemLayer.ABOVE, forgroundBricksBMD, "brickindustrial", ItemTab.BLOCK, false, false, 127));
            _loc_56.addBrick(createBrick(151, ItemLayer.FORGROUND, forgroundBricksBMD, "brickindustrial", ItemTab.BLOCK, false, false, 128));
            _loc_56.addBrick(createBrick(152, ItemLayer.FORGROUND, forgroundBricksBMD, "brickindustrial", ItemTab.BLOCK, false, false, 129));
            _loc_56.addBrick(createBrick(153, ItemLayer.ABOVE, forgroundBricksBMD, "brickindustrial", ItemTab.BLOCK, false, false, 130));
            brickPackages.push(_loc_56);
            var _loc_57:* = new ItemBrickPackage("timbered", "Timbered Blocks");
            new ItemBrickPackage("timbered", "Timbered Blocks").addBrick(createBrick(154, ItemLayer.ABOVE, forgroundBricksBMD, "bricktimbered", ItemTab.BLOCK, false, true, 131));
            _loc_57.addBrick(createBrick(590, ItemLayer.BACKGROUND, backgroundBricksBMD, "bricktimbered", ItemTab.BACKGROUND, false, false, 90));
            _loc_57.addBrick(createBrick(591, ItemLayer.BACKGROUND, backgroundBricksBMD, "bricktimbered", ItemTab.BACKGROUND, false, false, 91));
            _loc_57.addBrick(createBrick(592, ItemLayer.BACKGROUND, backgroundBricksBMD, "bricktimbered", ItemTab.BACKGROUND, false, false, 92));
            _loc_57.addBrick(createBrick(593, ItemLayer.BACKGROUND, backgroundBricksBMD, "bricktimbered", ItemTab.BACKGROUND, false, false, 93));
            _loc_57.addBrick(createBrick(594, ItemLayer.BACKGROUND, backgroundBricksBMD, "bricktimbered", ItemTab.BACKGROUND, false, false, 94));
            _loc_57.addBrick(createBrick(595, ItemLayer.BACKGROUND, backgroundBricksBMD, "bricktimbered", ItemTab.BACKGROUND, false, false, 95));
            _loc_57.addBrick(createBrick(596, ItemLayer.BACKGROUND, backgroundBricksBMD, "bricktimbered", ItemTab.BACKGROUND, false, false, 96));
            _loc_57.addBrick(createBrick(597, ItemLayer.BACKGROUND, backgroundBricksBMD, "bricktimbered", ItemTab.BACKGROUND, false, false, 97));
            _loc_57.addBrick(createBrick(598, ItemLayer.BACKGROUND, backgroundBricksBMD, "bricktimbered", ItemTab.BACKGROUND, false, false, 98));
            brickPackages.push(_loc_57);
            var _loc_58:* = new ItemBrickPackage("castle", "Castle Blocks");
            new ItemBrickPackage("castle", "Castle Blocks").addBrick(createBrick(158, ItemLayer.ABOVE, forgroundBricksBMD, "brickcastle", ItemTab.BLOCK, false, true, 132));
            _loc_58.addBrick(createBrick(159, ItemLayer.FORGROUND, forgroundBricksBMD, "brickcastle", ItemTab.BLOCK, false, true, 133));
            _loc_58.addBrick(createBrick(160, ItemLayer.FORGROUND, forgroundBricksBMD, "brickcastle", ItemTab.BLOCK, false, true, 134));
            _loc_58.addBrick(createBrick(599, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickcastle", ItemTab.BACKGROUND, false, false, 99));
            _loc_58.addBrick(createBrick(325, ItemLayer.DECORATION, decorationsBMD, "brickcastle", ItemTab.DECORATIVE, false, false, 196, 0));
            _loc_58.addBrick(createBrick(326, ItemLayer.ABOVE, decorationsBMD, "brickcastle", ItemTab.DECORATIVE, false, false, 197));
            brickPackages.push(_loc_58);
            var _loc_59:* = new ItemBrickPackage("medieval", "Medieval Blocks");
            new ItemBrickPackage("medieval", "Medieval Blocks").addBrick(createBrick(162, ItemLayer.ABOVE, forgroundBricksBMD, "brickmedieval", ItemTab.BLOCK, false, true, 136));
            _loc_59.addBrick(createBrick(163, ItemLayer.ABOVE, forgroundBricksBMD, "brickmedieval", ItemTab.BLOCK, false, true, 137));
            _loc_59.addBrick(createBrick(327, ItemLayer.DECORATION, decorationsBMD, "brickmedieval", ItemTab.DECORATIVE, false, false, 198, 0));
            _loc_59.addBrick(createBrick(328, ItemLayer.DECORATION, decorationsBMD, "brickmedieval", ItemTab.DECORATIVE, false, false, 199, 0));
            _loc_59.addBrick(createBrick(329, ItemLayer.DECORATION, decorationsBMD, "brickmedieval", ItemTab.DECORATIVE, false, false, 200, 0));
            _loc_59.addBrick(createBrick(330, ItemLayer.DECORATION, decorationsBMD, "brickmedieval", ItemTab.DECORATIVE, false, false, 201, 0));
            _loc_59.addBrick(createBrick(331, ItemLayer.DECORATION, decorationsBMD, "brickmedieval", ItemTab.DECORATIVE, false, false, 202, 0));
            _loc_59.addBrick(createBrick(600, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickmedieval", ItemTab.BACKGROUND, false, false, 100));
            brickPackages.push(_loc_59);
            var _loc_60:* = new ItemBrickPackage("pipes", "Pipe Blocks");
            new ItemBrickPackage("pipes", "Pipe Blocks").addBrick(createBrick(166, ItemLayer.FORGROUND, forgroundBricksBMD, "brickpipe", ItemTab.BLOCK, false, true, 140));
            _loc_60.addBrick(createBrick(167, ItemLayer.FORGROUND, forgroundBricksBMD, "brickpipe", ItemTab.BLOCK, false, true, 141));
            _loc_60.addBrick(createBrick(168, ItemLayer.FORGROUND, forgroundBricksBMD, "brickpipe", ItemTab.BLOCK, false, true, 142));
            _loc_60.addBrick(createBrick(169, ItemLayer.FORGROUND, forgroundBricksBMD, "brickpipe", ItemTab.BLOCK, false, true, 143));
            _loc_60.addBrick(createBrick(170, ItemLayer.FORGROUND, forgroundBricksBMD, "brickpipe", ItemTab.BLOCK, false, true, 144));
            _loc_60.addBrick(createBrick(171, ItemLayer.FORGROUND, forgroundBricksBMD, "brickpipe", ItemTab.BLOCK, false, true, 145));
            brickPackages.push(_loc_60);
            var _loc_61:* = new ItemBrickPackage("rocket", "Rocket Blocks");
            new ItemBrickPackage("rocket", "Rocket Blocks").addBrick(createBrick(172, ItemLayer.FORGROUND, forgroundBricksBMD, "brickrocket", ItemTab.BLOCK, false, true, 146));
            _loc_61.addBrick(createBrick(173, ItemLayer.FORGROUND, forgroundBricksBMD, "brickrocket", ItemTab.BLOCK, false, true, 147));
            _loc_61.addBrick(createBrick(174, ItemLayer.FORGROUND, forgroundBricksBMD, "brickrocket", ItemTab.BLOCK, false, true, 148));
            _loc_61.addBrick(createBrick(175, ItemLayer.FORGROUND, forgroundBricksBMD, "brickrocket", ItemTab.BLOCK, false, true, 149));
            _loc_61.addBrick(createBrick(601, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickrocket", ItemTab.BACKGROUND, false, true, 101));
            _loc_61.addBrick(createBrick(602, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickrocket", ItemTab.BACKGROUND, false, true, 102));
            _loc_61.addBrick(createBrick(603, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickrocket", ItemTab.BACKGROUND, false, true, 103));
            _loc_61.addBrick(createBrick(604, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickrocket", ItemTab.BACKGROUND, false, true, 104));
            _loc_61.addBrick(createBrick(332, ItemLayer.DECORATION, decorationsBMD, "brickrocket", ItemTab.DECORATIVE, false, false, 203, 0));
            _loc_61.addBrick(createBrick(333, ItemLayer.DECORATION, decorationsBMD, "brickrocket", ItemTab.DECORATIVE, false, false, 204, 0));
            _loc_61.addBrick(createBrick(334, ItemLayer.DECORATION, decorationsBMD, "brickrocket", ItemTab.DECORATIVE, false, false, 205, 0));
            _loc_61.addBrick(createBrick(335, ItemLayer.DECORATION, decorationsBMD, "brickrocket", ItemTab.DECORATIVE, false, false, 206, 0));
            brickPackages.push(_loc_61);
            var _loc_62:* = new ItemBrickPackage("mars", "Mars Blocks");
            new ItemBrickPackage("mars", "Mars Blocks").addBrick(createBrick(176, ItemLayer.FORGROUND, forgroundBricksBMD, "brickmars", ItemTab.BLOCK, false, true, 150, 4294945604));
            _loc_62.addBrick(createBrick(177, ItemLayer.FORGROUND, forgroundBricksBMD, "brickmars", ItemTab.BLOCK, false, true, 151, 4292711483));
            _loc_62.addBrick(createBrick(178, ItemLayer.FORGROUND, forgroundBricksBMD, "brickmars", ItemTab.BLOCK, false, true, 152, 4291200308));
            _loc_62.addBrick(createBrick(179, ItemLayer.FORGROUND, forgroundBricksBMD, "brickmars", ItemTab.BLOCK, false, true, 153, 4287717671));
            _loc_62.addBrick(createBrick(180, ItemLayer.ABOVE, forgroundBricksBMD, "brickmars", ItemTab.BLOCK, false, false, 154, 0));
            _loc_62.addBrick(createBrick(181, ItemLayer.ABOVE, forgroundBricksBMD, "brickmars", ItemTab.BLOCK, false, false, 155, 0));
            _loc_62.addBrick(createBrick(605, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickmars", ItemTab.BACKGROUND, false, true, 105, 4278460021));
            _loc_62.addBrick(createBrick(606, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickmars", ItemTab.BACKGROUND, false, true, 106, 4278460021));
            _loc_62.addBrick(createBrick(607, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickmars", ItemTab.BACKGROUND, false, true, 107, 4278460021));
            _loc_62.addBrick(createBrick(336, ItemLayer.ABOVE, decorationsBMD, "brickmars", ItemTab.DECORATIVE, false, false, 207, 0));
            brickPackages.push(_loc_62);
            var _loc_63:* = new ItemBrickPackage("monster", "Monster Blocks");
            new ItemBrickPackage("monster", "Monster Blocks").addBrick(createBrick(608, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickmonster", ItemTab.BACKGROUND, false, true, 108, 4288716897));
            _loc_63.addBrick(createBrick(609, ItemLayer.BACKGROUND, backgroundBricksBMD, "brickmonster", ItemTab.BACKGROUND, false, true, 109, 4285558852));
            _loc_63.addBrick(createBrick(338, ItemLayer.ABOVE, decorationsBMD, "brickmonster", ItemTab.DECORATIVE, false, false, 208, 0));
            _loc_63.addBrick(createBrick(339, ItemLayer.ABOVE, decorationsBMD, "brickmonster", ItemTab.DECORATIVE, false, false, 209, 0));
            _loc_63.addBrick(createBrick(340, ItemLayer.ABOVE, decorationsBMD, "brickmonster", ItemTab.DECORATIVE, false, false, 210, 0));
            _loc_63.addBrick(createBrick(341, ItemLayer.DECORATION, decorationsBMD, "brickmonster", ItemTab.DECORATIVE, false, false, 211, 0));
            _loc_63.addBrick(createBrick(342, ItemLayer.DECORATION, decorationsBMD, "brickmonster", ItemTab.DECORATIVE, false, false, 212, 0));
            brickPackages.push(_loc_63);
            var _loc_64:* = new BlText(14, 19, 3940096, "right", "visitor");
            new BlText(14, 19, 3940096, "right", "visitor").text = "xx";
            var _loc_65:* = new BlText(14, 19, 16777215, "right", "visitor");
            new BlText(14, 19, 16777215, "right", "visitor").filters = [new GlowFilter(0, 1, 2, 2, 2, 3, false, false)];
            _loc_65.text = "xx";
            var _loc_66:int = 0;
            while (_loc_66 < 100)
            {
                
                coinDoorsBMD.copyPixels(bmdBricks[43], bmdBricks[43].rect, new Point(18 * _loc_66, 0));
                coinGatesBMD.copyPixels(bmdBricks[165], bmdBricks[165].rect, new Point(18 * _loc_66, 0));
                if (_loc_66 > 0)
                {
                    _loc_64.text = _loc_66.toString();
                    _loc_65.text = _loc_66.toString();
                    _loc_68 = new Matrix();
                    if (_loc_66 % 10 == 1)
                    {
                        _loc_68.translate(_loc_66 * 18 - 1, 5);
                    }
                    else
                    {
                        _loc_68.translate(_loc_66 * 18, 5);
                    }
                    coinDoorsBMD.draw(_loc_64.clone(), _loc_68);
                    coinGatesBMD.draw(_loc_65.clone(), _loc_68);
                }
                _loc_66++;
            }
            sprCoinDoors = new BlSprite(coinDoorsBMD, 0, 0, 18, 18, coinDoorsBMD.width / 18);
            sprCoinGates = new BlSprite(coinGatesBMD, 0, 0, 18, 18, coinDoorsBMD.width / 18);
            var _loc_67:int = 0;
            while (_loc_67 < bmdBricks.length)
            {
                
                if (bmdBricks[_loc_67] == null)
                {
                    bmdBricks[_loc_67] = bmdBricks[0];
                }
                _loc_67++;
            }
            return;
        }// end function

        public static function getSmileyByPayvaultId(param1:String) : ItemSmiley
        {
            var _loc_2:int = 0;
            while (_loc_2 < smilies.length)
            {
                
                if (smilies[_loc_2].payvaultid == param1)
                {
                    return smilies[_loc_2];
                }
                _loc_2++;
            }
            return null;
        }// end function

        public static function getSmileyById(param1:int) : ItemSmiley
        {
            var _loc_2:int = 0;
            while (_loc_2 < smilies.length)
            {
                
                if (smilies[_loc_2].id == param1)
                {
                    return smilies[_loc_2];
                }
                _loc_2++;
            }
            return null;
        }// end function

        public static function getBrickPackageByName(param1:String) : ItemBrickPackage
        {
            var _loc_2:int = 0;
            while (_loc_2 < brickPackages.length)
            {
                
                if (brickPackages[_loc_2].name == param1)
                {
                    return brickPackages[_loc_2];
                }
                _loc_2++;
            }
            return null;
        }// end function

        public static function getBrickById(param1:int) : ItemBrick
        {
            var _loc_3:ItemBrickPackage = null;
            var _loc_4:int = 0;
            var _loc_2:int = 0;
            while (_loc_2 < brickPackages.length)
            {
                
                _loc_3 = brickPackages[_loc_2];
                _loc_4 = 0;
                while (_loc_4 < _loc_3.bricks.length)
                {
                    
                    if (_loc_3.bricks[_loc_4].id == param1)
                    {
                        return _loc_3.bricks[_loc_4];
                    }
                    _loc_4++;
                }
                _loc_2++;
            }
            return null;
        }// end function

        public static function getMinimapColor(param1:int) : Number
        {
            var _loc_2:* = bricks[param1];
            return _loc_2 == null ? (bricks[0].minimapColor) : (_loc_2.minimapColor);
        }// end function

        private static function createBrick(param1:int, param2:int, param3:BitmapData, param4:String, param5:int, param6:Boolean, param7:Boolean, param8:int, param9:Number = -1, param10:Boolean = false) : ItemBrick
        {
            var _loc_14:* = totalBricks + 1;
            totalBricks = _loc_14;
            var _loc_11:* = new BitmapData(16, 16, true, 0);
            new BitmapData(16, 16, true, 0).copyPixels(param3, new Rectangle(16 * param8, 0, 16, 16), new Point(0, 0));
            var _loc_12:* = new ItemBrick(param1, param2, _loc_11, param4, param5, param6, param10, param7, param9);
            if (bricks[param1] != null)
            {
                throw new Error("Error creating new brick \'" + param4 + "\'. Brick id \'" + param1 + "\' is already in use");
            }
            bmdBricks[param1] = _loc_12.bmd;
            bricks[param1] = _loc_12;
            return _loc_12;
        }// end function

        private static function addSmiley(param1:int, param2:String, param3:String, param4:BitmapData, param5:String, param6:uint = 4.29497e+009) : void
        {
            var _loc_9:* = totalSmilies + 1;
            totalSmilies = _loc_9;
            var _loc_7:* = new BitmapData(16, 26, true, 0);
            new BitmapData(16, 26, true, 0).copyPixels(param4, new Rectangle(16 * param1, 0, 16, 26), new Point(0, 0));
            smilies.push(new ItemSmiley(param1, param2, param3, _loc_7, param5, param6));
            return;
        }// end function

        private static function addPotion(param1:int, param2:String, param3:String, param4:BitmapData, param5:String) : void
        {
            var _loc_8:* = totalPotions + 1;
            totalPotions = _loc_8;
            var _loc_6:* = new BitmapData(16, 26, true, 0);
            new BitmapData(16, 26, true, 0).copyPixels(param4, new Rectangle(16 * param1, 0, 16, 26), new Point(0, 0));
            potions.push(new ItemPotion(param1, param2, param3, _loc_6, param5));
            return;
        }// end function

        public static function getPotionById(param1:int) : ItemPotion
        {
            var _loc_2:int = 0;
            while (_loc_2 < potions.length)
            {
                
                if (potions[_loc_2].id == param1)
                {
                    return potions[_loc_2];
                }
                _loc_2++;
            }
            return null;
        }// end function

    }
}
