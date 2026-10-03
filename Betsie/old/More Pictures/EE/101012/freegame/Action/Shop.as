package 
{
    import __AS3__.vec.*;
    import blitter.*;
    import data.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.net.*;
    import flash.utils.*;
    import gameanalytics.*;
    import items.*;
    import playerio.*;

    public class Shop extends Object
    {
        private static var refreshed:Boolean = false;
        private static var base:EverybodyEdits;
        private static var refreshDate:Number = 0;
        private static var _energy:int = 0;
        private static var _timeToEnergy:int = 0;
        private static var _totalEnergy:int = 0;
        private static var _secoundsBetweenEnergy:int = 0;
        private static var newest_item:String = "";
        private static var shopItems:Array;
        private static var client:Client;
        private static var selected:String = "featured";
        private static var container:Sprite;
        private static var dataidhash:Object = {};
        private static var eventdispatcher:EventDispatcher = new EventDispatcher();
        private static var inited:Boolean = false;
        public static var refreshLobby:Boolean = false;
        private static var shopRef:GetGemsNow = null;
        private static var gs:GetGemsNow;
        private static var last_gemamount:int = -1;

        public function Shop()
        {
            return;
        }// end function

        public static function setBase(param1:EverybodyEdits, param2:Client) : void
        {
            base = param1;
            client = param2;
            return;
        }// end function

        public static function setContainer(param1:Sprite) : void
        {
            container = param1;
            return;
        }// end function

        public static function addEventListener(param1:String, param2:Function) : void
        {
            eventdispatcher.addEventListener(param1, param2, false, 0, true);
            return;
        }// end function

        public static function dispatchEvent(event:Event) : void
        {
            eventdispatcher.dispatchEvent(event);
            return;
        }// end function

        public static function isInitiallyRefreshed() : Boolean
        {
            return refreshed;
        }// end function

        public static function reset(param1:Function) : void
        {
            refreshed = false;
            dataidhash = {};
            refresh(param1);
            return;
        }// end function

        public static function refresh(param1:Function) : void
        {
            var callback:* = param1;
            client.payVault.refresh(function () : void
            {
                base.requestRemoteMethod("getShop", function (param1:Message) : void
                {
                    update(param1);
                    if (callback != null)
                    {
                        callback();
                    }
                    return;
                }// end function
                );
                return;
            }// end function
            );
            return;
        }// end function

        public static function getRefreshTime() : Number
        {
            return refreshDate;
        }// end function

        public static function getItemData(param1:String) : ShopItemData
        {
            return dataidhash[param1] as ShopItemData;
        }// end function

        private static function setItemAsOwned(param1:String) : void
        {
            getItemData(param1).owned = true;
            return;
        }// end function

        public static function getShopItemData() : Vector.<ShopItemData>
        {
            var _loc_2:ShopItemData = null;
            if (!refreshed)
            {
                throw new Error("You cannot call the shop without refreshing it first");
            }
            var _loc_1:* = new Vector.<ShopItemData>;
            for each (_loc_2 in dataidhash)
            {
                
                _loc_1.push(_loc_2);
            }
            return _loc_1.concat();
        }// end function

        private static function update(param1:Message = null) : void
        {
            var _loc_4:ShopItemData = null;
            var _loc_5:ShopItemData = null;
            refreshed = true;
            refreshDate = new Date().time;
            shopItems = [];
            _energy = param1.getInt(1);
            _timeToEnergy = param1.getInt(2);
            _totalEnergy = param1.getInt(3);
            _secoundsBetweenEnergy = param1.getInt(4);
            if (Global.player_is_guest)
            {
                _energy = 100;
                _timeToEnergy = 60;
                _totalEnergy = 200;
                _secoundsBetweenEnergy = 150;
            }
            var _loc_2:* = param1.getInt(6);
            var _loc_3:int = 7;
            while (_loc_3 < param1.length)
            {
                
                _loc_4 = new ShopItemData(param1.getString(_loc_3), param1.getString((_loc_3 + 1)), param1.getInt(_loc_3 + 2), param1.getInt(_loc_3 + 3), param1.getInt(_loc_3 + 4), param1.getInt(_loc_3 + 5), param1.getInt(_loc_3 + 6), param1.getInt(_loc_3 + 7), param1.getString(_loc_3 + 8), param1.getString(_loc_3 + 9), param1.getString(_loc_3 + 10), param1.getInt(_loc_3 + 11), param1.getBoolean(_loc_3 + 12), param1.getBoolean(_loc_3 + 13), param1.getBoolean(_loc_3 + 14), param1.getBoolean(_loc_3 + 15), param1.getBoolean(_loc_3 + 16), param1.getBoolean(_loc_3 + 17), param1.getBoolean(_loc_3 + 18));
                if (_loc_4.type != null && (!_loc_4.isDevOnly || Config.show_disabled_shopitems))
                {
                    if (_loc_4.bitmapsheet_id != null)
                    {
                        setBitmapData(_loc_4);
                    }
                    if (_loc_4.id != "smileypostman" || Bl.data.fromemail)
                    {
                        dataidhash[_loc_4.id] = _loc_4;
                    }
                    if (_loc_4.isNew && newest_item == "")
                    {
                        newest_item = _loc_4.id;
                    }
                }
                _loc_3 = _loc_3 + _loc_2;
            }
            if (!Global.canchat && !Bl.data.chatbanned && !Global.player_is_guest)
            {
                _loc_5 = new ShopItemData("canchat", ShopItemData.TYPE_OTHER, -1, 0, 0, 3, 0, 3, "Chat access verification", "When enabling chat, you will also receive 50 Gems. The gems are awarded next time you login.", "shopitem_323", 8, false, true, false, false, false, true, false);
                _loc_5.isDollars = true;
                setBitmapData(_loc_5);
                dataidhash["canchat"] = _loc_5;
            }
            if (last_gemamount != -1 && last_gemamount < gems)
            {
                GameAnalytics.newEvent(EventCategory.BUSINESS, {event_id:"Purchase:Gems", currency:"gems", amount:(gems - last_gemamount) * 100});
            }
            last_gemamount = gems;
            dispatchEvent(new ShopEvent(ShopEvent.UPDATE));
            return;
        }// end function

        public static function setBitmapData(param1:ShopItemData) : BitmapData
        {
            var _loc_2:BitmapData = null;
            var _loc_3:int = 0;
            switch(param1.bitmapsheet_id)
            {
                case "smilies":
                {
                    _loc_2 = ItemManager.smiliesBMD;
                    _loc_3 = 16;
                    break;
                }
                case "potions":
                {
                    _loc_2 = ItemManager.potionBMD;
                    _loc_3 = 16;
                    break;
                }
                case "shopitem_131":
                {
                    _loc_2 = ItemManager.shopitems131BMD;
                    _loc_3 = 131;
                    break;
                }
                case "shopitem_227":
                {
                    _loc_2 = ItemManager.shopitems227BMD;
                    _loc_3 = 227;
                    break;
                }
                case "shopitem_323":
                {
                    _loc_2 = ItemManager.shopitems323BMD;
                    _loc_3 = 323;
                    break;
                }
                case "shopitem_other":
                {
                    _loc_2 = ItemManager.shopitemsOtherBMD;
                    _loc_3 = 131;
                    break;
                }
                default:
                {
                    return new BitmapData(1, 1, true, 0);
                    break;
                }
            }
            var _loc_4:* = new BitmapData(_loc_3, _loc_2.height, true, 0);
            new BitmapData(_loc_3, _loc_2.height, true, 0).copyPixels(_loc_2, new Rectangle(_loc_3 * param1.bitmapsheet_offset, 0, _loc_3, _loc_2.height), new Point(0, 0));
            param1.image_bitmap = _loc_4;
            return _loc_4;
        }// end function

        public static function useEnergy(param1:String, param2:Function) : void
        {
            var target:* = param1;
            var callback:* = param2;
            Global.tracker.trackEvent("shop", "useenergy", target);
            if (Global.player_is_guest)
            {
                Global.tracker.trackUserEvent("useenergy");
                Global.base.showRegister();
                Shop.callback(false);
                return;
            }
            base.requestRemoteMethod("useEnergy", function (param1:Message) : void
            {
                var m:* = param1;
                Global.tracker.trackUserEvent("useenergy");
                GameAnalytics.newEvent(EventCategory.DESIGN, {event_id:"Energy:Use"});
                if (m.getString(0) == "error")
                {
                    base.showInfo("Not enough energy!", "You do not have enough energy to upgrade this item at this time.\n\nBut remember that you always get one free energy every two minutes and thirty seconds, even when you are not online!\n\nSo play a few levels or take a quick nap and you should have enough energy again!");
                    callback(false);
                }
                else
                {
                    if (m.getBoolean(0))
                    {
                        setTimeout(function () : void
                {
                    client.payVault.refresh(function () : void
                    {
                        setItemAsOwned(target);
                        update(m);
                        dispatchEvent(new ShopEvent(ShopEvent.ITEM_AQUIRED));
                        return;
                    }// end function
                    );
                    return;
                }// end function
                , 50);
                    }
                    else
                    {
                        update(m);
                    }
                    callback(true);
                }
                return;
            }// end function
            , target);
            return;
        }// end function

        public static function useGems(param1:String, param2:int, param3:Function) : void
        {
            var target:* = param1;
            var value:* = param2;
            var callback:* = param3;
            Global.tracker.trackEvent("shop", "usegems", target);
            if (Global.player_is_guest)
            {
                Global.base.showRegister();
                Shop.callback(false);
                return;
            }
            if (target == "canchat")
            {
                buyChat(callback);
                return;
            }
            base.requestRemoteMethod("useGems", function (param1:Message) : void
            {
                var m:* = param1;
                if (m.getString(0) == "error")
                {
                    Global.tracker.trackEvent("shop", "usegemsfailure", target);
                    getMoreGems();
                    callback(false);
                }
                else
                {
                    Global.tracker.trackEvent("shop", "usegemssuccess", target, value);
                    Global.tracker.trackUserEvent("usegems", target, value);
                    GameAnalytics.newEvent(EventCategory.DESIGN, {event_id:"Gems:Use"});
                    setTimeout(function () : void
                {
                    client.payVault.refresh(function () : void
                    {
                        setItemAsOwned(target);
                        update(m);
                        dispatchEvent(new ShopEvent(ShopEvent.ITEM_AQUIRED));
                        return;
                    }// end function
                    );
                    return;
                }// end function
                , 50);
                    callback(true);
                }
                return;
            }// end function
            , target);
            return;
        }// end function

        private static function buyChat(param1:Function) : void
        {
            var conf:VerifyAge;
            var callback:* = param1;
            conf = new VerifyAge();
            container.addChild(conf);
            conf.x = (Global.width - 472) / 2;
            conf.closebtn.addEventListener(MouseEvent.CLICK, function () : void
            {
                callback(false);
                container.removeChild(conf);
                return;
            }// end function
            );
            conf.verifybtn.addEventListener(MouseEvent.CLICK, function () : void
            {
                Global.tracker.trackEvent("shop", "getchat");
                var paypalargs:Object;
                paypalargs["return"] = "http://everybodyedits.com/thankyou.html";
                client.payVault.getBuyDirectInfo("paypal", paypalargs, [{itemKey:"canchat2"}], function (param1:Object) : void
                {
                    var info:* = param1;
                    callback(true);
                    reset(function () : void
                    {
                        var req:URLRequest;
                        req = new URLRequest(info.paypalurl);
                        try
                        {
                            navigateToURL(req, "_top");
                        }
                        catch (e:Error)
                        {
                            navigateToURL(req, "_blank");
                        }
                        return;
                    }// end function
                    );
                    return;
                }// end function
                , function (param1:PlayerIOError) : void
                {
                    callback(false);
                    return;
                }// end function
                );
                return;
            }// end function
            );
            return;
        }// end function

        public static function get energy() : int
        {
            if (!refreshed)
            {
                throw new Error("You cannot call the shop without refreshing it first");
            }
            var _loc_1:* = _energy;
            var _loc_2:* = new Date().time - refreshDate;
            var _loc_3:* = _timeToEnergy - _loc_2 / 1000;
            while (_loc_3 < 0)
            {
                
                _loc_3 = _loc_3 + _secoundsBetweenEnergy;
                _loc_1++;
            }
            return Math.min(_totalEnergy, _loc_1);
        }// end function

        public static function get gems() : int
        {
            if (!refreshed)
            {
                throw new Error("You cannot call the shop without refreshing it first");
            }
            return client.payVault.coins;
        }// end function

        public static function get totalEnergy() : int
        {
            if (!refreshed)
            {
                throw new Error("You cannot call the shop without refreshing it first");
            }
            return _totalEnergy;
        }// end function

        public static function get prettyTimeToNext() : String
        {
            if (!refreshed)
            {
                throw new Error("You cannot call the shop without refreshing it first");
            }
            var _loc_1:* = new Date().time - refreshDate;
            var _loc_2:* = _timeToEnergy - _loc_1 / 1000;
            while (_loc_2 < 0)
            {
                
                _loc_2 = _loc_2 + _secoundsBetweenEnergy;
            }
            var _loc_3:* = Math.floor(_loc_2 / 60);
            var _loc_4:* = Math.floor(_loc_2 - _loc_3 * 60);
            return _loc_3 + ":" + (_loc_4 < 10 ? ("0" + _loc_4) : (_loc_4));
        }// end function

        public static function getMoreGems() : void
        {
            var close:Function;
            var closecallback:Function;
            var paypalargs:Object;
            var successcallback:Function;
            close = function (event:MouseEvent = null) : void
            {
                if (gs.parent)
                {
                    gs.parent.removeChild(gs);
                }
                shopRef = null;
                gs = null;
                return;
            }// end function
            ;
            Global.tracker.trackPageview("/getgems");
            Global.tracker.trackUserEvent("gems");
            GameAnalytics.newEvent(EventCategory.DESIGN, {event_id:"Gems:Open"});
            if (Global.player_is_guest)
            {
                Global.base.showRegister();
                return;
            }
            gs = new GetGemsNow();
            gs.name = "GetGemsNow";
            gs.x = (Global.width - 606) / 2;
            gs.closebtn.addEventListener(MouseEvent.CLICK, close);
            gs.stop();
            closecallback = function (param1:int = 0) : void
            {
                if (param1 > 0)
                {
                    Global.tracker.trackUserEvent("buygems", param1);
                }
                close();
                return;
            }// end function
            ;
            if (Global.playing_on_faceboook)
            {
                gs.gotoAndStop(3);
                gs.credits1.addEventListener(MouseEvent.CLICK, function () : void
            {
                base.buyGemsWithFacebook(10, closecallback);
                var _loc_1:Boolean = false;
                gs.credits6.visible = false;
                var _loc_1:* = _loc_1;
                gs.credits5.visible = _loc_1;
                var _loc_1:* = _loc_1;
                gs.credits4.visible = _loc_1;
                var _loc_1:* = _loc_1;
                gs.credits3.visible = _loc_1;
                var _loc_1:* = _loc_1;
                gs.credits2.visible = _loc_1;
                gs.credits1.visible = _loc_1;
                return;
            }// end function
            );
                gs.credits2.addEventListener(MouseEvent.CLICK, function () : void
            {
                base.buyGemsWithFacebook(20, closecallback);
                var _loc_1:Boolean = false;
                gs.credits6.visible = false;
                var _loc_1:* = _loc_1;
                gs.credits5.visible = _loc_1;
                var _loc_1:* = _loc_1;
                gs.credits4.visible = _loc_1;
                var _loc_1:* = _loc_1;
                gs.credits3.visible = _loc_1;
                var _loc_1:* = _loc_1;
                gs.credits2.visible = _loc_1;
                gs.credits1.visible = _loc_1;
                return;
            }// end function
            );
                gs.credits3.addEventListener(MouseEvent.CLICK, function () : void
            {
                base.buyGemsWithFacebook(50, closecallback);
                var _loc_1:Boolean = false;
                gs.credits6.visible = false;
                var _loc_1:* = _loc_1;
                gs.credits5.visible = _loc_1;
                var _loc_1:* = _loc_1;
                gs.credits4.visible = _loc_1;
                var _loc_1:* = _loc_1;
                gs.credits3.visible = _loc_1;
                var _loc_1:* = _loc_1;
                gs.credits2.visible = _loc_1;
                gs.credits1.visible = _loc_1;
                return;
            }// end function
            );
                gs.credits4.addEventListener(MouseEvent.CLICK, function () : void
            {
                base.buyGemsWithFacebook(100, closecallback);
                var _loc_1:Boolean = false;
                gs.credits6.visible = false;
                var _loc_1:* = _loc_1;
                gs.credits5.visible = _loc_1;
                var _loc_1:* = _loc_1;
                gs.credits4.visible = _loc_1;
                var _loc_1:* = _loc_1;
                gs.credits3.visible = _loc_1;
                var _loc_1:* = _loc_1;
                gs.credits2.visible = _loc_1;
                gs.credits1.visible = _loc_1;
                return;
            }// end function
            );
                gs.credits5.addEventListener(MouseEvent.CLICK, function () : void
            {
                base.buyGemsWithFacebook(200, closecallback);
                var _loc_1:Boolean = false;
                gs.credits6.visible = false;
                var _loc_1:* = _loc_1;
                gs.credits5.visible = _loc_1;
                var _loc_1:* = _loc_1;
                gs.credits4.visible = _loc_1;
                var _loc_1:* = _loc_1;
                gs.credits3.visible = _loc_1;
                var _loc_1:* = _loc_1;
                gs.credits2.visible = _loc_1;
                gs.credits1.visible = _loc_1;
                return;
            }// end function
            );
                gs.credits6.addEventListener(MouseEvent.CLICK, function () : void
            {
                base.buyGemsWithFacebook(500, closecallback);
                var _loc_1:Boolean = false;
                gs.credits6.visible = false;
                var _loc_1:* = _loc_1;
                gs.credits5.visible = _loc_1;
                var _loc_1:* = _loc_1;
                gs.credits4.visible = _loc_1;
                var _loc_1:* = _loc_1;
                gs.credits3.visible = _loc_1;
                var _loc_1:* = _loc_1;
                gs.credits2.visible = _loc_1;
                gs.credits1.visible = _loc_1;
                return;
            }// end function
            );
            }
            else if (Bl.data.iskongregate)
            {
                gs.gotoAndStop(2);
                gs.kreds1.addEventListener(MouseEvent.CLICK, function () : void
            {
                base.buyGemsWithKongregate(5, closecallback);
                var _loc_1:Boolean = false;
                gs.kreds6.visible = false;
                var _loc_1:* = _loc_1;
                gs.kreds5.visible = _loc_1;
                var _loc_1:* = _loc_1;
                gs.kreds4.visible = _loc_1;
                var _loc_1:* = _loc_1;
                gs.kreds3.visible = _loc_1;
                var _loc_1:* = _loc_1;
                gs.kreds2.visible = _loc_1;
                gs.kreds1.visible = _loc_1;
                return;
            }// end function
            );
                gs.kreds2.addEventListener(MouseEvent.CLICK, function () : void
            {
                base.buyGemsWithKongregate(10, closecallback);
                var _loc_1:Boolean = false;
                gs.kreds6.visible = false;
                var _loc_1:* = _loc_1;
                gs.kreds5.visible = _loc_1;
                var _loc_1:* = _loc_1;
                gs.kreds4.visible = _loc_1;
                var _loc_1:* = _loc_1;
                gs.kreds3.visible = _loc_1;
                var _loc_1:* = _loc_1;
                gs.kreds2.visible = _loc_1;
                gs.kreds1.visible = _loc_1;
                return;
            }// end function
            );
                gs.kreds3.addEventListener(MouseEvent.CLICK, function () : void
            {
                base.buyGemsWithKongregate(20, closecallback);
                var _loc_1:Boolean = false;
                gs.kreds6.visible = false;
                var _loc_1:* = _loc_1;
                gs.kreds5.visible = _loc_1;
                var _loc_1:* = _loc_1;
                gs.kreds4.visible = _loc_1;
                var _loc_1:* = _loc_1;
                gs.kreds3.visible = _loc_1;
                var _loc_1:* = _loc_1;
                gs.kreds2.visible = _loc_1;
                gs.kreds1.visible = _loc_1;
                return;
            }// end function
            );
                gs.kreds4.addEventListener(MouseEvent.CLICK, function () : void
            {
                base.buyGemsWithKongregate(50, closecallback);
                var _loc_1:Boolean = false;
                gs.kreds6.visible = false;
                var _loc_1:* = _loc_1;
                gs.kreds5.visible = _loc_1;
                var _loc_1:* = _loc_1;
                gs.kreds4.visible = _loc_1;
                var _loc_1:* = _loc_1;
                gs.kreds3.visible = _loc_1;
                var _loc_1:* = _loc_1;
                gs.kreds2.visible = _loc_1;
                gs.kreds1.visible = _loc_1;
                return;
            }// end function
            );
                gs.kreds5.addEventListener(MouseEvent.CLICK, function () : void
            {
                base.buyGemsWithKongregate(100, closecallback);
                var _loc_1:Boolean = false;
                gs.kreds6.visible = false;
                var _loc_1:* = _loc_1;
                gs.kreds5.visible = _loc_1;
                var _loc_1:* = _loc_1;
                gs.kreds4.visible = _loc_1;
                var _loc_1:* = _loc_1;
                gs.kreds3.visible = _loc_1;
                var _loc_1:* = _loc_1;
                gs.kreds2.visible = _loc_1;
                gs.kreds1.visible = _loc_1;
                return;
            }// end function
            );
                gs.kreds6.addEventListener(MouseEvent.CLICK, function () : void
            {
                base.buyGemsWithKongregate(200, closecallback);
                var _loc_1:Boolean = false;
                gs.kreds6.visible = false;
                var _loc_1:* = _loc_1;
                gs.kreds5.visible = _loc_1;
                var _loc_1:* = _loc_1;
                gs.kreds4.visible = _loc_1;
                var _loc_1:* = _loc_1;
                gs.kreds3.visible = _loc_1;
                var _loc_1:* = _loc_1;
                gs.kreds2.visible = _loc_1;
                gs.kreds1.visible = _loc_1;
                return;
            }// end function
            );
            }
            else
            {
                paypalargs;
                paypalargs["return"] = "http://everybodyedits.com/thankyou.html";
                successcallback = function (param1:String) : void
            {
                if (paypalargs["coinamount"] != null)
                {
                    Global.tracker.trackUserEvent("buygems", parseInt(paypalargs["coinamount"]));
                }
                handlePaymentUrlSuccess(param1);
                return;
            }// end function
            ;
                gs.buybtn1.addEventListener(MouseEvent.CLICK, function () : void
            {
                paypalargs["coinamount"] = "5";
                paypalargs["item_name"] = "5 Everybody Edits Gems";
                getProviderUrl("paypal", paypalargs, successcallback);
                return;
            }// end function
            );
                gs.buybtn2.addEventListener(MouseEvent.CLICK, function () : void
            {
                paypalargs["coinamount"] = "15";
                paypalargs["item_name"] = "15 Everybody Edits Gems";
                getProviderUrl("paypal", paypalargs, successcallback);
                return;
            }// end function
            );
                gs.buybtn3.addEventListener(MouseEvent.CLICK, function () : void
            {
                paypalargs["coinamount"] = "50";
                paypalargs["item_name"] = "50 Everybody Edits Gems";
                getProviderUrl("paypal", paypalargs, successcallback);
                return;
            }// end function
            );
                gs.buybtn4.addEventListener(MouseEvent.CLICK, function () : void
            {
                paypalargs["coinamount"] = "105";
                paypalargs["item_name"] = "105 Everybody Edits Gems";
                getProviderUrl("paypal", paypalargs, successcallback);
                return;
            }// end function
            );
                gs.buybtn5.addEventListener(MouseEvent.CLICK, function () : void
            {
                paypalargs["coinamount"] = "220";
                paypalargs["item_name"] = "220 Everybody Edits Gems";
                getProviderUrl("paypal", paypalargs, successcallback);
                return;
            }// end function
            );
                gs.buybtn6.addEventListener(MouseEvent.CLICK, function () : void
            {
                paypalargs["coinamount"] = "600";
                paypalargs["item_name"] = "600 Everybody Edits Gems";
                getProviderUrl("paypal", paypalargs, successcallback);
                return;
            }// end function
            );
                gs.buybtn7.addEventListener(MouseEvent.CLICK, function () : void
            {
                paypalargs["coinamount"] = "1300";
                paypalargs["item_name"] = "1300 Everybody Edits Gems";
                getProviderUrl("paypal", paypalargs, successcallback);
                return;
            }// end function
            );
                gs.srbtn.addEventListener(MouseEvent.CLICK, function () : void
            {
                getProviderUrl("superrewards", {}, successcallback);
                return;
            }// end function
            );
            }
            shopRef = gs;
            container.addChild(gs);
            return;
        }// end function

        public static function getProviderUrl(param1:String, param2:Object, param3:Function) : void
        {
            var _loc_5:String = null;
            var _loc_4:* = "http://api.playerio.com/payvault/" + param1 + "/coinsredirect?gameid=" + Config.playerio_game_id + "&connectuserid=" + Global.client.connectUserId + "&connection=secure";
            for (_loc_5 in param2)
            {
                
                _loc_4 = _loc_4 + ("&" + _loc_5 + "=" + escape(param2[_loc_5]));
            }
            Shop.param3(_loc_4);
            return;
        }// end function

        public static function doFocus() : void
        {
            if (shopRef)
            {
                container.addChild(shopRef);
            }
            return;
        }// end function

        private static function handlePaymentUrlSuccess(param1:String) : void
        {
            var thankyou:asset_paypalreturn;
            var url:* = param1;
            if (gs && gs.parent)
            {
                gs.parent.removeChild(gs);
            }
            shopRef = null;
            gs = null;
            thankyou = new asset_paypalreturn();
            thankyou.btn_returntogame.addEventListener(MouseEvent.CLICK, function () : void
            {
                thankyou.btn_returntogame.visible = false;
                setTimeout(function () : void
                {
                    refresh(function () : void
                    {
                        thankyou.parent.removeChild(thankyou);
                        return;
                    }// end function
                    );
                    return;
                }// end function
                , 3000);
                return;
            }// end function
            );
            thankyou.x = (Global.width - 472) / 2;
            thankyou.name = "Thankyou";
            container.addChild(thankyou);
            try
            {
                navigateToURL(new URLRequest(url), "_blank");
            }
            catch (e:Error)
            {
                Global.tracker.trackEvent("shop", "paymentpopupfailed", e.toString());
                navigateToURL(new URLRequest(url), "_top");
            }
            return;
        }// end function

        private static function handlePayPalRequestError(param1:PlayerIOError) : void
        {
            Global.tracker.trackEvent("shop", "paypalfailure", param1.message);
            return;
        }// end function

        public static function hasSeenNewest() : Boolean
        {
            return Global.sharedCookie.data["newest_item"] == newest_item;
        }// end function

        public static function setSeenNewest() : void
        {
            Global.sharedCookie.data["newest_item"] = newest_item;
            return;
        }// end function

    }
}
