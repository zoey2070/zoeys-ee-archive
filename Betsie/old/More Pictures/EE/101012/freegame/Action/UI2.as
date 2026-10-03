package 
{
    import Facebook.*;
    import __AS3__.vec.*;
    import blitter.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import flash.utils.*;
    import items.*;
    import playerio.*;
    import ui.*;
    import ui.brickoverlays.*;
    import ui.chat.*;
    import ui.ingame.*;
    import ui.shop.*;
    import ui2.*;

    public class UI2 extends Sprite
    {
        private var lobby:ui2lobbybtn;
        private var godmode:ui2godmodebtn;
        private var toggleminimap:ui2toggleminimapbtn;
        private var soundandfullscreen:ui2soundandfullscreenbtn;
        private var mylevel:ui2mylevelbtn;
        private var you:YouButton;
        private var potionbtn:PotionButton;
        private var share:ui2sharebtn;
        private var enterkey:ui2entereditkeybox;
        private var bmd:BitmapData;
        private var bmd2:BitmapData;
        private var coinsbmd:BitmapData;
        private var smiliesbmd:BitmapData;
        private var potionsbmd:BitmapData;
        private var chatbtn:ui2chatbtn;
        private var chatinput:ui2chatinput;
        private var favoriteBricks:BrickContainer;
        private var bselector:BrickSelector;
        private var base:EverybodyEdits;
        private var connection:Connection;
        private var above:Sprite;
        private var roomid:String;
        private var isTutorialRoom:Boolean = false;
        private var allowPotions:Boolean = false;
        private var shopbar:ShopBar;
        private var smilies:SmileySelector;
        private var potionselector:PotionSelector;
        private var potioncounter:PotionCounter;
        private var specialproperties:PropertiesBackground;
        public var commandHelp:Object;
        private var shopTimerId:uint;
        private var usedx:int = 0;
        private var timerArray:Array;
        private var textArray:Array;
        private var lastMessageTime:Number;
        private var justVisible:Boolean = false;

        public function UI2(param1:EverybodyEdits, param2:Connection, param3:Message, param4:int, param5:Boolean, param6:String, param7:SideChat, param8:Boolean, param9:Boolean)
        {
            var that:UI2;
            var cs:ItemSmiley;
            var base:* = param1;
            var connection:* = param2;
            var m:* = param3;
            var myid:* = param4;
            var canEdit:* = param5;
            var roomid:* = param6;
            var sidechat:* = param7;
            var isTutorialRoom:* = param8;
            var allowPot:* = param9;
            this.lobby = new ui2lobbybtn();
            this.godmode = new ui2godmodebtn();
            this.toggleminimap = new ui2toggleminimapbtn();
            this.soundandfullscreen = new ui2soundandfullscreenbtn();
            this.mylevel = new ui2mylevelbtn();
            this.share = new ui2sharebtn();
            this.enterkey = new ui2entereditkeybox();
            this.coinsbmd = new ui2coins();
            this.chatbtn = new ui2chatbtn();
            this.chatinput = new ui2chatinput();
            this.above = new Sprite();
            this.shopbar = new ShopBar();
            this.smilies = new SmileySelector();
            this.potionselector = new PotionSelector();
            this.potioncounter = new PotionCounter();
            this.commandHelp = {/addadmin <user>:"Gives admin privilages for the current level to <user>", /removeadmin <user>:"Removes admin privilages for the current level from <user>", /ban <user> <time>:"Bans <user> for <time> in minutes from your room", /clearlevel:"Clears the current level", /loadlevel:"Load the current level from the database", /reset:"Reset all none god users to a spawn point", /stealth:"You know what this does!", /stats:"Verbose stats about the current level"};
            this.timerArray = [5000, 5000, 5000, 5000, 5000];
            this.textArray = ["", "", "", "", "", "", "", "", "", ""];
            this.lastMessageTime = new Date().getTime();
            Global.chatIsVisible = false;
            Bl.data.moreisvisible = false;
            this.isTutorialRoom = isTutorialRoom;
            this.allowPotions = allowPot;
            this.bselector = new BrickSelector(this);
            Bl.data.bselector = this.bselector;
            this.roomid = roomid;
            this.smiliesbmd = ItemManager.smiliesBMD;
            this.potionsbmd = ItemManager.potionBMD;
            this.base = base;
            this.connection = connection;
            addChild(new ui2background());
            this.you = new YouButton(this.smiliesbmd);
            this.potionbtn = new PotionButton(this.potionsbmd);
            this.above.addChild(this.bselector);
            this.above.addChild(this.smilies);
            this.above.addChild(this.potionselector);
            this.potioncounter.deserializeFromMessage(m);
            this.shopbar.shopbtn.visible = false;
            var def:* = new Vector.<ItemBrick>;
            def.push(ItemManager.getBrickById(0), ItemManager.getBrickById(9), ItemManager.getBrickById(10), ItemManager.getBrickById(11), ItemManager.getBrickById(16), ItemManager.getBrickById(17), ItemManager.getBrickById(18), ItemManager.getBrickById(29), ItemManager.getBrickById(32), ItemManager.getBrickById(2), ItemManager.getBrickById(100));
            this.favoriteBricks = new BrickContainer(def, this);
            this.configureInterface();
            this.toggleMinimap(Bl.data.showMap);
            this.toggleSound(!Global.play_sounds);
            this.smilies.x = this.you.x - this.smilies.basiswidth / 2 + this.you.width / 2 >> 0;
            this.potionselector.x = this.potionbtn.x + 10 - this.potionselector.width / 2 >> 0;
            this.bselector.x = 640 - this.bselector.width >> 1;
            this.bselector.visible = false;
            addChild(this.chatinput);
            this.chatinput.y = -60;
            this.chatinput.x = 65;
            this.chatinput.visible = false;
            this.chatinput.text = new TabTextField();
            this.chatinput.addChild(this.chatinput.text);
            this.chatinput.text.x = 37;
            this.chatinput.text.y = 7;
            this.chatinput.text.width = 445;
            this.chatinput.quicksay0.addEventListener(MouseEvent.CLICK, function () : void
            {
                connection.send("autosay", 0);
                hideAll();
                return;
            }// end function
            );
            this.chatinput.quicksay1.addEventListener(MouseEvent.CLICK, function () : void
            {
                connection.send("autosay", 1);
                hideAll();
                return;
            }// end function
            );
            this.chatinput.quicksay2.addEventListener(MouseEvent.CLICK, function () : void
            {
                connection.send("autosay", 2);
                hideAll();
                return;
            }// end function
            );
            this.chatinput.quicksay3.addEventListener(MouseEvent.CLICK, function () : void
            {
                connection.send("autosay", 3);
                hideAll();
                return;
            }// end function
            );
            this.chatinput.quicksay4.addEventListener(MouseEvent.CLICK, function () : void
            {
                connection.send("autosay", 4);
                hideAll();
                return;
            }// end function
            );
            this.chatinput.quicksay5.addEventListener(MouseEvent.CLICK, function () : void
            {
                connection.send("autosay", 5);
                hideAll();
                return;
            }// end function
            );
            this.chatinput.quicksay6.addEventListener(MouseEvent.CLICK, function () : void
            {
                connection.send("autosay", 6);
                hideAll();
                return;
            }// end function
            );
            this.chatinput.quicksay7.addEventListener(MouseEvent.CLICK, function () : void
            {
                connection.send("autosay", 7);
                hideAll();
                return;
            }// end function
            );
            this.chatinput.quicksay8.addEventListener(MouseEvent.CLICK, function () : void
            {
                connection.send("autosay", 8);
                hideAll();
                return;
            }// end function
            );
            this.chatinput.quicksay9.addEventListener(MouseEvent.CLICK, function () : void
            {
                connection.send("autosay", 9);
                hideAll();
                return;
            }// end function
            );
            if (sidechat != null)
            {
                this.chatinput.text.SetWordFunction(sidechat.getUsers);
            }
            this.chatinput.text.field.addEventListener(KeyboardEvent.KEY_DOWN, function (event:KeyboardEvent) : void
            {
                event.preventDefault();
                event.stopImmediatePropagation();
                event.stopPropagation();
                if (event.keyCode == 27)
                {
                    hideAll();
                }
                if (event.keyCode == 13)
                {
                    sendChat();
                }
                return;
            }// end function
            );
            this.chatinput.say.addEventListener(MouseEvent.MOUSE_DOWN, function () : void
            {
                sendChat();
                return;
            }// end function
            );
            this.chatinput.text.field.addEventListener(MouseEvent.MOUSE_DOWN, function (event:MouseEvent) : void
            {
                event.preventDefault();
                event.stopImmediatePropagation();
                event.stopPropagation();
                return;
            }// end function
            );
            var sms:* = ItemManager.smilies;
            var a:int;
            while (a < sms.length)
            {
                
                cs = sms[a];
                if (cs.payvaultid == "" || base.client.payVault.has(cs.payvaultid) || cs.payvaultid == "pro" && Global.player_is_beta_member)
                {
                    this.smilies.addSmiley(new SmileyInstance(cs, this));
                }
                a = (a + 1);
            }
            this.drawPotionSelector();
            this.addEventListener(MouseEvent.MOUSE_DOWN, function (event:MouseEvent) : void
            {
                event.preventDefault();
                event.stopImmediatePropagation();
                event.stopPropagation();
                if (stage && !(event.target is TextField))
                {
                    stage.focus = Global.base;
                }
                return;
            }// end function
            );
            this.lobby.addEventListener(MouseEvent.MOUSE_DOWN, function () : void
            {
                base.ShowLobby();
                return;
            }// end function
            );
            this.godmode.addEventListener(MouseEvent.MOUSE_DOWN, function () : void
            {
                connection.send("god", godmode.currentFrame == 1);
                return;
            }// end function
            );
            connection.addMessageHandler("god", function (param1:Message, param2:int, param3:Boolean) : void
            {
                if (param2 == myid)
                {
                    toggleGodMode(param3);
                }
                return;
            }// end function
            );
            that;
            connection.addMessageHandler("givewizard", function (param1:Message) : void
            {
                Global.client.payVault.refresh();
                var _loc_2:* = ItemManager.getSmileyByPayvaultId("smileywizard");
                smilies.addSmiley(new SmileyInstance(_loc_2, that));
                setSelectedSmiley(_loc_2.id);
                return;
            }// end function
            );
            connection.addMessageHandler("givegrinch", function (param1:Message) : void
            {
                var i:ItemSmiley;
                var m:* = param1;
                try
                {
                    Global.client.payVault.refresh();
                    i = ItemManager.getSmileyByPayvaultId("smileyxmasgrinch");
                }
                catch (e:Error)
                {
                    Global.client.errorLog.writeError("Wxf " + e.toString(), i + "", "Part0", {});
                    try
                    {
                    }
                    smilies.addSmiley(new SmileyInstance(i, that));
                }
                catch (e:Error)
                {
                    Global.client.errorLog.writeError("Wxf " + e.toString(), i + "", "Part1", {});
                    try
                    {
                    }
                    setSelectedSmiley(i.id);
                }
                catch (e:Error)
                {
                    Global.client.errorLog.writeError("Wtf " + e.toString(), i + "", "Part2", {});
                }
                return;
            }// end function
            );
            connection.addMessageHandler("givewizard2", function (param1:Message) : void
            {
                Global.client.payVault.refresh();
                var _loc_2:* = ItemManager.getSmileyByPayvaultId("smileywizard2");
                smilies.addSmiley(new SmileyInstance(_loc_2, that));
                setSelectedSmiley(_loc_2.id);
                return;
            }// end function
            );
            connection.addMessageHandler("givewitch", function (param1:Message) : void
            {
                Global.client.payVault.refresh();
                var _loc_2:* = ItemManager.getSmileyByPayvaultId("smileywitch");
                smilies.addSmiley(new SmileyInstance(_loc_2, that));
                setSelectedSmiley(_loc_2.id);
                return;
            }// end function
            );
            this.chatbtn.addEventListener(MouseEvent.MOUSE_DOWN, function (event:MouseEvent) : void
            {
                toggleChat(chatbtn.currentFrame == 1);
                event.preventDefault();
                event.stopImmediatePropagation();
                event.stopPropagation();
                return;
            }// end function
            );
            this.toggleminimap.buttonMode = true;
            this.toggleminimap.addEventListener(MouseEvent.MOUSE_DOWN, function () : void
            {
                toggleMinimap(toggleminimap.currentFrame == 1);
                if (stage)
                {
                    stage.focus = Global.base;
                }
                return;
            }// end function
            );
            this.soundandfullscreen.sound.addEventListener(MouseEvent.MOUSE_DOWN, function () : void
            {
                toggleSound(soundandfullscreen.currentFrame == 1);
                return;
            }// end function
            );
            this.soundandfullscreen.fullscreen.addEventListener(MouseEvent.MOUSE_DOWN, function () : void
            {
                if (!Config.isMobile)
                {
                    try
                    {
                        if (Bl.stage.displayState == StageDisplayState.NORMAL)
                        {
                            Bl.stage.displayState = StageDisplayState.FULL_SCREEN;
                        }
                        else
                        {
                            Bl.stage.displayState = StageDisplayState.NORMAL;
                        }
                    }
                    catch (e:Error)
                    {
                    }
                }
                return;
            }// end function
            );
            this.mylevel.save.addEventListener(MouseEvent.MOUSE_DOWN, function () : void
            {
                toggleLevel(false);
                mylevel.gotoAndStop(3);
                mylevel.togglemodify.visible = false;
                connection.send("save");
                return;
            }// end function
            );
            this.mylevel.togglemodify.addEventListener(MouseEvent.MOUSE_DOWN, function () : void
            {
                toggleLevel(mylevel.currentFrame == 1);
                return;
            }// end function
            );
            connection.addMessageHandler("saved", function () : void
            {
                setTimeout(function () : void
                {
                    toggleLevel(false);
                    mylevel.togglemodify.visible = true;
                    return;
                }// end function
                , 2000);
                return;
            }// end function
            );
            this.mylevel.editname.addEventListener(MouseEvent.MOUSE_DOWN, function () : void
            {
                toggleLevel(false);
                try
                {
                    Bl.stage.displayState = StageDisplayState.NORMAL;
                    Bl.stage.scaleMode = StageScaleMode.NO_SCALE;
                }
                catch (e:Error)
                {
                }
                base.showPrompt(new Prompt("Type in new level name", Bl.data.roomname, function (param1:String) : void
                {
                    connection.send("name", param1);
                    Bl.data.roomname = param1;
                    if (stage)
                    {
                        stage.focus = Global.base;
                    }
                    return;
                }// end function
                ));
                return;
            }// end function
            );
            this.mylevel.editkey.addEventListener(MouseEvent.MOUSE_DOWN, function () : void
            {
                toggleLevel(false);
                try
                {
                    Bl.stage.displayState = StageDisplayState.NORMAL;
                    Bl.stage.scaleMode = StageScaleMode.NO_SCALE;
                }
                catch (e:Error)
                {
                }
                base.showPrompt(new Prompt("Type in new super secret edit key", "", function (param1:String) : void
                {
                    connection.send("key", param1);
                    if (stage)
                    {
                        stage.focus = Global.base;
                    }
                    return;
                }// end function
                ));
                return;
            }// end function
            );
            this.mylevel.clearlevel.addEventListener(MouseEvent.MOUSE_DOWN, function () : void
            {
                toggleLevel(false);
                base.showPrompt(new Prompt("Type CLEAR and press save to clear your level!", "", function (param1:String) : void
                {
                    if (param1 == "CLEAR")
                    {
                        connection.send("clear");
                    }
                    if (stage)
                    {
                        stage.focus = Global.base;
                    }
                    return;
                }// end function
                ));
                return;
            }// end function
            );
            this.mylevel.potions.addEventListener(MouseEvent.MOUSE_DOWN, function () : void
            {
                toggleLevel(false);
                connection.send("allowpotions", !allowPotions);
                return;
            }// end function
            );
            this.you.addEventListener(MouseEvent.MOUSE_DOWN, function () : void
            {
                smilies.x = you.x - smilies.basiswidth / 2 + you.width / 2 >> 0;
                toggleSmiley(!smilies.visible);
                return;
            }// end function
            );
            this.potionbtn.btn_select.addEventListener(MouseEvent.MOUSE_DOWN, function () : void
            {
                potionselector.x = potionbtn.x + 10 - potionselector.width / 2 >> 0;
                togglePotion(!potionselector.visible);
                return;
            }// end function
            );
            this.potionbtn.btn_use.addEventListener(MouseEvent.MOUSE_DOWN, function () : void
            {
                useSelectedPotion(potionselector.getSelectedPotion());
                return;
            }// end function
            );
            this.share.addEventListener(MouseEvent.MOUSE_DOWN, function () : void
            {
                if (Global.playing_on_faceboook)
                {
                    FB.ui({method:"stream.publish", message:"I found a great Everybody Edits level!", attachment:{name:"Play " + (Bl.data.roomname ? (Bl.data.roomname + " in ") : ("")) + "Everybody Edits", href:"http://apps.facebook.com/everedits/games/" + roomid, caption:"{*actor*} is having a blast playing " + (Bl.data.roomname ? (Bl.data.roomname + " in ") : ("")) + "Everybody Edits", description:"Why not try the level now?", media:[{type:"image", src:"http://r.playerio.com/r/everybody-edits-su9rn58o40itdbnw69plyw/Everybody Edits/img/ee100x100.png", href:"http://apps.facebook.com/everedits/games/" + roomid}]}}, function (param1) : void
                {
                    return;
                }// end function
                );
                }
                else
                {
                    Bl.overlayContainer.addChild(new Share("Direct url to this level!", "http://everybodyedits.com/games/" + roomid.split(" ").join("-")));
                }
                return;
            }// end function
            );
            this.favoriteBricks.more.addEventListener(MouseEvent.MOUSE_DOWN, function () : void
            {
                toggleMore(favoriteBricks.more.currentFrame == 1);
                return;
            }// end function
            );
            this.enterkey.key.addEventListener(MouseEvent.MOUSE_DOWN, function (event:MouseEvent) : void
            {
                event.stopImmediatePropagation();
                event.stopPropagation();
                event.preventDefault();
                return;
            }// end function
            );
            this.enterkey.key.addEventListener(KeyboardEvent.KEY_DOWN, function (event:KeyboardEvent) : void
            {
                event.stopImmediatePropagation();
                event.stopPropagation();
                event.preventDefault();
                return;
            }// end function
            );
            this.enterkey.send.addEventListener(MouseEvent.MOUSE_DOWN, function () : void
            {
                connection.send("access", enterkey.key.text);
                return;
            }// end function
            );
            connection.addMessageHandler("access", function (param1:Message) : void
            {
                Bl.data.canEdit = true;
                configureInterface();
                return;
            }// end function
            );
            connection.addMessageHandler("lostaccess", function (param1:Message) : void
            {
                if (!Bl.data.owner)
                {
                    toggleMore(false);
                    toggleGodMode(false);
                    Bl.data.canEdit = false;
                    configureInterface();
                }
                return;
            }// end function
            );
            connection.addMessageHandler("pc", function (param1:Message) : void
            {
                potioncounter.deserializeFromMessage(param1);
                drawPotionSelector();
                return;
            }// end function
            );
            this.setSelectedSmiley(Global.playerObject ? (Global.playerObject.smiley || 0) : (0));
            this.setSelectedPotion(0);
            this.toggleSmiley(false);
            this.togglePotion(false);
            this.toggleLevel(false);
            this.updateSelectorBricks();
            this.setSelected(0);
            addEventListener(Event.ADDED_TO_STAGE, this.handleAttach);
            addEventListener(Event.REMOVED_FROM_STAGE, this.handleDetatch);
            Shop.addEventListener(ShopEvent.UPDATE, this.handleShopUpdate);
            return;
        }// end function

        private function handleShopUpdate(event:ShopEvent) : void
        {
            this.drawPotionSelector();
            return;
        }// end function

        public function drawPotionSelector() : void
        {
            var _loc_3:ItemPotion = null;
            var _loc_4:PotionInstance = null;
            this.potionselector.clearPotions();
            var _loc_1:* = ItemManager.potions;
            var _loc_2:int = 0;
            while (_loc_2 < _loc_1.length)
            {
                
                _loc_3 = _loc_1[_loc_2];
                _loc_4 = new PotionInstance(_loc_3, this.potioncounter.getCount(_loc_3.id), this);
                this.potionselector.addPotion(_loc_4);
                _loc_2++;
            }
            return;
        }// end function

        public function updateSelectorBricks() : void
        {
            var _loc_3:ItemBrickPackage = null;
            var _loc_4:Vector.<ItemBrick> = null;
            var _loc_5:Vector.<ItemBrick> = null;
            var _loc_6:Vector.<ItemBrick> = null;
            var _loc_7:Vector.<ItemBrick> = null;
            var _loc_8:int = 0;
            var _loc_9:BrickPackage = null;
            var _loc_10:ItemBrick = null;
            this.bselector.removeAllPackages();
            var _loc_1:* = ItemManager.brickPackages;
            var _loc_2:int = 0;
            while (_loc_2 < _loc_1.length)
            {
                
                _loc_3 = _loc_1[_loc_2];
                _loc_4 = new Vector.<ItemBrick>;
                _loc_5 = new Vector.<ItemBrick>;
                _loc_6 = new Vector.<ItemBrick>;
                _loc_7 = new Vector.<ItemBrick>;
                _loc_8 = 0;
                while (_loc_8 < _loc_3.bricks.length)
                {
                    
                    _loc_10 = _loc_3.bricks[_loc_8];
                    if (_loc_10.payvaultid == "" || this.base.client.payVault.has(_loc_10.payvaultid) || _loc_10.payvaultid == "pro" && Global.player_is_beta_member)
                    {
                        if ((_loc_10.id == 77 || _loc_10.id == 83) && !Global.hasOwner)
                        {
                        }
                        else if (!_loc_10.requiresAdmin || Bl.data.isModerator)
                        {
                            if (!_loc_10.requiresOwnership || Bl.data.owner)
                            {
                                switch(_loc_10.tab)
                                {
                                    case ItemTab.BLOCK:
                                    {
                                        _loc_4.push(_loc_10);
                                        break;
                                    }
                                    case ItemTab.ACTION:
                                    {
                                        _loc_5.push(_loc_10);
                                        break;
                                    }
                                    case ItemTab.DECORATIVE:
                                    {
                                        _loc_6.push(_loc_10);
                                        break;
                                    }
                                    case ItemTab.BACKGROUND:
                                    {
                                        _loc_7.push(_loc_10);
                                        break;
                                    }
                                    default:
                                    {
                                        break;
                                    }
                                }
                            }
                        }
                    }
                    _loc_8++;
                }
                if (_loc_4.length > 0)
                {
                    _loc_9 = new BrickPackage(_loc_3.name, _loc_4, this);
                    this.bselector.addPackage(_loc_9, ItemTab.BLOCK);
                }
                if (_loc_5.length > 0)
                {
                    _loc_9 = new BrickPackage(_loc_3.name, _loc_5, this);
                    this.bselector.addPackage(_loc_9, ItemTab.ACTION);
                }
                if (_loc_6.length > 0)
                {
                    _loc_9 = new BrickPackage(_loc_3.name, _loc_6, this);
                    this.bselector.addPackage(_loc_9, ItemTab.DECORATIVE);
                }
                if (_loc_7.length > 0)
                {
                    _loc_9 = new BrickPackage(_loc_3.name, _loc_7, this);
                    this.bselector.addPackage(_loc_9, ItemTab.BACKGROUND);
                }
                _loc_2++;
            }
            this.bselector.redraw();
            return;
        }// end function

        public function toggleLevel(param1:Boolean) : void
        {
            if (param1)
            {
                this.hideAll();
                this.mylevel.gotoAndStop(2);
            }
            else
            {
                this.mylevel.gotoAndStop(1);
            }
            this.mylevel.save.visible = param1;
            this.mylevel.editkey.visible = param1;
            this.mylevel.editname.visible = param1;
            this.mylevel.clearlevel.visible = param1;
            this.mylevel.potions.visible = false;
            return;
        }// end function

        public function toggleSmiley(param1:Boolean) : void
        {
            if (param1)
            {
                this.hideAll();
            }
            this.smilies.visible = param1;
            return;
        }// end function

        public function togglePotion(param1:Boolean) : void
        {
            if (param1)
            {
                this.hideAll();
            }
            this.potionselector.visible = param1;
            return;
        }// end function

        public function dragIt(param1:ItemBrick) : void
        {
            this.favoriteBricks.dragIt(param1);
            return;
        }// end function

        public function setDefault(param1:int, param2:ItemBrick) : void
        {
            this.favoriteBricks.setDefault(param1, param2);
            return;
        }// end function

        public function toggleGodMode(param1:Boolean) : void
        {
            this.godmode.gotoAndStop(param1 ? (2) : (1));
            return;
        }// end function

        public function toggleMinimap(param1:Boolean) : void
        {
            this.toggleminimap.gotoAndStop(param1 ? (2) : (1));
            Bl.data.showMap = param1;
            return;
        }// end function

        public function toggleSound(param1:Boolean) : void
        {
            Global.play_sounds = !param1;
            this.soundandfullscreen.gotoAndStop(param1 ? (2) : (1));
            return;
        }// end function

        public function setSelected(param1:int) : void
        {
            this.hideAllProperties();
            if (this.bselector.visible)
            {
                switch(param1)
                {
                    case ItemId.COINDOOR:
                    case ItemId.COINGATE:
                    case 77:
                    case 83:
                    case 242:
                    case 1000:
                    {
                        this.showSpecialProperties(param1);
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            if (param1 == -1)
            {
                param1 = 243;
            }
            Bl.data.brick = param1;
            this.favoriteBricks.setSelected(param1);
            this.bselector.setSelected(param1);
            return;
        }// end function

        public function showSpecialProperties(param1:int) : void
        {
            this.hideAllProperties();
            var _loc_2:* = this.bselector.getPosition(param1);
            switch(param1)
            {
                case ItemId.COINDOOR:
                case ItemId.COINGATE:
                {
                    this.specialproperties = new CoinProperties(param1);
                    break;
                }
                case 1000:
                {
                    this.specialproperties = new LabelProperties();
                    break;
                }
                case 242:
                {
                    this.specialproperties = new PortalProperties();
                    break;
                }
                case 83:
                {
                    this.specialproperties = new DrumProperties();
                    break;
                }
                case 77:
                {
                    this.specialproperties = new PianoProperties();
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (_loc_2 == null)
            {
                return;
            }
            this.above.addChild(this.specialproperties);
            this.specialproperties.x = _loc_2.x + this.bselector.x;
            this.specialproperties.y = _loc_2.y + this.bselector.y;
            if (this.specialproperties.x - this.specialproperties.width / 2 < 0)
            {
                this.specialproperties.setOffsetX(-(this.specialproperties.x - this.specialproperties.width / 2));
            }
            else if (this.specialproperties.x + this.specialproperties.width / 2 > 640)
            {
                this.specialproperties.setOffsetX(640 - (this.specialproperties.x + this.specialproperties.width / 2));
            }
            return;
        }// end function

        public function hideAllProperties() : void
        {
            if (this.specialproperties != null && this.above.contains(this.specialproperties))
            {
                this.above.removeChild(this.specialproperties);
            }
            return;
        }// end function

        public function setSelectedSmiley(param1:int = 0) : void
        {
            this.connection.send(Bl.data.m + "f", param1);
            Global.playerObject.smiley = param1;
            this.you.setSelectedSmiley(param1);
            this.smilies.setSelectedSmiley(param1);
            this.toggleSmiley(false);
            return;
        }// end function

        public function setSelectedPotion(param1:int = 0) : void
        {
            this.potionbtn.setSelectedPotion(param1);
            this.potionselector.setSelectedPotion(param1);
            this.togglePotion(false);
            return;
        }// end function

        public function useSelectedPotion(param1:int) : void
        {
            if (param1 > 0)
            {
                this.connection.send(Bl.data.m + "p", param1);
                this.potionselector.clearSelected();
                this.potionbtn.setSelectedPotion(0);
            }
            return;
        }// end function

        public function toggleMore(param1:Boolean) : void
        {
            if (this.favoriteBricks.parent == null)
            {
                return;
            }
            if (param1)
            {
                this.hideAll();
            }
            else
            {
                this.hideAllProperties();
            }
            this.favoriteBricks.more.gotoAndStop(param1 ? (2) : (1));
            this.bselector.visible = param1;
            Bl.data.moreisvisible = param1;
            return;
        }// end function

        public function toggleChat(param1:Boolean) : void
        {
            if (param1)
            {
                this.hideAll();
                Global.chatIsVisible = true;
                this.chatbtn.gotoAndStop(2);
                this.chatinput.visible = true;
                if (stage)
                {
                    stage.focus = this.chatinput.text.field;
                }
                this.chatinput.text.field.text = "";
            }
            else
            {
                this.chatbtn.gotoAndStop(1);
                this.chatinput.visible = false;
                Global.chatIsVisible = false;
            }
            return;
        }// end function

        public function hideAll() : void
        {
            this.toggleSmiley(false);
            this.togglePotion(false);
            this.toggleLevel(false);
            this.toggleChat(false);
            this.toggleMore(false);
            this.hideAllProperties();
            return;
        }// end function

        public function configureInterface() : void
        {
            this.usedx = 0;
            if (this.godmode.parent)
            {
                removeChild(this.godmode);
            }
            if (this.you.parent)
            {
                removeChild(this.you);
            }
            if (this.potionbtn.parent)
            {
                removeChild(this.potionbtn);
            }
            if (this.favoriteBricks.parent)
            {
                removeChild(this.favoriteBricks);
            }
            if (this.mylevel.parent)
            {
                removeChild(this.mylevel);
            }
            if (this.enterkey.parent)
            {
                removeChild(this.enterkey);
            }
            this.add(this.lobby);
            this.add(this.share);
            if (this.isTutorialRoom)
            {
                this.share.visible = false;
            }
            if (Bl.data.canEdit)
            {
                if (!this.isTutorialRoom)
                {
                    this.add(this.godmode);
                    this.godmode.visible = Bl.data.isLockedRoom;
                }
                this.add(this.you);
                this.add(this.chatbtn);
                if (this.allowPotions && Global.player_is_beta_member)
                {
                    this.add(this.potionbtn);
                }
                else
                {
                    this.usedx = this.usedx + (this.potionbtn.width - 1);
                }
                this.add(this.favoriteBricks);
                if (this.isTutorialRoom)
                {
                    this.add(this.godmode);
                    this.godmode.visible = false;
                }
                this.add(this.mylevel);
                this.mylevel.visible = Bl.data.owner;
                this.usedx = this.usedx - 4;
            }
            else
            {
                this.add(this.you);
                this.add(this.chatbtn);
                if (this.allowPotions && Global.player_is_beta_member)
                {
                    this.add(this.potionbtn);
                }
                else
                {
                    this.usedx = this.usedx + (this.potionbtn.width - 1);
                }
                this.add(this.enterkey);
                if (this.isTutorialRoom)
                {
                    this.enterkey.visible = false;
                }
                this.usedx = this.usedx + 66;
            }
            this.add(this.soundandfullscreen);
            this.add(this.toggleminimap);
            addChild(this.above);
            return;
        }// end function

        private function add(param1:InteractiveObject) : void
        {
            param1.y = -29;
            param1.x = this.usedx;
            addChild(param1);
            this.usedx = this.usedx + (param1.width - 1);
            return;
        }// end function

        private function handleAttach(event:Event) : void
        {
            stage.stageFocusRect = false;
            stage.focus = stage;
            stage.addEventListener(KeyboardEvent.KEY_DOWN, this.handleKeyDown);
            stage.addEventListener(KeyboardEvent.KEY_UP, this.handleKeyUp);
            return;
        }// end function

        private function handleDetatch(event:Event) : void
        {
            stage.removeEventListener(KeyboardEvent.KEY_DOWN, this.handleKeyDown);
            stage.removeEventListener(KeyboardEvent.KEY_UP, this.handleKeyUp);
            return;
        }// end function

        private function handleMouseDown(event:MouseEvent) : void
        {
            return;
        }// end function

        private function sendChat() : void
        {
            var _loc_6:String = null;
            var _loc_7:int = 0;
            var _loc_1:* = this.chatinput.text.field.text;
            var _loc_2:* = _loc_1.toLocaleLowerCase();
            var _loc_3:* = _loc_1.charAt(0) == "/";
            this.textArray.push(_loc_1);
            this.textArray.shift();
            this.timerArray.push(new Date().getTime() - this.lastMessageTime);
            this.timerArray.shift();
            var _loc_4:int = 0;
            var _loc_5:int = 0;
            while (_loc_5 < this.timerArray.length)
            {
                
                _loc_4 = _loc_4 + this.timerArray[_loc_5];
                _loc_5++;
            }
            if (!_loc_3)
            {
                _loc_1 = _loc_1.replace(/([\?\!]{2})[\?\!]+""([\?\!]{2})[\?\!]+/gi, "$1");
                _loc_1 = _loc_1.replace(/\.{4,}""\.{4,}/gi, "...");
                _loc_6 = _loc_1.replace(/(:?.+)\1{4,}""(:?.+)\1{4,}/gi, "$1$1$1");
                while (_loc_6 != _loc_1)
                {
                    
                    _loc_1 = _loc_6;
                    _loc_6 = _loc_1.replace(/(:?.+)\1{4,}""(:?.+)\1{4,}/gi, "$1$1$1");
                }
                if (_loc_1.length > 4 && _loc_1.match(/[A-Z]""[A-Z]/g).length > _loc_1.length / 2)
                {
                    _loc_1 = _loc_1.toLowerCase();
                }
            }
            this.hideAll();
            if (_loc_3)
            {
                if (_loc_1 == "/killroom" && Bl.data.isModerator == true)
                {
                    this.connection.send("kill");
                }
                else
                {
                    this.connection.send("say", _loc_1);
                }
            }
            else if (_loc_1.replace(/\s""\s/gi, "").length > 0)
            {
                this.lastMessageTime = new Date().getTime();
                if (_loc_4 < 5000)
                {
                    Global.base.SystemSay("Easy now, you don\'t want the other players mistaking you for a spammer!");
                    return;
                }
                _loc_7 = 0;
                _loc_5 = 0;
                while (_loc_5 < this.textArray.length)
                {
                    
                    if (this.textArray[_loc_5] == _loc_1)
                    {
                        _loc_7++;
                    }
                    _loc_5++;
                }
                if (_loc_7 > 3)
                {
                    Global.base.SystemSay("You have said the same thing " + _loc_7 + " times. Time to try something new, or you might get kicked.");
                    return;
                }
                this.connection.send("say", _loc_1);
            }
            return;
        }// end function

        private function handleKeyDown(event:KeyboardEvent) : void
        {
            if (event.keyCode == 16)
            {
                Global.chatIsVisible = true;
            }
            if (event.keyCode == 9)
            {
                this.toggleMore(true);
                event.preventDefault();
                event.stopImmediatePropagation();
                event.stopPropagation();
            }
            if (event.keyCode == 13 && !Config.isMobile || event.keyCode == 84)
            {
                if (this.chatbtn.currentFrame == 1)
                {
                    this.justVisible = true;
                }
                event.preventDefault();
                event.stopImmediatePropagation();
                event.stopPropagation();
                this.toggleChat(true);
            }
            if (event.keyCode == 77)
            {
                this.toggleMinimap(this.toggleminimap.currentFrame == 1);
            }
            if (event.keyCode == 27)
            {
                this.hideAll();
            }
            if (event.altKey)
            {
                if (event.keyCode >= 48 && event.keyCode <= 57)
                {
                    event.preventDefault();
                    event.stopImmediatePropagation();
                    event.stopPropagation();
                    this.connection.send("autosay", event.keyCode - 48);
                    this.toggleChat(false);
                }
            }
            return;
        }// end function

        private function handleKeyUp(event:KeyboardEvent) : void
        {
            if (event.keyCode == 16)
            {
                Global.chatIsVisible = this.chatbtn.currentFrame != 1;
            }
            if (event.keyCode == 85)
            {
                this.useSelectedPotion(this.potionselector.getSelectedPotion());
            }
            if (event.keyCode == 9)
            {
                this.toggleMore(false);
                event.preventDefault();
                event.stopImmediatePropagation();
                event.stopPropagation();
            }
            if (this.justVisible)
            {
                this.toggleChat(true);
            }
            this.justVisible = false;
            return;
        }// end function

    }
}
