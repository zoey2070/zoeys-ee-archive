package ui.roomlist
{
    import flash.events.*;

    public class RoomFilter extends asset_roomfilter
    {
        private var callback:Function;
        private var showopen:Boolean = false;
        private var showlocked:Boolean = false;
        private var showsaved:Boolean = false;
        private var showmyworlds:Boolean = false;
        private var betaonly:Boolean = false;

        public function RoomFilter(param1:Function, param2:Function, param3:Function)
        {
            var callback:* = param1;
            var crateWorldCallback:* = param2;
            var reloadWorldsCallback:* = param3;
            this.callback = callback;
            this.showlocked = true;
            btnopen.buttonMode = true;
            btnopen.useHandCursor = true;
            btnopen.addEventListener(MouseEvent.MOUSE_DOWN, function () : void
            {
                reset();
                showopen = true;
                updateFilter();
                return;
            }// end function
            );
            btnlocked.buttonMode = true;
            btnlocked.useHandCursor = true;
            btnlocked.addEventListener(MouseEvent.MOUSE_DOWN, function () : void
            {
                reset();
                showlocked = true;
                updateFilter();
                return;
            }// end function
            );
            btnmysavedworlds.buttonMode = true;
            btnmysavedworlds.useHandCursor = true;
            btnmysavedworlds.addEventListener(MouseEvent.MOUSE_DOWN, function () : void
            {
                if (Global.player_is_guest)
                {
                    Global.base.showRegister();
                    return;
                }
                reset();
                showmyworlds = true;
                updateFilter();
                return;
            }// end function
            );
            bottom.btncreateroom.buttonMode = true;
            bottom.btncreateroom.useHandCursor = true;
            bottom.btncreateroom.addEventListener(MouseEvent.MOUSE_DOWN, function () : void
            {
                crateWorldCallback();
                return;
            }// end function
            );
            bottom.labelFilter.addEventListener(Event.CHANGE, function () : void
            {
                updateFilter();
                return;
            }// end function
            );
            if (!Global.player_is_beta_member)
            {
                bottom2.betabtn.visible = false;
            }
            bottom2.betabtn.buttonMode = true;
            bottom2.betabtn.useHandCursor = true;
            bottom2.betabtn.addEventListener(MouseEvent.MOUSE_DOWN, function () : void
            {
                bottom2.betabtn.checkbox.gotoAndStop(bottom2.betabtn.checkbox.currentFrame == 1 ? (2) : (1));
                betaonly = bottom2.betabtn.checkbox.currentFrame == 2;
                updateFilter();
                return;
            }// end function
            );
            bottom2.btnreload.buttonMode = true;
            bottom2.btnreload.useHandCursor = true;
            bottom2.btnreload.addEventListener(MouseEvent.MOUSE_DOWN, function () : void
            {
                reloadWorldsCallback();
                return;
            }// end function
            );
            this.updateFilter();
            return;
        }// end function

        public function enableRefreshButton(param1:Boolean) : void
        {
            bottom2.btnreload.mouseEnabled = param1;
            bottom2.btnreload.alpha = param1 ? (1) : (0.5);
            return;
        }// end function

        private function reset() : void
        {
            this.showopen = false;
            this.showlocked = false;
            this.showmyworlds = false;
            return;
        }// end function

        override public function set height(param1:Number) : void
        {
            bottom.y = param1;
            bottom2.y = param1 + 25;
            return;
        }// end function

        private function updateFilter() : void
        {
            btnopen.gotoAndStop(this.showopen ? (2) : (1));
            btnlocked.gotoAndStop(this.showlocked ? (2) : (1));
            btnmysavedworlds.gotoAndStop(this.showmyworlds ? (2) : (1));
            this.callback(bottom.labelFilter.text, this.showopen, this.showlocked, this.showmyworlds, this.betaonly);
            return;
        }// end function

    }
}
