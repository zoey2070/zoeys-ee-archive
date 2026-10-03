package ui.profile
{
    import data.*;
    import flash.display.*;
    import flash.events.*;
    import playerio.*;
    import sample.ui.components.*;
    import sample.ui.components.scroll.*;

    public class MyWorlds extends Sprite
    {
        private var worldlist:Array;
        private var rooms:Array;
        private var worlds:FillBox;
        private var worldcontent:Box;
        private var worldscrollbox:ScrollBox;
        private var renderedWorlds:int = 0;

        public function MyWorlds()
        {
            this.worldlist = [];
            this.worldcontent = new Box();
            this.worlds = new FillBox(2);
            this.worlds.forceScale = true;
            this.worldcontent.margin(0, 0, 0, 0);
            this.worldscrollbox = new ScrollBox().margin(0, 0, 0, 0).add(new Box().margin(25, 0, 0, 0).add(this.worlds));
            this.worldcontent.add(new Box().margin(0, 0, 0, 0).add(this.worldscrollbox));
            this.worldscrollbox.addChild(new Label("Worlds", 15, "left", 16777215, false, "system"));
            this.loadRooms();
            addChild(this.worldcontent);
            return;
        }// end function

        private function loadRooms() : void
        {
            while (this.worlds.numChildren > 0)
            {
                
                this.worlds.removeChildAt(0);
            }
            var _loc_1:* = Global.playerObject;
            this.rooms = _loc_1.roomids.concat();
            if (_loc_1.room0)
            {
                this.rooms.push(_loc_1.room0);
            }
            if (_loc_1.betaonlyroom)
            {
                this.rooms.push(_loc_1.betaonlyroom);
            }
            this.loadNextLevel();
            return;
        }// end function

        private function loadNextLevel() : void
        {
            if (this.rooms.length == 0)
            {
                if (this.renderedWorlds == 0)
                {
                    this.worldscrollbox.addChild(new Box().margin(25, NaN, NaN, 0).add(new Label("You have not created any worlds yet", 10, "left", 16777215, false, "system")));
                }
                return;
            }
            var toload:* = this.rooms.pop();
            if (toload == "")
            {
                this.loadNextLevel();
                return;
            }
            Global.client.bigDB.load("Worlds", toload, function (param1:DatabaseObject) : void
            {
                renderWorld(param1);
                loadNextLevel();
                return;
            }// end function
            , this.handleError);
            return;
        }// end function

        private function handleError(param1:Error) : void
        {
            return;
        }// end function

        private function renderWorld(param1:DatabaseObject) : void
        {
            if (param1 == null || param1.worlddata == null)
            {
                return;
            }
            var _loc_4:String = this;
            var _loc_5:* = this.renderedWorlds + 1;
            _loc_4.renderedWorlds = _loc_5;
            if (param1.name != Chat.filter(param1.name))
            {
                return;
            }
            if (!param1.width || !param1.height)
            {
                return;
            }
            var _loc_2:* = new ProfileWorld(param1);
            _loc_2.addEventListener(MouseEvent.CLICK, this.handleWorldClicked, false, 0, true);
            this.worldlist.push(_loc_2);
            this.worldlist.sortOn(["plays"], Array.NUMERIC | Array.DESCENDING);
            var _loc_3:int = 0;
            while (_loc_3 < this.worldlist.length)
            {
                
                this.worlds.addChild(this.worldlist[_loc_3]);
                _loc_3++;
            }
            this.worldscrollbox.refresh();
            return;
        }// end function

        protected function handleWorldClicked(event:MouseEvent) : void
        {
            var _loc_2:* = event.target as ProfileWorld;
            var _loc_3:* = new NavigationEvent(NavigationEvent.JOIN_WORLD, true, false);
            _loc_3.world_id = _loc_2.key;
            dispatchEvent(_loc_3);
            return;
        }// end function

        override public function set width(param1:Number) : void
        {
            this.worldcontent.width = param1;
            return;
        }// end function

        override public function set height(param1:Number) : void
        {
            this.worldcontent.height = param1;
            return;
        }// end function

    }
}
