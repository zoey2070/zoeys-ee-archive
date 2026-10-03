package ui
{
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import io.player.tools.*;
    import items.*;
    import ui.profile.*;

    public class LevelComplete extends assets_complete
    {
        protected var CrownSilver:Class;
        private var crown_silver:BitmapData;
        private var profile_smiley:Sprite;

        public function LevelComplete()
        {
            this.CrownSilver = LevelComplete_CrownSilver;
            this.crown_silver = new this.CrownSilver().bitmapData;
            addEventListener(MouseEvent.MOUSE_DOWN, function (event:MouseEvent) : void
            {
                event.preventDefault();
                event.stopImmediatePropagation();
                event.stopPropagation();
                return;
            }// end function
            );
            addEventListener(KeyboardEvent.KEY_DOWN, function (event:KeyboardEvent) : void
            {
                event.preventDefault();
                event.stopImmediatePropagation();
                event.stopPropagation();
                return;
            }// end function
            );
            name = "LevelCompleteScreen";
            tf_completed.text = "You completed \"" + Badwords.Filter(Global.currentLevelname.length > 0 ? (Global.currentLevelname) : ("Untitled World")) + "\"";
            btn_lobby.buttonMode = true;
            btn_lobby.mouseEnabled = true;
            btn_lobby.mouseChildren = false;
            btn_lobby.addEventListener(MouseEvent.CLICK, this.closeToLobby);
            btn_close.mouseEnabled = true;
            btn_close.addEventListener(MouseEvent.CLICK, this.close);
            btn_stay.buttonMode = true;
            btn_stay.mouseEnabled = true;
            btn_stay.mouseChildren = false;
            btn_stay.addEventListener(MouseEvent.CLICK, this.close);
            var smileygx:* = new FriendSmiley(ItemManager.smiliesBMD);
            smileygx.frame = Global.playerObject.smiley;
            var smileybitmap:* = smileygx.getAsBitmap(6);
            smileybitmap.y = 6;
            var crown:* = new FriendSmiley(this.crown_silver);
            var crownbitmap:* = crown.getAsBitmap(6);
            this.profile_smiley = new Sprite();
            this.profile_smiley.addChild(smileybitmap);
            this.profile_smiley.addChild(crownbitmap);
            this.profile_smiley.x = (-smileybitmap.width) / 2;
            this.profile_smiley.y = (-smileybitmap.height) / 2;
            headanimation.holder.addChild(this.profile_smiley);
            addEventListener(Event.ADDED_TO_STAGE, this.handleAddedToStage, false, 0, true);
            return;
        }// end function

        protected function handleAddedToStage(event:Event) : void
        {
            removeEventListener(Event.ADDED_TO_STAGE, this.handleAddedToStage);
            addEventListener(Event.REMOVED_FROM_STAGE, this.handleRemovedFromStage, false, 0, true);
            addEventListener(Event.ENTER_FRAME, this.doStarTick, false, 0, true);
            var _loc_2:int = 0;
            while (_loc_2 < 6)
            {
                
                this.createStar(Math.random() * 100);
                _loc_2++;
            }
            this.doStarRain();
            return;
        }// end function

        protected function handleRemovedFromStage(event:Event) : void
        {
            removeEventListener(Event.REMOVED_FROM_STAGE, this.handleRemovedFromStage);
            return;
        }// end function

        private function doStarRain() : void
        {
            if (stage != null)
            {
                this.createStar();
                setTimeout(this.doStarRain, 600);
            }
            return;
        }// end function

        private function createStar(param1:Number = 0) : void
        {
            var _loc_2:* = new PixelStar();
            var _loc_3:* = Math.random() * Math.PI * 2;
            _loc_2.speed = 2;
            _loc_2.speed_x = Math.cos(_loc_3);
            _loc_2.speed_y = Math.sin(_loc_3);
            starholder.addChild(_loc_2);
            var _loc_4:int = 0;
            while (_loc_4 < param1)
            {
                
                _loc_2.tick();
                _loc_4++;
            }
            return;
        }// end function

        protected function doStarTick(event:Event) : void
        {
            var _loc_2:uint = 0;
            while (_loc_2 < starholder.numChildren)
            {
                
                (starholder.getChildAt(_loc_2) as PixelStar).tick();
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        private function closeToLobby(event:Event = null) : void
        {
            this.close();
            Global.base.ShowLobby();
            return;
        }// end function

        private function close(event:Event = null) : void
        {
            if (stage)
            {
                stage.focus = Global.base;
            }
            this.parent.removeChild(this);
            return;
        }// end function

    }
}
